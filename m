From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: davinci: Use dma_request_chan() for requesting DMA channel" to the spi tree
Date: Mon, 02 May 2016 12:04:04 +0100
Message-ID: <E1axBe0-0001mJ-5g@debutante>
References: <1448891145-10766-12-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448891145-10766-12-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The patch

   spi: davinci: Use dma_request_chan() for requesting DMA channel

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fe5fd2540947a6c584e70f1249007dd636e62d78 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 29 Apr 2016 16:10:22 +0300
Subject: [PATCH] spi: davinci: Use dma_request_chan() for requesting DMA
 channel

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 76 +++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index fddb7a3be322..d36c11b73a35 100644
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
 
@@ -797,35 +792,19 @@ static irqreturn_t davinci_spi_irq(s32 irq, void *data)
 
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
@@ -936,8 +915,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 	struct resource *r;
-	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
-	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
 	int ret = 0;
 	u32 spipc0;
 
@@ -1044,27 +1021,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
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
@@ -1102,8 +1067,10 @@ static int davinci_spi_probe(struct platform_device *pdev)
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
@@ -1134,6 +1101,11 @@ static int davinci_spi_remove(struct platform_device *pdev)
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
2.8.1
