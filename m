From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 19/38] mmc: tegra: Add a workaround for tap value change glitch
Date: Thu, 30 Aug 2018 18:06:20 +0300
Message-ID: <20180830150639.21048-20-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add quirk to disable the card clock during configuration of the tap
value in tegra_sdhci_set_tap() and issue sdhci_reset() after value
change. This is a workaround to avoid propagation of a potential
glitch caused by setting the tap value.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index caa9a1b30d2e..d0a536f1b994 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -47,6 +47,9 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
 
+#define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
+#define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
+
 #define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
 #define SDHCI_AUTO_CAL_START				BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE				BIT(29)
@@ -68,6 +71,7 @@
 #define NVQUIRK_ENABLE_DDR50				BIT(5)
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
+#define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -515,12 +519,32 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+	bool card_clk_enabled = false;
 	u32 reg;
 
+	/*
+	 * Touching the tap values is a bit tricky on some SoC generations.
+	 * The quirk enables a workaround for a glitch that sometimes occurs if
+	 * the tap values are changed.
+	 */
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
+		card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 	reg &= ~SDHCI_CLOCK_CTRL_TAP_MASK;
 	reg |= tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
 	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
+	    card_clk_enabled) {
+		usleep_range(1, 2);
+		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+	}
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -774,7 +798,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
-		    NVQUIRK_HAS_PADCALIB,
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -799,7 +824,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
-		    NVQUIRK_HAS_PADCALIB,
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
-- 
2.18.0
