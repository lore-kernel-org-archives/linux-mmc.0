From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 2/3] mmc: tegra: fix reporting of base clock frequency
Date: Wed, 16 Apr 2014 16:08:38 -0700
Message-ID: <1397689719-28882-3-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397689719-28882-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Tegra SDHCI controllers, by default, report a base clock frequency
of 208Mhz in SDHCI_CAPABILTIES which may or may not be equal to the
actual base clock frequency.  This is because the clock rate is
configured by the clock controller, which is external to the SD/MMC
controller.  Since the SD/MMC controller has no knowledge of how this
clock is configured, it will simply report the maximum frequency.
While the reported value can be overridden by setting BASE_CLK_FREQ in
VENDOR_CLOCK_CTRL on Tegra30 and later SoCs, just set CAP_CLOCK_BASE_BROKEN
and supply sdhci_pltfm_clk_get_max_clock(), which simply does a
clk_get_rate(), as the get_max_clock() callback.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Changes from v1:
 - fixed up commit message per Stephen's suggestions
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
