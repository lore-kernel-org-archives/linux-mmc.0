From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 3/3] ARM: dts: exynos5250-snow: Enable wifi power-on
Date: Sun, 19 Jan 2014 19:56:55 -0800
Message-ID: <1390190215-22700-4-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52037 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaATD4C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 22:56:02 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so5974029pbc.0
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2014 19:56:02 -0800 (PST)
In-Reply-To: <1390190215-22700-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, chris@printf.net, Olof Johansson <olof@lixom.net>

This adds the required specifications of reset-gpios on snow to enable wifi.

The wifi module is always powered, but it has three more signals needed:
- Enable line (active high)
- Reset line (active low)
- 32kHz reference clock

The enable and reset lines are in practice quite similar (i.e. both
need to be 1 for the module to be enabled), so treat them both as
"reset gpios". The clock is specified using the new clock property on
MMC, which due to lack of append options right now has to duplicate the
first two clocks that are SoC generic.

Also, fix the pinctrl setting (that has moved from slot node to host
controller node), and add the two gpio lines to the pinctrl setup.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |   17 ++++++++++++++++-
 arch/arm/boot/dts/exynos5250-snow.dts         |   11 +++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..b72f342 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -34,6 +34,20 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
+
+		wifi_en: wifi-en {
+			samsung,pins = "gpx0-1";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		wifi_rst: wifi-rst {
+			samsung,pins = "gpx0-2";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	i2c@12C60000 {
@@ -41,7 +55,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
-		max77686@09 {
+		pmic: max77686@09 {
 			compatible = "maxim,max77686";
 			interrupt-parent = <&gpx3>;
 			interrupts = <2 0>;
@@ -284,6 +298,7 @@
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
+		cap-sdio-irq;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 7e45eea..c150483 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "exynos5250.dtsi"
 #include "exynos5250-cros-common.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Google Snow";
@@ -186,9 +187,15 @@
 	 */
 	mmc@12230000 {
 		status = "okay";
+		clocks = <&clock 280>, <&clock 139>, <&pmic 2>;
+		clock-names = "biu", "ciu", "card_ext_clock";
+		card-reset-gpios = <&gpx0 1 GPIO_ACTIVE_LOW>, /* WIFI_EN */
+				   <&gpx0 2 GPIO_ACTIVE_LOW>; /* WIFI_RSTn */
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4 &wifi_en &wifi_rst>;
 		slot@0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
+			reg = <0>;
+			bus-width = <4>;
 		};
 	};
 
-- 
1.7.10.4

