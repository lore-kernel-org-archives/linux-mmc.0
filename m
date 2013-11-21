From: Balaji T K <balajitk@ti.com>
Subject: [RFC PATCH v3 5/8] ARM: dts: add pbias dt node
Date: Thu, 21 Nov 2013 19:50:24 +0530
Message-ID: <1385043627-30439-6-git-send-email-balajitk@ti.com>
References: <20130613174554.GB1403@sirena.org.uk>
 <1385043627-30439-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1385043627-30439-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add pbias regulator node as a child of system control
module - syscon.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi     |   12 ++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   12 ++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   12 ++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   12 ++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   12 ++++++++++++
 5 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..08bf835 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -119,6 +119,18 @@
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
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c535a5a..d1725a4 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,18 @@
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
+			};
+		};
+
 		gpio1: gpio@4900c000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x4900c000 0x200>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f3a0c26..4e448cf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -130,6 +130,18 @@
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
+			};
+		};
+
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
 			reg = <0x48310000 0x200>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..160c25a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -134,6 +134,18 @@
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
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..86a00d7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -130,6 +130,18 @@
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
+			};
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
1.7.5.4

