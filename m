From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] mmc: sdhci-s3c: let device core setup the default pin
 configuration
Date: Wed, 06 Mar 2013 17:06:16 +0530
Message-ID: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56489 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210Ab3CFLO0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Mar 2013 06:14:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, linus.walleij@linaro.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, ben-linux@fluff.org, jh80.chung@samsung.com, tgih.jun@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

With device core now able to setup the default pin configuration,
the call to devm_pinctrl_get_select_default can be removed. And
the pin configuration code based on the deprecated Samsung specific
gpio bindings is also removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/mmc/samsung-sdhci.txt      |   35 +---------
 drivers/mmc/host/sdhci-s3c.c                       |   71 ++-----------------
 2 files changed, 12 insertions(+), 94 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
index 3b3a1ee..328e990 100644
--- a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
@@ -5,13 +5,6 @@ MMC, SD and eMMC storage mediums. This file documents differences between the
 core mmc properties described by mmc.txt and the properties used by the
 Samsung implmentation of the SDHCI controller.
 
-Note: The mmc core bindings documentation states that if none of the core
-card-detect bindings are used, then the standard sdhci card detect mechanism
-is used. The Samsung's SDHCI controller bindings extends this as listed below.
-
-[A] The property "samsung,cd-pinmux-gpio" can be used as stated in the
-    "Optional Board Specific Properties" section below.
-
 Required SoC Specific Properties:
 - compatible: should be one of the following
   - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
@@ -20,18 +13,8 @@ Required SoC Specific Properties:
     controller.
 
 Required Board Specific Properties:
-- Samsung GPIO variant (will be completely replaced by pinctrl):
-  - gpios: Should specify the gpios used for clock, command and data lines. The
-    gpio specifier format depends on the gpio controller.
-- Pinctrl variant (preferred if available):
-  - pinctrl-0: Should specify pin control groups used for this controller.
-  - pinctrl-names: Should contain only one value - "default".
-
-Optional Board Specific Properties:
-- samsung,cd-pinmux-gpio: Specifies the card detect line that is routed
-  through a pinmux to the card-detect pin of the card slot. This property
-  should be used only if none of the mmc core card-detect properties are
-  used. Only for Samsung GPIO variant.
+- pinctrl-0: Should specify pin control groups used for this controller.
+- pinctrl-names: Should contain only one value - "default".
 
 Example:
 	sdhci@12530000 {
@@ -39,19 +22,9 @@ Example:
 		reg = <0x12530000 0x100>;
 		interrupts = <0 75 0>;
 		bus-width = <4>;
-		cd-gpios = <&gpk2 2 2 3 3>;
-
-		/* Samsung GPIO variant */
-		gpios = <&gpk2 0 2 0 3>,  /* clock line */
-			<&gpk2 1 2 0 3>,  /* command line */
-			<&gpk2 3 2 3 3>,  /* data line 0 */
-			<&gpk2 4 2 3 3>,  /* data line 1 */
-			<&gpk2 5 2 3 3>,  /* data line 2 */
-			<&gpk2 6 2 3 3>;  /* data line 3 */
-
-		/* Pinctrl variant */
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
+		cd-gpios = <&gpk2 2 0>;
 		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
 	};
 
 	Note: This example shows both SoC specific and board specific properties
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7363efe..86e0bd7 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -24,7 +24,6 @@
 #include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/pinctrl/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -45,7 +44,6 @@
  * @ioarea: The resource created when we claimed the IO area.
  * @pdata: The platform data for this controller.
  * @cur_clk: The index of the current bus clock.
- * @gpios: List of gpio numbers parsed from device tree.
  * @clk_io: The clock for the internal bus interface.
  * @clk_bus: The clocks that are available for the SD/MMC bus clock.
  */
@@ -57,8 +55,6 @@ struct sdhci_s3c {
 	unsigned int		cur_clk;
 	int			ext_cd_irq;
 	int			ext_cd_gpio;
-	int			*gpios;
-	struct pinctrl          *pctrl;
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
@@ -447,88 +443,39 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 	struct device_node *node = dev->of_node;
 	struct sdhci_s3c *ourhost = to_s3c(host);
 	u32 max_width;
-	int gpio, cnt, ret;
+	int gpio;
 
 	/* if the bus-width property is not specified, assume width as 1 */
 	if (of_property_read_u32(node, "bus-width", &max_width))
 		max_width = 1;
 	pdata->max_width = max_width;
 
-	ourhost->gpios = devm_kzalloc(dev, NUM_GPIOS(pdata->max_width) *
-				sizeof(int), GFP_KERNEL);
-	if (!ourhost->gpios)
-		return -ENOMEM;
-
 	/* get the card detection method */
 	if (of_get_property(node, "broken-cd", NULL)) {
 		pdata->cd_type = S3C_SDHCI_CD_NONE;
-		goto setup_bus;
+		return 0;
 	}
 
 	if (of_get_property(node, "non-removable", NULL)) {
 		pdata->cd_type = S3C_SDHCI_CD_PERMANENT;
-		goto setup_bus;
+		return 0;
 	}
 
 	gpio = of_get_named_gpio(node, "cd-gpios", 0);
 	if (gpio_is_valid(gpio)) {
 		pdata->cd_type = S3C_SDHCI_CD_GPIO;
-		goto found_cd;
-	} else if (gpio != -ENOENT) {
-		dev_err(dev, "invalid card detect gpio specified\n");
-		return -EINVAL;
-	}
-
-	gpio = of_get_named_gpio(node, "samsung,cd-pinmux-gpio", 0);
-	if (gpio_is_valid(gpio)) {
-		pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
-		goto found_cd;
-	} else if (gpio != -ENOENT) {
-		dev_err(dev, "invalid card detect gpio specified\n");
-		return -EINVAL;
-	}
-
-	/* assuming internal card detect that will be configured by pinctrl */
-	pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
-	goto setup_bus;
-
- found_cd:
-	if (pdata->cd_type == S3C_SDHCI_CD_GPIO) {
 		pdata->ext_cd_gpio = gpio;
 		ourhost->ext_cd_gpio = -1;
 		if (of_get_property(node, "cd-inverted", NULL))
 			pdata->ext_cd_gpio_invert = 1;
-	} else if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		ret = devm_gpio_request(dev, gpio, "sdhci-cd");
-		if (ret) {
-			dev_err(dev, "card detect gpio request failed\n");
-			return -EINVAL;
-		}
-		ourhost->ext_cd_gpio = gpio;
-	}
-
- setup_bus:
-	if (!IS_ERR(ourhost->pctrl))
 		return 0;
-
-	/* get the gpios for command, clock and data lines */
-	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
-		gpio = of_get_gpio(node, cnt);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "invalid gpio[%d]\n", cnt);
-			return -EINVAL;
-		}
-		ourhost->gpios[cnt] = gpio;
-	}
-
-	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
-		ret = devm_gpio_request(dev, ourhost->gpios[cnt], "sdhci-gpio");
-		if (ret) {
-			dev_err(dev, "gpio[%d] request failed\n", cnt);
-			return -EINVAL;
-		}
+	} else if (gpio != -ENOENT) {
+		dev_err(dev, "invalid card detect gpio specified\n");
+		return -EINVAL;
 	}
 
+	/* assuming internal card detect that will be configured by pinctrl */
+	pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
 	return 0;
 }
 #else
@@ -589,8 +536,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_pdata_io_clk;
 	}
 
-	sc->pctrl = devm_pinctrl_get_select_default(&pdev->dev);
-
 	if (pdev->dev.of_node) {
 		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
 		if (ret)
-- 
1.6.6.rc2

