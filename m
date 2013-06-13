From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH] mmc: omap: remove unnecessary #if 0's
Date: Thu, 13 Jun 2013 18:25:55 +0300
Message-ID: <1371137155-15318-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454Ab3FMP0A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 11:26:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com

In commit 3451c067 (mmc: omap: add DMA engine support), some #if 0's
were used to comment out parts of the code.  This has been in the code
for over a year and are not needed anymore (and the commented-out code
doesn't even compile).  Remove them.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 drivers/mmc/host/omap.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 4b3e0eb..b94f38e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1413,33 +1413,17 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	else
 		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
 	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
-#if 0
-	if (!host->dma_tx) {
-		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
-	}
-#else
 	if (!host->dma_tx)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
 			sig);
-#endif
 	if (mmc_omap2())
 		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
 	else
 		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
 	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
-#if 0
-	if (!host->dma_rx) {
-		dev_err(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
-	}
-#else
 	if (!host->dma_rx)
 		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
 			sig);
-#endif
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-- 
1.7.10.4

