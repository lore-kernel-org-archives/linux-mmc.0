From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 08/27] mmc: mmci: add get_next_data callback
Date: Fri, 21 Sep 2018 11:46:02 +0200
Message-ID: <1537523181-14578-9-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Loic Pallardy <loic.pallardy@st.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds get_next_data callback to mmci_host_ops.
Generic mmci_get_next_data factorizes next_cookie check and
the host ops call.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 16 ++++++++++------
 drivers/mmc/host/mmci.h          |  3 +++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5734c05..55c4222 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -390,6 +390,14 @@ void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
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
@@ -738,12 +746,11 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmci_dmae_next *next = &dmae->next_data;
 
-	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
 	dmae->desc_current = next->desc;
@@ -785,13 +792,10 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
-{
-}
-
 static inline int mmci_dma_setup(struct mmci_host *host)
 {
 	return 0;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 0f2f82f..4f73070 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -277,6 +277,7 @@ struct mmci_host_ops {
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
 			    int err);
+	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 };
 
@@ -332,3 +333,5 @@ int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
+
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index e3cbdda..432a823 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -182,6 +182,7 @@ static int qcom_dma_setup(struct mmci_host *host)
 static struct mmci_host_ops qcom_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4
