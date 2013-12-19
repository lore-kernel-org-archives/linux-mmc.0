From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v6 5/7] ARM: dts: add pbias dt node
Date: Thu, 19 Dec 2013 18:08:38 +0530
Message-ID: <1387456720-7202-6-git-send-email-balajitk@ti.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1387456720-7202-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add pbias regulator node as a child of system control
module - syscon.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Added control module region which has pbias register.
remaining control module region for syscon can be added later when needed.

 arch/arm/boot/dts/dra7.dtsi     |   19 +++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   19 +++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   19 +++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   19 +++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   19 +++++++++++++++++++
 5 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..a599cae 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -110,6 +110,24 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dra7_ctrl_general: tisyscon@4a002e00 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4a002e00 0x7c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			pbias_regulator: pbias_regulator {
+				compatible = "ti,pbias-omap";
+				reg = <0 0x4>;
+				pbias_mmc_reg: pbias_mmc_omap5 {
+					regulator-name = "pbias_mmc_omap5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+				};
+			};
+		};
+
 		dra7_pmx_core: pinmux@4a003400 {
 			compatible = "pinctrl-single";
 			reg = <0x4a003400 0x0464>;
@@ -485,6 +503,7 @@
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d624345..f127901 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,24 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		omap2_scm_general: tisyscon@49002270 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x49002270 0x240>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			pbias_regulator: pbias_regulator {
+				compatible = "ti,pbias-omap";
+				reg = <0x230 0x4>;
+				pbias_mmc_reg: pbias_mmc_omap3 {
+					regulator-name = "pbias_mmc_omap3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+				};
+			};
+		};
+
 		gpio1: gpio@4900c000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x4900c000 0x200>;
@@ -183,6 +201,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..380a4c4 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -137,6 +137,24 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
+		omap3_scm_general: tisyscon@48002270 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x48002270 0x2f0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			pbias_regulator: pbias_regulator {
+				compatible = "ti,pbias-omap";
+				reg = <0x2b0 0x4>;
+				pbias_mmc_reg: pbias_mmc_omap3 {
+					regulator-name = "pbias_mmc_omap3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+				};
+			};
+		};
+
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
 			reg = <0x48310000 0x200>;
@@ -351,6 +369,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..938b596 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -134,6 +134,24 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
+		omap4_padconf_global: tisyscon@4a1005a0 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4a1005a0 0x170>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			pbias_regulator: pbias_regulator {
+				compatible = "ti,pbias-omap";
+				reg = <0x60 0x4>;
+				pbias_mmc_reg: pbias_mmc_omap4 {
+					regulator-name = "pbias_mmc_omap4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <10>;
+				};
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -367,6 +385,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..2df4862 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -130,6 +130,24 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
+		omap5_padconf_global: tisyscon@4a002da0 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4A002da0 0xec>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			pbias_regulator: pbias_regulator {
+				compatible = "ti,pbias-omap";
+				reg = <0x60 0x4>;
+				pbias_mmc_reg: pbias_mmc_omap5 {
+					regulator-name = "pbias_mmc_omap5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+				};
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -409,6 +427,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
-- 
1.7.5.4

