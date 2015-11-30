From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 11/15] spi: davinci: Use dma_request_chan() to requesting DMA channel
Date: Mon, 30 Nov 2015 15:45:41 +0200
Message-ID: <1448891145-10766-12-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

With the new dma_request_chan() the clinet driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the davinci_mmc driver can now support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-davinci.c | 76 +++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7d3af3eacf57..540fc8754085 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/edma.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -33,8 +32,6 @@
 
 #include <linux/platform_data/spi-davinci.h>
 
-#define SPI_NO_RESOURCE		((resource_size_t)-1)
-
 #define CS_DEFAULT	0xFF
 
 #define SPIFMT_PHASE_MASK	BIT(16)
@@ -130,8 +127,6 @@ struct davinci_spi {
 
 	struct dma_chan		*dma_rx;
 	struct dma_chan		*dma_tx;
-	int			dma_rx_chnum;
-	int			dma_tx_chnum;
 
 	struct davinci_spi_platform_data pdata;
 
@@ -796,35 +791,19 @@ static irqreturn_t davinci_spi_irq(s32 irq, void *data)
 
 static int davinci_spi_request_dma(struct davinci_spi *dspi)
 {
-	dma_cap_mask_t mask;
 	struct device *sdev = dspi->bitbang.master->dev.parent;
-	int r;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
 
-	dspi->dma_rx = dma_request_channel(mask, edma_filter_fn,
-					   &dspi->dma_rx_chnum);
-	if (!dspi->dma_rx) {
-		dev_err(sdev, "request RX DMA channel failed\n");
-		r = -ENODEV;
-		goto rx_dma_failed;
-	}
+	dspi->dma_rx = dma_request_chan(sdev, "rx");
+	if (IS_ERR(dspi->dma_rx))
+		return PTR_ERR(dspi->dma_rx);
 
-	dspi->dma_tx = dma_request_channel(mask, edma_filter_fn,
-					   &dspi->dma_tx_chnum);
-	if (!dspi->dma_tx) {
-		dev_err(sdev, "request TX DMA channel failed\n");
-		r = -ENODEV;
-		goto tx_dma_failed;
+	dspi->dma_tx = dma_request_chan(sdev, "tx");
+	if (IS_ERR(dspi->dma_tx)) {
+		dma_release_channel(dspi->dma_rx);
+		return PTR_ERR(dspi->dma_tx);
 	}
 
 	return 0;
-
-tx_dma_failed:
-	dma_release_channel(dspi->dma_rx);
-rx_dma_failed:
-	return r;
 }
 
 #if defined(CONFIG_OF)
@@ -935,8 +914,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 	struct resource *r;
-	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
-	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
 	int ret = 0;
 	u32 spipc0;
 
@@ -1043,27 +1020,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (r)
-		dma_rx_chan = r->start;
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (r)
-		dma_tx_chan = r->start;
-
 	dspi->bitbang.txrx_bufs = davinci_spi_bufs;
-	if (dma_rx_chan != SPI_NO_RESOURCE &&
-	    dma_tx_chan != SPI_NO_RESOURCE) {
-		dspi->dma_rx_chnum = dma_rx_chan;
-		dspi->dma_tx_chnum = dma_tx_chan;
-
-		ret = davinci_spi_request_dma(dspi);
-		if (ret)
-			goto free_clk;
-
-		dev_info(&pdev->dev, "DMA: supported\n");
-		dev_info(&pdev->dev, "DMA: RX channel: %pa, TX channel: %pa, event queue: %d\n",
-				&dma_rx_chan, &dma_tx_chan,
-				pdata->dma_event_q);
+
+	ret = davinci_spi_request_dma(dspi);
+	if (ret == -EPROBE_DEFER) {
+		goto free_clk;
+	} else if (ret) {
+		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
+		dspi->dma_rx = NULL;
+		dspi->dma_tx = NULL;
 	}
 
 	dspi->get_rx = davinci_spi_rx_buf_u8;
@@ -1101,8 +1066,10 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	return ret;
 
 free_dma:
-	dma_release_channel(dspi->dma_rx);
-	dma_release_channel(dspi->dma_tx);
+	if (dspi->dma_rx) {
+		dma_release_channel(dspi->dma_rx);
+		dma_release_channel(dspi->dma_tx);
+	}
 free_clk:
 	clk_disable_unprepare(dspi->clk);
 free_master:
@@ -1133,6 +1100,11 @@ static int davinci_spi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dspi->clk);
 	spi_master_put(master);
 
+	if (dspi->dma_rx) {
+		dma_release_channel(dspi->dma_rx);
+		dma_release_channel(dspi->dma_tx);
+	}
+
 	return 0;
 }
 
-- 
2.6.3
