From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API implementation
Date: Mon, 23 Apr 2012 17:06:11 +0100
Message-ID: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Remove the private DMA API implementation from omap_hsmmc, making it
use entirely the DMA engine API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c |  264 ++++++++++-------------------------------
 1 files changed, 64 insertions(+), 200 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6c09a80..fa85efe 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -38,7 +38,6 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
-#include <plat/dma.h>
 #include <mach/hardware.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
@@ -165,10 +164,9 @@ struct omap_hsmmc_host {
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
-	int			use_dma, dma_ch, dma2;
+	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
-	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
 	int			got_dbclk;
 	int			response_busy;
@@ -804,17 +802,16 @@ static struct dma_chan *omap_hsmmc_get_dma_chan(struct omap_hsmmc_host *host,
 
 static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_request *mrq)
 {
-	int dma_ch, dma2;
+	int dma_ch;
 
 	spin_lock(&host->irq_lock);
 	host->req_in_progress = 0;
 	dma_ch = host->dma_ch;
-	dma2 = host->dma2;
 	spin_unlock(&host->irq_lock);
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && (dma_ch != -1 || dma2 != -1))
+	if (mrq->data && host->use_dma && dma_ch != -1)
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -883,18 +880,16 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
  */
 static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 {
-	int dma_ch, dma2;
+	int dma_ch;
 
 	host->data->error = errno;
 
 	spin_lock(&host->irq_lock);
 	dma_ch = host->dma_ch;
 	host->dma_ch = -1;
-	dma2 = host->dma2;
-	host->dma2 = -1;
 	spin_unlock(&host->irq_lock);
 
-	if (host->use_dma && dma2 != -1) {
+	if (host->use_dma && dma_ch != -1) {
 		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
 
 		dmaengine_terminate_all(chan);
@@ -904,13 +899,6 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 
 		host->data->host_cookie = 0;
 	}
-	if (host->use_dma && dma_ch != -1) {
-		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
-			host->data->sg_len,
-			omap_hsmmc_get_dma_dir(host, host->data));
-		omap_free_dma(dma_ch);
-		host->data->host_cookie = 0;
-	}
 	host->data = NULL;
 }
 
@@ -1206,99 +1194,6 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int omap_hsmmc_get_dma_sync_dev(struct omap_hsmmc_host *host,
-				     struct mmc_data *data)
-{
-	int sync_dev;
-
-	if (data->flags & MMC_DATA_WRITE)
-		sync_dev = host->dma_line_tx;
-	else
-		sync_dev = host->dma_line_rx;
-	return sync_dev;
-}
-
-static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
-				       struct mmc_data *data,
-				       struct scatterlist *sgl)
-{
-	int blksz, nblk, dma_ch;
-
-	dma_ch = host->dma_ch;
-	if (data->flags & MMC_DATA_WRITE) {
-		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
-		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-			sg_dma_address(sgl), 0, 0);
-	} else {
-		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
-		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-			sg_dma_address(sgl), 0, 0);
-	}
-
-	blksz = host->data->blksz;
-	nblk = sg_dma_len(sgl) / blksz;
-
-	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
-			blksz / 4, nblk, OMAP_DMA_SYNC_FRAME,
-			omap_hsmmc_get_dma_sync_dev(host, data),
-			!(data->flags & MMC_DATA_WRITE));
-
-	omap_start_dma(dma_ch);
-}
-
-/*
- * DMA call back function
- */
-static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
-{
-	struct omap_hsmmc_host *host = cb_data;
-	struct mmc_data *data;
-	int dma_ch, req_in_progress;
-
-	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
-		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
-			ch_status);
-		return;
-	}
-
-	spin_lock(&host->irq_lock);
-	if (host->dma_ch < 0) {
-		spin_unlock(&host->irq_lock);
-		return;
-	}
-
-	data = host->mrq->data;
-	host->dma_sg_idx++;
-	if (host->dma_sg_idx < host->dma_len) {
-		/* Fire up the next transfer. */
-		omap_hsmmc_config_dma_params(host, data,
-					   data->sg + host->dma_sg_idx);
-		spin_unlock(&host->irq_lock);
-		return;
-	}
-
-	if (!data->host_cookie)
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     omap_hsmmc_get_dma_dir(host, data));
-
-	req_in_progress = host->req_in_progress;
-	dma_ch = host->dma_ch;
-	host->dma_ch = -1;
-	spin_unlock(&host->irq_lock);
-
-	omap_free_dma(dma_ch);
-
-	/* If DMA has finished after TC, complete the request */
-	if (!req_in_progress) {
-		struct mmc_request *mrq = host->mrq;
-
-		host->mrq = NULL;
-		mmc_request_done(host->mmc, mrq);
-	}
-}
-
 static void omap_hsmmc_dma_callback(void *param)
 {
 	struct omap_hsmmc_host *host = param;
@@ -1307,7 +1202,7 @@ static void omap_hsmmc_dma_callback(void *param)
 	int req_in_progress;
 
 	spin_lock_irq(&host->irq_lock);
-	if (host->dma2 < 0) {
+	if (host->dma_ch < 0) {
 		spin_unlock_irq(&host->irq_lock);
 		return;
 	}
@@ -1320,7 +1215,7 @@ static void omap_hsmmc_dma_callback(void *param)
 			     omap_hsmmc_get_dma_dir(host, data));
 
 	req_in_progress = host->req_in_progress;
-	host->dma2 = -1;
+	host->dma_ch = -1;
 	spin_unlock_irq(&host->irq_lock);
 
 	/* If DMA has finished after TC, complete the request */
@@ -1335,7 +1230,7 @@ static void omap_hsmmc_dma_callback(void *param)
 static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 				       struct mmc_data *data,
 				       struct omap_hsmmc_next *next,
-				       struct device *dev)
+				       struct dma_chan *chan)
 {
 	int dma_len;
 
@@ -1350,7 +1245,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 	/* Check if next job is already prepared */
 	if (next ||
 	    (!next && data->host_cookie != host->next_data.cookie)) {
-		dma_len = dma_map_sg(dev, data->sg, data->sg_len,
+		dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
 				     omap_hsmmc_get_dma_dir(host, data));
 
 	} else {
@@ -1377,7 +1272,9 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	int dma_ch = 0, ret = 0, i;
+	struct dma_slave_config cfg;
+	struct dma_async_tx_descriptor *tx;
+	int ret = 0, i;
 	struct mmc_data *data = req->data;
 	struct dma_chan *chan;
 
@@ -1395,66 +1292,43 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 		 */
 		return -EINVAL;
 
-	BUG_ON(host->dma_ch != -1 || host->dma2 != -1);
+	BUG_ON(host->dma_ch != -1);
 
 	chan = omap_hsmmc_get_dma_chan(host, data);
-	if (!chan) {
-		ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
-				       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);
-		if (ret != 0) {
-			dev_err(mmc_dev(host->mmc),
-				"%s: omap_request_dma() failed with %d\n",
-				mmc_hostname(host->mmc), ret);
-			return ret;
-		}
-		ret = omap_hsmmc_pre_dma_transfer(host, data, NULL,
-						  mmc_dev(host->mmc));
-		if (ret)
-			return ret;
-
-		host->dma_ch = dma_ch;
-		host->dma_sg_idx = 0;
 
-		omap_hsmmc_config_dma_params(host, data, data->sg);
-	} else {
-		struct dma_slave_config cfg;
-		struct dma_async_tx_descriptor *tx;
+	cfg.src_addr = host->mapbase + OMAP_HSMMC_DATA;
+	cfg.dst_addr = host->mapbase + OMAP_HSMMC_DATA;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_maxburst = data->blksz / 4;
+	cfg.dst_maxburst = data->blksz / 4;
 
-		cfg.src_addr = host->mapbase + OMAP_HSMMC_DATA;
-		cfg.dst_addr = host->mapbase + OMAP_HSMMC_DATA;
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		cfg.src_maxburst = data->blksz / 4;
-		cfg.dst_maxburst = data->blksz / 4;
-
-		ret = dmaengine_slave_config(chan, &cfg);
-		if (ret)
-			return ret;
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		return ret;
 
-		ret = omap_hsmmc_pre_dma_transfer(host, data, NULL,
-						  chan->device->dev);
-		if (ret)
-			return ret;
+	ret = omap_hsmmc_pre_dma_transfer(host, data, NULL, chan);
+	if (ret)
+		return ret;
 
-		tx = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
-			data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!tx) {
-			dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
-			/* FIXME: cleanup */
-			return -1;
-		}
+	tx = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
+		data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx) {
+		dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
+		/* FIXME: cleanup */
+		return -1;
+	}
 
-		tx->callback = omap_hsmmc_dma_callback;
-		tx->callback_param = host;
+	tx->callback = omap_hsmmc_dma_callback;
+	tx->callback_param = host;
 
-		/* Does not fail */
-		dmaengine_submit(tx);
+	/* Does not fail */
+	dmaengine_submit(tx);
 
-		host->dma2 = 1;
+	host->dma_ch = 1;
 
-		dma_async_issue_pending(chan);
-	}
+	dma_async_issue_pending(chan);
 
 	return 0;
 }
@@ -1536,14 +1410,11 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (host->use_dma) {
+	if (host->use_dma && data->host_cookie) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
-		struct device *dev = c ? c->device->dev : mmc_dev(mmc);
 
-		if (data->host_cookie)
-			dma_unmap_sg(dev,
-				     data->sg, data->sg_len,
-				     omap_hsmmc_get_dma_dir(host, data));
+		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
+			     omap_hsmmc_get_dma_dir(host, data));
 		data->host_cookie = 0;
 	}
 }
@@ -1560,10 +1431,9 @@ static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 
 	if (host->use_dma) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, mrq->data);
-		struct device *dev = c ? c->device->dev : mmc_dev(mmc);
 
 		if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
-						&host->next_data, dev))
+						&host->next_data, c))
 			mrq->data->host_cookie = 0;
 	}
 }
@@ -1577,7 +1447,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	int err;
 
 	BUG_ON(host->req_in_progress);
-	BUG_ON(host->dma_ch != -1 || host->dma2 != -1);
+	BUG_ON(host->dma_ch != -1);
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1890,6 +1760,8 @@ static inline struct omap_mmc_platform_data
 }
 #endif
 
+extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
+
 static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -1898,6 +1770,8 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 	const struct of_device_id *match;
+	dma_cap_mask_t mask;
+	unsigned tx_req, rx_req;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1942,9 +1816,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->pdata	= pdata;
 	host->dev	= &pdev->dev;
 	host->use_dma	= 1;
-	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch	= -1;
-	host->dma2	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
@@ -2036,36 +1908,28 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
 		goto err_irq;
 	}
-	host->dma_line_tx = res->start;
+	tx_req = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
 		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
 		goto err_irq;
 	}
-	host->dma_line_rx = res->start;
+	rx_req = res->start;
 
-	{
-		dma_cap_mask_t mask;
-		unsigned sig;
-		extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-#if 1
-		sig = host->dma_line_rx;
-		host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
-		if (!host->rx_chan) {
-			dev_warn(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
-		}
-#endif
-#if 1
-		sig = host->dma_line_tx;
-		host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
-		if (!host->tx_chan) {
-			dev_warn(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
-		}
-#endif
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
+	if (!host->rx_chan) {
+		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
+		goto err_irq;
+	}
+
+	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
+	if (!host->tx_chan) {
+		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
+		goto err_irq;
 	}
 
 	/* Request IRQ for MMC operations */
-- 
1.7.4.4

