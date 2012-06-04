From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH REPOST 1/2] mmc: tegra: use bus-width property instead of support-8bit
Date: Mon,  4 Jun 2012 12:32:34 -0600
Message-ID: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Update the driver to parse the new unified bus-width property introduced
in commit 7f21779 "mmc: dt: Consolidate DT bindings", instead of the legacy
support-8bit property.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Chris, It's probably easiest conflict-wise if I take this through the Tegra
tree. (Note: When I posted this series before, I said there shouldn't be any
conflicts if you take them through the MMC tree. That's probably still true,
but unforseen future conflicts seem more likely in the .dts files in the
second patch than sdhci-tegra.c in this patch, so the Tegra tree may make
more sense). Since the second patch depends on the first, it's easiest if
these go in through the same tree. Does this sound OK?

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
