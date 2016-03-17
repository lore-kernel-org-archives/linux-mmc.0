From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 1/5] mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
Date: Wed, 16 Mar 2016 22:45:31 -0500
Message-ID: <1458186341-6970-2-git-send-email-david@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, David Lechner <david@lechnology.com>, Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

v3 changes: This is a new patch in v3 (from Peter Ujfalusi) and replaces my
previous "mmc: davinci: don't use dma platform resources" patch.


 drivers/mmc/host/davinci_mmc.c | 53 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 693144e..eb3ca9e 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -32,12 +32,10 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/edma.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/platform_data/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
 
 /*
@@ -202,7 +200,6 @@ struct mmc_davinci_host {
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
-	u32 rxdma, txdma;
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	bool use_dma;
@@ -513,35 +510,20 @@ davinci_release_dma_channels(struct mmc_davinci_host *host)
 
 static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 {
-	int r;
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->dma_tx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->txdma, mmc_dev(host->mmc), "tx");
-	if (!host->dma_tx) {
+	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
+	if (IS_ERR(host->dma_tx)) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
-		return -ENODEV;
+		return PTR_ERR(host->dma_tx);
 	}
 
-	host->dma_rx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->rxdma, mmc_dev(host->mmc), "rx");
-	if (!host->dma_rx) {
+	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
+	if (IS_ERR(host->dma_rx)) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
-		r = -ENODEV;
-		goto free_master_write;
+		dma_release_channel(host->dma_tx);
+		return PTR_ERR(host->dma_rx);
 	}
 
 	return 0;
-
-free_master_write:
-	dma_release_channel(host->dma_tx);
-
-	return r;
 }
 
 /*----------------------------------------------------------------------*/
@@ -1253,18 +1235,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
-	else
-		host->rxdma = r->start;
-
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
-	else
-		host->txdma = r->start;
-
 	host->mem_res = mem;
 	host->base = ioremap(mem->start, mem_size);
 	if (!host->base)
@@ -1291,8 +1261,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host->mmc_irq = irq;
 	host->sdio_irq = platform_get_irq(pdev, 1);
 
-	if (host->use_dma && davinci_acquire_dma_channels(host) != 0)
-		host->use_dma = 0;
+	if (host->use_dma) {
+		ret = davinci_acquire_dma_channels(host);
+		if (ret == -EPROBE_DEFER)
+			goto out;
+		else if (ret)
+			host->use_dma = 0;
+	}
 
 	/* REVISIT:  someday, support IRQ-driven card detection.  */
 	mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
1.9.1
