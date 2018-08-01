From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 07/14] mmc: mmci: add prepare/unprepare_data callbacks
Date: Wed, 1 Aug 2018 11:36:54 +0200
Message-ID: <1533116221-380-8-git-send-email-ludovic.Barre@st.com>
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

This patch adds prepare/unprepare callbacks to mmci_host_ops.
Like this mmci_pre/post_request can be generic, mmci_prepare_data
and mmci_unprepare_data provide common next_cookie management.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 118 +++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h          |  10 ++++
 drivers/mmc/host/mmci_qcom_dml.c |   2 +
 3 files changed, 93 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e4d80f1..345aa2e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -58,6 +58,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -69,6 +70,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -81,6 +83,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_u300 = {
@@ -99,6 +102,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_nomadik = {
@@ -118,6 +122,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500 = {
@@ -143,6 +148,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -170,6 +176,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -187,6 +194,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_qcom = {
@@ -357,6 +365,31 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+int mmci_prepare_data(struct mmci_host *host, struct mmc_data *data, bool next)
+{
+	int err;
+
+	if (!host->ops || !host->ops->prepare_data)
+		return 0;
+
+	err = host->ops->prepare_data(host, data, next);
+
+	if (next && !err)
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
+
+	return err;
+}
+
+void mmci_unprepare_data(struct mmci_host *host, struct mmc_data *data,
+			 int err)
+{
+	if (host->ops && host->ops->unprepare_data)
+		host->ops->unprepare_data(host, data, err);
+
+	data->host_cookie = 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -588,9 +621,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
-static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
-				struct dma_chan **dma_chan,
-				struct dma_async_tx_descriptor **dma_desc)
+static int __mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
+				 struct dma_chan **dma_chan,
+				 struct dma_async_tx_descriptor **dma_desc)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 	struct variant_data *variant = host->variant;
@@ -651,22 +684,21 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return -ENOMEM;
 }
 
-static inline int mmci_dma_prepare_data(struct mmci_host *host,
-					struct mmc_data *data,
-					bool next)
+int mmci_dmae_prepare_data(struct mmci_host *host,
+			   struct mmc_data *data, bool next)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 	struct dmaengine_next *nd = &dmae->next_data;
 
 	if (next)
-		return __mmci_dma_prep_data(host, data, &nd->dma_chan,
+		return __mmci_dmae_prep_data(host, data, &nd->dma_chan,
 					    &nd->dma_desc);
 	/* Check if next job is already prepared. */
 	if (dmae->dma_current && dmae->dma_desc_current)
 		return 0;
 
 	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &dmae->dma_current,
+	return __mmci_dmae_prep_data(host, data, &dmae->dma_current,
 				    &dmae->dma_desc_current);
 }
 
@@ -676,7 +708,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	struct mmc_data *data = host->data;
 	int ret;
 
-	ret = mmci_dma_prepare_data(host, host->data, false);
+	ret = mmci_prepare_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -720,33 +752,11 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	next->dma_chan = NULL;
 }
 
-static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
-{
-	struct mmci_host *host = mmc_priv(mmc);
-	struct mmc_data *data = mrq->data;
-
-	if (!data)
-		return;
-
-	BUG_ON(data->host_cookie);
-
-	if (mmci_validate_data(host, data))
-		return;
+void mmci_dmae_unprepare_data(struct mmci_host *host,
+			      struct mmc_data *data, int err)
 
-	if (!mmci_dma_prepare_data(host, data, true))
-		data->host_cookie = ++host->next_cookie < 0 ?
-			1 : host->next_cookie;
-}
-
-static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
-			      int err)
 {
-	struct mmci_host *host = mmc_priv(mmc);
 	struct dmaengine_priv *dmae = host->dma_priv;
-	struct mmc_data *data = mrq->data;
-
-	if (!data || !data->host_cookie)
-		return;
 
 	__mmci_dmae_unmap(host, data);
 
@@ -769,10 +779,13 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 
 		next->dma_desc = NULL;
 		next->dma_chan = NULL;
-		data->host_cookie = 0;
 	}
 }
 
+static struct mmci_host_ops mmci_variant_ops = {
+	.prepare_data = mmci_dmae_prepare_data,
+	.unprepare_data = mmci_dmae_unprepare_data,
+};
 #else
 /* Blank functions if the DMA engine is not available */
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
@@ -802,11 +815,42 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 	return -ENOSYS;
 }
 
-#define mmci_pre_request NULL
-#define mmci_post_request NULL
-
+static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
+void mmci_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+}
+
+static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	WARN_ON(data->host_cookie);
+
+	if (mmci_validate_data(host, data))
+		return;
+
+	mmci_prepare_data(host, data, true);
+}
+
+static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
+			      int err)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data || !data->host_cookie)
+		return;
+
+	mmci_unprepare_data(host, data, err);
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d2ec4fd..fa2702b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,10 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*prepare_data)(struct mmci_host *host, struct mmc_data *data,
+			    bool next);
+	void (*unprepare_data)(struct mmci_host *host, struct mmc_data *data,
+			       int err);
 	int (*dma_setup)(struct mmci_host *host);
 };
 
@@ -323,3 +327,9 @@ struct mmci_host {
 };
 
 void qcom_variant_init(struct mmci_host *host);
+void mmci_variant_init(struct mmci_host *host);
+
+int mmci_dmae_prepare_data(struct mmci_host *host, struct mmc_data *data,
+			   bool next);
+void mmci_dmae_unprepare_data(struct mmci_host *host,
+			      struct mmc_data *data, int err);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 1bb59cf..d534fa1 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -180,6 +180,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
+	.prepare_data = mmci_dmae_prepare_data,
+	.unprepare_data = mmci_dmae_unprepare_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4
