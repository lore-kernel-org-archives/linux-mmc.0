From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2] MMC: au1xmmc: remove Alchemy CPU subtype dependencies
Date: Mon,  1 Aug 2011 19:04:10 +0200
Message-ID: <1312218250-20376-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52908 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1HAREU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Aug 2011 13:04:20 -0400
Received: by fxh19 with SMTP id 19so4739885fxh.19
        for <linux-mmc@vger.kernel.org>; Mon, 01 Aug 2011 10:04:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Manuel Lauss <manuel.lauss@googlemail.com>

Replace all occurrences of CONFIG_SOC_AU1??? with runtime feature
detection.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V2: remove AU1300 cases; it's not yet upstream.

 drivers/mmc/host/au1xmmc.c |   93 +++++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index ef72e87..56e7834 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -64,11 +64,8 @@
 #define AU1XMMC_DESCRIPTOR_COUNT 1
 
 /* max DMA seg size: 64KB on Au1100, 4MB on Au1200 */
-#ifdef CONFIG_SOC_AU1100
-#define AU1XMMC_DESCRIPTOR_SIZE 0x0000ffff
-#else	/* Au1200 */
-#define AU1XMMC_DESCRIPTOR_SIZE 0x003fffff
-#endif
+#define AU1100_MMC_DESCRIPTOR_SIZE 0x0000ffff
+#define AU1200_MMC_DESCRIPTOR_SIZE 0x003fffff
 
 #define AU1XMMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
 		     MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
@@ -127,6 +124,7 @@ struct au1xmmc_host {
 #define HOST_F_XMIT	0x0001
 #define HOST_F_RECV	0x0002
 #define HOST_F_DMA	0x0010
+#define HOST_F_DBDMA	0x0020
 #define HOST_F_ACTIVE	0x0100
 #define HOST_F_STOP	0x1000
 
@@ -151,6 +149,16 @@ struct au1xmmc_host {
 #define DMA_CHANNEL(h)	\
 	(((h)->flags & HOST_F_XMIT) ? (h)->tx_chan : (h)->rx_chan)
 
+static inline int has_dbdma(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1200:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static inline void IRQ_ON(struct au1xmmc_host *host, u32 mask)
 {
 	u32 val = au_readl(HOST_CONFIG(host));
@@ -353,14 +361,12 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 	data->bytes_xfered = 0;
 
 	if (!data->error) {
-		if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+		if (host->flags & (HOST_F_DMA | HOST_F_DBDMA)) {
 			u32 chan = DMA_CHANNEL(host);
 
 			chan_tab_t *c = *((chan_tab_t **)chan);
 			au1x_dma_chan_t *cp = c->chan_ptr;
 			data->bytes_xfered = cp->ddma_bytecnt;
-#endif
 		} else
 			data->bytes_xfered =
 				(data->blocks * data->blksz) - host->pio.len;
@@ -570,11 +576,10 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 
 	host->status = HOST_S_DATA;
 
-	if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+	if ((host->flags & (HOST_F_DMA | HOST_F_DBDMA))) {
 		u32 channel = DMA_CHANNEL(host);
 
-		/* Start the DMA as soon as the buffer gets something in it */
+		/* Start the DBDMA as soon as the buffer gets something in it */
 
 		if (host->flags & HOST_F_RECV) {
 			u32 mask = SD_STATUS_DB | SD_STATUS_NE;
@@ -584,7 +589,6 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 		}
 
 		au1xxx_dbdma_start(channel);
-#endif
 	}
 }
 
@@ -633,8 +637,7 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 
 	au_writel(data->blksz - 1, HOST_BLKSIZE(host));
 
-	if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+	if (host->flags & (HOST_F_DMA | HOST_F_DBDMA)) {
 		int i;
 		u32 channel = DMA_CHANNEL(host);
 
@@ -663,7 +666,6 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 
 			datalen -= len;
 		}
-#endif
 	} else {
 		host->pio.index = 0;
 		host->pio.offset = 0;
@@ -838,7 +840,6 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_SOC_AU1200
 /* 8bit memory DMA device */
 static dbdev_tab_t au1xmmc_mem_dbdev = {
 	.dev_id		= DSCR_CMD0_ALWAYS,
@@ -905,7 +906,7 @@ static int au1xmmc_dbdma_init(struct au1xmmc_host *host)
 	au1xxx_dbdma_ring_alloc(host->rx_chan, AU1XMMC_DESCRIPTOR_COUNT);
 
 	/* DBDMA is good to go */
-	host->flags |= HOST_F_DMA;
+	host->flags |= HOST_F_DMA | HOST_F_DBDMA;
 
 	return 0;
 }
@@ -918,7 +919,6 @@ static void au1xmmc_dbdma_shutdown(struct au1xmmc_host *host)
 		au1xxx_dbdma_chan_free(host->rx_chan);
 	}
 }
-#endif
 
 static void au1xmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
 {
@@ -997,8 +997,16 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->f_min =   450000;
 	mmc->f_max = 24000000;
 
-	mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
-	mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1100:
+		mmc->max_seg_size = AU1100_MMC_DESCRIPTOR_SIZE;
+		mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
+		break;
+	case ALCHEMY_CPU_AU1200:
+		mmc->max_seg_size = AU1200_MMC_DESCRIPTOR_SIZE;
+		mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
+		break;
+	}
 
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 512;
@@ -1028,11 +1036,12 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
 			(unsigned long)host);
 
-#ifdef CONFIG_SOC_AU1200
-	ret = au1xmmc_dbdma_init(host);
-	if (ret)
-		printk(KERN_INFO DRIVER_NAME ": DBDMA init failed; using PIO\n");
-#endif
+	if (has_dbdma()) {
+		ret = au1xmmc_dbdma_init(host);
+		if (ret)
+			printk(KERN_INFO DRIVER_NAME ": DBDMA init failed; "
+						     "using PIO\n");
+	}
 
 #ifdef CONFIG_LEDS_CLASS
 	if (host->platdata && host->platdata->led) {
@@ -1073,9 +1082,8 @@ out5:
 	au_writel(0, HOST_CONFIG2(host));
 	au_sync();
 
-#ifdef CONFIG_SOC_AU1200
-	au1xmmc_dbdma_shutdown(host);
-#endif
+	if (host->flags & HOST_F_DBDMA)
+		au1xmmc_dbdma_shutdown(host);
 
 	tasklet_kill(&host->data_task);
 	tasklet_kill(&host->finish_task);
@@ -1120,9 +1128,9 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 		tasklet_kill(&host->data_task);
 		tasklet_kill(&host->finish_task);
 
-#ifdef CONFIG_SOC_AU1200
-		au1xmmc_dbdma_shutdown(host);
-#endif
+		if (host->flags & HOST_F_DBDMA)
+			au1xmmc_dbdma_shutdown(host);
+
 		au1xmmc_set_power(host, 0);
 
 		free_irq(host->irq, host);
@@ -1181,24 +1189,23 @@ static struct platform_driver au1xmmc_driver = {
 
 static int __init au1xmmc_init(void)
 {
-#ifdef CONFIG_SOC_AU1200
-	/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
-	 * of 8 bits.  And since devices are shared, we need to create
-	 * our own to avoid freaking out other devices.
-	 */
-	memid = au1xxx_ddma_add_device(&au1xmmc_mem_dbdev);
-	if (!memid)
-		printk(KERN_ERR "au1xmmc: cannot add memory dbdma dev\n");
-#endif
+	if (has_dbdma()) {
+		/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
+		* of 8 bits.  And since devices are shared, we need to create
+		* our own to avoid freaking out other devices.
+		*/
+		memid = au1xxx_ddma_add_device(&au1xmmc_mem_dbdev);
+		if (!memid)
+			printk(KERN_ERR "au1xmmc: cannot add memory dbdma\n");
+	}
 	return platform_driver_register(&au1xmmc_driver);
 }
 
 static void __exit au1xmmc_exit(void)
 {
-#ifdef CONFIG_SOC_AU1200
-	if (memid)
+	if (has_dbdma() && memid)
 		au1xxx_ddma_del_device(memid);
-#endif
+
 	platform_driver_unregister(&au1xmmc_driver);
 }
 
-- 
1.7.6

