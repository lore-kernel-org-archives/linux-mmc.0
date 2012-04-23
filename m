From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 10/12] spi: omap2-mcspi: add DMA engine support
Date: Mon, 23 Apr 2012 17:07:32 +0100
Message-ID: <E1SMLnY-0002Wg-TD@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

Add DMA engine support to the OMAP SPI driver.  This supplements the
private DMA API implementation contained within this driver, and the
driver can be independently switched at build time between using DMA
engine and the private DMA API for the transmit and receive sides.

Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/spi/spi-omap2-mcspi.c |  184 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 152 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index bb9274c..b2461d7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -20,6 +20,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  */
+#define USE_DMA_ENGINE_RX
+#define USE_DMA_ENGINE_TX
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -28,6 +30,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -95,6 +98,8 @@
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
+	struct dma_chan *dma_tx;
+	struct dma_chan *dma_rx;
 	int dma_tx_channel;
 	int dma_rx_channel;
 
@@ -290,6 +295,30 @@ static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 	return 0;
 }
 
+static void omap2_mcspi_rx_callback(void *data)
+{
+	struct spi_device *spi = data;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+
+	complete(&mcspi_dma->dma_rx_completion);
+
+	/* We must disable the DMA RX request */
+	omap2_mcspi_set_dma_req(spi, 1, 0);
+}
+
+static void omap2_mcspi_tx_callback(void *data)
+{
+	struct spi_device *spi = data;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+
+	complete(&mcspi_dma->dma_tx_completion);
+
+	/* We must disable the DMA TX request */
+	omap2_mcspi_set_dma_req(spi, 0, 0);
+}
+
 static unsigned
 omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 {
@@ -304,6 +333,9 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	u8			* rx;
 	const u8		* tx;
 	void __iomem		*chstat_reg;
+	struct dma_slave_config	cfg;
+	enum dma_slave_buswidth width;
+	unsigned es;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -311,6 +343,71 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
 
+	if (cs->word_len <= 8) {
+		width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		es = 1;
+	} else if (cs->word_len <= 16) {
+		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		es = 2;
+	} else {
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		es = 4;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
+	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
+	cfg.src_addr_width = width;
+	cfg.dst_addr_width = width;
+	cfg.src_maxburst = 1;
+	cfg.dst_maxburst = 1;
+
+	if (xfer->tx_buf && mcspi_dma->dma_tx) {
+		struct dma_async_tx_descriptor *tx;
+		struct scatterlist sg;
+
+		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
+
+		sg_init_table(&sg, 1);
+		sg_dma_address(&sg) = xfer->tx_dma;
+		sg_dma_len(&sg) = xfer->len;
+
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
+			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (tx) {
+			tx->callback = omap2_mcspi_tx_callback;
+			tx->callback_param = spi;
+			dmaengine_submit(tx);
+		} else {
+			/* FIXME: fall back to PIO? */
+		}
+	}
+
+	if (xfer->rx_buf && mcspi_dma->dma_rx) {
+		struct dma_async_tx_descriptor *tx;
+		struct scatterlist sg;
+		size_t len = xfer->len - es;
+
+		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
+
+		if (l & OMAP2_MCSPI_CHCONF_TURBO)
+			len -= es;
+
+		sg_init_table(&sg, 1);
+		sg_dma_address(&sg) = xfer->rx_dma;
+		sg_dma_len(&sg) = len;
+
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
+			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (tx) {
+			tx->callback = omap2_mcspi_rx_callback;
+			tx->callback_param = spi;
+			dmaengine_submit(tx);
+		} else {
+			/* FIXME: fall back to PIO? */
+		}
+	}
+
 	count = xfer->len;
 	c = count;
 	word_len = cs->word_len;
@@ -332,7 +429,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		element_count = count >> 2;
 	}
 
-	if (tx != NULL) {
+	if (tx != NULL && mcspi_dma->dma_tx_channel != -1) {
 		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
 				data_type, element_count, 1,
 				OMAP_DMA_SYNC_ELEMENT,
@@ -347,7 +444,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 				xfer->tx_dma, 0, 0);
 	}
 
-	if (rx != NULL) {
+	if (rx != NULL && mcspi_dma->dma_rx_channel != -1) {
 		elements = element_count - 1;
 		if (l & OMAP2_MCSPI_CHCONF_TURBO)
 			elements--;
@@ -367,12 +464,18 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	if (tx != NULL) {
-		omap_start_dma(mcspi_dma->dma_tx_channel);
+		if (mcspi_dma->dma_tx)
+			dma_async_issue_pending(mcspi_dma->dma_tx);
+		else
+			omap_start_dma(mcspi_dma->dma_tx_channel);
 		omap2_mcspi_set_dma_req(spi, 0, 1);
 	}
 
 	if (rx != NULL) {
-		omap_start_dma(mcspi_dma->dma_rx_channel);
+		if (mcspi_dma->dma_rx)
+			dma_async_issue_pending(mcspi_dma->dma_rx);
+		else
+			omap_start_dma(mcspi_dma->dma_rx_channel);
 		omap2_mcspi_set_dma_req(spi, 1, 1);
 	}
 
@@ -396,7 +499,10 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		dma_unmap_single(&spi->dev, xfer->rx_dma, count, DMA_FROM_DEVICE);
 		omap2_mcspi_set_enable(spi, 0);
 
+		elements = element_count - 1;
+
 		if (l & OMAP2_MCSPI_CHCONF_TURBO) {
+			elements--;
 
 			if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
 				   & OMAP2_MCSPI_CHSTAT_RXS)) {
@@ -715,50 +821,58 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 static void omap2_mcspi_dma_rx_callback(int lch, u16 ch_status, void *data)
 {
-	struct spi_device	*spi = data;
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
-
-	mcspi = spi_master_get_devdata(spi->master);
-	mcspi_dma = &(mcspi->dma_channels[spi->chip_select]);
-
-	complete(&mcspi_dma->dma_rx_completion);
-
-	/* We must disable the DMA RX request */
-	omap2_mcspi_set_dma_req(spi, 1, 0);
+	omap2_mcspi_rx_callback(data);
 }
 
 static void omap2_mcspi_dma_tx_callback(int lch, u16 ch_status, void *data)
 {
-	struct spi_device	*spi = data;
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
-
-	mcspi = spi_master_get_devdata(spi->master);
-	mcspi_dma = &(mcspi->dma_channels[spi->chip_select]);
-
-	complete(&mcspi_dma->dma_tx_completion);
-
-	/* We must disable the DMA TX request */
-	omap2_mcspi_set_dma_req(spi, 0, 0);
+	omap2_mcspi_tx_callback(data);
 }
 
+extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
+
 static int omap2_mcspi_request_dma(struct spi_device *spi)
 {
 	struct spi_master	*master = spi->master;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
+	dma_cap_mask_t mask;
+	unsigned sig;
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 
+	init_completion(&mcspi_dma->dma_rx_completion);
+	init_completion(&mcspi_dma->dma_tx_completion);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+#ifdef USE_DMA_ENGINE_RX
+	sig = mcspi_dma->dma_rx_sync_dev;
+	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	if (!mcspi_dma->dma_rx) {
+		dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
+		return -EAGAIN;
+	}
+#else
 	if (omap_request_dma(mcspi_dma->dma_rx_sync_dev, "McSPI RX",
 			omap2_mcspi_dma_rx_callback, spi,
 			&mcspi_dma->dma_rx_channel)) {
 		dev_err(&spi->dev, "no RX DMA channel for McSPI\n");
 		return -EAGAIN;
 	}
+#endif
 
+#ifdef USE_DMA_ENGINE_TX
+	sig = mcspi_dma->dma_tx_sync_dev;
+	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	if (!mcspi_dma->dma_tx) {
+		dev_err(&spi->dev, "no TX DMA engine channel for McSPI\n");
+		dma_release_channel(mcspi_dma->dma_rx);
+		mcspi_dma->dma_rx = NULL;
+		return -EAGAIN;
+	}
+#else
 	if (omap_request_dma(mcspi_dma->dma_tx_sync_dev, "McSPI TX",
 			omap2_mcspi_dma_tx_callback, spi,
 			&mcspi_dma->dma_tx_channel)) {
@@ -767,9 +881,7 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		dev_err(&spi->dev, "no TX DMA channel for McSPI\n");
 		return -EAGAIN;
 	}
-
-	init_completion(&mcspi_dma->dma_rx_completion);
-	init_completion(&mcspi_dma->dma_tx_completion);
+#endif
 
 	return 0;
 }
@@ -803,8 +915,8 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
 	}
 
-	if (mcspi_dma->dma_rx_channel == -1
-			|| mcspi_dma->dma_tx_channel == -1) {
+	if ((!mcspi_dma->dma_rx && mcspi_dma->dma_rx_channel == -1) ||
+	    (!mcspi_dma->dma_tx && mcspi_dma->dma_tx_channel == -1)) {
 		ret = omap2_mcspi_request_dma(spi);
 		if (ret < 0)
 			return ret;
@@ -839,6 +951,14 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 	if (spi->chip_select < spi->master->num_chipselect) {
 		mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
+		if (mcspi_dma->dma_rx) {
+			dma_release_channel(mcspi_dma->dma_rx);
+			mcspi_dma->dma_rx = NULL;
+		}
+		if (mcspi_dma->dma_tx) {
+			dma_release_channel(mcspi_dma->dma_tx);
+			mcspi_dma->dma_tx = NULL;
+		}
 		if (mcspi_dma->dma_rx_channel != -1) {
 			omap_free_dma(mcspi_dma->dma_rx_channel);
 			mcspi_dma->dma_rx_channel = -1;
-- 
1.7.4.4

