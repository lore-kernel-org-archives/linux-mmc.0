From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation
 failure
Date: Thu, 11 Nov 2010 12:19:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011111215120.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

The easiest way to fall back to PIO, when a DMA descriptor allocation fails is
to disable DMA on the controller but continue with the current request in PIO
mode. This way tmio_mmc_start_dma() can become void, since it cannot be failing
any more. The current version is also broken: it is testing a wrong 
pointer and thus failing to recognise, that a descriptor allocation wasn't 
successful.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Since this is a bug-fix and it only touches the DMA case, only present on 
sh-mobile platforms, this should be good for 2.6.37, Ian?

 drivers/mmc/host/tmio_mmc.c |   69 +++++++++++++++---------------------------
 drivers/mmc/host/tmio_mmc.h |    2 -
 2 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 9034414..10416c3 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -427,11 +427,12 @@ static void tmio_dma_complete(void *arg)
 		enable_mmc_irqs(host, TMIO_STAT_DATAEND);
 }
 
-static int tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
+static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_rx;
+	dma_cookie_t cookie;
 	int ret;
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_FROM_DEVICE);
@@ -442,21 +443,20 @@ static int tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	}
 
 	if (desc) {
-		host->desc = desc;
 		desc->callback = tmio_dma_complete;
 		desc->callback_param = host;
-		host->cookie = desc->tx_submit(desc);
-		if (host->cookie < 0) {
-			host->desc = NULL;
-			ret = host->cookie;
+		cookie = desc->tx_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
 		} else {
 			chan->device->device_issue_pending(chan);
 		}
 	}
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, host->cookie, host->mrq);
+		__func__, host->sg_len, ret, cookie, host->mrq);
 
-	if (!host->desc) {
+	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
 			ret = -EIO;
@@ -471,23 +471,18 @@ static int tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 		tmio_mmc_enable_dma(host, false);
-		reset(host);
-		/* Fail this request, let above layers recover */
-		host->mrq->cmd->error = ret;
-		tmio_mmc_finish_request(host);
 	}
 
 	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
-		desc, host->cookie, host->sg_len);
-
-	return ret > 0 ? 0 : ret;
+		desc, cookie, host->sg_len);
 }
 
-static int tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
+static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_tx;
+	dma_cookie_t cookie;
 	int ret;
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_TO_DEVICE);
@@ -498,19 +493,18 @@ static int tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	}
 
 	if (desc) {
-		host->desc = desc;
 		desc->callback = tmio_dma_complete;
 		desc->callback_param = host;
-		host->cookie = desc->tx_submit(desc);
-		if (host->cookie < 0) {
-			host->desc = NULL;
-			ret = host->cookie;
+		cookie = desc->tx_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
 		}
 	}
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, host->cookie, host->mrq);
+		__func__, host->sg_len, ret, cookie, host->mrq);
 
-	if (!host->desc) {
+	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
 			ret = -EIO;
@@ -525,30 +519,22 @@ static int tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 		tmio_mmc_enable_dma(host, false);
-		reset(host);
-		/* Fail this request, let above layers recover */
-		host->mrq->cmd->error = ret;
-		tmio_mmc_finish_request(host);
 	}
 
 	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
-		desc, host->cookie);
-
-	return ret > 0 ? 0 : ret;
+		desc, cookie);
 }
 
-static int tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
-			return tmio_mmc_start_dma_rx(host);
+			tmio_mmc_start_dma_rx(host);
 	} else {
 		if (host->chan_tx)
-			return tmio_mmc_start_dma_tx(host);
+			tmio_mmc_start_dma_tx(host);
 	}
-
-	return 0;
 }
 
 static void tmio_issue_tasklet_fn(unsigned long priv)
@@ -584,9 +570,6 @@ static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
 static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 				 struct tmio_mmc_data *pdata)
 {
-	host->cookie = -EINVAL;
-	host->desc = NULL;
-
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (pdata->dma) {
 		dma_cap_mask_t mask;
@@ -632,15 +615,11 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 		host->chan_rx = NULL;
 		dma_release_channel(chan);
 	}
-
-	host->cookie = -EINVAL;
-	host->desc = NULL;
 }
 #else
-static int tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
-	return 0;
 }
 
 static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
@@ -682,7 +661,9 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
 	sd_ctrl_write16(host, CTL_XFER_BLK_COUNT, data->blocks);
 
-	return tmio_mmc_start_dma(host, data);
+	tmio_mmc_start_dma(host, data);
+
+	return 0;
 }
 
 /* Process requests from the MMC layer */
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0fedc78..0b7d916 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -112,9 +112,7 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_complete;
 	struct tasklet_struct	dma_issue;
 #ifdef CONFIG_TMIO_MMC_DMA
-	struct dma_async_tx_descriptor *desc;
 	unsigned int            dma_sglen;
-	dma_cookie_t		cookie;
 #endif
 };
 
-- 
1.7.2.3

