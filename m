From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v3 1/5] mmc: mxcmmc: fix race conditions for host->req and
 host->data access
Date: Mon,  8 Apr 2013 23:28:05 +0200
Message-ID: <1365456489-13152-2-git-send-email-agust@denx.de>
References: <1365456489-13152-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1365456489-13152-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

mxcmci_dma_callback() is invoked by DMA drivers in soft-irq
context and can be interrupted by the mxcmci_irq() interrupt
which can finish the mmc request or data transfer and set
host->req or host->data pointers to NULL. Then mxcmci_data_done()
crashes with a null pointer dereferences. Protect all accesses
to host->req and host->data by spin locks.

Also check host->data pointer in mxcmci_watchdog() before
dereferencing it.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
v3:
 - move to first patch in the series as asked by Sascha
 - add Acked-by

v2:
 - only rebased

 drivers/mmc/host/mxcmmc.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index ff9e496..8ae7cf5 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -623,24 +623,40 @@ static void mxcmci_datawork(struct work_struct *work)
 
 static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 {
-	struct mmc_data *data = host->data;
+	struct mmc_request *req;
 	int data_error;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 
-	if (!data)
+	if (!host->data) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		return;
+	}
+
+	if (!host->req) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	req = host->req;
+	if (!req->stop)
+		host->req = NULL; /* we will handle finish req below */
 
 	data_error = mxcmci_finish_data(host, stat);
 
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	mxcmci_read_response(host, stat);
 	host->cmd = NULL;
 
-	if (host->req->stop) {
-		if (mxcmci_start_cmd(host, host->req->stop, 0)) {
-			mxcmci_finish_request(host, host->req);
+	if (req->stop) {
+		if (mxcmci_start_cmd(host, req->stop, 0)) {
+			mxcmci_finish_request(host, req);
 			return;
 		}
 	} else {
-		mxcmci_finish_request(host, host->req);
+		mxcmci_finish_request(host, req);
 	}
 }
 
@@ -931,7 +947,8 @@ static void mxcmci_watchdog(unsigned long data)
 
 	/* Mark transfer as erroneus and inform the upper layers */
 
-	host->data->error = -ETIMEDOUT;
+	if (host->data)
+		host->data->error = -ETIMEDOUT;
 	host->req = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
-- 
1.7.5.4
