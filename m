From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2] mmc: mxs-mmc: add support for pre_req and post_req
Date: Wed, 20 Apr 2011 21:51:56 +0800
Message-ID: <1303307516-1549-1-git-send-email-shawn.guo@linaro.org>
References: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.182]:29917
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753104Ab1DTNsY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 09:48:24 -0400
In-Reply-To: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
If not calling pre_req() before mxs_mmc_request(), request()
will prepare the cache just like it did it before.
It is optional to use pre_req() and post_req().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
* Get dma_unmap_sg() call in mxs_mmc_request_done() non-blocking

 drivers/mmc/host/mxs-mmc.c |   81 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 99d39a6..235acfa 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -137,6 +137,10 @@
 
 #define SSP_PIO_NUM	3
 
+struct mxs_mmc_next {
+	s32 cookie;
+};
+
 struct mxs_mmc_host {
 	struct mmc_host			*mmc;
 	struct mmc_request		*mrq;
@@ -154,6 +158,7 @@ struct mxs_mmc_host {
 	struct mxs_dma_data		dma_data;
 	unsigned int			dma_dir;
 	u32				ssp_pio_words[SSP_PIO_NUM];
+	struct mxs_mmc_next		next_data;
 
 	unsigned int			version;
 	unsigned char			bus_width;
@@ -236,8 +241,10 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
 	}
 
 	if (data) {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-			     data->sg_len, host->dma_dir);
+		if (!data->host_cookie)
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len, host->dma_dir);
+
 		/*
 		 * If there was an error on any block, we mark all
 		 * data blocks as being in error.
@@ -302,6 +309,31 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mxs_mmc_prep_dma_data(struct mxs_mmc_host *host,
+				struct mmc_data *data,
+				struct mxs_mmc_next *next)
+{
+	if (!next && data->host_cookie &&
+	    data->host_cookie != host->next_data.cookie) {
+		printk(KERN_WARNING "[%s] invalid cookie: data->host_cookie %d"
+		       " host->next_data.cookie %d\n",
+		       __func__, data->host_cookie, host->next_data.cookie);
+		data->host_cookie = 0;
+	}
+
+	/* Check if next job is already prepared */
+	if (next || (!next && data->host_cookie != host->next_data.cookie))
+		if (dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			       (data->flags & MMC_DATA_WRITE) ?
+			       DMA_TO_DEVICE : DMA_FROM_DEVICE) == 0)
+			return -EINVAL;
+
+	if (next)
+		data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 	struct mxs_mmc_host *host, unsigned int append)
 {
@@ -312,8 +344,8 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 
 	if (data) {
 		/* data */
-		dma_map_sg(mmc_dev(host->mmc), data->sg,
-			   data->sg_len, host->dma_dir);
+		if (mxs_mmc_prep_dma_data(host, data, NULL))
+			return NULL;
 		sgl = data->sg;
 		sg_len = data->sg_len;
 	} else {
@@ -328,9 +360,11 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 		desc->callback = mxs_mmc_dma_irq_callback;
 		desc->callback_param = host;
 	} else {
-		if (data)
+		if (data) {
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
 				     data->sg_len, host->dma_dir);
+			data->host_cookie = 0;
+		}
 	}
 
 	return desc;
@@ -553,6 +587,40 @@ static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
 	}
 }
 
+static void mxs_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
+			    bool is_first_req)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	if (data->host_cookie) {
+		data->host_cookie = 0;
+		return;
+	}
+
+	if (mxs_mmc_prep_dma_data(host, data, &host->next_data))
+		data->host_cookie = 0;
+}
+
+static void mxs_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
+			     int err)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	if (data->host_cookie) {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+			     data->sg_len, host->dma_dir);
+		data->host_cookie = 0;
+	}
+}
+
 static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
@@ -644,6 +712,8 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 }
 
 static const struct mmc_host_ops mxs_mmc_ops = {
+	.pre_req = mxs_mmc_pre_req,
+	.post_req = mxs_mmc_post_req,
 	.request = mxs_mmc_request,
 	.get_ro = mxs_mmc_get_ro,
 	.get_cd = mxs_mmc_get_cd,
@@ -708,6 +778,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->dma_res = dmares;
 	host->irq = irq_err;
 	host->sdio_irq_en = 0;
+	host->next_data.cookie = 1;
 
 	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
-- 
1.7.4.1


