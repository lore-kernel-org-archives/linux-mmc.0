From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: omap_hsmmc: don't print uninitialized variables
Date: Mon, 25 Jan 2016 16:50:20 +0100
Message-ID: <1453737031-1959584-1-git-send-email-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54830 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889AbcAYPvF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2016 10:51:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Arnd Bergmann <arnd@arndb.de>, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

When DT based probing is used but the DMA request fails, the
driver will print uninitialized stack data from the rx_req
and tx_req variables, as indicated by this warning:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);

This restructures the function to separate the simple DT probe
from the more complex platform data code path, and only
prints the information that is actually available and
needed in case of an error, which makes it nicer to read
and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/omap_hsmmc.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b6639ea0bf18..e06b1881b6a1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2002,8 +2002,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 	const struct of_device_id *match;
-	dma_cap_mask_t mask;
-	unsigned tx_req, rx_req;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
 
@@ -2133,7 +2131,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	if (!pdev->dev.of_node) {
+	host->tx_chan = dma_request_slave_channel(&pdev->dev, "tx");
+	host->rx_chan = dma_request_slave_channel(&pdev->dev, "rx");
+	if (!host->tx_chan || !host->rx_chan) {
+		dma_cap_mask_t mask;
+		unsigned tx_req, rx_req;
+
+		dev_err(mmc_dev(host->mmc), "falling back to manual DMA configuration\n");
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
 		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
 		if (!res) {
 			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
@@ -2141,6 +2149,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 			goto err_irq;
 		}
 		tx_req = res->start;
+		host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
+		if (!host->rx_chan) {
+			dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
+			ret = -ENXIO;
+			goto err_irq;
+		}
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 		if (!res) {
@@ -2149,29 +2163,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 			goto err_irq;
 		}
 		rx_req = res->start;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->rx_chan =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &rx_req, &pdev->dev, "rx");
+		host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
 
-	if (!host->rx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
-		ret = -ENXIO;
-		goto err_irq;
-	}
-
-	host->tx_chan =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &tx_req, &pdev->dev, "tx");
-
-	if (!host->tx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
-		ret = -ENXIO;
-		goto err_irq;
+		if (!host->tx_chan) {
+			dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
+			ret = -ENXIO;
+			goto err_irq;
+		}
 	}
 
 	/* Request IRQ for MMC operations */
-- 
2.7.0

