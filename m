From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH V2 2/2] mmc: tegra: use mmc_of_parse to get the support of standard MMC DT bindings
Date: Fri, 22 Feb 2013 11:23:40 +0800
Message-ID: <1361503420-16473-3-git-send-email-josephl@nvidia.com>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:4578 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab3BVDYD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 22:24:03 -0500
In-Reply-To: <1361503420-16473-1-git-send-email-josephl@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, Joseph Lo <josephl@nvidia.com>

Updating the sdhci-tegra driver to use mmc_of_parse to support standard
MMC DT bindings. Then we can remove the redundant code that already support
in generic MMC core.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
---
V2:
* some modifications for sdhci_tegra_parse_dt()
---
 drivers/mmc/host/sdhci-tegra.c | 92 +++++-------------------------------------
 1 file changed, 10 insertions(+), 82 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 08b06e9..f2ede63 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <asm/gpio.h>
 
@@ -44,10 +45,7 @@ struct sdhci_tegra_soc_data {
 
 struct sdhci_tegra {
 	const struct sdhci_tegra_soc_data *soc_data;
-	int cd_gpio;
-	int wp_gpio;
 	int power_gpio;
-	int is_8bit;
 };
 
 static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
@@ -107,23 +105,9 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 
 static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
-
-	if (!gpio_is_valid(tegra_host->wp_gpio))
-		return -1;
-
-	return gpio_get_value(tegra_host->wp_gpio);
+	return mmc_gpio_get_ro(host->mmc);
 }
 
-static irqreturn_t carddetect_irq(int irq, void *data)
-{
-	struct sdhci_host *sdhost = (struct sdhci_host *)data;
-
-	tasklet_schedule(&sdhost->card_tasklet);
-	return IRQ_HANDLED;
-};
-
 static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -145,12 +129,11 @@ static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
 
 static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 	u32 ctrl;
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	if (tegra_host->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
+	if ((host->mmc->caps & MMC_CAP_8_BIT_DATA) &&
+	    (bus_width == MMC_BUS_WIDTH_8)) {
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 		ctrl |= SDHCI_CTRL_8BITBUS;
 	} else {
@@ -216,19 +199,15 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
 
-static void sdhci_tegra_parse_dt(struct device *dev,
-					struct sdhci_tegra *tegra_host)
+static void sdhci_tegra_parse_dt(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-	u32 bus_width;
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 
-	tegra_host->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
-	tegra_host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
 	tegra_host->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
-
-	if (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
-	    bus_width == 8)
-		tegra_host->is_8bit = 1;
+	mmc_of_parse(host->mmc);
 }
 
 static int sdhci_tegra_probe(struct platform_device *pdev)
@@ -260,7 +239,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host->soc_data = soc_data;
 	pltfm_host->priv = tegra_host;
 
-	sdhci_tegra_parse_dt(&pdev->dev, tegra_host);
+	sdhci_tegra_parse_dt(&pdev->dev);
 
 	if (gpio_is_valid(tegra_host->power_gpio)) {
 		rc = gpio_request(tegra_host->power_gpio, "sdhci_power");
@@ -272,37 +251,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		gpio_direction_output(tegra_host->power_gpio, 1);
 	}
 
-	if (gpio_is_valid(tegra_host->cd_gpio)) {
-		rc = gpio_request(tegra_host->cd_gpio, "sdhci_cd");
-		if (rc) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to allocate cd gpio\n");
-			goto err_cd_req;
-		}
-		gpio_direction_input(tegra_host->cd_gpio);
-
-		rc = request_irq(gpio_to_irq(tegra_host->cd_gpio),
-				 carddetect_irq,
-				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				 mmc_hostname(host->mmc), host);
-
-		if (rc)	{
-			dev_err(mmc_dev(host->mmc), "request irq error\n");
-			goto err_cd_irq_req;
-		}
-
-	}
-
-	if (gpio_is_valid(tegra_host->wp_gpio)) {
-		rc = gpio_request(tegra_host->wp_gpio, "sdhci_wp");
-		if (rc) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to allocate wp gpio\n");
-			goto err_wp_req;
-		}
-		gpio_direction_input(tegra_host->wp_gpio);
-	}
-
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
 		dev_err(mmc_dev(host->mmc), "clk err\n");
@@ -312,9 +260,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (tegra_host->is_8bit)
-		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-
 	rc = sdhci_add_host(host);
 	if (rc)
 		goto err_add_host;
@@ -325,15 +270,6 @@ err_add_host:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
-	if (gpio_is_valid(tegra_host->wp_gpio))
-		gpio_free(tegra_host->wp_gpio);
-err_wp_req:
-	if (gpio_is_valid(tegra_host->cd_gpio))
-		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
-err_cd_irq_req:
-	if (gpio_is_valid(tegra_host->cd_gpio))
-		gpio_free(tegra_host->cd_gpio);
-err_cd_req:
 	if (gpio_is_valid(tegra_host->power_gpio))
 		gpio_free(tegra_host->power_gpio);
 err_power_req:
@@ -351,14 +287,6 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (gpio_is_valid(tegra_host->wp_gpio))
-		gpio_free(tegra_host->wp_gpio);
-
-	if (gpio_is_valid(tegra_host->cd_gpio)) {
-		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
-		gpio_free(tegra_host->cd_gpio);
-	}
-
 	if (gpio_is_valid(tegra_host->power_gpio))
 		gpio_free(tegra_host->power_gpio);
 
-- 
1.8.1.1

