From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
	initialization
Date: Wed, 18 Apr 2012 22:36:42 +0100
Message-ID: <20120418213642.GV25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk> <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com> <20120418152956.GP25053@n2100.arm.linux.org.uk> <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com> <20120418194224.GS25053@n2100.arm.linux.org.uk> <20120418200214.GP21106@atomide.com> <20120418202447.GT25053@n2100.arm.linux.org.uk> <20120418210142.GR21106@atomide.com> <20120418211606.GU25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418211606.GU25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 10:16:06PM +0100, Russell King - ARM Linux wrote:
> I don't think it has to in this case, though I am thinking that we
> may have to adjust the frame size for other peripherals.
> 
> In the case of the OMAP1 MMC driver, let me pull out that chunk of code
> again:
> 
>         frame = data->blksz;
>         if (cpu_is_omap15xx() && frame > 32)
>                 frame = 32;
>         else if (frame > 64)
>                 frame = 64;
>         frame >>= 1;
>         if (!(data->flags & MMC_DATA_WRITE)) {
>                 buf = 0x800f | ((frame - 1) << 8);
>         } else {
>                 buf = 0x0f80 | ((frame - 1) << 0);
>         }
>         OMAP_MMC_WRITE(host, BUF, buf);
> 
> Nothing there depends on the size of an individual scatterlist entry -
> the dependencies for the frame size are the smaller of the FIFO size
> and the data block size.  I believe we can cope with that quite well on
> a per-transfer basis, and I _think_ we can get away with writing this
> BUF register just once per transfer (similar to what happens for PIO
> transfers.)
> 
> However, this is going to be rather hit and miss for me - all I can do
> is create a patch and check that it builds.  I have no way (that I know
> of) to test this change as I don't have any OMAP1 nor OMAP2 hardware.

Right, so from a purely theoretical standpoint, here's the OMAP1 driver
converted, and build-tested only.  Modulo a few warnings and patch 8,
you should be able to convert between DMA engine and the original DMA
engine implementation by changing the definition at the top.

I have to stress: this is untested, it may eat your MMC/SD cards.  Test
it carefully and test it well.

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 887c0e5..a77c72e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -10,6 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define USE_DMA_ENGINE
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -17,6 +18,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
@@ -128,6 +130,10 @@ struct mmc_omap_host {
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
@@ -153,12 +159,14 @@ struct mmc_omap_host {
 
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
@@ -406,18 +414,34 @@ mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
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
+#ifdef USE_DMA_ENGINE
+	if (c) {
+		if (data->error) {
+			dmaengine_terminate_all(c);
+			/* Claim nothing transferred on error... */
+			data->bytes_xfered = 0;
+		}
+		dev = c->device->dev;
+	}
+#endif
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
@@ -891,6 +917,19 @@ static void mmc_omap_cover_handler(unsigned long param)
 		  jiffies + msecs_to_jiffies(OMAP_MMC_COVER_POLL_DELAY));
 }
 
+#ifdef USE_DMA_ENGINE
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
+#endif
+#ifdef USE_DMA_PRIVATE
 /* Prepare to transfer the next segment of a scatterlist */
 static void
 mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
@@ -1045,6 +1084,7 @@ static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data
 
 	return 0;
 }
+#endif
 
 static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_request *req)
 {
@@ -1117,6 +1157,82 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 	}
 
 	host->sg_idx = 0;
+#ifdef USE_DMA_ENGINE
+	if (use_dma) {
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
+#endif
+#ifdef USE_DMA_PRIVATE
 	if (use_dma) {
 		if (mmc_omap_get_dma_channel(host, data) == 0) {
 			enum dma_data_direction dma_data_dir;
@@ -1136,6 +1252,9 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		} else
 			use_dma = 0;
 	}
+#else
+	use_dma = 0;
+#endif
 
 	/* Revert to PIO? */
 	if (!use_dma) {
@@ -1157,8 +1276,17 @@ static void mmc_omap_start_request(struct mmc_omap_host *host,
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
@@ -1395,11 +1523,15 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 	mmc_free_host(mmc);
 }
 
+extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
+
 static int __init mmc_omap_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
+	dma_cap_mask_t mask;
+	unsigned sig;
 	int i, ret = 0;
 	int irq;
 
@@ -1439,7 +1571,9 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	setup_timer(&host->clk_timer, mmc_omap_clk_timer, (unsigned long) host);
 
 	spin_lock_init(&host->dma_lock);
+#ifdef USE_DMA_PRIVATE
 	setup_timer(&host->dma_timer, mmc_omap_dma_timer, (unsigned long) host);
+#endif
 	spin_lock_init(&host->slot_lock);
 	init_waitqueue_head(&host->slot_wq);
 
@@ -1452,8 +1586,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	host->use_dma = 1;
+#ifdef USE_DMA_PRIVATE
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch = -1;
+#endif
 
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
@@ -1474,9 +1610,46 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_iclk;
 	}
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+#ifdef USE_DMA_ENGINE
+	host->dma_tx_burst = -1;
+	host->dma_rx_burst = -1;
+
+	sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
+	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+#if 0
+	if (!host->dma_tx) {
+		def_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
+			sig);
+		goto err_dma;
+	}
+#else
+	if (!host->dma_tx)
+		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
+			sig);
+#endif
+#endif
+#ifdef USE_DMA_ENGINE
+	sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
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
+#endif
+
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-		goto err_free_fclk;
+		goto err_free_dma;
 
 	if (pdata->init != NULL) {
 		ret = pdata->init(&pdev->dev);
@@ -1504,7 +1677,11 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
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
@@ -1539,6 +1716,11 @@ static int mmc_omap_remove(struct platform_device *pdev)
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

