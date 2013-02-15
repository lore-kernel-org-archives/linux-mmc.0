From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] mmc: tegra: assume CONFIG_OF, remove platform data
Date: Fri, 15 Feb 2013 15:07:19 -0700
Message-ID: <1360966039-24071-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra only supports, and always enables, device tree. Remove all ifdefs
and runtime checks for DT support from the driver. Platform data is
therefore no longer required. Rework the driver to parse the device tree
directly into struct sdhci_tegra.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c                |  119 ++++++++++---------------
 include/linux/platform_data/mmc-sdhci-tegra.h |   28 ------
 2 files changed, 45 insertions(+), 102 deletions(-)
 delete mode 100644 include/linux/platform_data/mmc-sdhci-tegra.h

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 5a600a5..08b06e9 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -27,8 +27,6 @@
 
 #include <asm/gpio.h>
 
-#include <linux/platform_data/mmc-sdhci-tegra.h>
-
 #include "sdhci-pltfm.h"
 
 /* Tegra SDHOST controller vendor register definitions */
@@ -45,8 +43,11 @@ struct sdhci_tegra_soc_data {
 };
 
 struct sdhci_tegra {
-	const struct tegra_sdhci_platform_data *plat;
 	const struct sdhci_tegra_soc_data *soc_data;
+	int cd_gpio;
+	int wp_gpio;
+	int power_gpio;
+	int is_8bit;
 };
 
 static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
@@ -108,12 +109,11 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
-	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
 
-	if (!gpio_is_valid(plat->wp_gpio))
+	if (!gpio_is_valid(tegra_host->wp_gpio))
 		return -1;
 
-	return gpio_get_value(plat->wp_gpio);
+	return gpio_get_value(tegra_host->wp_gpio);
 }
 
 static irqreturn_t carddetect_irq(int irq, void *data)
@@ -147,11 +147,10 @@ static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
-	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
 	u32 ctrl;
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	if (plat->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
+	if (tegra_host->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 		ctrl |= SDHCI_CTRL_8BITBUS;
 	} else {
@@ -217,31 +216,19 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
 
-static struct tegra_sdhci_platform_data *sdhci_tegra_dt_parse_pdata(
-						struct platform_device *pdev)
+static void sdhci_tegra_parse_dt(struct device *dev,
+					struct sdhci_tegra *tegra_host)
 {
-	struct tegra_sdhci_platform_data *plat;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	u32 bus_width;
 
-	if (!np)
-		return NULL;
-
-	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
-	if (!plat) {
-		dev_err(&pdev->dev, "Can't allocate platform data\n");
-		return NULL;
-	}
-
-	plat->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
-	plat->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
-	plat->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
+	tegra_host->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
+	tegra_host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
+	tegra_host->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
 
 	if (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
 	    bus_width == 8)
-		plat->is_8bit = 1;
-
-	return plat;
+		tegra_host->is_8bit = 1;
 }
 
 static int sdhci_tegra_probe(struct platform_device *pdev)
@@ -250,7 +237,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	const struct sdhci_tegra_soc_data *soc_data;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
-	struct tegra_sdhci_platform_data *plat;
 	struct sdhci_tegra *tegra_host;
 	struct clk *clk;
 	int rc;
@@ -263,52 +249,40 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	host = sdhci_pltfm_init(pdev, soc_data->pdata);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-
 	pltfm_host = sdhci_priv(host);
 
-	plat = pdev->dev.platform_data;
-
-	if (plat == NULL)
-		plat = sdhci_tegra_dt_parse_pdata(pdev);
-
-	if (plat == NULL) {
-		dev_err(mmc_dev(host->mmc), "missing platform data\n");
-		rc = -ENXIO;
-		goto err_no_plat;
-	}
-
 	tegra_host = devm_kzalloc(&pdev->dev, sizeof(*tegra_host), GFP_KERNEL);
 	if (!tegra_host) {
 		dev_err(mmc_dev(host->mmc), "failed to allocate tegra_host\n");
 		rc = -ENOMEM;
-		goto err_no_plat;
+		goto err_alloc_tegra_host;
 	}
-
-	tegra_host->plat = plat;
 	tegra_host->soc_data = soc_data;
-
 	pltfm_host->priv = tegra_host;
 
-	if (gpio_is_valid(plat->power_gpio)) {
-		rc = gpio_request(plat->power_gpio, "sdhci_power");
+	sdhci_tegra_parse_dt(&pdev->dev, tegra_host);
+
+	if (gpio_is_valid(tegra_host->power_gpio)) {
+		rc = gpio_request(tegra_host->power_gpio, "sdhci_power");
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate power gpio\n");
 			goto err_power_req;
 		}
-		gpio_direction_output(plat->power_gpio, 1);
+		gpio_direction_output(tegra_host->power_gpio, 1);
 	}
 
-	if (gpio_is_valid(plat->cd_gpio)) {
-		rc = gpio_request(plat->cd_gpio, "sdhci_cd");
+	if (gpio_is_valid(tegra_host->cd_gpio)) {
+		rc = gpio_request(tegra_host->cd_gpio, "sdhci_cd");
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate cd gpio\n");
 			goto err_cd_req;
 		}
-		gpio_direction_input(plat->cd_gpio);
+		gpio_direction_input(tegra_host->cd_gpio);
 
-		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
+		rc = request_irq(gpio_to_irq(tegra_host->cd_gpio),
+				 carddetect_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				 mmc_hostname(host->mmc), host);
 
@@ -319,14 +293,14 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	}
 
-	if (gpio_is_valid(plat->wp_gpio)) {
-		rc = gpio_request(plat->wp_gpio, "sdhci_wp");
+	if (gpio_is_valid(tegra_host->wp_gpio)) {
+		rc = gpio_request(tegra_host->wp_gpio, "sdhci_wp");
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate wp gpio\n");
 			goto err_wp_req;
 		}
-		gpio_direction_input(plat->wp_gpio);
+		gpio_direction_input(tegra_host->wp_gpio);
 	}
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
@@ -338,9 +312,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
-	host->mmc->pm_caps = plat->pm_flags;
-
-	if (plat->is_8bit)
+	if (tegra_host->is_8bit)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
 	rc = sdhci_add_host(host);
@@ -353,19 +325,19 @@ err_add_host:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
-	if (gpio_is_valid(plat->wp_gpio))
-		gpio_free(plat->wp_gpio);
+	if (gpio_is_valid(tegra_host->wp_gpio))
+		gpio_free(tegra_host->wp_gpio);
 err_wp_req:
-	if (gpio_is_valid(plat->cd_gpio))
-		free_irq(gpio_to_irq(plat->cd_gpio), host);
+	if (gpio_is_valid(tegra_host->cd_gpio))
+		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
 err_cd_irq_req:
-	if (gpio_is_valid(plat->cd_gpio))
-		gpio_free(plat->cd_gpio);
+	if (gpio_is_valid(tegra_host->cd_gpio))
+		gpio_free(tegra_host->cd_gpio);
 err_cd_req:
-	if (gpio_is_valid(plat->power_gpio))
-		gpio_free(plat->power_gpio);
+	if (gpio_is_valid(tegra_host->power_gpio))
+		gpio_free(tegra_host->power_gpio);
 err_power_req:
-err_no_plat:
+err_alloc_tegra_host:
 	sdhci_pltfm_free(pdev);
 	return rc;
 }
@@ -375,21 +347,20 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
-	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 
-	if (gpio_is_valid(plat->wp_gpio))
-		gpio_free(plat->wp_gpio);
+	if (gpio_is_valid(tegra_host->wp_gpio))
+		gpio_free(tegra_host->wp_gpio);
 
-	if (gpio_is_valid(plat->cd_gpio)) {
-		free_irq(gpio_to_irq(plat->cd_gpio), host);
-		gpio_free(plat->cd_gpio);
+	if (gpio_is_valid(tegra_host->cd_gpio)) {
+		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
+		gpio_free(tegra_host->cd_gpio);
 	}
 
-	if (gpio_is_valid(plat->power_gpio))
-		gpio_free(plat->power_gpio);
+	if (gpio_is_valid(tegra_host->power_gpio))
+		gpio_free(tegra_host->power_gpio);
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
diff --git a/include/linux/platform_data/mmc-sdhci-tegra.h b/include/linux/platform_data/mmc-sdhci-tegra.h
deleted file mode 100644
index 8f84306..0000000
--- a/include/linux/platform_data/mmc-sdhci-tegra.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2009 Palm, Inc.
- * Author: Yvonne Yip <y@palm.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef __PLATFORM_DATA_TEGRA_SDHCI_H
-#define __PLATFORM_DATA_TEGRA_SDHCI_H
-
-#include <linux/mmc/host.h>
-
-struct tegra_sdhci_platform_data {
-	int cd_gpio;
-	int wp_gpio;
-	int power_gpio;
-	int is_8bit;
-	int pm_flags;
-};
-
-#endif
-- 
1.7.10.4
