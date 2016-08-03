From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
Date: Wed,  3 Aug 2016 16:18:42 -0700
Message-ID: <20160803231843.23012-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33188 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbcHCXTj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Aug 2016 19:19:39 -0400
Received: by mail-pa0-f51.google.com with SMTP id b2so25301415pat.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Aug 2016 16:18:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Victor Wan <victor.wan@amlogic.com>, Jerry Cao <jerry.cao@amlogic.com>, Xing Wu <xing.xu@amlogic.com>

Add binding and basic support for the SD/eMMC controller on Amlogic
S905/GXBB devices.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt | 29 +++++++++
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 74 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 71 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 36 ++++++++++-
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
new file mode 100644
index 000000000000..2bfdf47018c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
@@ -0,0 +1,29 @@
+Amlogic SD / eMMC controller for S905/GXBB family SoCs
+
+The MMC 5.1 compliant host controller on Amlogic provides the
+interface for SD, eMMC and SDIO devices.
+
+This file documents the properties in addition to those available in
+the MMC core bindings, documented by mmc.txt.
+
+Required properties:
+- compatible : contains "amlogic,meson-gxbb"
+- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
+- clock-names: Should contain the following:
+	"core" - Main peripheral bus clock
+	"clkin0" - Parent clock of internal mux
+	"clkin1" - Other parent clock of internal mux
+  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
+  clock rate requested by the MMC core.
+
+Example:
+
+	sd_emmc_a: mmc@70000 {
+        	compatible = "amlogic,meson-gxbb-mmc";
+		reg = <0x0 0x70000 0x0 0x2000>;
+                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "clkin0", "clkin1";
+		pinctrl-0 = <&emmc_pins>;
+	};
+
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 90a84c514d3d..f41d8fe5c706 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -73,6 +73,45 @@
 			default-state = "off";
 		};
 	};
+
+	mmc_iv: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "mmc-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		gpio-states = <0 1>;
+
+		/*
+		 * Based on ODROID-C2 schematics:
+		 * signal name: IO_TF_3V3N_1V8, GPIOAO bit 3
+		 */
+		states = <3300000 0
+			  1800000 1>;
+	};
+
+	vcc1v8: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vcc3v3: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &uart_AO {
@@ -87,3 +126,38 @@
 	pinctrl-names = "default";
 };
 
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+
+	vmmc-supply = <&mmc_iv>;
+	voltage-ranges = <1800 3300>;
+};
+
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	voltage-ranges = <1800 3300>;
+	vmmc-supply = <&vcc3v3>;
+	vmmcq-sumpply = <&vcc1v8>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index f4f30f674b4c..77698815943a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -57,6 +57,42 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	mmc_iv: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "mmc-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		gpio-states = <0 1>;
+
+		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
+		states = <1800000 0
+			  3300000 1>;
+	};
+
+	vddio_boot: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
 };
 
 /* This UART is brought out to the DB9 connector */
@@ -72,3 +108,38 @@
 	pinctrl-names = "default";
 };
 
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+
+	voltage-ranges = <1800 3300>;
+	vmmc-supply = <&mmc_iv>;
+};
+
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	voltage-ranges = <1800 3300>;
+	vmmc-supply = <&vcc_3v3>;
+	vmmcq-sumpply = <&vddio_boot>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 35c8b2beb05c..2c200f96467c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -247,7 +247,8 @@
 					mux {
 						groups = "emmc_nand_d07",
 						       "emmc_cmd",
-						       "emmc_clk";
+						       "emmc_clk",
+						       "emmc_ds";
 						function = "emmc";
 					};
 				};
@@ -330,6 +331,39 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xd0000000 0x0 0x200000>;
+
+			sd_emmc_a: mmc@70000 {
+				compatible = "amlogic,meson-gxbb-mmc";
+				reg = <0x0 0x70000 0x0 0x2000>;
+				interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_SD_EMMC_A>,
+					 <&xtal>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				status = "disabled";
+			};
+
+			sd_emmc_b: mmc@72000 {
+				compatible = "amlogic,meson-gxbb-mmc";
+				reg = <0x0 0x72000 0x0 0x2000>;
+				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_SD_EMMC_B>,
+					 <&xtal>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				status = "disabled";
+			};
+
+			sd_emmc_c: mmc@74000 {
+				compatible = "amlogic,meson-gxbb-mmc";
+				reg = <0x0 0x74000 0x0 0x2000>;
+				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_SD_EMMC_C>,
+					 <&xtal>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				status = "disabled";
+			};
 		};
 
 		ethmac: ethernet@c9410000 {
-- 
2.9.0

