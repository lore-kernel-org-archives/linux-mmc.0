From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V6 08/23] mmc: mmci: add dma_error callback
Date: Mon, 8 Oct 2018 14:08:40 +0200
Message-ID: <1539000535-13261-9-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_error callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 26 +++++++++++++++-----------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4570042..3d4431b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -469,6 +469,15 @@ void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		host->ops->dma_finalize(host, data);
 }
 
+void mmci_dma_error(struct mmci_host *host)
+{
+	if (!host->use_dma)
+		return;
+
+	if (host->ops && host->ops->dma_error)
+		host->ops->dma_error(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -633,11 +642,11 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 		     mmc_get_dma_dir(data));
 }
 
-static void mmci_dma_data_error(struct mmci_host *host)
+void mmci_dmae_error(struct mmci_host *host)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 
-	if (!host->use_dma || !dma_inprogress(host))
+	if (!dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
@@ -674,7 +683,7 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data)
 	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
 	 */
 	if (status & MCI_RXDATAAVLBLMASK) {
-		mmci_dma_data_error(host);
+		mmci_dma_error(host);
 		if (!data->error)
 			data->error = -EIO;
 	} else if (!data->host_cookie) {
@@ -854,18 +863,13 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
 	.dma_finalize = mmci_dmae_finalize,
+	.dma_error = mmci_dmae_error,
 };
 
 void mmci_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 }
-#else
-/* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_data_error(struct mmci_host *host)
-{
-}
-
 #endif
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1037,7 +1041,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		mmci_dma_data_error(host);
+		mmci_dma_error(host);
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -1183,7 +1187,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			mmci_dma_data_error(host);
+			mmci_dma_error(host);
 
 			mmci_stop_data(host);
 		}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8c1493b..bcf3e8b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -282,6 +282,7 @@ struct mmci_host_ops {
 	void (*dma_release)(struct mmci_host *host);
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
+	void (*dma_error)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -343,3 +344,4 @@ int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
 void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
+void mmci_dmae_error(struct mmci_host *host);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index c2ef73f..25d0a75 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -191,6 +191,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
 	.dma_finalize = mmci_dmae_finalize,
+	.dma_error = mmci_dmae_error,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
