From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 38/38] ARM: cubox-i: add support for Wifi/BT
Date: Wed, 23 Apr 2014 20:09:24 +0100
Message-ID: <E1Wd2Xs-0003wq-IR@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46563 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932511AbaDWTJc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:09:32 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi  |  8 +++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi | 98 +++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index c928c0a5e3cc..67fe5585f6dd 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -152,6 +152,14 @@
 	status = "okay";
 };
 
+&uart4 {
+	status = "okay";
+};
+
+&usdhc1 {
+	status = "okay";
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
index d729d0b15f25..a5d72895d9ce 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -1,9 +1,69 @@
 /*
  * Copyright (C) 2013,2014 Russell King
  */
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		reg_brcm_osc: brcm-osc-reg {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio5 5 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_microsom_brcm_osc_reg>;
+			regulator-name = "brcm_osc_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		reg_brcm: brcm-reg {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio3 19 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_microsom_brcm_reg>;
+			regulator-name = "brcm_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			startup-delay-us = <200000>;
+		};
+	};
+};
 
 &iomuxc {
 	microsom {
+		pinctrl_microsom_brcm_osc_reg: microsom-brcm-osc-reg {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05 0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_reg: microsom-brcm-reg {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19 0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_wifi: microsom-brcm-wifi {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__XTALOSC_REF_CLK_32K	0x1b0b0
+				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x40013070
+				MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26	0x40013070
+				MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27	0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_bt: microsom-brcm-bt {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x40013070
+				MX6QDL_PAD_CSI0_DAT15__GPIO6_IO01	0x40013070
+				MX6QDL_PAD_CSI0_DAT18__GPIO6_IO04	0x40013070
+			>;
+		};
+
 		pinctrl_microsom_uart1: microsom-uart1 {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
@@ -11,6 +71,15 @@
 			>;
 		};
 
+		pinctrl_microsom_uart4_1: microsom-uart4 {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
+			>;
+		};
+
 		pinctrl_microsom_usbotg: microsom-usbotg {
 			/*
 			 * Similar to pinctrl_usbotg_2, but we want it
@@ -18,6 +87,17 @@
 			 */
 			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
 		};
+
+		pinctrl_microsom_usdhc1: microsom-usdhc1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+			>;
+		};
 	};
 };
 
@@ -27,7 +107,25 @@
 	status = "okay";
 };
 
+/* UART4 - Connected to optional BRCM Wifi/BT/FM */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_brcm_bt &pinctrl_microsom_uart4_1>;
+	fsl,uart-has-rtscts;
+};
+
 &usbotg {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_microsom_usbotg>;
 };
+
+/* USDHC1 - Connected to optional BRCM Wifi/BT/FM */
+&usdhc1 {
+	card-external-vcc-supply = <&reg_brcm>;
+	card-reset-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>, <&gpio6 0 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_brcm_wifi &pinctrl_microsom_usdhc1>;
+	vmmc-supply = <&reg_brcm>;
+};
-- 
1.8.3.1

