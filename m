From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 06/25] mmc: mmci: add get_next_data callback
Date: Tue, 2 Oct 2018 14:09:08 +0200
Message-ID: <1538482167-13819-7-git-send-email-ludovic.Barre@st.com>
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

This patch adds get_next_data callback to mmci_host_ops.
Generic mmci_get_next_data factorizes next_cookie check and
the host ops call.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 16 ++++++++++------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7f66724..9236d4f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -403,6 +403,14 @@ void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
 	data->host_cookie = 0;
 }
 
+void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+{
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
+
+	if (host->ops && host->ops->get_next_data)
+		host->ops->get_next_data(host, data);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -756,7 +764,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmci_dmae_next *next = &dmae->next_data;
@@ -764,7 +772,6 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	if (!host->use_dma)
 		return;
 
-	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
 	dmae->desc_current = next->desc;
@@ -809,14 +816,11 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
-{
-}
-
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e43be60..8d65d55 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -277,6 +277,7 @@ struct mmci_host_ops {
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
 			    int err);
+	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 };
 
@@ -336,5 +337,6 @@ int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 9f60ac0..16ae40e 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -185,6 +185,7 @@ static int qcom_dma_setup(struct mmci_host *host)
 static struct mmci_host_ops qcom_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4
