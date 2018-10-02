From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 08/25] mmc: mmci: add dma_start callback
Date: Tue, 2 Oct 2018 14:09:10 +0200
Message-ID: <1538482167-13819-9-git-send-email-ludovic.Barre@st.com>
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

This patch adds dma_start callback to mmci_host_ops.
Create a generic mmci_dma_start function which regroup
common action between variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 69 +++++++++++++++++++++++-----------------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8f482f3..53d2012 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -417,6 +417,41 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
+int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
+{
+	struct mmc_data *data = host->data;
+	int ret;
+
+	if (!host->use_dma)
+		return -EINVAL;
+
+	ret = mmci_prep_data(host, data, false);
+	if (ret)
+		return ret;
+
+	if (!host->ops || !host->ops->dma_start)
+		return -EINVAL;
+
+	/* Okay, go for it. */
+	dev_vdbg(mmc_dev(host->mmc),
+		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
+		 data->sg_len, data->blksz, data->blocks, data->flags);
+
+	host->ops->dma_start(host, &datactrl);
+
+	/* Trigger the DMA transfer */
+	mmci_write_datactrlreg(host, datactrl);
+
+	/*
+	 * Let the MMCI say when the data is ended and it's time
+	 * to fire next DMA request. When that happens, MMCI will
+	 * call mmci_data_end()
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	return 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -729,23 +764,11 @@ int mmci_dmae_prep_data(struct mmci_host *host,
 				    &dmae->desc_current);
 }
 
-static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
 {
-	int ret;
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 
-	if (!host->use_dma)
-		return -EINVAL;
-
-	ret = mmci_dmae_prep_data(host, host->data, false);
-	if (ret)
-		return ret;
-
-	/* Okay, go for it. */
-	dev_vdbg(mmc_dev(host->mmc),
-		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
-		 data->sg_len, data->blksz, data->blocks, data->flags);
 	host->dma_in_progress = true;
 	dmaengine_submit(dmae->desc_current);
 	dma_async_issue_pending(dmae->cur);
@@ -753,18 +776,8 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
 
-	datactrl |= MCI_DPSM_DMAENABLE;
+	*datactrl |= MCI_DPSM_DMAENABLE;
 
-	/* Trigger the DMA transfer */
-	mmci_write_datactrlreg(host, datactrl);
-
-	/*
-	 * Let the MMCI say when the data is ended and it's time
-	 * to fire next DMA request. When that happens, MMCI will
-	 * call mmci_data_end()
-	 */
-	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
-	       host->base + MMCIMASK0);
 	return 0;
 }
 
@@ -823,6 +836,7 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
+	.dma_start = mmci_dmae_start,
 };
 #else
 /* Blank functions if the DMA engine is not available */
@@ -835,11 +849,6 @@ static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
 
-static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
-{
-	return -ENOSYS;
-}
-
 static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
@@ -942,7 +951,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
 	 */
-	if (!mmci_dma_start_data(host, datactrl))
+	if (!mmci_dma_start(host, datactrl))
 		return;
 
 	/* IRQ mode, map the SG list for CPU reading/writing */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 9deca99..1bb4a14 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -280,6 +280,7 @@ struct mmci_host_ops {
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
+	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 };
 
 struct mmci_host {
@@ -341,4 +342,5 @@ void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
+int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 5334427..ae1c193 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -188,6 +188,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
+	.dma_start = mmci_dmae_start,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
