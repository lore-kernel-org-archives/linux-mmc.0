From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v7 5/7] ARM: dts: add pbias dt node
Date: Fri, 20 Dec 2013 23:05:53 +0530
Message-ID: <1387560955-6547-6-git-send-email-balajitk@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45827 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756876Ab3LTRgT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Dec 2013 12:36:19 -0500
In-Reply-To: <1387560955-6547-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>

Add pbias regulator node as a child of system control
module - syscon.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi     |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   18 ++++++++++++++++++
 5 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..4e68df1 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -110,6 +110,23 @@
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
+				};
+			};
+		};
+
 		dra7_pmx_core: pinmux@4a003400 {
 			compatible = "pinctrl-single";
 			reg = <0x4a003400 0x0464>;
@@ -485,6 +502,7 @@
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d624345..142de17 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,23 @@
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
+				pbias_mmc_reg: pbias_mmc_omap2430 {
+					regulator-name = "pbias_mmc_omap2430";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+				};
+			};
+		};
+
 		gpio1: gpio@4900c000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x4900c000 0x200>;
@@ -183,6 +200,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..ba796e9 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -137,6 +137,23 @@
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
+				pbias_mmc_reg: pbias_mmc_omap2430 {
+					regulator-name = "pbias_mmc_omap2430";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+				};
+			};
+		};
+
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
 			reg = <0x48310000 0x200>;
@@ -351,6 +368,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..a05ea2c 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -134,6 +134,23 @@
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
+				};
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -367,6 +384,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..1d14f0d 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -130,6 +130,23 @@
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
+				};
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -409,6 +426,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_mmc_reg>;
 		};
 
 		mmc2: mmc@480b4000 {
-- 
1.7.5.4

