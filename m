From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 10/14] mmc: mmci: add dma_release callback
Date: Wed, 1 Aug 2018 11:36:57 +0200
Message-ID: <1533116221-380-11-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_release callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 13 ++++++++-----
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ae47d08..177e2e8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -409,6 +409,12 @@ int mmci_dma_setup(struct mmci_host *host)
 	return host->ops->dma_setup(host);
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -546,7 +552,7 @@ int mmci_dmae_setup(struct mmci_host *host)
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 
@@ -799,13 +805,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.unprepare_data = mmci_dmae_unprepare_data,
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
index e1b389c..f961f90 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -279,6 +279,7 @@ struct mmci_host_ops {
 			       int err);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -336,3 +337,4 @@ void mmci_dmae_unprepare_data(struct mmci_host *host,
 			      struct mmc_data *data, int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 47abbdd..3c9d32e 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -186,6 +186,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.unprepare_data = mmci_dmae_unprepare_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4
