From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Cleanup code for DMA handling
Date: Fri, 3 Feb 2012 14:13:51 +0100
Message-ID: <1328274831-13879-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:60693 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848Ab2BCNOc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 08:14:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

The cookie is now used to indicate if dma_unmap_sg shall be
done in post_request. At DMA errors, the DMA job is immediately
not only terminated but also unmapped. To indicate that this
has been done the cookie is reset to zero. post_request will
thus only do dma_umap_sg for requests which has a cookie not set
to zero.

Some corresponding duplicated code could then be removed and
moreover some minor corrections at DMA errors for terminating
the same DMA job twice has also been fixed.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Do note that this patch is based upon the below patchseries:
"mmc: mmci: Improved PM and SDIO support"

---
 drivers/mmc/host/mmci.c |  153 +++++++++++++++++++++++------------------------
 1 files changed, 75 insertions(+), 78 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1c6c874..b29d34f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -374,10 +374,31 @@ static inline void mmci_dma_release(struct mmci_host *host)
 	host->dma_rx_channel = host->dma_tx_channel = NULL;
 }
 
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	dmaengine_terminate_all(host->dma_current);
+	host->data->host_cookie = 0;
+}
+
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
-	struct dma_chan *chan = host->dma_current;
+	struct dma_chan *chan;
 	enum dma_data_direction dir;
+
+	if (data->flags & MMC_DATA_READ) {
+		dir = DMA_FROM_DEVICE;
+		chan = host->dma_rx_channel;
+	} else {
+		dir = DMA_TO_DEVICE;
+		chan = host->dma_tx_channel;
+	}
+
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+}
+
+static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
 	u32 status;
 	int i;
 
@@ -396,19 +417,14 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
 	 */
 	if (status & MCI_RXDATAAVLBLMASK) {
-		dmaengine_terminate_all(chan);
-		if (!data->error)
+		if (!data->error) {
 			data->error = -EIO;
-	}
-
-	if (data->flags & MMC_DATA_WRITE) {
-		dir = DMA_TO_DEVICE;
-	} else {
-		dir = DMA_FROM_DEVICE;
+			mmci_dma_data_error(host);
+		}
 	}
 
 	if (!data->host_cookie)
-		dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+		mmci_dma_unmap(host, data);
 
 	/*
 	 * Use of DMA with scatter-gather is impossible.
@@ -420,14 +436,10 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	}
 }
 
-static void mmci_dma_data_error(struct mmci_host *host)
-{
-	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
-}
-
-static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
-			      struct mmci_host_next *next)
+/* prepares DMA channel and DMA descriptor, returns non-zero on failure */
+static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
+				struct dma_chan **dma_chan,
+				struct dma_async_tx_descriptor **dma_desc)
 {
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
@@ -443,16 +455,6 @@ static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	struct dma_async_tx_descriptor *desc;
 	int nr_sg;
 
-	/* Check if next job is already prepared */
-	if (data->host_cookie && !next &&
-	    host->dma_current && host->dma_desc_current)
-		return 0;
-
-	if (!next) {
-		host->dma_current = NULL;
-		host->dma_desc_current = NULL;
-	}
-
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_FROM_DEVICE;
 		chan = host->dma_rx_channel;
@@ -484,30 +486,42 @@ static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (!desc)
 		goto unmap_exit;
 
-	if (next) {
-		next->dma_chan = chan;
-		next->dma_desc = desc;
-	} else {
-		host->dma_current = chan;
-		host->dma_desc_current = desc;
-	}
+	*dma_chan = chan;
+	*dma_desc = desc;
 
 	return 0;
 
  unmap_exit:
-	if (!next)
-		dmaengine_terminate_all(chan);
 	dma_unmap_sg(device->dev, data->sg, data->sg_len, conf.direction);
 	return -ENOMEM;
 }
 
+static int inline mmci_dma_prep_data(struct mmci_host *host,
+				     struct mmc_data *data)
+{
+	/* Check if next job is already prepared. */
+	if (host->dma_current && host->dma_desc_current)
+		return 0;
+
+	/* No job were prepared thus do it now. */
+	return __mmci_dma_prep_data(host, data, &host->dma_current,
+				    &host->dma_desc_current);
+}
+
+static inline int mmci_dma_prep_next(struct mmci_host *host,
+				     struct mmc_data *data)
+{
+	struct mmci_host_next *nd = &host->next_data;
+	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
+}
+
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
 	struct mmc_data *data = host->data;
 	struct variant_data *variant = host->variant;
 
-	ret = mmci_dma_prep_data(host, host->data, NULL);
+	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
 		return ret;
 
@@ -543,18 +557,14 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	struct mmci_host_next *next = &host->next_data;
 
 	if (data->host_cookie && data->host_cookie != next->cookie) {
-		pr_warning("[%s] invalid cookie: data->host_cookie %d"
+		pr_err("[%s] invalid cookie: data->host_cookie %d"
 		       " host->next_data.cookie %d\n",
 		       __func__, data->host_cookie, host->next_data.cookie);
-		data->host_cookie = 0;
+		BUG();
 	}
 
-	if (!data->host_cookie)
-		return;
-
 	host->dma_desc_current = next->dma_desc;
 	host->dma_current = next->dma_chan;
-
 	next->dma_desc = NULL;
 	next->dma_chan = NULL;
 }
@@ -569,22 +579,13 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (!data)
 		return;
 
-	if (mmci_validate_data(host, mrq->data))
-		return;
+	BUG_ON(data->host_cookie);
 
-	if (data->host_cookie) {
-		data->host_cookie = 0;
+	if (mmci_validate_data(host, data))
 		return;
-	}
 
-	/* if config for dma */
-	if (((data->flags & MMC_DATA_WRITE) && host->dma_tx_channel) ||
-	    ((data->flags & MMC_DATA_READ) && host->dma_rx_channel)) {
-		if (mmci_dma_prep_data(host, data, nd))
-			data->host_cookie = 0;
-		else
-			data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
-	}
+	if (!mmci_dma_prep_next(host, data))
+		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -592,29 +593,19 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct dma_chan *chan;
-	enum dma_data_direction dir;
 
-	if (!data)
+	if (!data || !data->host_cookie)
 		return;
 
-	if (data->flags & MMC_DATA_READ) {
-		dir = DMA_FROM_DEVICE;
-		chan = host->dma_rx_channel;
-	} else {
-		dir = DMA_TO_DEVICE;
-		chan = host->dma_tx_channel;
-	}
-
+	mmci_dma_unmap(host, data);
 
-	/* if config for dma */
-	if (chan) {
-		if (err)
-			dmaengine_terminate_all(chan);
-		if (data->host_cookie)
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-				     data->sg_len, dir);
-		mrq->data->host_cookie = 0;
+	if (err) {
+		struct dma_chan *chan;
+		if (data->flags & MMC_DATA_READ)
+			chan = host->dma_rx_channel;
+		else
+			chan = host->dma_tx_channel;
+		dmaengine_terminate_all(chan);
 	}
 }
 
@@ -635,6 +626,10 @@ static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
 }
 
+static inline void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+}
+
 static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
@@ -817,7 +812,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 
 	if (status & MCI_DATAEND || data->error) {
 		if (dma_inprogress(host))
-			mmci_dma_unmap(host, data);
+			mmci_dma_finalize(host, data);
 		mmci_stop_data(host);
 
 		if (!data->error)
@@ -854,8 +849,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if (!cmd->data || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			if (dma_inprogress(host))
+			if (dma_inprogress(host)) {
 				mmci_dma_data_error(host);
+				mmci_dma_unmap(host, host->data);
+			}
 			mmci_stop_data(host);
 		}
 		mmci_request_end(host, cmd->mrq);
-- 
1.7.5.4

