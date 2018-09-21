From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 09/27] mmc: mmci: modify dma_setup callback
Date: Fri, 21 Sep 2018 11:46:03 +0200
Message-ID: <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
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

This patch creates a generic mmci_dma_setup which calls
dma_setup callback and manages common next_cookie.
This patch is needed for sdmmc variant which has a different
dma settings.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

# Conflicts:
#	drivers/mmc/host/mmci.h

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 25 +++++++++++++------------
 drivers/mmc/host/mmci.h          |  1 +
 drivers/mmc/host/mmci_qcom_dml.c |  2 ++
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 55c4222..2a433ed 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -398,6 +398,17 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
+int mmci_dma_setup(struct mmci_host *host)
+{
+	if (!host->ops || !host->ops->dma_setup)
+		return 0;
+
+	/* initialize pre request cookie */
+	host->next_cookie = 1;
+
+	return host->ops->dma_setup(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -472,7 +483,7 @@ struct mmci_dmae_priv {
 
 #define mmci_dmae_inprogress(dmae) ((dmae)->in_progress)
 
-static int mmci_dma_setup(struct mmci_host *host)
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 	struct mmci_dmae_priv *dmae;
@@ -488,9 +499,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
 						     "tx");
 
-	/* initialize pre request cookie */
-	host->next_cookie = 1;
-
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
@@ -531,9 +539,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		return host->ops->dma_setup(host);
-
 	return 0;
 }
 
@@ -793,14 +798,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
+	.dma_setup = mmci_dmae_setup,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline int mmci_dma_setup(struct mmci_host *host)
-{
-	return 0;
-}
-
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4f73070..72fe02d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -334,4 +334,5 @@ int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
+int mmci_dmae_setup(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 432a823..003c497 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -126,6 +126,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 	int consumer_id, producer_id;
 	struct device_node *np = host->mmc->parent->of_node;
 
+	mmci_dmae_setup(host);
+
 	consumer_id = of_get_dml_pipe_index(np, "tx");
 	producer_id = of_get_dml_pipe_index(np, "rx");
 
-- 
2.7.4
