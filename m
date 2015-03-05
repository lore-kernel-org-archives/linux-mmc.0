From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-spear: Remove exported header
Date: Thu,  5 Mar 2015 16:33:11 +0100
Message-ID: <1425569591-20387-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:43821 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbbCEPdS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 10:33:18 -0500
Received: by labgf13 with SMTP id gf13so27638936lab.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 07:33:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Viresh Kumar <viresh.linux@gmail.com>
Cc: linux-mmc@vger.kernel.org, spear-devel@list.st.com

Move the member for card_int_gpio into the struct spear_sdhci.

In this way we eliminate the last user of the struct sdhci_plat_data,
which enables us to remove the exported header for sdhci-spear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-spear.c  | 35 +++++++++--------------------------
 include/linux/mmc/sdhci-spear.h | 34 ----------------------------------
 2 files changed, 9 insertions(+), 60 deletions(-)
 delete mode 100644 include/linux/mmc/sdhci-spear.h

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index f482f7f..df08834 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -26,14 +26,13 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sdhci-spear.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/io.h>
 #include "sdhci.h"
 
 struct spear_sdhci {
 	struct clk *clk;
-	struct sdhci_plat_data *data;
+	int card_int_gpio;
 };
 
 /* sdhci ops */
@@ -44,26 +43,16 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
+static void sdhci_probe_config_dt(struct device_node *np,
+				struct spear_sdhci *host)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct sdhci_plat_data *pdata = NULL;
 	int cd_gpio;
 
 	cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
 	if (!gpio_is_valid(cd_gpio))
 		cd_gpio = -1;
 
-	/* If pdata is required */
-	if (cd_gpio != -1) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata)
-			dev_err(&pdev->dev, "DT: kzalloc failed\n");
-		else
-			pdata->card_int_gpio = cd_gpio;
-	}
-
-	return pdata;
+	host->card_int_gpio = cd_gpio;
 }
 
 static int sdhci_probe(struct platform_device *pdev)
@@ -116,24 +105,18 @@ static int sdhci_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Error setting desired clk, clk=%lu\n",
 				clk_get_rate(sdhci->clk));
 
-	sdhci->data = sdhci_probe_config_dt(pdev);
-	if (IS_ERR(sdhci->data)) {
-		dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-		goto disable_clk;
-	}
-
+	sdhci_probe_config_dt(pdev->dev.of_node, sdhci);
 	/*
 	 * It is optional to use GPIOs for sdhci card detection. If
-	 * sdhci->data is NULL, then use original sdhci lines otherwise
+	 * sdhci->card_int_gpio < 0, then use original sdhci lines otherwise
 	 * GPIO lines. We use the built-in GPIO support for this.
 	 */
-	if (sdhci->data && sdhci->data->card_int_gpio >= 0) {
-		ret = mmc_gpio_request_cd(host->mmc,
-					  sdhci->data->card_int_gpio, 0);
+	if (sdhci->card_int_gpio >= 0) {
+		ret = mmc_gpio_request_cd(host->mmc, sdhci->card_int_gpio, 0);
 		if (ret < 0) {
 			dev_dbg(&pdev->dev,
 				"failed to request card-detect gpio%d\n",
-				sdhci->data->card_int_gpio);
+				sdhci->card_int_gpio);
 			goto disable_clk;
 		}
 	}
diff --git a/include/linux/mmc/sdhci-spear.h b/include/linux/mmc/sdhci-spear.h
deleted file mode 100644
index 8cc095a..0000000
--- a/include/linux/mmc/sdhci-spear.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * include/linux/mmc/sdhci-spear.h
- *
- * SDHCI declarations specific to ST SPEAr platform
- *
- * Copyright (C) 2010 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef LINUX_MMC_SDHCI_SPEAR_H
-#define LINUX_MMC_SDHCI_SPEAR_H
-
-#include <linux/platform_device.h>
-/*
- * struct sdhci_plat_data: spear sdhci platform data structure
- *
- * card_int_gpio: gpio pin used for card detection
- */
-struct sdhci_plat_data {
-	int card_int_gpio;
-};
-
-/* This function is used to set platform_data field of pdev->dev */
-static inline void
-sdhci_set_plat_data(struct platform_device *pdev, struct sdhci_plat_data *data)
-{
-	pdev->dev.platform_data = data;
-}
-
-#endif /* LINUX_MMC_SDHCI_SPEAR_H */
-- 
1.9.1

