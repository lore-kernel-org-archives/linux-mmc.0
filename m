From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 12/40] mmc: tegra: Reconfigure pad voltages during voltage switching
Date: Wed, 1 Aug 2018 19:32:02 +0300
Message-ID: <1533141150-10511-13-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Parse the pinctrl state and nvidia,only-1-8-v properties from the device
tree. Validate the pinctrl and regulator configuration before unmasking
UHS modes. Implement pad voltage state reconfiguration in the mmc
start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
and add set it for Tegra210 and Tegra186.

The pad configuration is done in the mmc callback because the order of
pad reconfiguration and sdhci voltage switch depend on the voltage to
which the transition occurs.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 138 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ddf00166..7d98455 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -55,6 +57,7 @@
 #define NVQUIRK_ENABLE_SDR104		BIT(4)
 #define NVQUIRK_ENABLE_DDR50		BIT(5)
 #define NVQUIRK_HAS_PADCALIB		BIT(6)
+#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -66,8 +69,12 @@ struct sdhci_tegra {
 	struct gpio_desc *power_gpio;
 	bool ddr_signaling;
 	bool pad_calib_required;
+	bool pad_control_available;
 
 	struct reset_control *rst;
+	struct pinctrl *pinctrl_sdmmc;
+	struct pinctrl_state *pinctrl_state_3v3;
+	struct pinctrl_state *pinctrl_state_1v8;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -138,12 +145,46 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 	return mmc_gpio_get_ro(host->mmc);
 }
 
+static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	int has_1v8, has_3v3;
+
+	/*
+	 * The SoCs which have NVQUIRK_NEEDS_PAD_CONTROL require software pad
+	 * voltage configuration in order to perform voltage switching. This
+	 * means that valid pinctrl info is required on SDHCI instances capable
+	 * of performing voltage switching. Whether or not an SDHCI instance is
+	 * capable of voltage switching is determined based on the regulator.
+	 */
+
+	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
+		return true;
+
+	if (IS_ERR(host->mmc->supply.vqmmc))
+		return false;
+
+	has_1v8 = regulator_is_supported_voltage(host->mmc->supply.vqmmc,
+						 1700000, 1950000);
+
+	has_3v3 = regulator_is_supported_voltage(host->mmc->supply.vqmmc,
+						 2700000, 3600000);
+
+	if (has_1v8 == 1 && has_3v3 == 1)
+		return tegra_host->pad_control_available;
+
+	/* Fixed voltage, no pad control required. */
+	return true;
+}
+
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl, clk_ctrl;
+	bool pad_and_regulators_valid;
 
 	sdhci_reset(host, mask);
 
@@ -160,13 +201,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
 
-	/*
-	 * If the board does not define a regulator for the SDHCI
-	 * IO voltage, then don't advertise support for UHS modes
-	 * even if the device supports it because the IO voltage
-	 * cannot be configured.
-	 */
-	if (!IS_ERR(host->mmc->supply.vqmmc)) {
+	pad_and_regulators_valid = tegra_sdhci_is_pad_and_regulator_valid(host);
+	if (pad_and_regulators_valid) {
 		/* Erratum: Enable SDHCI spec v3.00 support */
 		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
@@ -286,6 +322,84 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
 
+static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (!tegra_host->pad_control_available)
+		return 0;
+
+	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+					   tegra_host->pinctrl_state_1v8);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+				"setting 1.8V failed, ret: %d\n", ret);
+	} else {
+		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+					   tegra_host->pinctrl_state_3v3);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+				"setting 3.3V failed, ret: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
+						   struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret = 0;
+
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		if (ret < 0)
+			return ret;
+		ret = sdhci_start_signal_voltage_switch(mmc, ios);
+	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		ret = sdhci_start_signal_voltage_switch(mmc, ios);
+		if (ret < 0)
+			return ret;
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+	}
+
+	return ret;
+}
+
+static int tegra_sdhci_init_pinctrl_info(struct device *dev,
+					 struct sdhci_tegra *tegra_host)
+{
+	tegra_host->pinctrl_sdmmc = devm_pinctrl_get(dev);
+	if (IS_ERR(tegra_host->pinctrl_sdmmc)) {
+		dev_dbg(dev, "No pinctrl info, err: %ld\n",
+			PTR_ERR(tegra_host->pinctrl_sdmmc));
+		return -1;
+	}
+
+	tegra_host->pinctrl_state_3v3 =
+		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
+	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
+		dev_warn(dev, "Missing 3.3V pad state, err: %ld\n",
+			 PTR_ERR(tegra_host->pinctrl_state_3v3));
+		return -1;
+	}
+
+	tegra_host->pinctrl_state_1v8 =
+		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
+	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
+		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
+			 PTR_ERR(tegra_host->pinctrl_state_3v3));
+		return -1;
+	}
+
+	tegra_host->pad_control_available = true;
+
+	return 0;
+}
+
 static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -419,6 +533,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -442,6 +557,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
@@ -478,8 +594,16 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host = sdhci_pltfm_priv(pltfm_host);
 	tegra_host->ddr_signaling = false;
 	tegra_host->pad_calib_required = false;
+	tegra_host->pad_control_available = false;
 	tegra_host->soc_data = soc_data;
 
+	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
+		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
+		if (rc == 0)
+			host->mmc_host_ops.start_signal_voltage_switch =
+				sdhci_tegra_start_signal_voltage_switch;
+	}
+
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
 		goto err_parse_dt;
-- 
2.7.4
