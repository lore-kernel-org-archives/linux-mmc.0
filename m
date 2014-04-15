From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 2/4] mmc: tegra: fix reporting of base clock frequency
Date: Mon, 14 Apr 2014 18:42:41 -0700
Message-ID: <1397526163-20126-3-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Tegra SDHCI controllers, by default, report a base clock frequency
of 208Mhz in SDHCI_CAPABILTIES which may or may not be equal to the
actual base clock frequency.  While this can be overridden by setting
BASE_CLK_FREQ in VENDOR_CLOCK_CTRL on Tegra30 and later SoCs, just
set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and supply a get_max_clock()
callback to get the actual rate of the base clock.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/mmc/host/sdhci-tegra.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3cadd9c..c3f92d9 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -165,13 +165,15 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.write_l    = tegra_sdhci_writel,
 	.platform_bus_width = tegra_sdhci_buswidth,
 	.platform_reset_exit = tegra_sdhci_reset_exit,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.ops  = &tegra_sdhci_ops,
 };
 
@@ -186,7 +188,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.ops  = &tegra_sdhci_ops,
 };
 
@@ -202,7 +205,8 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.ops  = &tegra_sdhci_ops,
 };
 
-- 
1.9.1.423.g4596e3a
