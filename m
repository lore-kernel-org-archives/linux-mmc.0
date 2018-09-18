From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 12/27] mmc: mmci: add dma_finalize callback
Date: Tue, 18 Sep 2018 12:55:29 +0200
Message-ID: <1537268144-21152-13-git-send-email-ludovic.Barre@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_finalize callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 14 ++++++++------
 drivers/mmc/host/mmci.h          |  3 ++-
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 10c7adc..1158d5c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -447,6 +447,12 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
+void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	if (host->ops && host->ops->dma_finalize)
+		host->ops->dma_finalize(host, data);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -626,7 +632,7 @@ static void mmci_dma_data_error(struct mmci_host *host)
 	mmci_dma_unmap(host, host->data);
 }
 
-static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
@@ -820,14 +826,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_finalize(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-}
-
 static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 72f449f..7838155 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -281,6 +281,7 @@ struct mmci_host_ops {
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
+	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
 };
 
 struct mmci_host {
@@ -340,4 +341,4 @@ void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
-
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index e2e756c..f1fd48a 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -188,6 +188,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
