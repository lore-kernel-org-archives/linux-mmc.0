From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 03/25] mmc: mmci: introduce dma_priv pointer to mmci_host
Date: Tue, 2 Oct 2018 14:09:05 +0200
Message-ID: <1538482167-13819-4-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

-Introduces dma_priv pointer to define specific
needs for each dma engine. This patch is needed to prepare
sdmmc variant with internal dma which not use dmaengine API.
-Moves next cookie to mmci host structure to share same cookie
management between all variants.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 144 ++++++++++++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  19 ++-----
 2 files changed, 94 insertions(+), 69 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2dc37f5..cf0f482 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -372,6 +372,9 @@ void mmci_dma_setup(struct mmci_host *host)
 	if (host->ops->dma_setup(host))
 		return;
 
+	/* initialize pre request cookie */
+	host->next_cookie = 1;
+
 	host->use_dma = true;
 }
 
@@ -433,33 +436,52 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
+struct mmci_dmae_next {
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan	*chan;
+};
+
+struct mmci_dmae_priv {
+	struct dma_chan	*cur;
+	struct dma_chan	*rx_channel;
+	struct dma_chan	*tx_channel;
+	struct dma_async_tx_descriptor	*desc_current;
+	struct mmci_dmae_next next_data;
+};
+
 static inline void mmci_dma_release(struct mmci_host *host);
 
 int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
+	struct mmci_dmae_priv *dmae;
 
-	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
-	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
+	if (!dmae)
+		return -ENOMEM;
 
-	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+	host->dma_priv = dmae;
+
+	dmae->rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "rx");
+	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "tx");
 
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
 	 * is specified but cannot be located, DMA will be disabled.
 	 */
-	if (host->dma_rx_channel && !host->dma_tx_channel)
-		host->dma_tx_channel = host->dma_rx_channel;
+	if (dmae->rx_channel && !dmae->tx_channel)
+		dmae->tx_channel = dmae->rx_channel;
 
-	if (host->dma_rx_channel)
-		rxname = dma_chan_name(host->dma_rx_channel);
+	if (dmae->rx_channel)
+		rxname = dma_chan_name(dmae->rx_channel);
 	else
 		rxname = "none";
 
-	if (host->dma_tx_channel)
-		txname = dma_chan_name(host->dma_tx_channel);
+	if (dmae->tx_channel)
+		txname = dma_chan_name(dmae->tx_channel);
 	else
 		txname = "none";
 
@@ -470,22 +492,22 @@ int mmci_dmae_setup(struct mmci_host *host)
 	 * Limit the maximum segment size in any SG entry according to
 	 * the parameters of the DMA engine device.
 	 */
-	if (host->dma_tx_channel) {
-		struct device *dev = host->dma_tx_channel->device->dev;
+	if (dmae->tx_channel) {
+		struct device *dev = dmae->tx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
-	if (host->dma_rx_channel) {
-		struct device *dev = host->dma_rx_channel->device->dev;
+	if (dmae->rx_channel) {
+		struct device *dev = dmae->rx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (!host->dma_tx_channel || !host->dma_rx_channel) {
+	if (!dmae->tx_channel || !dmae->rx_channel) {
 		mmci_dma_release(host);
 		return -EINVAL;
 	}
@@ -499,21 +521,24 @@ int mmci_dmae_setup(struct mmci_host *host)
  */
 static inline void mmci_dma_release(struct mmci_host *host)
 {
-	if (host->dma_rx_channel)
-		dma_release_channel(host->dma_rx_channel);
-	if (host->dma_tx_channel)
-		dma_release_channel(host->dma_tx_channel);
-	host->dma_rx_channel = host->dma_tx_channel = NULL;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
+	if (dmae->rx_channel)
+		dma_release_channel(dmae->rx_channel);
+	if (dmae->tx_channel)
+		dma_release_channel(dmae->tx_channel);
+	dmae->rx_channel = dmae->tx_channel = NULL;
 }
 
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct dma_chan *chan;
 
 	if (data->flags & MMC_DATA_READ)
-		chan = host->dma_rx_channel;
+		chan = dmae->rx_channel;
 	else
-		chan = host->dma_tx_channel;
+		chan = dmae->tx_channel;
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
@@ -521,14 +546,16 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
 	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
+	dmaengine_terminate_all(dmae->cur);
 	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 	host->data->host_cookie = 0;
 
 	mmci_dma_unmap(host, host->data);
@@ -536,6 +563,7 @@ static void mmci_dma_data_error(struct mmci_host *host)
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
 	int i;
 
@@ -575,8 +603,8 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	}
 
 	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
@@ -584,6 +612,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
 		.src_addr = host->phybase + MMCIFIFO,
@@ -602,10 +631,10 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_DEV_TO_MEM;
-		chan = host->dma_rx_channel;
+		chan = dmae->rx_channel;
 	} else {
 		conf.direction = DMA_MEM_TO_DEV;
-		chan = host->dma_tx_channel;
+		chan = dmae->tx_channel;
 	}
 
 	/* If there's no DMA channel, fall back to PIO */
@@ -645,25 +674,30 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 static inline int mmci_dma_prep_data(struct mmci_host *host,
 				     struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
 	/* Check if next job is already prepared. */
-	if (host->dma_current && host->dma_desc_current)
+	if (dmae->cur && dmae->desc_current)
 		return 0;
 
 	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &host->dma_current,
-				    &host->dma_desc_current);
+	return __mmci_dma_prep_data(host, data, &dmae->cur,
+				    &dmae->desc_current);
 }
 
 static inline int mmci_dma_prep_next(struct mmci_host *host,
 				     struct mmc_data *data)
 {
-	struct mmci_host_next *nd = &host->next_data;
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *nd = &dmae->next_data;
+
+	return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
 }
 
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 
 	if (!host->use_dma)
@@ -678,8 +712,8 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
 	host->dma_in_progress = true;
-	dmaengine_submit(host->dma_desc_current);
-	dma_async_issue_pending(host->dma_current);
+	dmaengine_submit(dmae->desc_current);
+	dma_async_issue_pending(dmae->cur);
 
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
@@ -701,25 +735,25 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
-	struct mmci_host_next *next = &host->next_data;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *next = &dmae->next_data;
 
 	if (!host->use_dma)
 		return;
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
-	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
+	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
-	host->dma_desc_current = next->dma_desc;
-	host->dma_current = next->dma_chan;
-	next->dma_desc = NULL;
-	next->dma_chan = NULL;
+	dmae->desc_current = next->desc;
+	dmae->cur = next->chan;
+	next->desc = NULL;
+	next->chan = NULL;
 }
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
 
 	if (!host->use_dma || !data)
 		return;
@@ -730,13 +764,15 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 			      int err)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
 
 	if (!host->use_dma || !data || !data->host_cookie)
@@ -745,24 +781,24 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	mmci_dma_unmap(host, data);
 
 	if (err) {
-		struct mmci_host_next *next = &host->next_data;
+		struct mmci_dmae_next *next = &dmae->next_data;
 		struct dma_chan *chan;
 		if (data->flags & MMC_DATA_READ)
-			chan = host->dma_rx_channel;
+			chan = dmae->rx_channel;
 		else
-			chan = host->dma_tx_channel;
+			chan = dmae->tx_channel;
 		dmaengine_terminate_all(chan);
 
-		if (host->dma_desc_current == next->dma_desc)
-			host->dma_desc_current = NULL;
+		if (dmae->desc_current == next->desc)
+			dmae->desc_current = NULL;
 
-		if (host->dma_current == next->dma_chan) {
+		if (dmae->cur == next->chan) {
 			host->dma_in_progress = false;
-			host->dma_current = NULL;
+			dmae->cur = NULL;
 		}
 
-		next->dma_desc = NULL;
-		next->dma_chan = NULL;
+		next->desc = NULL;
+		next->chan = NULL;
 		data->host_cookie = 0;
 	}
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f7fe80f..2524ed1 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -276,12 +276,6 @@ struct mmci_host_ops {
 	int (*dma_setup)(struct mmci_host *host);
 };
 
-struct mmci_host_next {
-	struct dma_async_tx_descriptor	*dma_desc;
-	struct dma_chan			*dma_chan;
-	s32				cookie;
-};
-
 struct mmci_host {
 	phys_addr_t		phybase;
 	void __iomem		*base;
@@ -324,19 +318,14 @@ struct mmci_host {
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
 	u8			use_dma:1;
-#ifdef CONFIG_DMA_ENGINE
-	/* DMA stuff */
-	struct dma_chan		*dma_current;
-	struct dma_chan		*dma_rx_channel;
-	struct dma_chan		*dma_tx_channel;
-	struct dma_async_tx_descriptor	*dma_desc_current;
-	struct mmci_host_next	next_data;
 	u8			dma_in_progress:1;
+	void			*dma_priv;
 
-#define dma_inprogress(host)	((host)->dma_in_progress)
-#endif
+	s32			next_cookie;
 };
 
+#define dma_inprogress(host)	((host)->dma_in_progress)
+
 void mmci_variant_init(struct mmci_host *host);
 
 int mmci_dmae_setup(struct mmci_host *host);
-- 
2.7.4
