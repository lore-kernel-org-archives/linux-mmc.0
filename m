From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mmc: omap: Use dma_request_chan() for requesting DMA channel
Date: Fri, 29 Apr 2016 16:06:37 +0300
Message-ID: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
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
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b9958a123594..a8d9228657b2 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -23,7 +23,6 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/of.h>
-#include <linux/omap-dma.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/mmc.h>
@@ -1321,8 +1320,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
-	dma_cap_mask_t mask;
-	unsigned sig = 0;
 	int i, ret = 0;
 	int irq;
 
@@ -1382,29 +1379,31 @@ static int mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_iclk;
 	}
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (res)
-		sig = res->start;
-	host->dma_tx = dma_request_slave_channel_compat(mask,
-				omap_dma_filter_fn, &sig, &pdev->dev, "tx");
-	if (!host->dma_tx)
-		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (res)
-		sig = res->start;
-	host->dma_rx = dma_request_slave_channel_compat(mask,
-				omap_dma_filter_fn, &sig, &pdev->dev, "rx");
-	if (!host->dma_rx)
-		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
+		ret = PTR_ERR(host->dma_tx);
+		if (ret == -EPROBE_DEFER)
+			goto err_free_iclk;
+
+		host->dma_tx = NULL;
+		dev_warn(host->dev, "TX DMA channel request failed\n");
+	}
+
+	host->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(host->dma_rx)) {
+		ret = PTR_ERR(host->dma_rx);
+		if (ret == -EPROBE_DEFER) {
+			dma_release_channel(host->dma_tx);
+			clk_put(host->fclk);
+			goto err_free_iclk;
+		}
+
+		host->dma_rx = NULL;
+		dev_warn(host->dev, "RX DMA channel request failed\n");
+	}
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-- 
2.8.1
