From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] mmc: Remove distinction between hw and phys segments
Date: Fri, 10 Sep 2010 01:33:59 -0400
Message-ID: <yq1occ6qi0o.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:28183 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab0IJFfA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Sep 2010 01:35:00 -0400
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by rcsinet10.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id o8A5YvAA024456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 05:34:58 GMT
Received: from acsmt353.oracle.com (acsmt353.oracle.com [141.146.40.153])
	by acsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id o8A0Oq3w001326
	for <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 05:34:56 GMT
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


We have deprecated the distinction between hardware and physical
segments in the block layer.  Consolidate the two limits into one in
drivers/mmc/.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index e876678..efcad8c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -147,7 +147,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 	}
 
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
-	if (host->max_hw_segs == 1) {
+	if (host->max_segs == 1) {
 		unsigned int bouncesz;
 
 		bouncesz = MMC_QUEUE_BOUNCESZ;
@@ -197,16 +197,16 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 		blk_queue_bounce_limit(mq->queue, limit);
 		blk_queue_max_hw_sectors(mq->queue,
 			min(host->max_blk_count, host->max_req_size / 512));
-		blk_queue_max_segments(mq->queue, host->max_hw_segs);
+		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
 		mq->sg = kmalloc(sizeof(struct scatterlist) *
-			host->max_phys_segs, GFP_KERNEL);
+			host->max_segs, GFP_KERNEL);
 		if (!mq->sg) {
 			ret = -ENOMEM;
 			goto cleanup_queue;
 		}
-		sg_init_table(mq->sg, host->max_phys_segs);
+		sg_init_table(mq->sg, host->max_segs);
 	}
 
 	init_MUTEX(&mq->thread_sem);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d80cfdc..10b8af2 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -94,8 +94,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	 * By default, hosts do not support SGIO or large requests.
 	 * They have to set these according to their abilities.
 	 */
-	host->max_hw_segs = 1;
-	host->max_phys_segs = 1;
+	host->max_segs = 1;
 	host->max_seg_size = PAGE_CACHE_SIZE;
 
 	host->max_req_size = PAGE_CACHE_SIZE;
diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 5f3a599..80a95b4 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -946,8 +946,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	mmc->max_blk_size  = MCI_MAXBLKSIZE;
 	mmc->max_blk_count = MCI_BLKATONCE;
 	mmc->max_req_size  = MCI_BUFSIZE;
-	mmc->max_phys_segs = MCI_BLKATONCE;
-	mmc->max_hw_segs   = MCI_BLKATONCE;
+	mmc->max_segs      = MCI_BLKATONCE;
 	mmc->max_seg_size  = MCI_BUFSIZE;
 
 	host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 95ef864..ac7989f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1618,8 +1618,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	if (slot_data->bus_width >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	mmc->max_hw_segs = 64;
-	mmc->max_phys_segs = 64;
+	mmc->max_segs = 64;
 	mmc->max_req_size = 32768 * 512;
 	mmc->max_blk_size = 32768;
 	mmc->max_blk_count = 512;
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index c8da5d3..59b2265 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -998,7 +998,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->f_max = 24000000;
 
 	mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
-	mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT;
+	mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
 
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 512;
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 4b0e677..bac7d62 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -469,7 +469,7 @@ static int __devinit sdh_probe(struct platform_device *pdev)
 	}
 
 	mmc->ops = &sdh_ops;
-	mmc->max_phys_segs = 32;
+	mmc->max_segs = 32;
 	mmc->max_seg_size = 1 << 16;
 	mmc->max_blk_size = 1 << 11;
 	mmc->max_blk_count = 1 << 11;
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 33d9f1b..e15547c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -138,7 +138,7 @@
 /*
  * One scatterlist dma "segment" is at most MAX_CCNT rw_threshold units,
  * and we handle up to MAX_NR_SG segments.  MMC_BLOCK_BOUNCE kicks in only
- * for drivers with max_hw_segs == 1, making the segments bigger (64KB)
+ * for drivers with max_segs == 1, making the segments bigger (64KB)
  * than the page or two that's otherwise typical. nr_sg (passed from
  * platform data) == 16 gives at least the same throughput boost, using
  * EDMA transfer linkage instead of spending CPU time copying pages.
@@ -1239,8 +1239,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	 * Each hw_seg uses one EDMA parameter RAM slot, always one
 	 * channel and then usually some linked slots.
 	 */
-	mmc->max_hw_segs	= 1 + host->n_link;
-	mmc->max_phys_segs	= mmc->max_hw_segs;
+	mmc->max_segs		= 1 + host->n_link;
 
 	/* EDMA limit per hw segment (one or two MBytes) */
 	mmc->max_seg_size	= MAX_CCNT * rw_threshold;
@@ -1250,8 +1249,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	mmc->max_blk_count	= 65535; /* NBLK is 16 bits */
 	mmc->max_req_size	= mmc->max_blk_size * mmc->max_blk_count;
 
-	dev_dbg(mmc_dev(host->mmc), "max_phys_segs=%d\n", mmc->max_phys_segs);
-	dev_dbg(mmc_dev(host->mmc), "max_hw_segs=%d\n", mmc->max_hw_segs);
+	dev_dbg(mmc_dev(host->mmc), "max_segs=%d\n", mmc->max_segs);
 	dev_dbg(mmc_dev(host->mmc), "max_blk_size=%d\n", mmc->max_blk_size);
 	dev_dbg(mmc_dev(host->mmc), "max_req_size=%d\n", mmc->max_req_size);
 	dev_dbg(mmc_dev(host->mmc), "max_seg_size=%d\n", mmc->max_seg_size);
diff --git a/drivers/mmc/host/imxmmc.c b/drivers/mmc/host/imxmmc.c
index 9a68ff4..24f24c8 100644
--- a/drivers/mmc/host/imxmmc.c
+++ b/drivers/mmc/host/imxmmc.c
@@ -965,8 +965,7 @@ static int __init imxmci_probe(struct platform_device *pdev)
 	mmc->caps = MMC_CAP_4_BIT_DATA;
 
 	/* MMC core transfer sizes tunable parameters */
-	mmc->max_hw_segs = 64;
-	mmc->max_phys_segs = 64;
+	mmc->max_segs = 64;
 	mmc->max_seg_size = 64*512;	/* default PAGE_CACHE_SIZE */
 	mmc->max_req_size = 64*512;	/* default PAGE_CACHE_SIZE */
 	mmc->max_blk_size = 2048;
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index ad4f987..b3a0ab0 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -876,8 +876,7 @@ static int __devinit jz4740_mmc_probe(struct platform_device* pdev)
 	mmc->max_blk_count = (1 << 15) - 1;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 
-	mmc->max_phys_segs = 128;
-	mmc->max_hw_segs = 128;
+	mmc->max_segs = 128;
 	mmc->max_seg_size = mmc->max_req_size;
 
 	host->mmc = mmc;
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 62a3582..5b0b506 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1345,8 +1345,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 
 	mmc->ops = &mmc_spi_ops;
 	mmc->max_blk_size = MMC_SPI_BLOCKSIZE;
-	mmc->max_hw_segs = MMC_SPI_BLOCKSATONCE;
-	mmc->max_phys_segs = MMC_SPI_BLOCKSATONCE;
+	mmc->max_segs = MMC_SPI_BLOCKSATONCE;
 	mmc->max_req_size = MMC_SPI_BLOCKSATONCE * MMC_SPI_BLOCKSIZE;
 	mmc->max_blk_count = MMC_SPI_BLOCKSATONCE;
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 840b301..4b91a2c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -704,8 +704,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	/*
 	 * We can do SGIO
 	 */
-	mmc->max_hw_segs = 16;
-	mmc->max_phys_segs = NR_SG;
+	mmc->max_segs = NR_SG;
 
 	/*
 	 * Since only a certain number of bits are valid in the data length
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index ff77523..1290d14 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1164,8 +1164,7 @@ msmsdcc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
 
-	mmc->max_phys_segs = NR_SG;
-	mmc->max_hw_segs = NR_SG;
+	mmc->max_segs = NR_SG;
 	mmc->max_blk_size = 4096;	/* MCI_DATA_CTL BLOCKSIZE up to 4096 */
 	mmc->max_blk_count = 65536;
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 366eefa..a5bf60e 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -742,8 +742,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 
-	mmc->max_hw_segs = 1;
-	mmc->max_phys_segs = 1;
+	mmc->max_segs = 1;
 	mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 350f78e..bdd2cbb 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -790,8 +790,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	/* MMC core transfer sizes tunable parameters */
-	mmc->max_hw_segs = 64;
-	mmc->max_phys_segs = 64;
+	mmc->max_segs = 64;
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index d98ddcf..0c7e37f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1335,8 +1335,7 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	 * NOTE max_seg_size assumption that small blocks aren't
 	 * normally used (except e.g. for reading SD registers).
 	 */
-	mmc->max_phys_segs = 32;
-	mmc->max_hw_segs = 32;
+	mmc->max_segs = 32;
 	mmc->max_blk_size = 2048;	/* BLEN is 11 bits (+1) */
 	mmc->max_blk_count = 2048;	/* NBLK is 11 bits (+1) */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4a8776f..6dd451f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2105,8 +2105,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	/* Since we do only SG emulation, we can have as many segs
 	 * as we want. */
-	mmc->max_phys_segs = 1024;
-	mmc->max_hw_segs = 1024;
+	mmc->max_segs = 1024;
 
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 0a4e43f..b7dfcac 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -576,7 +576,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	 * We can do SG-DMA, but we don't because we never know how much
 	 * data we successfully wrote to the card.
 	 */
-	mmc->max_phys_segs = NR_SG;
+	mmc->max_segs = NR_SG;
 
 	/*
 	 * Our hardware DMA can handle a maximum of one page per SG entry.
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2e16e0a..262b388 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1736,8 +1736,7 @@ static int __devinit s3cmci_probe(struct platform_device *pdev)
 	mmc->max_req_size	= 4095 * 512;
 	mmc->max_seg_size	= mmc->max_req_size;
 
-	mmc->max_phys_segs	= 128;
-	mmc->max_hw_segs	= 128;
+	mmc->max_segs		= 128;
 
 	dbg(host, dbg_debug,
 	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%u.\n",
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..f608626 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1850,12 +1850,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * can do scatter/gather or not.
 	 */
 	if (host->flags & SDHCI_USE_ADMA)
-		mmc->max_hw_segs = 128;
+		mmc->max_segs = 128;
 	else if (host->flags & SDHCI_USE_SDMA)
-		mmc->max_hw_segs = 1;
+		mmc->max_segs = 1;
 	else /* PIO */
-		mmc->max_hw_segs = 128;
-	mmc->max_phys_segs = 128;
+		mmc->max_segs = 128;
 
 	/*
 	 * Maximum number of sectors in one transfer. Limited by DMA boundary
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5d3f824..0f06b80 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -846,8 +846,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
 	if (pd->caps)
 		mmc->caps |= pd->caps;
-	mmc->max_phys_segs = 128;
-	mmc->max_hw_segs = 128;
+	mmc->max_segs = 128;
 	mmc->max_blk_size = 512;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index cec9995..457c26e 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -978,11 +978,10 @@ static int tifm_sd_probe(struct tifm_dev *sock)
 	mmc->f_max = 24000000;
 
 	mmc->max_blk_count = 2048;
-	mmc->max_hw_segs = mmc->max_blk_count;
+	mmc->max_segs = mmc->max_blk_count;
 	mmc->max_blk_size = min(TIFM_MMCSD_MAX_BLOCK_SIZE, PAGE_SIZE);
 	mmc->max_seg_size = mmc->max_blk_count * mmc->max_blk_size;
 	mmc->max_req_size = mmc->max_seg_size;
-	mmc->max_phys_segs = mmc->max_hw_segs;
 
 	sock->card_event = tifm_sd_card_event;
 	sock->data_event = tifm_sd_data_event;
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 19f2d72..9ed84dd 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1050,8 +1050,7 @@ static void via_init_mmc_host(struct via_crdr_mmc_host *host)
 	mmc->ops = &via_sdc_ops;
 
 	/*Hardware cannot do scatter lists*/
-	mmc->max_hw_segs = 1;
-	mmc->max_phys_segs = 1;
+	mmc->max_segs = 1;
 
 	mmc->max_blk_size = VIA_CRDR_MAX_BLOCK_LENGTH;
 	mmc->max_blk_count = VIA_CRDR_MAX_BLOCK_COUNT;
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 0012f5d..7fca0a3 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1235,8 +1235,7 @@ static int __devinit wbsd_alloc_mmc(struct device *dev)
 	 * Maximum number of segments. Worst case is one sector per segment
 	 * so this will be 64kB/512.
 	 */
-	mmc->max_hw_segs = 128;
-	mmc->max_phys_segs = 128;
+	mmc->max_segs = 128;
 
 	/*
 	 * Maximum request size. Also limited by 64KiB buffer.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1575b52..ded4017 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -162,8 +162,7 @@ struct mmc_host {
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
-	unsigned short		max_hw_segs;	/* see blk_queue_max_hw_segments */
-	unsigned short		max_phys_segs;	/* see blk_queue_max_phys_segments */
+	unsigned short		max_segs;	/* see blk_queue_max_segments */
 	unsigned short		unused;
 	unsigned int		max_req_size;	/* maximum number of bytes in one req */
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
