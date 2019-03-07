From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 4/6] mmc: mmci: qcom: define get_dctrl_cfg
Date: Thu, 7 Mar 2019 17:39:00 +0100
Message-ID: <1551976742-4358-5-git-send-email-ludovic.Barre@st.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch defines get_dctrl_cfg callback for qcom variant.
qcom variant has a specific block size definition.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_qcom_dml.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index ccc1b18..f437ad1 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -188,9 +188,22 @@ static int qcom_dma_setup(struct mmci_host *host)
 	return 0;
 }
 
+static u32 qcom_get_dctrl_cfg(struct mmci_host *host)
+{
+	u32 datactrl;
+
+	datactrl = MCI_DPSM_ENABLE;
+	datactrl |= (host->data->blksz << 4);
+	datactrl |= mmci_dctrl_dir(host);
+	datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
+
+	return datactrl;
+}
+
 static struct mmci_host_ops qcom_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_datactrl_cfg = qcom_get_dctrl_cfg,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
-- 
2.7.4
