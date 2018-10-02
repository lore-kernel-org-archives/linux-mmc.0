From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 07/25] mmc: mmci: add dma_release callback
Date: Tue, 2 Oct 2018 14:09:09 +0200
Message-ID: <1538482167-13819-8-git-send-email-ludovic.Barre@st.com>
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

This patch adds dma_release callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 15 ++++++++-------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9236d4f..8f482f3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -378,6 +378,12 @@ void mmci_dma_setup(struct mmci_host *host)
 	host->use_dma = true;
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+}
+
 int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
@@ -482,8 +488,6 @@ struct mmci_dmae_priv {
 	struct mmci_dmae_next next_data;
 };
 
-static inline void mmci_dma_release(struct mmci_host *host);
-
 int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
@@ -552,7 +556,7 @@ int mmci_dmae_setup(struct mmci_host *host)
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 
@@ -818,13 +822,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
+	.dma_release = mmci_dmae_release,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
-
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
 {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8d65d55..9deca99 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -279,6 +279,7 @@ struct mmci_host_ops {
 			    int err);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -339,4 +340,5 @@ void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 16ae40e..5334427 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -187,6 +187,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
