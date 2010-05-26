From: akpm@linux-foundation.org
Subject: [patch 001/203] davinci: mmc: pass number of SG segments as platform data
Date: Wed, 26 May 2010 14:41:49 -0700
Message-ID: <201005262141.o4QLfn5w015294@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36828 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753378Ab0EZVmW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:42:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sudhakar.raj@ti.com, khilman@deeprootsystems.com, linux-mmc@vger.kernel.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

On some platforms like DM355, the number of EDMA parameter slots available
for EDMA_SLOT_ANY usage are few.  In such cases, if MMC/SD uses 16 slots
for each instance of MMC controller, then the number of slots available
for other modules will be very few.

By passing the number of EDMA slots to be used in MMC driver from platform
data, EDMA slots available for other purposes can be controlled.

Most of the platforms will not use this platform data variable.  But on
DM355, as the number of EDMA resources available is limited, the number of
scatter- gather segments used inside the MMC driver can be 8 (passed as
platform data) instead of 16.  On DM355, when the number of scatter-gather
segments was reduced to 8, I saw a performance difference of about
0.25-0.4 Mbytes/sec during write.  Read performance variations were
negligible.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-davinci/include/mach/mmc.h |    3 ++
 drivers/mmc/host/davinci_mmc.c           |   24 ++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff -puN arch/arm/mach-davinci/include/mach/mmc.h~davinci-mmc-pass-number-of-sg-segments-as-platform-data arch/arm/mach-davinci/include/mach/mmc.h
--- a/arch/arm/mach-davinci/include/mach/mmc.h~davinci-mmc-pass-number-of-sg-segments-as-platform-data
+++ a/arch/arm/mach-davinci/include/mach/mmc.h
@@ -22,6 +22,9 @@ struct davinci_mmc_config {
 
 	/* Version of the MMC/SD controller */
 	u8	version;
+
+	/* Number of sg segments */
+	u8	nr_sg;
 };
 void davinci_setup_mmc(int module, struct davinci_mmc_config *config);
 
diff -puN drivers/mmc/host/davinci_mmc.c~davinci-mmc-pass-number-of-sg-segments-as-platform-data drivers/mmc/host/davinci_mmc.c
--- a/drivers/mmc/host/davinci_mmc.c~davinci-mmc-pass-number-of-sg-segments-as-platform-data
+++ a/drivers/mmc/host/davinci_mmc.c
@@ -137,15 +137,15 @@
 
 /*
  * One scatterlist dma "segment" is at most MAX_CCNT rw_threshold units,
- * and we handle up to NR_SG segments.  MMC_BLOCK_BOUNCE kicks in only
+ * and we handle up to MAX_NR_SG segments.  MMC_BLOCK_BOUNCE kicks in only
  * for drivers with max_hw_segs == 1, making the segments bigger (64KB)
- * than the page or two that's otherwise typical.  NR_SG == 16 gives at
- * least the same throughput boost, using EDMA transfer linkage instead
- * of spending CPU time copying pages.
+ * than the page or two that's otherwise typical. nr_sg (passed from
+ * platform data) == 16 gives at least the same throughput boost, using
+ * EDMA transfer linkage instead of spending CPU time copying pages.
  */
 #define MAX_CCNT	((1 << 16) - 1)
 
-#define NR_SG		16
+#define MAX_NR_SG	16
 
 static unsigned rw_threshold = 32;
 module_param(rw_threshold, uint, S_IRUGO);
@@ -192,7 +192,7 @@ struct mmc_davinci_host {
 	struct edmacc_param	tx_template;
 	struct edmacc_param	rx_template;
 	unsigned		n_link;
-	u32			links[NR_SG - 1];
+	u32			links[MAX_NR_SG - 1];
 
 	/* For PIO we walk scatterlists one segment at a time. */
 	unsigned int		sg_len;
@@ -202,6 +202,8 @@ struct mmc_davinci_host {
 	u8 version;
 	/* for ns in one cycle calculation */
 	unsigned ns_in_one_cycle;
+	/* Number of sg segments */
+	u8 nr_sg;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
@@ -568,6 +570,7 @@ davinci_release_dma_channels(struct mmc_
 
 static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 {
+	u32 link_size;
 	int r, i;
 
 	/* Acquire master DMA write channel */
@@ -593,7 +596,8 @@ static int __init davinci_acquire_dma_ch
 	/* Allocate parameter RAM slots, which will later be bound to a
 	 * channel as needed to handle a scatterlist.
 	 */
-	for (i = 0; i < ARRAY_SIZE(host->links); i++) {
+	link_size = min_t(unsigned, host->nr_sg, ARRAY_SIZE(host->links));
+	for (i = 0; i < link_size; i++) {
 		r = edma_alloc_slot(EDMA_CTLR(host->txdma), EDMA_SLOT_ANY);
 		if (r < 0) {
 			dev_dbg(mmc_dev(host->mmc), "dma PaRAM alloc --> %d\n",
@@ -1202,6 +1206,12 @@ static int __init davinci_mmcsd_probe(st
 
 	init_mmcsd_host(host);
 
+	if (pdata->nr_sg)
+		host->nr_sg = pdata->nr_sg - 1;
+
+	if (host->nr_sg > MAX_NR_SG || !host->nr_sg)
+		host->nr_sg = MAX_NR_SG;
+
 	host->use_dma = use_dma;
 	host->irq = irq;
 
_
