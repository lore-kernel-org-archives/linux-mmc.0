From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Thu,  4 Jan 2018 21:10:45 +0100
Message-ID: <20180104201045.31139-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40616 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeADUM6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 15:12:58 -0500
Received: by mail-lf0-f67.google.com with SMTP id u84so2990817lff.7
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 12:12:58 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

The bounce buffer is gone from the MMC core, and now we found out
that there are some (crippled) i.MX boards out there that have broken
ADMA (cannot do scatter-gather), and broken PIO so they must use
SDMA.

SDMA sets down the number of segments to one, so that each segment
gets turned into a singular request that ping-pongs to the block
layer before the next request/segment is issued.

These devices can see major benefits from a bounce buffer, as
a fragmented read or write buffer may come in even though the sectors
we will be reading or writing to the MMC/SD-card are consecutive.

This patch accumulates those fragmented scatterlists in a physically
contigous bounce buffer so that we can issue bigger DMA data chunks
to/from the card.

It is possible to achieve even better speed-ups by adding a second
bounce buffer so that the ->pre_req() hook in the driver can do
the buffer copying and DMA mapping/flushing while the request is
in flight. We save this optimization for later.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I would be surprised if this works, which is why i sprinkled a
few extra prints all over the place so we can see what goes
wrong. If it would happen to work, try to comment out the noisy
prints ("bouncing read/write data") so they don't disturb test
results.
---
 drivers/mmc/host/sdhci.c | 118 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |   3 ++
 2 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..d35e25effe7d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -502,8 +502,28 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	if (data->host_cookie == COOKIE_PRE_MAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			      mmc_get_dma_dir(data));
+	/* Bounce write requests to the bounce buffer */
+	if (host->bounce_buffer) {
+		if (mmc_get_dma_dir(data) == DMA_TO_DEVICE) {
+			pr_info("bouncing write data\n");
+
+			/* Copy the data to the bounce buffer */
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  host->bounce_buffer, host->bounce_buffer_size);
+		}
+
+		/* Map the bounce buffer to the device for both reads and writes */
+		sg_count = dma_map_sg(mmc_dev(host->mmc), host->bounce_sg,
+				      1, DMA_TO_DEVICE);
+
+		/* Overzealous check */
+		if (sg_count != 1)
+			pr_err("mapped bounce buffer more than one SG entry\n");
+	} else {
+		/* Just access the data directly from memory */
+		sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				      mmc_get_dma_dir(data));
+	}
 
 	if (sg_count == 0)
 		return -ENOSPC;
@@ -858,8 +878,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sg_dma_address(data->sg),
-				SDHCI_DMA_ADDRESS);
+			/* Bounce buffer goes to work */
+			if (host->bounce_buffer)
+				sdhci_writel(host, sg_dma_address(host->bounce_sg),
+					     SDHCI_DMA_ADDRESS);
+			else
+				sdhci_writel(host, sg_dma_address(data->sg),
+					     SDHCI_DMA_ADDRESS);
 		}
 	}
 
@@ -2248,7 +2273,12 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	mrq->data->host_cookie = COOKIE_UNMAPPED;
 
-	if (host->flags & SDHCI_REQ_USE_DMA)
+	/*
+	 * No pre-mapping in the pre hook if we're using the bounce buffer,
+	 * for that we would need two bounce buffers since one buffer is
+	 * in flight when this is getting called.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
 		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
@@ -2352,8 +2382,25 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		struct mmc_data *data = mrq->data;
 
 		if (data && data->host_cookie == COOKIE_MAPPED) {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			if (host->bounce_buffer) {
+				/* Unmap the bounce buffer */
+				dma_unmap_sg(mmc_dev(host->mmc), host->bounce_sg,
+					     1, mmc_get_dma_dir(data));
+
+				/* On reads, copy the data back to the sglist */
+				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+					pr_info("bouncing read data\n");
+
+					sg_copy_from_buffer(data->sg, data->sg_len,
+							    host->bounce_buffer,
+							    host->bounce_buffer_size);
+				}
+			} else {
+				/* Unmap the raw data */
+				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+					     data->sg_len,
+					     mmc_get_dma_dir(data));
+			}
 			data->host_cookie = COOKIE_UNMAPPED;
 		}
 	}
@@ -2636,7 +2683,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
 			u32 dmastart, dmanow;
-			dmastart = sg_dma_address(host->data->sg);
+
+			if (host->bounce_buffer)
+				dmastart = sg_dma_address(host->bounce_sg);
+			else
+				dmastart = sg_dma_address(host->data->sg);
+
 			dmanow = dmastart + host->data->bytes_xfered;
 			/*
 			 * Force update to the next DMA block boundary.
@@ -3713,6 +3765,50 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	if (mmc->max_segs == 1) {
+		unsigned int max_blocks;
+		unsigned int max_seg_size;
+
+		max_seg_size = mmc->max_req_size;
+		max_blocks = max_seg_size / 512;
+
+		/*
+		 * When we just support one segment, we can get significant speedups
+		 * by the help of a bounce buffer to group scattered reads/writes
+		 * together.
+		 *
+		 * TODO: is this too big? Stealing too much memory? The old bounce
+		 * buffer is max 64K. This should be the 512K that SDMA can handle
+		 * if I read the code above right. Anyways let's try this.
+		 * FIXME: use devm_*
+		 */
+		host->bounce_buffer = kmalloc(max_seg_size, GFP_KERNEL);
+		if (!host->bounce_buffer) {
+			pr_err("failed to allocate %u bytes for bounce buffer\n",
+			       max_seg_size);
+			return -ENOMEM;
+		}
+		host->bounce_buffer_size = max_seg_size;
+
+		/*
+		 * Initialize single-entry sglist to point at the bounce buffer
+		 * FIXME: use devm_*
+		 */
+		host->bounce_sg = kmalloc(sizeof(*host->bounce_sg), GFP_KERNEL);
+		if (!host->bounce_sg) {
+			pr_err("failed to allocate bounce buffer sglist\n");
+			return -ENOMEM;
+		}
+		sg_init_one(host->bounce_sg, host->bounce_buffer, max_seg_size);
+
+		/* Lie about this since we're bouncing */
+		mmc->max_segs = max_blocks;
+		mmc->max_seg_size = max_seg_size;
+
+		pr_info("SDMA with bounce buffer: bounce up to %u segments into one, max segment size %u bytes\n",
+			max_blocks, max_seg_size);
+	}
+
 	return 0;
 
 unreg:
@@ -3743,6 +3839,12 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 				  host->align_addr);
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
+	/* kfree() on NULL is fine */
+	kfree(host->bounce_sg);
+	kfree(host->bounce_buffer);
+	/* Overzealous but following the style above */
+	host->bounce_sg = NULL;
+	host->bounce_buffer = NULL;
 }
 EXPORT_SYMBOL_GPL(sdhci_cleanup_host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444c317f..31fc2302454a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -440,6 +440,9 @@ struct sdhci_host {
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
+	char *bounce_buffer;	/* For packing SDMA reads/writes */
+	size_t bounce_buffer_size;
+	struct scatterlist *bounce_sg;
 
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
-- 
2.14.3

