From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V10 4/4] mmc: tegra: HW Command Queue Support for Tegra SDMMC
Date: Tue, 22 Jan 2019 11:56:33 -0800
Message-ID: <1548186993-6229-4-git-send-email-skomatineni@nvidia.com>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds HW Command Queue for supported Tegra SDMMC
controllers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V10]: Changes are same as V9 except this series has SDHCI core changes
	into seperate patch 

 drivers/mmc/host/Kconfig       |   1 +
 drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..0739d26c001b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
 	depends on ARCH_TEGRA
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_CQHCI
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
 	  platform with SD or MMC devices, say Y or M here.
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e6ace31e2a41..d400f158bee4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -33,6 +33,7 @@
 #include <linux/ktime.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 /* Tegra SDHOST controller vendor register definitions */
 #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
@@ -89,6 +90,9 @@
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 
+/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
+#define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
+
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 nvquirks;
@@ -128,6 +132,7 @@ struct sdhci_tegra {
 	u32 default_tap;
 	u32 default_trim;
 	u32 dqs_trim;
+	bool enable_hwcq;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -595,6 +600,20 @@ static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 		tegra_host->dqs_trim = 0x11;
 }
 
+static void tegra_sdhci_parse_dt(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (device_property_read_bool(host->mmc->parent, "supports-cqe"))
+		tegra_host->enable_hwcq = true;
+	else
+		tegra_host->enable_hwcq = false;
+
+	tegra_sdhci_parse_pad_autocal_dt(host);
+	tegra_sdhci_parse_tap_and_trim(host);
+}
+
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -836,6 +855,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 cqcfg = 0;
+
+	/*
+	 * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
+	 * registers when CQE is enabled.
+	 */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	if (cqcfg & CQHCI_ENABLE)
+		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
+
+	sdhci_cqe_enable(mmc);
+
+	if (cqcfg & CQHCI_ENABLE)
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+}
+
+static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
+	.enable	= sdhci_tegra_cqe_enable,
+	.disable = sdhci_cqe_disable,
+	.dumpregs = sdhci_tegra_dumpregs,
+};
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
@@ -989,6 +1051,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
 	.get_max_clock = tegra_sdhci_get_max_clock,
+	.irq = sdhci_tegra_cqhci_irq,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -1030,6 +1093,54 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
 
+static int sdhci_tegra_add_host(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	if (!tegra_host->enable_hwcq)
+		return sdhci_add_host(host);
+
+	sdhci_enable_v4_mode(host);
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+
+	cq_host = devm_kzalloc(host->mmc->parent,
+				sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
+	cq_host->ops = &sdhci_tegra_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64)
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret)
+		goto cleanup;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1077,9 +1188,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-	tegra_sdhci_parse_pad_autocal_dt(host);
-
-	tegra_sdhci_parse_tap_and_trim(host);
+	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
@@ -1117,7 +1226,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	usleep_range(2000, 4000);
 
-	rc = sdhci_add_host(host);
+	rc = sdhci_tegra_add_host(host);
 	if (rc)
 		goto err_add_host;
 
-- 
2.7.4
