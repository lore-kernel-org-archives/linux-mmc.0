From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: sdhci-tegra: get_ro(): Retrieve pdata correctly
Date: Tue,  9 Aug 2011 12:16:38 -0600
Message-ID: <1312913798-32564-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The active platform data pointer is stored as pltfm_host->priv, and not
always in the platform device itself. In particular, the platform data in
the platform device is NULL when the platform data comes from Device Tree.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Grant, this patch is for branch devicetree/next; the Tegra DT support
doesn't appear to be in other branches yet.

 drivers/mmc/host/sdhci-tegra.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 9329465..406d360 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -74,10 +74,8 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 
 static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
 {
-	struct platform_device *pdev = to_platform_device(mmc_dev(sdhci->mmc));
-	struct tegra_sdhci_platform_data *plat;
-
-	plat = pdev->dev.platform_data;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(sdhci);
+	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
 
 	if (!gpio_is_valid(plat->wp_gpio))
 		return -1;
-- 
1.7.0.4
