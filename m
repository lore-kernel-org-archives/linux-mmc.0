From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mmc: omap_hsmmc:  Use dma_request_chan() for requesting DMA channel
Date: Fri, 29 Apr 2016 16:06:18 +0300
Message-ID: <1461935178-28617-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com
Cc: tony@atomide.com, rogerq@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 50 +++++++++----------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e9d75c6dd516..06a167292820 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -32,7 +32,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
-#include <linux/omap-dmaengine.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
@@ -1989,8 +1988,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 	const struct of_device_id *match;
-	dma_cap_mask_t mask;
-	unsigned tx_req, rx_req;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
 
@@ -2120,44 +2117,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	if (!pdev->dev.of_node) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-		if (!res) {
-			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
-			ret = -ENXIO;
-			goto err_irq;
-		}
-		tx_req = res->start;
-
-		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-		if (!res) {
-			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
-			ret = -ENXIO;
-			goto err_irq;
-		}
-		rx_req = res->start;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->rx_chan =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &rx_req, &pdev->dev, "rx");
-
-	if (!host->rx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
-		ret = -ENXIO;
+	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(host->rx_chan)) {
+		dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
+		ret = PTR_ERR(host->rx_chan);
 		goto err_irq;
 	}
 
-	host->tx_chan =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &tx_req, &pdev->dev, "tx");
-
-	if (!host->tx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
-		ret = -ENXIO;
+	host->tx_chan = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(host->tx_chan)) {
+		dev_err(mmc_dev(host->mmc), "TX DMA channel request failed\n");
+		ret = PTR_ERR(host->tx_chan);
 		goto err_irq;
 	}
 
@@ -2215,9 +2185,9 @@ err_slot_name:
 	mmc_remove_host(mmc);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
-	if (host->tx_chan)
+	if (!IS_ERR_OR_NULL(host->tx_chan))
 		dma_release_channel(host->tx_chan);
-	if (host->rx_chan)
+	if (!IS_ERR_OR_NULL(host->rx_chan))
 		dma_release_channel(host->rx_chan);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
-- 
2.8.1
