From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 04/11] mmc: omap: add DMA engine support
Date: Thu, 07 Jun 2012 12:07:34 +0100
Message-ID: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add DMA engine support to the OMAP driver.  This supplements the
private DMA API implementation contained within this driver, and the
driver can be switched at build time between using DMA engine and the
private DMA API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap.c       |  199 ++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/omap_hsmmc.c |    3 +-
 2 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 552196c..eaea251 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -17,10 +17,12 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/omap-dma.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/clk.h>
@@ -99,6 +101,8 @@
 
 struct mmc_omap_host;
 
+#define USE_DMA_PRIVATE
+
 struct mmc_omap_slot {
 	int			id;
 	unsigned int		vdd;
@@ -128,6 +132,10 @@ struct mmc_omap_host {
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
+	struct dma_chan		*dma_rx;
+	u32			dma_rx_burst;
+	struct dma_chan		*dma_tx;
+	u32			dma_tx_burst;
 	struct resource		*mem_res;
 	void __iomem		*virt_base;
 	unsigned int		phys_base;
@@ -153,12 +161,14 @@ struct mmc_omap_host {
 
 	unsigned		use_dma:1;
 	unsigned		brs_received:1, dma_done:1;
-	unsigned		dma_is_read:1;
 	unsigned		dma_in_use:1;
+#ifdef USE_DMA_PRIVATE
+	unsigned		dma_is_read:1;
 	int			dma_ch;
-	spinlock_t		dma_lock;
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
+#endif
+	spinlock_t		dma_lock;
 
 	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
 	struct mmc_omap_slot    *current_slot;
@@ -406,18 +416,32 @@ mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
 		     int abort)
 {
 	enum dma_data_direction dma_data_dir;
+	struct device *dev = mmc_dev(host->mmc);
+	struct dma_chan *c;
 
+#ifdef USE_DMA_PRIVATE
 	BUG_ON(host->dma_ch < 0);
 	if (data->error)
 		omap_stop_dma(host->dma_ch);
 	/* Release DMA channel lazily */
 	mod_timer(&host->dma_timer, jiffies + HZ);
-	if (data->flags & MMC_DATA_WRITE)
+#endif
+	if (data->flags & MMC_DATA_WRITE) {
 		dma_data_dir = DMA_TO_DEVICE;
-	else
+		c = host->dma_tx;
+	} else {
 		dma_data_dir = DMA_FROM_DEVICE;
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
-		     dma_data_dir);
+		c = host->dma_rx;
+	}
+	if (c) {
+		if (data->error) {
+			dmaengine_terminate_all(c);
+			/* Claim nothing transferred on error... */
+			data->bytes_xfered = 0;
+		}
+		dev = c->device->dev;
+	}
+	dma_unmap_sg(dev, data->sg, host->sg_len, dma_data_dir);
 }
 
 static void mmc_omap_send_stop_work(struct work_struct *work)
@@ -524,6 +548,7 @@ mmc_omap_end_of_data(struct mmc_omap_host *host, struct mmc_data *data)
 		mmc_omap_xfer_done(host, data);
 }
 
+#ifdef USE_DMA_PRIVATE
 static void
 mmc_omap_dma_timer(unsigned long data)
 {
@@ -533,6 +558,7 @@ mmc_omap_dma_timer(unsigned long data)
 	omap_free_dma(host->dma_ch);
 	host->dma_ch = -1;
 }
+#endif
 
 static void
 mmc_omap_dma_done(struct mmc_omap_host *host, struct mmc_data *data)
@@ -891,6 +917,18 @@ static void mmc_omap_cover_handler(unsigned long param)
 		  jiffies + msecs_to_jiffies(OMAP_MMC_COVER_POLL_DELAY));
 }
 
+static void mmc_omap_dma_callback(void *priv)
+{
+	struct mmc_omap_host *host = priv;
+	struct mmc_data *data = host->data;
+
+	/* If we got to the end of DMA, assume everything went well */
+	data->bytes_xfered += data->blocks * data->blksz;
+
+	mmc_omap_dma_done(host, data);
+}
+
+#ifdef USE_DMA_PRIVATE
 /* Prepare to transfer the next segment of a scatterlist */
 static void
 mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
@@ -1045,6 +1083,7 @@ static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data
 
 	return 0;
 }
+#endif
 
 static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_request *req)
 {
@@ -1118,6 +1157,80 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 
 	host->sg_idx = 0;
 	if (use_dma) {
+		enum dma_data_direction dma_data_dir;
+		struct dma_async_tx_descriptor *tx;
+		struct dma_chan *c;
+		u32 burst, *bp;
+		u16 buf;
+
+		/*
+		 * FIFO is 16x2 bytes on 15xx, and 32x2 bytes on 16xx
+		 * and 24xx. Use 16 or 32 word frames when the
+		 * blocksize is at least that large. Blocksize is
+		 * usually 512 bytes; but not for some SD reads.
+		 */
+		burst = cpu_is_omap15xx() ? 32 : 64;
+		if (burst > data->blksz)
+			burst = data->blksz;
+
+		burst >>= 1;
+
+		if (data->flags & MMC_DATA_WRITE) {
+			c = host->dma_tx;
+			bp = &host->dma_tx_burst;
+			buf = 0x0f80 | (burst - 1) << 0;
+			dma_data_dir = DMA_TO_DEVICE;
+		} else {
+			c = host->dma_rx;
+			bp = &host->dma_rx_burst;
+			buf = 0x800f | (burst - 1) << 8;
+			dma_data_dir = DMA_FROM_DEVICE;
+		}
+
+		if (!c)
+			goto use_pio;
+
+		/* Only reconfigure if we have a different burst size */
+		if (*bp != burst) {
+			struct dma_slave_config cfg;
+
+			cfg.src_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
+			cfg.dst_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
+			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			cfg.src_maxburst = burst;
+			cfg.dst_maxburst = burst;
+
+			if (dmaengine_slave_config(c, &cfg))
+				goto use_pio;
+
+			*bp = burst;
+		}
+
+		host->sg_len = dma_map_sg(c->device->dev, data->sg, sg_len,
+					  dma_data_dir);
+		if (host->sg_len == 0)
+			goto use_pio;
+
+		tx = dmaengine_prep_slave_sg(c, data->sg, host->sg_len,
+			data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!tx)
+			goto use_pio;
+
+		OMAP_MMC_WRITE(host, BUF, buf);
+
+		tx->callback = mmc_omap_dma_callback;
+		tx->callback_param = host;
+		dmaengine_submit(tx);
+		host->brs_received = 0;
+		host->dma_done = 0;
+		host->dma_in_use = 1;
+		return;
+	}
+ use_pio:
+#ifdef USE_DMA_PRIVATE
+	if (use_dma) {
 		if (mmc_omap_get_dma_channel(host, data) == 0) {
 			enum dma_data_direction dma_data_dir;
 
@@ -1136,6 +1249,9 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		} else
 			use_dma = 0;
 	}
+#else
+	use_dma = 0;
+#endif
 
 	/* Revert to PIO? */
 	if (!use_dma) {
@@ -1157,8 +1273,17 @@ static void mmc_omap_start_request(struct mmc_omap_host *host,
 	/* only touch fifo AFTER the controller readies it */
 	mmc_omap_prepare_data(host, req);
 	mmc_omap_start_command(host, req->cmd);
-	if (host->dma_in_use)
-		omap_start_dma(host->dma_ch);
+	if (host->dma_in_use) {
+		struct dma_chan *c = host->data->flags & MMC_DATA_WRITE ?
+				host->dma_tx : host->dma_rx;
+
+		if (c)
+			dma_async_issue_pending(c);
+#ifdef USE_DMA_PRIVATE
+		else
+			omap_start_dma(host->dma_ch);
+#endif
+	}
 }
 
 static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
@@ -1400,6 +1525,8 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
+	dma_cap_mask_t mask;
+	unsigned sig;
 	int i, ret = 0;
 	int irq;
 
@@ -1439,7 +1566,9 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	setup_timer(&host->clk_timer, mmc_omap_clk_timer, (unsigned long) host);
 
 	spin_lock_init(&host->dma_lock);
+#ifdef USE_DMA_PRIVATE
 	setup_timer(&host->dma_timer, mmc_omap_dma_timer, (unsigned long) host);
+#endif
 	spin_lock_init(&host->slot_lock);
 	init_waitqueue_head(&host->slot_wq);
 
@@ -1452,8 +1581,10 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	host->use_dma = 1;
+#ifdef USE_DMA_PRIVATE
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch = -1;
+#endif
 
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
@@ -1474,9 +1605,48 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_iclk;
 	}
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	host->dma_tx_burst = -1;
+	host->dma_rx_burst = -1;
+
+	if (cpu_is_omap24xx())
+		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
+	else
+		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
+	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+#if 0
+	if (!host->dma_tx) {
+		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
+			sig);
+		goto err_dma;
+	}
+#else
+	if (!host->dma_tx)
+		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
+			sig);
+#endif
+	if (cpu_is_omap24xx())
+		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
+	else
+		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
+	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+#if 0
+	if (!host->dma_rx) {
+		dev_err(host->dev, "unable to obtain RX DMA engine channel %u\n",
+			sig);
+		goto err_dma;
+	}
+#else
+	if (!host->dma_rx)
+		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
+			sig);
+#endif
+
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-		goto err_free_fclk;
+		goto err_free_dma;
 
 	if (pdata->init != NULL) {
 		ret = pdata->init(&pdev->dev);
@@ -1508,7 +1678,11 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		pdata->cleanup(&pdev->dev);
 err_free_irq:
 	free_irq(host->irq, host);
-err_free_fclk:
+err_free_dma:
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 	clk_put(host->fclk);
 err_free_iclk:
 	clk_disable(host->iclk);
@@ -1543,6 +1717,11 @@ static int __devexit mmc_omap_remove(struct platform_device *pdev)
 	clk_disable(host->iclk);
 	clk_put(host->iclk);
 
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
+
 	iounmap(host->virt_base);
 	release_mem_region(pdev->resource[0].start,
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9504092..5d7dbc9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/omap-dma.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
@@ -1774,8 +1775,6 @@ static inline struct omap_mmc_platform_data
 }
 #endif
 
-extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
-
 static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
-- 
1.7.4.4

