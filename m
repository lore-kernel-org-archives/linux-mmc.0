From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
Date: Wed, 27 Mar 2019 10:05:29 +0100
Message-ID: <1553677532-3539-3-git-send-email-ludovic.Barre@st.com>
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch defines get_dctrl_cfg callback for legacy variants
whatever DMA_ENGINE configuration.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e6a2c1..a818511 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -46,11 +46,8 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-#ifdef CONFIG_DMA_ENGINE
 static void mmci_variant_init(struct mmci_host *host);
-#else
-static inline void mmci_variant_init(struct mmci_host *host) {}
-#endif
+static void ux500v2_variant_init(struct mmci_host *host);
 
 static unsigned int fmax = 515633;
 
@@ -231,7 +228,7 @@ static struct variant_data variant_ux500v2 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
-	.init			= mmci_variant_init,
+	.init			= ux500v2_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -617,6 +614,16 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+static u32 mmci_get_dctrl_cfg(struct mmci_host *host)
+{
+	return MCI_DPSM_ENABLE | mmci_dctrl_blksz(host);
+}
+
+static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
+{
+	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -941,6 +948,7 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_datactrl_cfg = mmci_get_dctrl_cfg,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
@@ -948,12 +956,22 @@ static struct mmci_host_ops mmci_variant_ops = {
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
+void ux500v2_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+	host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
+}
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-- 
2.7.4
