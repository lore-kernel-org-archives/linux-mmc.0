From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V3 09/10] ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
Date: Tue, 21 May 2013 01:01:50 +0200
Message-ID: <1369090911-1479-10-git-send-email-gmbnomis@gmail.com>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:20118 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094Ab3ETXCn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 19:02:43 -0400
In-Reply-To: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |    2 +
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |   97 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts   |   40 +++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug.dts         |   45 ++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9f7121..e81a387 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -84,6 +84,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-ns2max.dtb \
 	kirkwood-ns2mini.dtb \
 	kirkwood-nsa310.dtb \
+	kirkwood-sheevaplug.dtb \
+	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
 	kirkwood-ts219-6281.dtb \
 	kirkwood-ts219-6282.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
new file mode 100644
index 0000000..9d59475
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -0,0 +1,97 @@
+/*
+ * kirkwood-sheevaplug-common.dts - Common parts for Sheevaplugs
+ *
+ * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
+ *
+ * Licensed under GPLv2
+ */
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp@f1000000 {
+		pinctrl: pinctrl@10000 {
+
+			pmx_usb_power_enable: pmx-usb-power-enable {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_led_red: pmx-led-red {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_led_blue: pmx-led-blue {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+			pmx_sdio_cd: pmx-sdio-cd {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_sdio_wp: pmx-sdio-wp {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
+		serial@12000 {
+			status = "okay";
+		};
+
+		nand@3000000 {
+			status = "okay";
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x0000000 0x100000>;
+			};
+
+			partition@100000 {
+				label = "uImage";
+				reg = <0x0100000 0x400000>;
+			};
+
+			partition@500000 {
+				label = "root";
+				reg = <0x0500000 0x1fb00000>;
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_power: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 29 0>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		health {
+			label = "sheevaplug:blue:health";
+			gpios = <&gpio1 17 1>;
+			linux,default-trigger = "default-on";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
new file mode 100644
index 0000000..1c6946a
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
@@ -0,0 +1,40 @@
+/*
+ * kirkwood-sheevaplug-esata.dts - Device tree file for eSATA Sheevaplug
+ *
+ * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
+ *
+ * Licensed under GPLv2
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood-sheevaplug-common.dtsi"
+
+/ {
+	model = "Globalscale Technologies eSATA SheevaPlug";
+	compatible = "globalscale,sheevaplug-esata-rev13", "globalscale,sheevaplug-esata", "globalscale,sheevaplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	ocp@f1000000 {
+		pinctrl: pinctrl@10000 {
+
+			pinctrl-0 = < &pmx_nand &pmx_uart0
+				      &pmx_usb_power_enable
+				      &pmx_led_blue>;
+			pinctrl-names = "default";
+
+		};
+
+		sata@80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+		mvsdio@90000 {
+			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd &pmx_sdio_wp>;
+			pinctrl-names = "default";
+			status = "okay";
+			cd-gpios = <&gpio1 12 1>;
+			wp-gpios = <&gpio1 15 0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
new file mode 100644
index 0000000..f7684066
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -0,0 +1,45 @@
+/*
+ * kirkwood-sheevaplug-esata.dts - Device tree file for Sheevaplug
+ *
+ * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
+ *
+ * Licensed under GPLv2
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood-sheevaplug-common.dtsi"
+
+/ {
+	model = "Globalscale Technologies SheevaPlug";
+	compatible = "globalscale,sheevaplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	ocp@f1000000 {
+		pinctrl: pinctrl@10000 {
+
+			pinctrl-0 = < &pmx_nand &pmx_uart0
+				      &pmx_usb_power_enable
+				      &pmx_led_red
+				      &pmx_led_blue>;
+			pinctrl-names = "default";
+
+		};
+
+		mvsdio@90000 {
+			pinctrl-0 = <&pmx_sdio>;
+			pinctrl-names = "default";
+			status = "okay";
+			/* No CD or WP GPIOs */
+			broken-cd;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		misc {
+			label = "sheevaplug:red:misc";
+			gpios = <&gpio1 14 1>;
+		};
+	};
+};
-- 
1.7.9.5

