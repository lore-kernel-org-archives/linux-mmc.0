From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH FIX+RESEND 7/7] mmc: omap: Get DMA request numbers via platform resource
Date: Sun,  6 Oct 2013 20:36:18 +0300
Message-ID: <1381080978-29127-7-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46806 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3JFRir (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Oct 2013 13:38:47 -0400
In-Reply-To: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, aaro.koskinen@iki.fi, Jarkko Nikula <jarkko.nikula@bitmer.com>

There is no need to define MMC DMA TX and RX request numbers locally for
OMAP1xxx and OMAP24xx and assign them non-portable way since they already
come via platform resources. See commits

6c432f7 ("ARM: OMAP1: Pass dma request lines in platform data to MMC driver")
b955eef ("ARM: OMAP2: Use hwmod to initialize mmc for 2420")

Note that mmc_omap_probe doesn't change failure mechanism in case if it
fails get DMA request number or DMA channel. In that case it just falls
back to PIO transfer for TX and/or RX.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
Aaro:
Sorry to bother you but I know you have OMAP1xxx based boards and I
apreciate if you can give a quick test :-)
I have tested this set on OMAP2420 based Nokia N810.
---
 drivers/mmc/host/omap.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 1b56f06..eb22953 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -90,17 +90,6 @@
 #define OMAP_MMC_CMDTYPE_AC	2
 #define OMAP_MMC_CMDTYPE_ADTC	3
 
-#define OMAP_DMA_MMC_TX		21
-#define OMAP_DMA_MMC_RX		22
-#define OMAP_DMA_MMC2_TX	54
-#define OMAP_DMA_MMC2_RX	55
-
-#define OMAP24XX_DMA_MMC2_TX	47
-#define OMAP24XX_DMA_MMC2_RX	48
-#define OMAP24XX_DMA_MMC1_TX	61
-#define OMAP24XX_DMA_MMC1_RX	62
-
-
 #define DRIVER_NAME "mmci-omap"
 
 /* Specifies how often in millisecs to poll for card status changes
@@ -1328,7 +1317,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
-	unsigned sig;
 	int i, ret = 0;
 	int irq;
 
@@ -1394,22 +1382,21 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	if (mmc_omap2())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
-	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (res)
+		host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn,
+						   &res->start);
 	if (!host->dma_tx)
-		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
-	if (mmc_omap2())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
-	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+		dev_warn(host->dev,
+			 "unable to obtain TX DMA. Falling back to PIO\n");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (res)
+		host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn,
+						   &res->start);
 	if (!host->dma_rx)
-		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+		dev_warn(host->dev,
+			 "unable to obtain RX DMA. Falling back to PIO\n");
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-- 
1.8.4.rc3

