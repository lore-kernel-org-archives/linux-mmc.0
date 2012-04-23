From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/12] mmc: omap: remove private DMA API implementation
Date: Mon, 23 Apr 2012 17:06:52 +0100
Message-ID: <E1SMLmu-0002WY-9q@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Remove the private DMA API implementation from omap, making it use
entirely the DMA engine API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap.c |  235 +---------------------------------------------
 1 files changed, 6 insertions(+), 229 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index bd1d1da..8ddc2a0 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -100,8 +100,6 @@
 
 struct mmc_omap_host;
 
-#define USE_DMA_PRIVATE
-
 struct mmc_omap_slot {
 	int			id;
 	unsigned int		vdd;
@@ -161,12 +159,6 @@ struct mmc_omap_host {
 	unsigned		use_dma:1;
 	unsigned		brs_received:1, dma_done:1;
 	unsigned		dma_in_use:1;
-#ifdef USE_DMA_PRIVATE
-	unsigned		dma_is_read:1;
-	int			dma_ch;
-	struct timer_list	dma_timer;
-	unsigned		dma_len;
-#endif
 	spinlock_t		dma_lock;
 
 	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
@@ -418,13 +410,6 @@ mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
 	struct device *dev = mmc_dev(host->mmc);
 	struct dma_chan *c;
 
-#ifdef USE_DMA_PRIVATE
-	BUG_ON(host->dma_ch < 0);
-	if (data->error)
-		omap_stop_dma(host->dma_ch);
-	/* Release DMA channel lazily */
-	mod_timer(&host->dma_timer, jiffies + HZ);
-#endif
 	if (data->flags & MMC_DATA_WRITE) {
 		dma_data_dir = DMA_TO_DEVICE;
 		c = host->dma_tx;
@@ -547,18 +532,6 @@ mmc_omap_end_of_data(struct mmc_omap_host *host, struct mmc_data *data)
 		mmc_omap_xfer_done(host, data);
 }
 
-#ifdef USE_DMA_PRIVATE
-static void
-mmc_omap_dma_timer(unsigned long data)
-{
-	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
-
-	BUG_ON(host->dma_ch < 0);
-	omap_free_dma(host->dma_ch);
-	host->dma_ch = -1;
-}
-#endif
-
 static void
 mmc_omap_dma_done(struct mmc_omap_host *host, struct mmc_data *data)
 {
@@ -927,163 +900,6 @@ static void mmc_omap_dma_callback(void *priv)
 	mmc_omap_dma_done(host, data);
 }
 
-#ifdef USE_DMA_PRIVATE
-/* Prepare to transfer the next segment of a scatterlist */
-static void
-mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
-{
-	int dma_ch = host->dma_ch;
-	unsigned long data_addr;
-	u16 buf, frame;
-	u32 count;
-	struct scatterlist *sg = &data->sg[host->sg_idx];
-	int src_port = 0;
-	int dst_port = 0;
-	int sync_dev = 0;
-
-	data_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
-	frame = data->blksz;
-	count = sg_dma_len(sg);
-
-	if ((data->blocks == 1) && (count > data->blksz))
-		count = frame;
-
-	host->dma_len = count;
-
-	/* FIFO is 16x2 bytes on 15xx, and 32x2 bytes on 16xx and 24xx.
-	 * Use 16 or 32 word frames when the blocksize is at least that large.
-	 * Blocksize is usually 512 bytes; but not for some SD reads.
-	 */
-	if (cpu_is_omap15xx() && frame > 32)
-		frame = 32;
-	else if (frame > 64)
-		frame = 64;
-	count /= frame;
-	frame >>= 1;
-
-	if (!(data->flags & MMC_DATA_WRITE)) {
-		buf = 0x800f | ((frame - 1) << 8);
-
-		if (cpu_class_is_omap1()) {
-			src_port = OMAP_DMA_PORT_TIPB;
-			dst_port = OMAP_DMA_PORT_EMIFF;
-		}
-		if (cpu_is_omap24xx())
-			sync_dev = OMAP24XX_DMA_MMC1_RX;
-
-		omap_set_dma_src_params(dma_ch, src_port,
-					OMAP_DMA_AMODE_CONSTANT,
-					data_addr, 0, 0);
-		omap_set_dma_dest_params(dma_ch, dst_port,
-					 OMAP_DMA_AMODE_POST_INC,
-					 sg_dma_address(sg), 0, 0);
-		omap_set_dma_dest_data_pack(dma_ch, 1);
-		omap_set_dma_dest_burst_mode(dma_ch, OMAP_DMA_DATA_BURST_4);
-	} else {
-		buf = 0x0f80 | ((frame - 1) << 0);
-
-		if (cpu_class_is_omap1()) {
-			src_port = OMAP_DMA_PORT_EMIFF;
-			dst_port = OMAP_DMA_PORT_TIPB;
-		}
-		if (cpu_is_omap24xx())
-			sync_dev = OMAP24XX_DMA_MMC1_TX;
-
-		omap_set_dma_dest_params(dma_ch, dst_port,
-					 OMAP_DMA_AMODE_CONSTANT,
-					 data_addr, 0, 0);
-		omap_set_dma_src_params(dma_ch, src_port,
-					OMAP_DMA_AMODE_POST_INC,
-					sg_dma_address(sg), 0, 0);
-		omap_set_dma_src_data_pack(dma_ch, 1);
-		omap_set_dma_src_burst_mode(dma_ch, OMAP_DMA_DATA_BURST_4);
-	}
-
-	/* Max limit for DMA frame count is 0xffff */
-	BUG_ON(count > 0xffff);
-
-	OMAP_MMC_WRITE(host, BUF, buf);
-	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S16,
-				     frame, count, OMAP_DMA_SYNC_FRAME,
-				     sync_dev, 0);
-}
-
-/* A scatterlist segment completed */
-static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
-{
-	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
-	struct mmc_data *mmcdat = host->data;
-
-	if (unlikely(host->dma_ch < 0)) {
-		dev_err(mmc_dev(host->mmc),
-			"DMA callback while DMA not enabled\n");
-		return;
-	}
-	/* FIXME: We really should do something to _handle_ the errors */
-	if (ch_status & OMAP1_DMA_TOUT_IRQ) {
-		dev_err(mmc_dev(host->mmc),"DMA timeout\n");
-		return;
-	}
-	if (ch_status & OMAP_DMA_DROP_IRQ) {
-		dev_err(mmc_dev(host->mmc), "DMA sync error\n");
-		return;
-	}
-	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
-		return;
-	}
-	mmcdat->bytes_xfered += host->dma_len;
-	host->sg_idx++;
-	if (host->sg_idx < host->sg_len) {
-		mmc_omap_prepare_dma(host, host->data);
-		omap_start_dma(host->dma_ch);
-	} else
-		mmc_omap_dma_done(host, host->data);
-}
-
-static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data *data)
-{
-	const char *dma_dev_name;
-	int sync_dev, dma_ch, is_read, r;
-
-	is_read = !(data->flags & MMC_DATA_WRITE);
-	del_timer_sync(&host->dma_timer);
-	if (host->dma_ch >= 0) {
-		if (is_read == host->dma_is_read)
-			return 0;
-		omap_free_dma(host->dma_ch);
-		host->dma_ch = -1;
-	}
-
-	if (is_read) {
-		if (host->id == 0) {
-			sync_dev = OMAP_DMA_MMC_RX;
-			dma_dev_name = "MMC1 read";
-		} else {
-			sync_dev = OMAP_DMA_MMC2_RX;
-			dma_dev_name = "MMC2 read";
-		}
-	} else {
-		if (host->id == 0) {
-			sync_dev = OMAP_DMA_MMC_TX;
-			dma_dev_name = "MMC1 write";
-		} else {
-			sync_dev = OMAP_DMA_MMC2_TX;
-			dma_dev_name = "MMC2 write";
-		}
-	}
-	r = omap_request_dma(sync_dev, dma_dev_name, mmc_omap_dma_cb,
-			     host, &dma_ch);
-	if (r != 0) {
-		dev_dbg(mmc_dev(host->mmc), "omap_request_dma() failed with %d\n", r);
-		return r;
-	}
-	host->dma_ch = dma_ch;
-	host->dma_is_read = is_read;
-
-	return 0;
-}
-#endif
-
 static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_request *req)
 {
 	u16 reg;
@@ -1228,38 +1044,13 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		return;
 	}
  use_pio:
-#ifdef USE_DMA_PRIVATE
-	if (use_dma) {
-		if (mmc_omap_get_dma_channel(host, data) == 0) {
-			enum dma_data_direction dma_data_dir;
-
-			if (data->flags & MMC_DATA_WRITE)
-				dma_data_dir = DMA_TO_DEVICE;
-			else
-				dma_data_dir = DMA_FROM_DEVICE;
-
-			host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
-						sg_len, dma_data_dir);
-			host->total_bytes_left = 0;
-			mmc_omap_prepare_dma(host, req->data);
-			host->brs_received = 0;
-			host->dma_done = 0;
-			host->dma_in_use = 1;
-		} else
-			use_dma = 0;
-	}
-#else
-	use_dma = 0;
-#endif
 
 	/* Revert to PIO? */
-	if (!use_dma) {
-		OMAP_MMC_WRITE(host, BUF, 0x1f1f);
-		host->total_bytes_left = data->blocks * block_size;
-		host->sg_len = sg_len;
-		mmc_omap_sg_to_buf(host);
-		host->dma_in_use = 0;
-	}
+	OMAP_MMC_WRITE(host, BUF, 0x1f1f);
+	host->total_bytes_left = data->blocks * block_size;
+	host->sg_len = sg_len;
+	mmc_omap_sg_to_buf(host);
+	host->dma_in_use = 0;
 }
 
 static void mmc_omap_start_request(struct mmc_omap_host *host,
@@ -1276,12 +1067,7 @@ static void mmc_omap_start_request(struct mmc_omap_host *host,
 		struct dma_chan *c = host->data->flags & MMC_DATA_WRITE ?
 				host->dma_tx : host->dma_rx;
 
-		if (c)
-			dma_async_issue_pending(c);
-#ifdef USE_DMA_PRIVATE
-		else
-			omap_start_dma(host->dma_ch);
-#endif
+		dma_async_issue_pending(c);
 	}
 }
 
@@ -1567,9 +1353,6 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	setup_timer(&host->clk_timer, mmc_omap_clk_timer, (unsigned long) host);
 
 	spin_lock_init(&host->dma_lock);
-#ifdef USE_DMA_PRIVATE
-	setup_timer(&host->dma_timer, mmc_omap_dma_timer, (unsigned long) host);
-#endif
 	spin_lock_init(&host->slot_lock);
 	init_waitqueue_head(&host->slot_wq);
 
@@ -1580,13 +1363,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->id = pdev->id;
 	host->mem_res = res;
 	host->irq = irq;
-
 	host->use_dma = 1;
-#ifdef USE_DMA_PRIVATE
-	host->dev->dma_mask = &pdata->dma_mask;
-	host->dma_ch = -1;
-#endif
-
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
 	host->virt_base = ioremap(res->start, resource_size(res));
-- 
1.7.4.4

