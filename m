From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] mmc: host: sdhci-tegra: cleanup ifdefs
Date: Wed, 20 Feb 2013 13:35:16 -0500
Message-ID: <1361385317-6020-4-git-send-email-rklein@nvidia.com>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361385317-6020-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The structs wrapped with the SOC ifdefs are small enough where having
them always there shouldn't be a big overhead. Removing the ifdefs
also makes the code a little cleaner.

Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 1276131..5e126bf 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -173,7 +173,6 @@ static struct sdhci_ops tegra_sdhci_ops = {
 	.platform_reset_exit = tegra_sdhci_reset_exit,
 };
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 static struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
@@ -187,9 +186,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
 };
-#endif
 
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 static struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -203,15 +200,10 @@ static struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300,
 };
-#endif
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
-#endif
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
-#endif
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
-- 
1.7.9.5
