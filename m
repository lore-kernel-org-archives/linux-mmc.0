From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH 1/7] mmc: bcm2835: reset host on timeout
Date: Sun, 11 Nov 2018 14:45:24 +0100
Message-ID: <1541943930-23873-2-git-send-email-stefan.wahren@i2se.com>
References: <1541943930-23873-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1541943930-23873-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Suchanek <msuchanek-l3A5Bk7waGM@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Michal Suchanek <msuchanek-l3A5Bk7waGM@public.gmane.org>

The bcm2835 mmc host tends to lock up for unknown reason so reset it on
timeout. The upper mmc block layer tries retransimitting with single
blocks which tends to work out after a long wait.

This is better than giving up and leaving the machine broken for no
obvious reason.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Michal Suchanek <msuchanek-l3A5Bk7waGM@public.gmane.org>
---
 drivers/mmc/host/bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 768972a..f1712df 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -286,6 +286,7 @@ static void bcm2835_reset(struct mmc_host *mmc)
 
 	if (host->dma_chan)
 		dmaengine_terminate_sync(host->dma_chan);
+	host->dma_chan = NULL;
 	bcm2835_reset_internal(host);
 }
 
@@ -837,6 +838,8 @@ static void bcm2835_timeout(struct work_struct *work)
 		dev_err(dev, "timeout waiting for hardware interrupt.\n");
 		bcm2835_dumpregs(host);
 
+		bcm2835_reset(host->mmc);
+
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
 			bcm2835_finish_data(host);
-- 
2.7.4
