From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v4] mmc: dw_mmc: let device core setup the default pin
 configuration
Date: Tue, 09 Apr 2013 11:29:46 +0530
Message-ID: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40980 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab3DIFlT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 01:41:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-arm-kernel@lists.infradead.org, t.figa@samsung.com, heiko@sntech.de, linus.walleij@linaro.org, dianders@chromium.org, patches@linaro.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes since v3:
- Rebased to the latest mmc-next branch, resolving the compilation
  error with this patch due to changes in commit f2f942ce
  "mmc: dw_mmc: Check return value of regulator_enable".
  Thanks to Doug for pointing out this issue with the v3 patch.

 drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
 drivers/mmc/host/dw_mmc.c        |   14 +++-----------
 drivers/mmc/host/dw_mmc.h        |    3 ---
 3 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index c7f0976..f013e7e 100644
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
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
@@ -205,7 +168,6 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
-	.setup_bus		= dw_mci_exynos_setup_bus,
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 45d9216..5dcef43 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1952,14 +1952,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	else
 		bus_width = 1;
 
-	if (drv_data && drv_data->setup_bus) {
-		struct device_node *slot_np;
-		slot_np = dw_mci_of_find_slot_node(host->dev, slot->id);
-		ret = drv_data->setup_bus(host, slot_np, bus_width);
-		if (ret)
-			goto err_setup_bus;
-	}
-
 	switch (bus_width) {
 	case 8:
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
@@ -2002,7 +1994,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		if (ret) {
 			dev_err(host->dev,
 				"failed to enable regulator: %d\n", ret);
-			goto err_setup_bus;
+			return ret;
 		}
 	}
 
@@ -2015,7 +2007,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto err_setup_bus;
+		goto err_add_host;
 
 #if defined(CONFIG_DEBUG_FS)
 	dw_mci_init_debugfs(slot);
@@ -2032,7 +2024,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	return 0;
 
-err_setup_bus:
+err_add_host:
 	mmc_free_host(mmc);
 	return -EINVAL;
 }
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 53b8fd9..0b74189 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -190,7 +190,6 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @prepare_command: handle CMD register extensions.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
- * @setup_bus: initialize io-interface
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -203,7 +202,5 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-	int		(*setup_bus)(struct dw_mci *host,
-				struct device_node *slot_np, u8 bus_width);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.6.6.rc2

