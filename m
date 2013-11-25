From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] mmc: tegra: add support for Tegra124
Date: Mon, 25 Nov 2013 15:19:53 -0700
Message-ID: <1385417993-7848-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra124's MMC controller is very similar to earlier SoC generations,
and can be supported by the same driver.

However, there are some non-backwards-compatible HW differences, and
hence a new DT compatible value must be used to describe the HW. This
patch updates the driver to support that new compatible value.

That said, the HW differences are only relevant when enabling certain
high-performance transfer modes. Since the driver is currently very
simple and doesn't enable those modes, we don't actually need to address
any of these HW differences in the code yet, hence the simple nature of
this patch.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 5b7b2eba8a54..a835898a68dd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -198,6 +198,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra114 = {
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
-- 
1.8.1.5
