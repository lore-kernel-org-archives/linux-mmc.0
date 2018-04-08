From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
Date: Sun, 8 Apr 2018 11:36:47 +0000
Message-ID: <20180408113647.13543-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Nan Li <nan.li@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Nan Li <nan.li@amlogic.com>

The IP of eMMC controller in AXG is similiar to Meson-GX series.
Here we add the initial support of the HS200 mode with
clock running at 166MHz (to be safe), since we found some eMMC chip
fail to run at 200MHz due to tunning phase error.

Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Hi Kevin
  Please note this patch actually depend on the eMMC driver here [0].
  Still a few problem to solve, to improve the tuning phase driver to make
the clock running at 200MHz, and to further support the HS400 mode.
Anyway, this patch itself is quite independent.

changes since v1 at [1]:
 - fix missing gpio dt-bindings header

[0] http://lkml.kernel.org/r/20180403100652.41056-1-yixun.lan@amlogic.com
[1] http://lkml.kernel.org/r/20180403102651.60340-1-yixun.lan@amlogic.com
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 58 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 82 ++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 57eedced5a51..f67d4e47e641 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -15,6 +15,44 @@
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
 	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &ethmac {
@@ -47,3 +85,23 @@
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
 };
+
+/* emmc storage */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	max-frequency = <180000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..cb70778c323c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/axg-clkc.h>
+#include <dt-bindings/gpio/meson-axg-gpio.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -113,6 +114,36 @@
 		#size-cells = <2>;
 		ranges;
 
+		apb: apb@ffe00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffe00000 0x0 0x200000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
+
+			sd_emmc_b: sd@5000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x5000 0x0 0x2000>;
+				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc CLKID_SD_EMMC_B>,
+					<&clkc CLKID_SD_EMMC_B_CLK0>,
+					<&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+			};
+
+			sd_emmc_c: mmc@7000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x7000 0x0 0x2000>;
+				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc CLKID_SD_EMMC_C>,
+					<&clkc CLKID_SD_EMMC_C_CLK0>,
+					<&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+			};
+		};
+
 		cbus: bus@ffd00000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xffd00000 0x0 0x25000>;
@@ -309,6 +340,57 @@
 					gpio-ranges = <&pinctrl_periphs 0 0 86>;
 				};
 
+				emmc_pins: emmc {
+					mux {
+						groups = "emmc_nand_d0",
+							"emmc_nand_d1",
+							"emmc_nand_d2",
+							"emmc_nand_d3",
+							"emmc_nand_d4",
+							"emmc_nand_d5",
+							"emmc_nand_d6",
+							"emmc_nand_d7",
+							"emmc_clk",
+							"emmc_cmd",
+							"emmc_ds";
+						function = "emmc";
+					};
+				};
+
+				emmc_clk_gate_pins: emmc_clk_gate {
+					mux {
+						groups = "BOOT_8";
+						function = "gpio_periphs";
+					};
+					cfg-pull-down {
+						pins = "BOOT_8";
+						bias-pull-down;
+					};
+				};
+
+				sdio_pins: sdio {
+					mux {
+						groups = "sdio_d0",
+							"sdio_d1",
+							"sdio_d2",
+							"sdio_d3",
+							"sdio_cmd",
+							"sdio_clk";
+						function = "sdio";
+					};
+				};
+
+				sdio_clk_gate_pins: sdio_clk_gate {
+					mux {
+						groups = "GPIOX_4";
+						function = "gpio_periphs";
+					};
+					cfg-pull-down {
+						pins = "GPIOX_4";
+						bias-pull-down;
+					};
+				};
+
 				eth_rmii_x_pins: eth-x-rmii {
 					mux {
 						groups = "eth_mdio_x",
-- 
2.16.2
