From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] mmc: dwmmc: let device core setup the default pin configuration
Date: Wed, 06 Mar 2013 17:34:21 +0530
Message-ID: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-arm-kernel@lists.infradead.org, t.figa@samsung.com, heiko@sntech.de, linus.walleij@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 72fd0f2..467d043 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -152,43 +152,6 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	return 0;
 }
 
-static int dw_mci_exynos_setup_bus(struct dw_mci *host,
-				struct device_node *slot_np, u8 bus_width)
-{
-	int idx, gpio, ret;
-
-	if (!slot_np)
-		return -EINVAL;
-
-	/* cmd + clock + bus-width pins */
-	for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
-		gpio = of_get_gpio(slot_np, idx);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(host->dev, "invalid gpio: %d\n", gpio);
-			return -EINVAL;
-		}
-
-		ret = devm_gpio_request(host->dev, gpio, "dw-mci-bus");
-		if (ret) {
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
-			return -EBUSY;
-		}
-	}
-
-	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
-		return 0;
-
-	gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
-	if (gpio_is_valid(gpio)) {
-		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
-	} else {
-		dev_info(host->dev, "cd gpio not available");
-	}
-
-	return 0;
-}
-
 /* Exynos5250 controller specific capabilities */
 static unsigned long exynos5250_dwmmc_caps[4] = {
 	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
@@ -205,7 +168,6 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
 	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
-	.setup_bus		= dw_mci_exynos_setup_bus,
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
-- 
1.6.6.rc2
