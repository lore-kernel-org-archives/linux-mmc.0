From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 25/38] mmc: tegra: Disable card clock during tuning cmd on Tegra210
Date: Thu, 30 Aug 2018 18:06:26 +0300
Message-ID: <20180830150639.21048-26-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Implement tegra210_sdhci_writew() to disable card clock and issue a
reset when the tuning command is sent. This is done to prevent an
intermittent hang with around 10 % failure rate during tuning.

Add tegra186_sdhci_ops because this workaround is specific to Tegra210.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 81 ++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0bdce437e752..aa1574b8d96c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -177,6 +177,50 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 	}
 }
 
+static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
+{
+	bool status;
+	u32 reg;
+
+	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	status = !!(reg & SDHCI_CLOCK_CARD_EN);
+
+	if (status == enable)
+		return status;
+
+	if (enable)
+		reg |= SDHCI_CLOCK_CARD_EN;
+	else
+		reg &= ~SDHCI_CLOCK_CARD_EN;
+
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	return status;
+}
+
+static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	bool is_tuning_cmd = 0;
+	bool clk_enabled;
+	u8 cmd;
+
+	if (reg == SDHCI_COMMAND) {
+		cmd = SDHCI_GET_CMD(val);
+		is_tuning_cmd = cmd == MMC_SEND_TUNING_BLOCK ||
+				cmd == MMC_SEND_TUNING_BLOCK_HS200;
+	}
+
+	if (is_tuning_cmd)
+		clk_enabled = tegra_sdhci_configure_card_clk(host, 0);
+
+	writew(val, host->ioaddr + reg);
+
+	if (is_tuning_cmd) {
+		udelay(1);
+		tegra_sdhci_configure_card_clk(host, clk_enabled);
+	}
+}
+
 static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 {
 	return mmc_gpio_get_ro(host->mmc);
@@ -215,28 +259,6 @@ static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
 	return true;
 }
 
-static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
-{
-	bool status;
-	u32 reg;
-
-	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	status = !!(reg & SDHCI_CLOCK_CARD_EN);
-
-	if (status == enable)
-		return status;
-
-	if (enable)
-		reg |= SDHCI_CLOCK_CARD_EN;
-	else
-		reg &= ~SDHCI_CLOCK_CARD_EN;
-
-	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
-
-	return status;
-}
-
-
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -834,6 +856,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 static const struct sdhci_ops tegra210_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
+	.write_w    = tegra210_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -861,6 +884,18 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
+static const struct sdhci_ops tegra186_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_w     = tegra_sdhci_readw,
+	.write_l    = tegra_sdhci_writel,
+	.set_clock  = tegra_sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset      = tegra_sdhci_reset,
+	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.voltage_switch = tegra_sdhci_voltage_switch,
+	.get_max_clock = tegra_sdhci_get_max_clock,
+};
+
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -877,7 +912,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		    * But it is not supported as of now.
 		    */
 		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
-	.ops  = &tegra210_sdhci_ops,
+	.ops  = &tegra186_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
-- 
2.18.0
