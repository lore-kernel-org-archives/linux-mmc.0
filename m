From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 02/11] mmc: omap_hsmmc: add DMA engine support
Date: Thu, 07 Jun 2012 12:06:53 +0100
Message-ID: <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add DMA engine support to the OMAP HSMMC driver.  This supplements the
private DMA API implementation contained within this driver, and the
driver can be switched at build time between using DMA engine and the
private DMA API.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c |  192 +++++++++++++++++++++++++++++++++++------
 1 files changed, 165 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9a7a60a..f80361f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
+#include <linux/dmaengine.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -167,7 +168,9 @@ struct omap_hsmmc_host {
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
-	int			use_dma, dma_ch;
+	int			use_dma, dma_ch, dma2;
+	struct dma_chan		*tx_chan;
+	struct dma_chan		*rx_chan;
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
 	int			response_busy;
@@ -802,19 +805,26 @@ omap_hsmmc_get_dma_dir(struct omap_hsmmc_host *host, struct mmc_data *data)
 		return DMA_FROM_DEVICE;
 }
 
+static struct dma_chan *omap_hsmmc_get_dma_chan(struct omap_hsmmc_host *host,
+	struct mmc_data *data)
+{
+	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
+}
+
 static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_request *mrq)
 {
-	int dma_ch;
+	int dma_ch, dma2;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->irq_lock, flags);
 	host->req_in_progress = 0;
 	dma_ch = host->dma_ch;
+	dma2 = host->dma2;
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && dma_ch != -1)
+	if (mrq->data && host->use_dma && (dma_ch != -1 || dma2 != -1))
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -886,7 +896,7 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
  */
 static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 {
-	int dma_ch;
+	int dma_ch, dma2;
 	unsigned long flags;
 
 	host->data->error = errno;
@@ -894,8 +904,20 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	spin_lock_irqsave(&host->irq_lock, flags);
 	dma_ch = host->dma_ch;
 	host->dma_ch = -1;
+	dma2 = host->dma2;
+	host->dma2 = -1;
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
+	if (host->use_dma && dma2 != -1) {
+		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
+
+		dmaengine_terminate_all(chan);
+		dma_unmap_sg(chan->device->dev,
+			host->data->sg, host->data->sg_len,
+			omap_hsmmc_get_dma_dir(host, host->data));
+
+		host->data->host_cookie = 0;
+	}
 	if (host->use_dma && dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
 			host->data->sg_len,
@@ -1292,9 +1314,43 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	}
 }
 
+static void omap_hsmmc_dma_callback(void *param)
+{
+	struct omap_hsmmc_host *host = param;
+	struct dma_chan *chan;
+	struct mmc_data *data;
+	int req_in_progress;
+
+	spin_lock_irq(&host->irq_lock);
+	if (host->dma2 < 0) {
+		spin_unlock_irq(&host->irq_lock);
+		return;
+	}
+
+	data = host->mrq->data;
+	chan = omap_hsmmc_get_dma_chan(host, data);
+	if (!data->host_cookie)
+		dma_unmap_sg(chan->device->dev,
+			     data->sg, data->sg_len,
+			     omap_hsmmc_get_dma_dir(host, data));
+
+	req_in_progress = host->req_in_progress;
+	host->dma2 = -1;
+	spin_unlock_irq(&host->irq_lock);
+
+	/* If DMA has finished after TC, complete the request */
+	if (!req_in_progress) {
+		struct mmc_request *mrq = host->mrq;
+
+		host->mrq = NULL;
+		mmc_request_done(host->mmc, mrq);
+	}
+}
+
 static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 				       struct mmc_data *data,
-				       struct omap_hsmmc_next *next)
+				       struct omap_hsmmc_next *next,
+				       struct device *dev)
 {
 	int dma_len;
 
@@ -1309,8 +1365,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 	/* Check if next job is already prepared */
 	if (next ||
 	    (!next && data->host_cookie != host->next_data.cookie)) {
-		dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
-				     data->sg_len,
+		dma_len = dma_map_sg(dev, data->sg, data->sg_len,
 				     omap_hsmmc_get_dma_dir(host, data));
 
 	} else {
@@ -1339,6 +1394,7 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 {
 	int dma_ch = 0, ret = 0, i;
 	struct mmc_data *data = req->data;
+	struct dma_chan *chan;
 
 	/* Sanity check: all the SG entries must be aligned by block size. */
 	for (i = 0; i < data->sg_len; i++) {
@@ -1354,24 +1410,66 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 		 */
 		return -EINVAL;
 
-	BUG_ON(host->dma_ch != -1);
+	BUG_ON(host->dma_ch != -1 || host->dma2 != -1);
 
-	ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
-			       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);
-	if (ret != 0) {
-		dev_err(mmc_dev(host->mmc),
-			"%s: omap_request_dma() failed with %d\n",
-			mmc_hostname(host->mmc), ret);
-		return ret;
-	}
-	ret = omap_hsmmc_pre_dma_transfer(host, data, NULL);
-	if (ret)
-		return ret;
+	chan = omap_hsmmc_get_dma_chan(host, data);
+	if (!chan) {
+		ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
+				       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);
+		if (ret != 0) {
+			dev_err(mmc_dev(host->mmc),
+				"%s: omap_request_dma() failed with %d\n",
+				mmc_hostname(host->mmc), ret);
+			return ret;
+		}
+		ret = omap_hsmmc_pre_dma_transfer(host, data, NULL,
+						  mmc_dev(host->mmc));
+		if (ret)
+			return ret;
+
+		host->dma_ch = dma_ch;
+		host->dma_sg_idx = 0;
+
+		omap_hsmmc_config_dma_params(host, data, data->sg);
+	} else {
+		struct dma_slave_config cfg;
+		struct dma_async_tx_descriptor *tx;
+
+		cfg.src_addr = host->mapbase + OMAP_HSMMC_DATA;
+		cfg.dst_addr = host->mapbase + OMAP_HSMMC_DATA;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.src_maxburst = data->blksz / 4;
+		cfg.dst_maxburst = data->blksz / 4;
+
+		ret = dmaengine_slave_config(chan, &cfg);
+		if (ret)
+			return ret;
+
+		ret = omap_hsmmc_pre_dma_transfer(host, data, NULL,
+						  chan->device->dev);
+		if (ret)
+			return ret;
+
+		tx = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
+			data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!tx) {
+			dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
+			/* FIXME: cleanup */
+			return -1;
+		}
 
-	host->dma_ch = dma_ch;
-	host->dma_sg_idx = 0;
+		tx->callback = omap_hsmmc_dma_callback;
+		tx->callback_param = host;
 
-	omap_hsmmc_config_dma_params(host, data, data->sg);
+		/* Does not fail */
+		dmaengine_submit(tx);
+
+		host->dma2 = 1;
+
+		dma_async_issue_pending(chan);
+	}
 
 	return 0;
 }
@@ -1454,9 +1552,12 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmc_data *data = mrq->data;
 
 	if (host->use_dma) {
+		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
+		struct device *dev = c ? c->device->dev : mmc_dev(mmc);
+
 		if (data->host_cookie)
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-				     data->sg_len,
+			dma_unmap_sg(dev,
+				     data->sg, data->sg_len,
 				     omap_hsmmc_get_dma_dir(host, data));
 		data->host_cookie = 0;
 	}
@@ -1472,10 +1573,14 @@ static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		return ;
 	}
 
-	if (host->use_dma)
+	if (host->use_dma) {
+		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, mrq->data);
+		struct device *dev = c ? c->device->dev : mmc_dev(mmc);
+
 		if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
-						&host->next_data))
+						&host->next_data, dev))
 			mrq->data->host_cookie = 0;
+	}
 }
 
 /*
@@ -1487,7 +1592,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	int err;
 
 	BUG_ON(host->req_in_progress);
-	BUG_ON(host->dma_ch != -1);
+	BUG_ON(host->dma_ch != -1 || host->dma2 != -1);
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1854,6 +1959,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch	= -1;
+	host->dma2	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
@@ -1951,6 +2057,29 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	}
 	host->dma_line_rx = res->start;
 
+	{
+		dma_cap_mask_t mask;
+		unsigned sig;
+		extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+#if 1
+		sig = host->dma_line_rx;
+		host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+		if (!host->rx_chan) {
+			dev_warn(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
+		}
+#endif
+#if 1
+		sig = host->dma_line_tx;
+		host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+		if (!host->tx_chan) {
+			dev_warn(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
+		}
+#endif
+	}
+
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
@@ -2028,6 +2157,10 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
+	if (host->tx_chan)
+		dma_release_channel(host->tx_chan);
+	if (host->rx_chan)
+		dma_release_channel(host->rx_chan);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
@@ -2063,6 +2196,11 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 
+	if (host->tx_chan)
+		dma_release_channel(host->tx_chan);
+	if (host->rx_chan)
+		dma_release_channel(host->rx_chan);
+
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
-- 
1.7.4.4

