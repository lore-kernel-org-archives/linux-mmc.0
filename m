From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 24/24] arm64: dts: mediatek: add pumpkin board dts
Date: Sat, 23 Mar 2019 22:16:12 +0100
Message-ID: <20190323211612.860-25-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

The pumpkin board is  made by Gossamer Engineering and is using
a MediaTek SoC. The board currently comes in two available version:
MT8516 SoC and MT8167 SoC.
The board provides the following IOs: eMMC, NAND, SD card, USB type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, and an expansion header.

Additionally there is a HDMI port, DSI port, and camera port only
on the MT8167 version of the board.

The board can be powered by battery and/or via a USB Type-C port and
is using a PMIC MT6392.

The eMMC and NAND are sharing pins and cannot be used together.

This commit is adding the basic boot support for the Pumpkin MT8516
board on the eMMC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/mt8516-pumpkin.dts      |  19 ++
 .../boot/dts/mediatek/pumpkin-common.dtsi     | 210 ++++++++++++++++++
 .../dts/mediatek/pumpkin-emmc-common.dtsi     |  75 +++++++
 4 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e8f952fb279b..3c4edaec9449 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
new file mode 100644
index 000000000000..016f11c6c88c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "pumpkin-common.dtsi"
+#include "pumpkin-emmc-common.dtsi"
+
+/ {
+	model = "Pumpkin MT8516";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
new file mode 100644
index 000000000000..79d227f28428
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "mt8516.dtsi"
+#include "mt6392.dtsi"
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>;
+
+		volume-up {
+			gpios = <&pio 42 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <115>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		volume-down {
+			gpios = <&pio 43 GPIO_ACTIVE_LOW>;
+			label = "volume_down";
+			linux,code = <114>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+};
+
+&cpu0 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&i2c0 {
+	clock-div = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	tca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		rst-gpio = <&pio 65 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tca6416_pins>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		eint20_mux_sel0 {
+			gpio-hog;
+			gpios = <0 0>;
+			input;
+			line-name = "eint20_mux_sel0";
+		};
+
+		expcon_mux_sel1 {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "expcon_mux_sel1";
+		};
+
+		mrg_di_mux_sel2 {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "mrg_di_mux_sel2";
+		};
+
+		sd_sdio_mux_sel3 {
+			gpio-hog;
+			gpios = <3 0>;
+			input;
+			line-name = "sd_sdio_mux_sel3";
+		};
+
+		sd_sdio_mux_ctrl7 {
+			gpio-hog;
+			gpios = <7 0>;
+			output-low;
+			line-name = "sd_sdio_mux_ctrl7";
+		};
+
+		hw_id0 {
+			gpio-hog;
+			gpios = <8 0>;
+			input;
+			line-name = "hw_id0";
+		};
+
+		hw_id1 {
+			gpio-hog;
+			gpios = <9 0>;
+			input;
+			line-name = "hw_id1";
+		};
+
+		hw_id2 {
+			gpio-hog;
+			gpios = <10 0>;
+			input;
+			line-name = "hw_id2";
+		};
+
+		fg_int_n {
+			gpio-hog;
+			gpios = <11 0>;
+			input;
+			line-name = "fg_int_n";
+		};
+
+		usba_pwr_en {
+			gpio-hog;
+			gpios = <12 0>;
+			output-high;
+			line-name = "usba_pwr_en";
+		};
+
+		wifi_3v3_pg {
+			gpio-hog;
+			gpios = <13 0>;
+			input;
+			line-name = "wifi_3v3_pg";
+		};
+
+		cam_rst {
+			gpio-hog;
+			gpios = <14 0>;
+			output-low;
+			line-name = "cam_rst";
+		};
+
+		cam_pwdn {
+			gpio-hog;
+			gpios = <15 0>;
+			output-low;
+			line-name = "cam_pwdn";
+		};
+	};
+};
+
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&state_default>;
+
+	state_default:pinconf_default {
+	};
+
+	gpio_keys_default: gpiodefault {
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_42_KPCOL0__FUNC_GPIO42>,
+				 <MT8516_PIN_43_KPCOL1__FUNC_GPIO43>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	i2c0_pins_a: i2c0@0 {
+		pins1 {
+			pinmux = <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
+				 <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
+			bias-disable;
+		};
+	};
+
+
+	tca6416_pins: pinmux_tca6416_pins {
+		gpio_mux_rst_n_pin {
+			pinmux = <MT8516_PIN_65_UTXD1__FUNC_GPIO65>;
+			output-high;
+		};
+
+		gpio_mux_int_n_pin {
+			pinmux = <MT8516_PIN_64_URXD1__FUNC_GPIO64>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
new file mode 100644
index 000000000000..6044c8c91cb1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6392_vemc3v3_reg>;
+	vqmmc-supply = <&mt6392_vio18_reg>;
+	non-removable;
+};
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_120_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8516_PIN_119_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8516_PIN_118_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8516_PIN_117_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8516_PIN_113_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8516_PIN_112_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8516_PIN_111_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8516_PIN_110_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8516_PIN_115_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8516_PIN_116_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins_rst {
+			pinmux = <MT8516_PIN_114_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0@0{
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_120_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8516_PIN_119_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8516_PIN_118_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8516_PIN_117_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8516_PIN_113_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8516_PIN_112_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8516_PIN_111_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8516_PIN_110_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8516_PIN_115_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT8516_PIN_116_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_rst {
+			pinmux = <MT8516_PIN_114_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+};
-- 
2.20.1
