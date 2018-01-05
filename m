From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri,  5 Jan 2018 15:15:35 +0100
Message-ID: <20180105141535.17614-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34856 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeAEORm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 09:17:42 -0500
Received: by mail-lf0-f65.google.com with SMTP id h5so5305743lfj.2
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2018 06:17:41 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pierre Ossman <pierre@ossman.eu>

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

When tested with thise PCI-integrated host (1217:8221) that
only supports SDMA:
0b:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS
        SD/MMC Card Reader Controller (rev 05)
This patch gave ~1Mbyte/s improved throughput on large reads and
writes when testing using iozone than without the patch.

It is possible to achieve even better speed-ups by adding a second
bounce buffer so that the ->pre_req() hook in the driver can do
the buffer copying and DMA mapping/flushing while the request is
in flight. We save this optimization for later.

Cc: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Skip the remapping and fiddling with the buffer, instead use
  dma_alloc_coherent() and use a simple, coherent bounce buffer.
- Couple kernel messages to ->parent of the mmc_host as it relates
  to the hardware characteristics.
---
 drivers/mmc/host/sdhci.c | 94 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h |  3 ++
 2 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..97d4c6fc1159 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -502,8 +502,20 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	if (data->host_cookie == COOKIE_PRE_MAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			      mmc_get_dma_dir(data));
+	/* Bounce write requests to the bounce buffer */
+	if (host->bounce_buffer) {
+		if (mmc_get_dma_dir(data) == DMA_TO_DEVICE) {
+			/* Copy the data to the bounce buffer */
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  host->bounce_buffer, host->bounce_buffer_size);
+		}
+		/* Just a dummy value */
+		sg_count = 1;
+	} else {
+		/* Just access the data directly from memory */
+		sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				      mmc_get_dma_dir(data));
+	}
 
 	if (sg_count == 0)
 		return -ENOSPC;
@@ -858,8 +870,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sg_dma_address(data->sg),
-				SDHCI_DMA_ADDRESS);
+			/* Bounce buffer goes to work */
+			if (host->bounce_buffer)
+				sdhci_writel(host, host->bounce_addr,
+					     SDHCI_DMA_ADDRESS);
+			else
+				sdhci_writel(host, sg_dma_address(data->sg),
+					     SDHCI_DMA_ADDRESS);
 		}
 	}
 
@@ -2248,7 +2265,12 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
 
@@ -2352,8 +2374,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		struct mmc_data *data = mrq->data;
 
 		if (data && data->host_cookie == COOKIE_MAPPED) {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			if (host->bounce_buffer) {
+				/* On reads, copy the bounced data into the sglist */
+				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
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
@@ -2636,7 +2669,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
 			u32 dmastart, dmanow;
-			dmastart = sg_dma_address(host->data->sg);
+
+			if (host->bounce_buffer)
+				dmastart = host->bounce_addr;
+			else
+				dmastart = sg_dma_address(host->data->sg);
+
 			dmanow = dmastart + host->data->bytes_xfered;
 			/*
 			 * Force update to the next DMA block boundary.
@@ -3713,6 +3751,43 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	if (mmc->max_segs == 1) {
+		unsigned int max_blocks;
+		unsigned int max_seg_size;
+
+		max_seg_size = mmc->max_req_size;
+		max_blocks = max_seg_size / 512;
+		dev_info(mmc->parent, "host only supports SDMA, activate bounce buffer\n");
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
+		host->bounce_buffer = dma_alloc_coherent(mmc->parent, max_seg_size,
+							 &host->bounce_addr, GFP_KERNEL);
+		if (!host->bounce_buffer) {
+			dev_err(mmc->parent,
+				"failed to allocate %u bytes for bounce buffer\n",
+				max_seg_size);
+			return -ENOMEM;
+		}
+		host->bounce_buffer_size = max_seg_size;
+
+		/* Lie about this since we're bouncing */
+		mmc->max_segs = max_blocks;
+		mmc->max_seg_size = max_seg_size;
+
+		dev_info(mmc->parent,
+			 "bounce buffer: bounce up to %u segments into one, max segment size %u bytes\n",
+			 max_blocks, max_seg_size);
+	}
+
 	return 0;
 
 unreg:
@@ -3743,6 +3818,9 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 				  host->align_addr);
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
+	if (host->bounce_buffer)
+		dma_free_coherent(mmc->parent, host->bounce_buffer_size,
+				  host->bounce_buffer, host->bounce_addr);
 }
 EXPORT_SYMBOL_GPL(sdhci_cleanup_host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444c317f..865e09618d22 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -440,6 +440,9 @@ struct sdhci_host {
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
+	char *bounce_buffer;	/* For packing SDMA reads/writes */
+	dma_addr_t bounce_addr;
+	size_t bounce_buffer_size;
 
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
-- 
2.14.3

