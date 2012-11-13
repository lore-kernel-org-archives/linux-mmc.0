From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 2/2] mmc: host: sdhci-s3c: Add support for pinctrl
Date: Tue, 13 Nov 2012 11:30:19 +0100
Message-ID: <1352802619-29547-3-git-send-email-t.figa@samsung.com>
References: <1352802619-29547-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11520 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2KMKbB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 05:31:01 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDF007VX96LAN50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:37 +0900 (KST)
Received: from mcdsrvbld02.digital.local ([106.116.37.23])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDF0004096MWE80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:36 +0900 (KST)
In-reply-to: <1352802619-29547-1-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

This patch adds support for pin configuration using pinctrl subsystem
to the sdhci-s3c driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/mmc/samsung-sdhci.txt        | 20 +++++++++++++-------
 drivers/mmc/host/sdhci-s3c.c                         | 12 ++++++++++--
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
index 630a7d7..97e9e31 100644
--- a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
@@ -12,10 +12,6 @@ is used. The Samsung's SDHCI controller bindings extends this as listed below.
 [A] The property "samsung,cd-pinmux-gpio" can be used as stated in the
     "Optional Board Specific Properties" section below.
 
-[B] If core card-detect bindings and "samsung,cd-pinmux-gpio" property
-    is not specified, it is assumed that there is no card detection
-    mechanism used.
-
 Required SoC Specific Properties:
 - compatible: should be one of the following
   - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
@@ -24,14 +20,18 @@ Required SoC Specific Properties:
     controller.
 
 Required Board Specific Properties:
-- gpios: Should specify the gpios used for clock, command and data lines. The
-  gpio specifier format depends on the gpio controller.
+- Samsung GPIO variant (will be completely replaced by pinctrl):
+  - gpios: Should specify the gpios used for clock, command and data lines. The
+    gpio specifier format depends on the gpio controller.
+- Pinctrl variant (preferred if available):
+  - pinctrl-0: Should specify pin control groups used for this controller.
+  - pinctrl-names: Should contain only one value - "default".
 
 Optional Board Specific Properties:
 - samsung,cd-pinmux-gpio: Specifies the card detect line that is routed
   through a pinmux to the card-detect pin of the card slot. This property
   should be used only if none of the mmc core card-detect properties are
-  used.
+  used. Only for Samsung GPIO variant.
 
 Example:
 	sdhci@12530000 {
@@ -40,12 +40,18 @@ Example:
 		interrupts = <0 75 0>;
 		bus-width = <4>;
 		cd-gpios = <&gpk2 2 2 3 3>;
+
+		/* Samsung GPIO variant */
 		gpios = <&gpk2 0 2 0 3>,  /* clock line */
 			<&gpk2 1 2 0 3>,  /* command line */
 			<&gpk2 3 2 3 3>,  /* data line 0 */
 			<&gpk2 4 2 3 3>,  /* data line 1 */
 			<&gpk2 5 2 3 3>,  /* data line 2 */
 			<&gpk2 6 2 3 3>;  /* data line 3 */
+
+		/* Pinctrl variant */
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
+		pinctrl-names = "default";
 	};
 
 	Note: This example shows both SoC specific and board specific properties
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 039ed99..f6731b0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -24,6 +24,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -57,6 +58,7 @@ struct sdhci_s3c {
 	int			ext_cd_irq;
 	int			ext_cd_gpio;
 	int			*gpios;
+	struct pinctrl          *pctrl;
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
@@ -477,8 +479,9 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 		return -EINVAL;
 	}
 
-	dev_info(dev, "assuming no card detect line available\n");
-	pdata->cd_type = S3C_SDHCI_CD_NONE;
+	/* assuming internal card detect that will be configured by pinctrl */
+	pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
+	goto setup_bus;
 
  found_cd:
 	if (pdata->cd_type == S3C_SDHCI_CD_GPIO) {
@@ -496,6 +499,9 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 	}
 
  setup_bus:
+	if (!IS_ERR(ourhost->pctrl))
+		return 0;
+
 	/* get the gpios for command, clock and data lines */
 	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
 		gpio = of_get_gpio(node, cnt);
@@ -574,6 +580,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_pdata;
 	}
 
+	sc->pctrl = devm_pinctrl_get_select_default(&pdev->dev);
+
 	if (pdev->dev.of_node) {
 		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
 		if (ret)
-- 
1.8.0

