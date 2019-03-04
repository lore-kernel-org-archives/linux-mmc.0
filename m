From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
Date: Mon, 4 Mar 2019 11:17:02 +0100
Message-ID: <1551694625-6414-3-git-send-email-ludovic.Barre@st.com>
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch defines get_dctrl_cfg callback for legacy variants
whatever DMA_ENGINE configuration.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..e1d3f42 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -47,11 +47,8 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-#ifdef CONFIG_DMA_ENGINE
 void mmci_variant_init(struct mmci_host *host);
-#else
-static inline void mmci_variant_init(struct mmci_host *host) {}
-#endif
+void mmci_ux500v2_variant_init(struct mmci_host *host);
 
 #ifdef CONFIG_MMC_STM32_SDMMC
 void sdmmc_variant_init(struct mmci_host *host);
@@ -238,7 +235,7 @@ static struct variant_data variant_ux500v2 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
-	.init			= mmci_variant_init,
+	.init			= mmci_ux500v2_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -624,6 +621,24 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+u32 mmci_get_dctrl_cfg(struct mmci_host *host)
+{
+	struct variant_data *variant = host->variant;
+	int blksz_bits;
+
+	blksz_bits = ffs(host->data->blksz) - 1;
+	BUG_ON(1 << blksz_bits != host->data->blksz);
+
+	return variant->datactrl_dpsm_enable | blksz_bits << 4;
+}
+
+u32 mmci_ux500v2_get_dctrl_cfg(struct mmci_host *host)
+{
+	struct variant_data *variant = host->variant;
+
+	return variant->datactrl_dpsm_enable | (host->data->blksz << 16);
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -952,6 +967,7 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_datactrl_cfg = mmci_get_dctrl_cfg,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
@@ -959,12 +975,22 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_finalize = mmci_dmae_finalize,
 	.dma_error = mmci_dmae_error,
 };
+#else
+static struct mmci_host_ops mmci_variant_ops = {
+	.get_datactrl_cfg = mmci_get_dctrl_cfg,
+}
+#endif
 
 void mmci_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 }
-#endif
+
+void mmci_ux500v2_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+	host->ops->get_datactrl_cfg = mmci_ux500v2_get_dctrl_cfg;
+}
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-- 
2.7.4
