From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 6/6] mmc: davinci_mmc: Switch to use the new dmaengine API for requesting channel (NOT FOR MERGE)
Date: Fri, 27 Nov 2015 10:29:42 +0200
Message-ID: <1448612982-28141-7-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

With the new dma_request_chan() the clinet driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the davinci_mmc driver can now support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/davinci_mmc.c | 51 ++++++++++++------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ea2a2ebc6b91..e69bdeeee032 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -37,7 +37,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/platform_data/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
 
 /*
@@ -517,35 +516,20 @@ davinci_release_dma_channels(struct mmc_davinci_host *host)
 
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
+	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx", NULL);
+	if (IS_ERR(host->dma_tx)) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
-		return -ENODEV;
+		return PTR_ERR(host->dma_tx);
 	}
 
-	host->dma_rx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->rxdma, mmc_dev(host->mmc), "rx");
-	if (!host->dma_rx) {
+	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx", NULL);
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
@@ -1262,18 +1246,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
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
@@ -1300,8 +1272,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
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
2.6.3
