From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Date: Mon, 4 Jun 2018 18:35:40 +0300
Message-ID: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
and tegra_sdhci_get_max_clock is removed. It appears that the
shdci-tegra specific callback was originally introduced due to the
requirement that the host clock has to be twice the bus clock on DDR50
mode. As far as I can tell the only effect the removal has on DDR50 mode
is in cases where the parent clock is unable to supply the requested
clock rate, causing the DDR50 mode to run at a lower frequency.
Currently the DDR50 mode isn't enabled on any of the SoCs and would also
require configuring the SDHCI clock divider register to function
properly.

The problem with tegra_sdhci_get_max_clock is that it divides the clock
rate by two and thus artificially limits the maximum frequency of faster
signaling modes which don't have the host-bus frequency ratio requirement
of DDR50 such as SDR104 and HS200. Furthermore, the call to
clk_round_rate() may return an error which isn't handled by
tegra_sdhci_get_max_clock.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 970d38f6..c8745b5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_set_uhs_signaling(host, timing);
 }
 
-static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	/*
-	 * DDR modes require the host to run at double the card frequency, so
-	 * the maximum rate we can support is half of the module input clock.
-	 */
-	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
-}
-
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
 	u32 reg;
@@ -309,7 +298,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
-	.get_max_clock = tegra_sdhci_get_max_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
@@ -357,7 +346,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
-	.get_max_clock = tegra_sdhci_get_max_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
-- 
2.7.4
