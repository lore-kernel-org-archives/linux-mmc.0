From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v4 5/7] ARM: dts: add pbias dt node
Date: Tue, 10 Dec 2013 15:46:15 +0530
Message-ID: <1386670577-3530-6-git-send-email-balajitk@ti.com>
References: <1385043627-30439-1-git-send-email-balajitk@ti.com>
 <1386670577-3530-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1386670577-3530-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add pbias regulator node as a child of system control
module - syscon.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi     |   14 ++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   14 ++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   14 ++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   14 ++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
 5 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..1a52676 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -119,6 +119,19 @@
 			pinctrl-single,function-mask = <0x3fffffff>;
 		};
 
+		tisyscon: tisyscon@4A100600 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4A002E00 0x4>;
+				pbias_regulator: pbias_regulator {
+					compatible = "regulator-pbias-omap5";
+					pbias-reg-offset = <0>;
+					regulator-name = "pbias_regulator";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <10>;
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -485,6 +498,7 @@
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			pbias-supply = <&pbias_regulator>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d624345..7d084c4 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,19 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		tisyscon: tisyscon@490024A0 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x490024A0 0x4>;
+				pbias_regulator: pbias_regulator {
+					compatible = "regulator-pbias-omap2";
+					pbias-reg-offset = <0>;
+					regulator-name = "pbias_regulator";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+			};
+		};
+
 		gpio1: gpio@4900c000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x4900c000 0x200>;
@@ -183,6 +196,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_regulator>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..88f0179 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -137,6 +137,19 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
+		tisyscon: tisyscon@48002520 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x48002520 0x4>;
+				pbias_regulator: pbias_regulator {
+					compatible = "regulator-pbias-omap3";
+					pbias-reg-offset = <0>;
+					regulator-name = "pbias_regulator";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <100>;
+			};
+		};
+
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
 			reg = <0x48310000 0x200>;
@@ -351,6 +364,7 @@
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_regulator>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..09e8d52 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -134,6 +134,19 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
+		tisyscon: tisyscon@4A100600 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4A100600 0x4>;
+				pbias_regulator: pbias_regulator {
+					compatible = "regulator-pbias-omap4";
+					pbias-reg-offset = <0>;
+					regulator-name = "pbias_regulator";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <10>;
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -367,6 +380,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_regulator>;
 		};
 
 		mmc2: mmc@480b4000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..93edb2e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -130,6 +130,19 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
+		tisyscon: tisyscon@4A002E00 {
+			compatible = "ti,control-syscon", "syscon", "simple-bus";
+			reg = <0x4A002E00 0x4>;
+				pbias_regulator: pbias_regulator {
+					compatible = "regulator-pbias-omap5";
+					pbias-reg-offset = <0>;
+					regulator-name = "pbias_regulator";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-enable-ramp-delay = <10>;
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -409,6 +422,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			pbias-supply = <&pbias_regulator>;
 		};
 
 		mmc2: mmc@480b4000 {
-- 
1.7.5.4

