From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 12 Jan 2018 15:19:07 +0100
Message-ID: <20180112141907.18203-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The bounce buffer is gone from the MMC core, and now we found out
that there are some (crippled) i.MX boards out there that have broken
ADMA (cannot do scatter-gather), and broken PIO so they must use
SDMA. Closer examination shows a less significant slowdown also on
SDMA-only capable Laptop hosts.

SDMA sets down the number of segments to one, so that each segment
gets turned into a singular request that ping-pongs to the block
layer before the next request/segment is issued.

Apparently it happens a lot that the block layer send requests
that include a lot of physically discontigous segments. My guess
is that this phenomenon is coming from the file system.

These devices that cannot handle scatterlists in hardware can see
major benefits from a DMA-contigous bounce buffer.

This patch accumulates those fragmented scatterlists in a physically
contigous bounce buffer so that we can issue bigger DMA data chunks
to/from the card.

When tested with thise PCI-integrated host (1217:8221) that
only supports SDMA:
0b:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS
        SD/MMC Card Reader Controller (rev 05)
This patch gave ~1Mbyte/s improved throughput on large reads and
writes when testing using iozone than without the patch.

On the i.MX SDHCI controllers on the crippled i.MX 25 and i.MX 35
the patch restores the performance to what it was before we removed
the bounce buffers, and then some: performance is better than ever
because we now allocate a bounce buffer the size of the maximum
single request the SDMA engine can handle. On the PCI laptop this
is 256K, whereas with the old bounce buffer code it was 64K max.

Cc: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Benoît Thébaudeau <benoit@wsystem.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: stable@vger.kernel.org
Fixes: de3ee99b097d ("mmc: Delete bounce buffer handling")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- Go back to dma_alloc_coherent() as this apparently works better.
- Keep the other changes, cap for 64KB, fall back to single segments.
- Requesting a test of this on i.MX. (Sorry Benjamin.)
ChangeLog v3->v4:
- Cap the bounce buffer to 64KB instead of the biggest segment
  as we experience diminishing returns with buffers > 64KB.
- Instead of using dma_alloc_coherent(), use good old devm_kmalloc()
  and issue dma_sync_single_for*() to explicitly switch
  ownership between CPU and the device. This way we exercise the
  cache better and may consume less CPU.
- Bail out with single segments if we cannot allocate a bounce
  buffer.
- Tested on the PCI SDHCI on my laptop: requesting a new test
  on i.MX from Benjamin. (Please!)
ChangeLog v2->v3:
- Rewrite the commit message a bit
- Add Benjamin's Tested-by
- Add Fixes and stable tags
ChangeLog v1->v2:
- Skip the remapping and fiddling with the buffer, instead use
  dma_alloc_coherent() and use a simple, coherent bounce buffer.
- Couple kernel messages to ->parent of the mmc_host as it relates
  to the hardware characteristics.
---
 drivers/mmc/host/sdhci.c | 105 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |   3 ++
 2 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..4e594d5e3185 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
@@ -502,8 +503,22 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	if (data->host_cookie == COOKIE_PRE_MAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			      mmc_get_dma_dir(data));
+	/* Bounce write requests to the bounce buffer */
+	if (host->bounce_buffer) {
+		if (mmc_get_dma_dir(data) == DMA_TO_DEVICE) {
+			/* Copy the data to the bounce buffer */
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  host->bounce_buffer,
+					  host->bounce_buffer_size);
+		}
+		/* Just a dummy value */
+		sg_count = 1;
+	} else {
+		/* Just access the data directly from memory */
+		sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg,
+				      data->sg_len,
+				      mmc_get_dma_dir(data));
+	}
 
 	if (sg_count == 0)
 		return -ENOSPC;
@@ -858,8 +873,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
 
@@ -2248,7 +2268,12 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
 
@@ -2352,8 +2377,23 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		struct mmc_data *data = mrq->data;
 
 		if (data && data->host_cookie == COOKIE_MAPPED) {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			if (host->bounce_buffer) {
+				/*
+				 * On reads, copy the bounced data into the
+				 * sglist
+				 */
+				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+					sg_copy_from_buffer(data->sg,
+						data->sg_len,
+						host->bounce_buffer,
+						host->bounce_buffer_size);
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
@@ -2636,7 +2676,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
@@ -3713,6 +3758,47 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	if (mmc->max_segs == 1) {
+		unsigned int max_blocks;
+		unsigned int max_seg_size;
+
+		max_seg_size = SZ_64K;
+		if (mmc->max_req_size < max_seg_size)
+			max_seg_size = mmc->max_req_size;
+		max_blocks = max_seg_size / 512;
+		dev_info(mmc->parent,
+			 "host only supports SDMA, activate bounce buffer\n");
+
+		/*
+		 * When we just support one segment, we can get significant
+		 * speedup by the help of a bounce buffer to group scattered
+		 * reads/writes together.
+		 */
+		host->bounce_buffer = dma_alloc_coherent(mmc->parent,
+							 max_seg_size,
+							 &host->bounce_addr,
+							 GFP_KERNEL);
+		if (!host->bounce_buffer) {
+			dev_err(mmc->parent,
+				"failed to allocate %u bytes for bounce buffer, falling back to single segments\n",
+				max_seg_size);
+			/*
+			 * Exiting with zero here makes sure we proceed with
+			 * mmc->max_segs == 1.
+			 */
+			return 0;
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
@@ -3743,6 +3829,9 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
