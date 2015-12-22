From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v2 1/5] mmc: tegra: implement module external clock change
Date: Tue, 22 Dec 2015 19:41:00 +0100
Message-ID: <1450809664-11360-2-git-send-email-dev@lynxeye.de>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450809664-11360-1-git-send-email-dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Allow the the driver to change the clock supplied from the CAR directly,
minimizing the need to divide the clock inside the SDMMC module itself.

This allows for higher clock speeds than the default 48MHz supplied to
the module and is a prerequisite to support DDR signaling modes, where
the Tegra host needs to be run with a fixed internal divider of 2 for
data to be sampled correctly. (Tegra K1 TRM v03p chapter 29.7.1.1)

Also enable the broken preset value quirk as the preset values need to
be adapted to the changed clocking. While Tegra114+ allows this through
vendor registers, there is no such way for Tegra30. Takes the easy way
out  and keep things consistent between the different SoC generations by
flagging the preset registers as unusable.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 61 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 368f1b7..f11db83 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -49,6 +49,7 @@ struct sdhci_tegra_soc_data {
 struct sdhci_tegra {
 	const struct sdhci_tegra_soc_data *soc_data;
 	struct gpio_desc *power_gpio;
+	bool ddr_signaling;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -143,6 +144,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (soc_data->nvquirks & NVQUIRK_DISABLE_SDR104)
 		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
 	sdhci_writew(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
+
+	tegra_host->ddr_signaling = false;
 }
 
 static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
@@ -164,15 +167,54 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+	unsigned long host_clk;
+
+	if (!clock)
+		return;
+
+	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
+	clk_set_rate(pltfm_host->clk, host_clk);
+	host->max_clk = clk_get_rate(pltfm_host->clk);
+
+	return sdhci_set_clock(host, clock);
+}
+
+static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
+					  unsigned timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+
+	if (timing == MMC_TIMING_UHS_DDR50)
+		tegra_host->ddr_signaling = true;
+
+	return sdhci_set_uhs_signaling(host, timing);
+}
+
+static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	/*
+	 * DDR modes require the host to run at double the card frequency, so
+	 * the maximum rate we can support is half of the module input clock.
+	 */
+	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
+}
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
-	.set_clock  = sdhci_set_clock,
+	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
@@ -197,6 +239,7 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra_sdhci_ops,
 };
 
@@ -212,11 +255,11 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.read_w     = tegra_sdhci_readw,
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
-	.set_clock  = sdhci_set_clock,
+	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
@@ -226,6 +269,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra114_sdhci_ops,
 };
 
@@ -241,7 +285,9 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra114_sdhci_ops,
 };
 
@@ -288,6 +334,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_alloc_tegra_host;
 	}
+	tegra_host->ddr_signaling = false;
 	tegra_host->soc_data = soc_data;
 	pltfm_host->priv = tegra_host;
 
-- 
2.5.0
