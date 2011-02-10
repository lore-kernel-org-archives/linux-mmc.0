From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] mmc: sdhci-tegra: free irq on error and remove
Date: Thu, 10 Feb 2011 18:07:30 +0100
Message-ID: <1297357650-14245-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1BJRHh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 12:07:37 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>
---

Found the leak while working on the esdhc-imx driver. Not even compile tested,
please check.

 drivers/mmc/host/sdhci-tegra.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 4823ee9..f7e1f96 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -169,7 +169,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate wp gpio\n");
-			goto out_cd;
+			goto out_irq;
 		}
 		tegra_gpio_enable(plat->wp_gpio);
 		gpio_direction_input(plat->wp_gpio);
@@ -195,6 +195,9 @@ out_wp:
 		gpio_free(plat->wp_gpio);
 	}
 
+out_irq:
+	if (gpio_is_valid(plat->cd_gpio))
+		free_irq(gpio_to_irq(plat->cd_gpio), host);
 out_cd:
 	if (gpio_is_valid(plat->cd_gpio)) {
 		tegra_gpio_disable(plat->cd_gpio);
@@ -225,6 +228,7 @@ static void tegra_sdhci_pltfm_exit(struct sdhci_host *host)
 	}
 
 	if (gpio_is_valid(plat->cd_gpio)) {
+		free_irq(gpio_to_irq(plat->cd_gpio), host);
 		tegra_gpio_disable(plat->cd_gpio);
 		gpio_free(plat->cd_gpio);
 	}
-- 
1.7.2.3

