From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 02/24] mmc: mmci: create common mmci_dma_setup/release
Date: Fri, 5 Oct 2018 15:22:40 +0200
Message-ID: <1538745782-27446-3-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch creates a common mmci_dma_setup/release which calls
dma_setup/release callbacks of mmci_host_ops and manages
common features like use_dma... If there is a fallbacks to
pio mode, dma functions must check use_dma.

error management:
-mmci_dmae_setup fail if Tx and Rx dma channels are not defined
-qcom_dma_setup fail if one of both dma channels is not defined,
 Qcom has no specific resource to release, just mmci dmae resource.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 69 +++++++++++++++++++++++++++++++---------
 drivers/mmc/host/mmci.h          | 15 ++++++++-
 drivers/mmc/host/mmci_qcom_dml.c | 10 ++++--
 3 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index db8c085..07b799c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -68,6 +69,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -80,6 +82,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_u300 = {
@@ -98,6 +101,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_nomadik = {
@@ -117,6 +121,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500 = {
@@ -142,6 +147,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -169,6 +175,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -186,6 +193,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_qcom = {
@@ -356,6 +364,27 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+
+	host->use_dma = false;
+}
+
+void mmci_dma_setup(struct mmci_host *host)
+{
+	if (!host->ops || !host->ops->dma_setup)
+		return;
+
+	if (host->ops->dma_setup(host)) {
+		mmci_dma_release(host);
+		return;
+	}
+
+	host->use_dma = true;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -414,7 +443,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 
@@ -464,15 +493,17 @@ static void mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		host->ops->dma_setup(host);
+	if (!host->dma_tx_channel && !host->dma_rx_channel)
+		return -EINVAL;
+
+	return 0;
 }
 
 /*
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	if (host->dma_rx_channel)
 		dma_release_channel(host->dma_rx_channel);
@@ -496,7 +527,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
@@ -514,7 +545,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -640,6 +671,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	int ret;
 	struct mmc_data *data = host->data;
 
+	if (!host->use_dma)
+		return -EINVAL;
+
 	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
 		return ret;
@@ -674,6 +708,9 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_host_next *next = &host->next_data;
 
+	if (!host->use_dma)
+		return;
+
 	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
@@ -689,7 +726,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 	struct mmci_host_next *nd = &host->next_data;
 
-	if (!data)
+	if (!host->use_dma || !data)
 		return;
 
 	BUG_ON(data->host_cookie);
@@ -707,7 +744,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!data || !data->host_cookie)
+	if (!host->use_dma || !data || !data->host_cookie)
 		return;
 
 	mmci_dma_unmap(host, data);
@@ -735,18 +772,20 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
+static struct mmci_host_ops mmci_variant_ops = {
+	.dma_setup = mmci_dmae_setup,
+	.dma_release = mmci_dmae_release,
+};
+
+void mmci_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+}
 #else
 /* Blank functions if the DMA engine is not available */
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 }
-static inline void mmci_dma_setup(struct mmci_host *host)
-{
-}
-
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
 
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 01e6c6b..9b0a960 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,7 +273,8 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
-	void (*dma_setup)(struct mmci_host *host);
+	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host_next {
@@ -323,6 +324,7 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
+	u8			use_dma:1;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
@@ -336,3 +338,14 @@ struct mmci_host {
 #endif
 };
 
+#ifdef CONFIG_DMA_ENGINE
+void mmci_variant_init(struct mmci_host *host);
+#else
+static inline void mmci_variant_init(struct mmci_host *host)
+{
+}
+#endif
+
+int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
+
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index be3fab5..aa070a9 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
 }
 
 /* Initialize the dml hardware connected to SD Card controller */
-static void qcom_dma_setup(struct mmci_host *host)
+static int qcom_dma_setup(struct mmci_host *host)
 {
 	u32 config;
 	void __iomem *base;
 	int consumer_id, producer_id;
 	struct device_node *np = host->mmc->parent->of_node;
 
+	if (mmci_dmae_setup(host))
+		return -EINVAL;
+
 	consumer_id = of_get_dml_pipe_index(np, "tx");
 	producer_id = of_get_dml_pipe_index(np, "rx");
 
 	if (producer_id < 0 || consumer_id < 0) {
 		host->variant->qcom_dml = false;
-		return;
+		return -EINVAL;
 	}
 
 	base = host->base + DML_OFFSET;
@@ -175,10 +178,13 @@ static void qcom_dma_setup(struct mmci_host *host)
 
 	/* Make sure dml initialization is finished */
 	mb();
+
+	return 0;
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
