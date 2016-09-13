From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v7 09/11] arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3
Date: Tue, 13 Sep 2016 12:57:06 +0200
Message-ID: <1473764228-24768-10-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Enable the exposed SD card slots in the DT of the r8a7796/salvator-x.

Based on work for the r8a7795/salvator-x by Ai Kyuse.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 13db7d61c26c..a8373c248ad1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "r8a7796.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Renesas Salvator-X board based on r8a7796";
@@ -29,6 +30,55 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
+
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi3: regulator-vcc-sdhi3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI3 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi3: regulator-vccq-sdhi3 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI3 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
 };
 
 &pfc {
@@ -43,12 +93,46 @@
 		groups = "scif_clk_a";
 		function = "scif_clk";
 	};
+
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+	};
+
+	sdhi3_pins: sd3 {
+		groups = "sdhi3_data4", "sdhi3_ctrl";
+		function = "sdhi3";
+	};
 };
 
 &extal_clk {
 	clock-frequency = <16666666>;
 };
 
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&sdhi3 {
+	pinctrl-0 = <&sdhi3_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi3>;
+	vqmmc-supply = <&vccq_sdhi3>;
+	cd-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-0 = <&scif2_pins>;
 	pinctrl-names = "default";
-- 
2.7.0.rc3.207.g0ac5344
