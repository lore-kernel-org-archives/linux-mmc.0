From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 04/27] mmc: mmci: introduce dma_priv pointer to mmci_host
Date: Fri, 21 Sep 2018 11:45:58 +0200
Message-ID: <1537523181-14578-5-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch introduces dma_priv pointer to define specific
needs for each dma engine. This patch is needed to prepare
sdmmc variant with internal dma which not use dmaengine API.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v2:
-rename specific dma engine structure to mmci_dmae_next/priv
-remove dma prefixe of mmci_dmae_priv fields, rename "current"
field to "cur" this avoid build issue with "current" defined
in include/asm-generic/current.h

 drivers/mmc/host/mmci.c | 155 ++++++++++++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  18 +-----
 2 files changed, 99 insertions(+), 74 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2f845f3..6de7c8d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -415,31 +415,57 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
+struct mmci_dmae_next {
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan	*chan;
+	s32 cookie;
+};
+
+struct mmci_dmae_priv {
+	struct dma_chan	*cur;
+	struct dma_chan	*rx_channel;
+	struct dma_chan	*tx_channel;
+	struct dma_async_tx_descriptor	*desc_current;
+	struct mmci_dmae_next next_data;
+	bool in_progress;
+};
+
+#define mmci_dmae_inprogress(dmae) ((dmae)->in_progress)
+
 static int mmci_dma_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
+	struct mmci_dmae_priv *dmae;
+
+	dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
+	if (!dmae)
+		return -ENOMEM;
 
-	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
-	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	host->dma_priv = dmae;
+
+	dmae->rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "rx");
+	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "tx");
 
 	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+	dmae->next_data.cookie = 1;
 
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
 
@@ -450,15 +476,15 @@ static int mmci_dma_setup(struct mmci_host *host)
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
@@ -477,21 +503,24 @@ static int mmci_dma_setup(struct mmci_host *host)
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
@@ -499,14 +528,16 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
-	if (!dma_inprogress(host))
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
+	if (!mmci_dmae_inprogress(dmae))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmaengine_terminate_all(dmae->cur);
+	dmae->in_progress = false;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 	host->data->host_cookie = 0;
 
 	mmci_dma_unmap(host, host->data);
@@ -514,10 +545,11 @@ static void mmci_dma_data_error(struct mmci_host *host)
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
 	int i;
 
-	if (!dma_inprogress(host))
+	if (!mmci_dmae_inprogress(dmae))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -551,9 +583,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		mmci_dma_release(host);
 	}
 
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->in_progress = false;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
@@ -561,6 +593,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
 		.src_addr = host->phybase + MMCIFIFO,
@@ -579,10 +612,10 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 
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
@@ -622,26 +655,31 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
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
-	int ret;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
+	int ret;
 
 	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
@@ -651,9 +689,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	dev_vdbg(mmc_dev(host->mmc),
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
-	host->dma_in_progress = true;
-	dmaengine_submit(host->dma_desc_current);
-	dma_async_issue_pending(host->dma_current);
+	dmae->in_progress = true;
+	dmaengine_submit(dmae->desc_current);
+	dma_async_issue_pending(dmae->cur);
 
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
@@ -675,22 +713,24 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
-	struct mmci_host_next *next = &host->next_data;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *next = &dmae->next_data;
 
 	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
-	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
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
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
+	struct mmci_dmae_next *nd = &dmae->next_data;
 
 	if (!data)
 		return;
@@ -708,6 +748,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 			      int err)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
 
 	if (!data || !data->host_cookie)
@@ -716,24 +757,24 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
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
-			host->dma_in_progress = false;
-			host->dma_current = NULL;
+		if (dmae->cur == next->chan) {
+			dmae->in_progress = false;
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
index 06299ac..1e9a45b 100644
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
@@ -323,16 +317,6 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
-#ifdef CONFIG_DMA_ENGINE
-	/* DMA stuff */
-	struct dma_chan		*dma_current;
-	struct dma_chan		*dma_rx_channel;
-	struct dma_chan		*dma_tx_channel;
-	struct dma_async_tx_descriptor	*dma_desc_current;
-	struct mmci_host_next	next_data;
-	bool			dma_in_progress;
-
-#define dma_inprogress(host)	((host)->dma_in_progress)
-#endif
+	void			*dma_priv;
 };
 
-- 
2.7.4
