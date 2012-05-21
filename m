From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 1/2] mmc: tegra: use bus-width property instead of support-8bit
Date: Mon, 21 May 2012 16:50:59 -0600
Message-ID: <1337640660-13273-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Update the driver to parse the new unified bus-width property introduced
in commit 7f21779 "mmc: dt: Consolidate DT bindings", instead of the legacy
support-8bit property.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
These should go into 3.6; both patches have a bunch of dependencies in
3.5 that would be hard to manage. I think you can take both changes
through the MMC tree in 3.6 without risk of significant conflicts.

 drivers/mmc/host/sdhci-tegra.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b38d8a7..6e5338a 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -223,6 +223,7 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
 {
 	struct tegra_sdhci_platform_data *plat;
 	struct device_node *np = pdev->dev.of_node;
+	u32 bus_width;
 
 	if (!np)
 		return NULL;
@@ -236,7 +237,9 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
 	plat->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
 	plat->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
 	plat->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
-	if (of_find_property(np, "support-8bit", NULL))
+
+	if (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+	    bus_width == 8)
 		plat->is_8bit = 1;
 
 	return plat;
-- 
1.7.0.4
