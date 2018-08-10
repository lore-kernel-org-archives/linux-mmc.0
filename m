From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 05/40] soc/tegra: pmc: Fix pad voltage configuration for Tegra186
Date: Fri, 10 Aug 2018 21:08:07 +0300
Message-ID: <1533924522-1037-6-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Implement support for the PMC_IMPL_E_33V_PWR register which replaces
PMC_PWR_DET register interface of the SoC generations preceding
Tegra186. Also add the voltage bit offsets to the tegra186_io_pads[]
table and the AO_HV pad.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 55 +++++++++++++++++++++++++++++++++++--------------
 include/soc/tegra/pmc.h |  1 +
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2d6f3fc..d3ce6d1 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -65,6 +65,8 @@
 
 #define PWRGATE_STATUS			0x38
 
+#define PMC_IMPL_E_33V_PWR		0x40
+
 #define PMC_PWR_DET			0x48
 
 #define PMC_SCRATCH0_MODE_RECOVERY	BIT(31)
@@ -154,6 +156,7 @@ struct tegra_pmc_soc {
 	bool has_tsense_reset;
 	bool has_gpu_clamps;
 	bool needs_mbist_war;
+	bool has_impl_33v_pwr;
 
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
@@ -1073,20 +1076,31 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 
 	mutex_lock(&pmc->powergates_lock);
 
-	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
-	value = tegra_pmc_readl(PMC_PWR_DET);
-	value |= BIT(pad->voltage);
-	tegra_pmc_writel(value, PMC_PWR_DET);
+	if (pmc->soc->has_impl_33v_pwr) {
+		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
 
-	/* update I/O voltage */
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+		if (voltage == TEGRA_IO_PAD_1800000UV)
+			value &= ~BIT(pad->voltage);
+		else
+			value |= BIT(pad->voltage);
 
-	if (voltage == TEGRA_IO_PAD_1800000UV)
-		value &= ~BIT(pad->voltage);
-	else
+		tegra_pmc_writel(value, PMC_IMPL_E_33V_PWR);
+	} else {
+		/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
+		value = tegra_pmc_readl(PMC_PWR_DET);
 		value |= BIT(pad->voltage);
+		tegra_pmc_writel(value, PMC_PWR_DET);
+
+		/* update I/O voltage */
+		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
-	tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+		if (voltage == TEGRA_IO_PAD_1800000UV)
+			value &= ~BIT(pad->voltage);
+		else
+			value |= BIT(pad->voltage);
+
+		tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+	}
 
 	mutex_unlock(&pmc->powergates_lock);
 
@@ -1108,7 +1122,10 @@ int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 	if (pad->voltage == UINT_MAX)
 		return -ENOTSUPP;
 
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+	if (pmc->soc->has_impl_33v_pwr)
+		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
+	else
+		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
 	if ((value & BIT(pad->voltage)) == 0)
 		return TEGRA_IO_PAD_1800000UV;
@@ -1567,6 +1584,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.cpu_powergates = tegra30_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.regs = &tegra20_pmc_regs,
@@ -1609,6 +1627,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.cpu_powergates = tegra114_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.regs = &tegra20_pmc_regs,
@@ -1689,6 +1708,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.cpu_powergates = tegra124_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
 	.regs = &tegra20_pmc_regs,
@@ -1778,6 +1798,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.cpu_powergates = tegra210_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_impl_33v_pwr = false,
 	.needs_mbist_war = true,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
@@ -1806,7 +1827,7 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = 5 },
 	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_CAM, .dpd = 38, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 40, .voltage = UINT_MAX },
@@ -1818,12 +1839,13 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = 2 },
 	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = 4 },
+	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = 6 },
 	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 1 },
+	{ .id = TEGRA_IO_PAD_AO_HV, .dpd = UINT_MAX, .voltage = 0 },
 };
 
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
@@ -1876,6 +1898,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.cpu_powergates = NULL,
 	.has_tsense_reset = false,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
 	.regs = &tegra186_pmc_regs,
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index c32bf91..445aa66 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -134,6 +134,7 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_USB2,
 	TEGRA_IO_PAD_USB3,
 	TEGRA_IO_PAD_USB_BIAS,
+	TEGRA_IO_PAD_AO_HV,
 };
 
 /* deprecated, use TEGRA_IO_PAD_{HDMI,LVDS} instead */
-- 
2.7.4
