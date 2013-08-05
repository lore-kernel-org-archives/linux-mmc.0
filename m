From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 01/12] dma: edma: Setup parameters to DMA MAX_NR_SG at a
	time
Date: Mon, 5 Aug 2013 11:14:46 -0500
Message-ID: <1375719297-12871-2-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Changes are made here for configuring existing parameters to support
DMA'ing them out in batches as needed.

Also allocate as many as slots as needed by the SG list, but not more
than MAX_NR_SG. Then these slots will be reused accordingly.
For ex, if MAX_NR_SG=10, and number of SG entries is 40, still only
10 slots will be allocated to DMA the entire SG list of size 40.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5f3e532..7b0853c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -222,9 +222,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	enum dma_slave_buswidth dev_width;
 	u32 burst;
 	struct scatterlist *sg;
-	int i;
 	int acnt, bcnt, ccnt, src, dst, cidx;
 	int src_bidx, dst_bidx, src_cidx, dst_cidx;
+	int i, num_slots_needed;
 
 	if (unlikely(!echan || !sgl || !sg_len))
 		return NULL;
@@ -262,8 +262,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 
 	edesc->pset_nr = sg_len;
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		/* Allocate a PaRAM slot, if needed */
+	/* Allocate a PaRAM slot, if needed */
+
+	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
+
+	for (i = 0; i < num_slots_needed; i++) {
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
 				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
@@ -273,6 +276,10 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 				return NULL;
 			}
 		}
+	}
+
+	/* Configure PaRAM sets for each SG */
+	for_each_sg(sgl, sg, sg_len, i) {
 
 		acnt = dev_width;
 
@@ -330,6 +337,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		/* Configure A or AB synchronized transfers */
 		if (edesc->absync)
 			edesc->pset[i].opt |= SYNCDIM;
+
 		/* If this is the last set, enable completion interrupt flag */
 		if (i == sg_len - 1)
 			edesc->pset[i].opt |= TCINTEN;
-- 
1.7.9.5
