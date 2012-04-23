From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 11/12] spi: omap2-mcspi: remove private DMA API
 implementation
Date: Mon, 23 Apr 2012 17:07:53 +0100
Message-ID: <E1SMLnt-0002Wm-26@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

Remove the private DMA API implementation from spi-omap2-mcspi.c,
making it use entirely the DMA engine API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/spi/spi-omap2-mcspi.c |  104 ++---------------------------------------
 1 files changed, 5 insertions(+), 99 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b2461d7..e1a3432 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -20,8 +20,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  */
-#define USE_DMA_ENGINE_RX
-#define USE_DMA_ENGINE_TX
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -42,7 +40,6 @@
 
 #include <linux/spi/spi.h>
 
-#include <plat/dma.h>
 #include <plat/clock.h>
 #include <plat/mcspi.h>
 
@@ -100,8 +97,6 @@
 struct omap2_mcspi_dma {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
-	int dma_tx_channel;
-	int dma_rx_channel;
 
 	int dma_tx_sync_dev;
 	int dma_rx_sync_dev;
@@ -325,9 +320,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, c;
-	unsigned long		base, tx_reg, rx_reg;
-	int			word_len, data_type, element_count;
+	unsigned int		count;
+	int			word_len, element_count;
 	int			elements = 0;
 	u32			l;
 	u8			* rx;
@@ -409,73 +403,26 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
-	c = count;
 	word_len = cs->word_len;
 
-	base = cs->phys;
-	tx_reg = base + OMAP2_MCSPI_TX0;
-	rx_reg = base + OMAP2_MCSPI_RX0;
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
 
 	if (word_len <= 8) {
-		data_type = OMAP_DMA_DATA_TYPE_S8;
 		element_count = count;
 	} else if (word_len <= 16) {
-		data_type = OMAP_DMA_DATA_TYPE_S16;
 		element_count = count >> 1;
 	} else /* word_len <= 32 */ {
-		data_type = OMAP_DMA_DATA_TYPE_S32;
 		element_count = count >> 2;
 	}
 
-	if (tx != NULL && mcspi_dma->dma_tx_channel != -1) {
-		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
-				data_type, element_count, 1,
-				OMAP_DMA_SYNC_ELEMENT,
-				mcspi_dma->dma_tx_sync_dev, 0);
-
-		omap_set_dma_dest_params(mcspi_dma->dma_tx_channel, 0,
-				OMAP_DMA_AMODE_CONSTANT,
-				tx_reg, 0, 0);
-
-		omap_set_dma_src_params(mcspi_dma->dma_tx_channel, 0,
-				OMAP_DMA_AMODE_POST_INC,
-				xfer->tx_dma, 0, 0);
-	}
-
-	if (rx != NULL && mcspi_dma->dma_rx_channel != -1) {
-		elements = element_count - 1;
-		if (l & OMAP2_MCSPI_CHCONF_TURBO)
-			elements--;
-
-		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
-				data_type, elements, 1,
-				OMAP_DMA_SYNC_ELEMENT,
-				mcspi_dma->dma_rx_sync_dev, 1);
-
-		omap_set_dma_src_params(mcspi_dma->dma_rx_channel, 0,
-				OMAP_DMA_AMODE_CONSTANT,
-				rx_reg, 0, 0);
-
-		omap_set_dma_dest_params(mcspi_dma->dma_rx_channel, 0,
-				OMAP_DMA_AMODE_POST_INC,
-				xfer->rx_dma, 0, 0);
-	}
-
 	if (tx != NULL) {
-		if (mcspi_dma->dma_tx)
-			dma_async_issue_pending(mcspi_dma->dma_tx);
-		else
-			omap_start_dma(mcspi_dma->dma_tx_channel);
+		dma_async_issue_pending(mcspi_dma->dma_tx);
 		omap2_mcspi_set_dma_req(spi, 0, 1);
 	}
 
 	if (rx != NULL) {
-		if (mcspi_dma->dma_rx)
-			dma_async_issue_pending(mcspi_dma->dma_rx);
-		else
-			omap_start_dma(mcspi_dma->dma_rx_channel);
+		dma_async_issue_pending(mcspi_dma->dma_rx);
 		omap2_mcspi_set_dma_req(spi, 1, 1);
 	}
 
@@ -819,16 +766,6 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static void omap2_mcspi_dma_rx_callback(int lch, u16 ch_status, void *data)
-{
-	omap2_mcspi_rx_callback(data);
-}
-
-static void omap2_mcspi_dma_tx_callback(int lch, u16 ch_status, void *data)
-{
-	omap2_mcspi_tx_callback(data);
-}
-
 extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
 
 static int omap2_mcspi_request_dma(struct spi_device *spi)
@@ -847,23 +784,13 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-#ifdef USE_DMA_ENGINE_RX
 	sig = mcspi_dma->dma_rx_sync_dev;
 	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 	if (!mcspi_dma->dma_rx) {
 		dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
 		return -EAGAIN;
 	}
-#else
-	if (omap_request_dma(mcspi_dma->dma_rx_sync_dev, "McSPI RX",
-			omap2_mcspi_dma_rx_callback, spi,
-			&mcspi_dma->dma_rx_channel)) {
-		dev_err(&spi->dev, "no RX DMA channel for McSPI\n");
-		return -EAGAIN;
-	}
-#endif
 
-#ifdef USE_DMA_ENGINE_TX
 	sig = mcspi_dma->dma_tx_sync_dev;
 	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 	if (!mcspi_dma->dma_tx) {
@@ -872,16 +799,6 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		mcspi_dma->dma_rx = NULL;
 		return -EAGAIN;
 	}
-#else
-	if (omap_request_dma(mcspi_dma->dma_tx_sync_dev, "McSPI TX",
-			omap2_mcspi_dma_tx_callback, spi,
-			&mcspi_dma->dma_tx_channel)) {
-		omap_free_dma(mcspi_dma->dma_rx_channel);
-		mcspi_dma->dma_rx_channel = -1;
-		dev_err(&spi->dev, "no TX DMA channel for McSPI\n");
-		return -EAGAIN;
-	}
-#endif
 
 	return 0;
 }
@@ -915,8 +832,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
 	}
 
-	if ((!mcspi_dma->dma_rx && mcspi_dma->dma_rx_channel == -1) ||
-	    (!mcspi_dma->dma_tx && mcspi_dma->dma_tx_channel == -1)) {
+	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
 		ret = omap2_mcspi_request_dma(spi);
 		if (ret < 0)
 			return ret;
@@ -959,14 +875,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 			dma_release_channel(mcspi_dma->dma_tx);
 			mcspi_dma->dma_tx = NULL;
 		}
-		if (mcspi_dma->dma_rx_channel != -1) {
-			omap_free_dma(mcspi_dma->dma_rx_channel);
-			mcspi_dma->dma_rx_channel = -1;
-		}
-		if (mcspi_dma->dma_tx_channel != -1) {
-			omap_free_dma(mcspi_dma->dma_tx_channel);
-			mcspi_dma->dma_tx_channel = -1;
-		}
 	}
 }
 
@@ -1326,7 +1234,6 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 			break;
 		}
 
-		mcspi->dma_channels[i].dma_rx_channel = -1;
 		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		sprintf(dma_ch_name, "tx%d", i);
 		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
@@ -1337,7 +1244,6 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 			break;
 		}
 
-		mcspi->dma_channels[i].dma_tx_channel = -1;
 		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
 	}
 
-- 
1.7.4.4

