From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 11/14] ARM: sunxi: dt: Add sample and output mmc clocks
Date: Thu, 17 Jul 2014 11:08:51 +0200
Message-ID: <1405588134-2396-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add the sample and output clocks for the MMC phase support.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  79 ++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  80 +++++++++++++++++++++++++----
 arch/arm/boot/dts/sun6i-a31.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 5 files changed, 430 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 459cb6377764..847b785a9caf 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -227,6 +227,22 @@
 			clock-output-names = "mmc0";
 		};
 
+		mmc0_output_clk: clk_mmc_output@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_output";
+		};
+
+		mmc0_sample_clk: clk_mmc_sample@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_sample";
+		};
+
 		mmc1_clk: clk@01c2008c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -235,6 +251,22 @@
 			clock-output-names = "mmc1";
 		};
 
+		mmc1_output_clk: clk_mmc_output@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_output";
+		};
+
+		mmc1_sample_clk: clk_mmc_sample@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_sample";
+		};
+
 		mmc2_clk: clk@01c20090 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -243,6 +275,22 @@
 			clock-output-names = "mmc2";
 		};
 
+		mmc2_output_clk: clk_mmc_output@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_output";
+		};
+
+		mmc2_sample_clk: clk_mmc_sample@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_sample";
+		};
+
 		mmc3_clk: clk@01c20094 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -251,6 +299,22 @@
 			clock-output-names = "mmc3";
 		};
 
+		mmc3_output_clk: clk_mmc_output@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_output";
+		};
+
+		mmc3_sample_clk: clk_mmc_sample@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_sample";
+		};
+
 		ts_clk: clk@01c20098 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -380,8 +444,14 @@
 		mmc0: mmc@01c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk>,
+				 <&mmc0_sample_clk>,
+				 <&mmc0_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -389,8 +459,14 @@
 		mmc1: mmc@01c10000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk>,
+				 <&mmc1_sample_clk>,
+				 <&mmc1_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <33>;
 			status = "disabled";
 		};
@@ -398,8 +474,14 @@
 		mmc2: mmc@01c11000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk>,
+				 <&mmc2_sample_clk>,
+				 <&mmc2_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <34>;
 			status = "disabled";
 		};
@@ -407,8 +489,14 @@
 		mmc3: mmc@01c12000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 11>,
+				 <&mmc3_clk>,
+				 <&mmc3_sample_clk>,
+				 <&mmc3_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <35>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index d6446b71a333..3a0d19d69379 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -212,6 +212,22 @@
 			clock-output-names = "mmc0";
 		};
 
+		mmc0_output_clk: clk_mmc_output@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_output";
+		};
+
+		mmc0_sample_clk: clk_mmc_sample@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_sample";
+		};
+
 		mmc1_clk: clk@01c2008c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -220,6 +236,22 @@
 			clock-output-names = "mmc1";
 		};
 
+		mmc1_output_clk: clk_mmc_output@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_output";
+		};
+
+		mmc1_sample_clk: clk_mmc_sample@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_sample";
+		};
+
 		mmc2_clk: clk@01c20090 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -228,6 +260,22 @@
 			clock-output-names = "mmc2";
 		};
 
+		mmc2_output_clk: clk_mmc_output@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_output";
+		};
+
+		mmc2_sample_clk: clk_mmc_sample@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_sample";
+		};
+
 		ts_clk: clk@01c20098 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -341,8 +389,14 @@
 		mmc0: mmc@01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk>,
+				 <&mmc0_sample_clk>,
+				 <&mmc0_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -350,8 +404,14 @@
 		mmc1: mmc@01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk>,
+				 <&mmc1_sample_clk>,
+				 <&mmc1_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <33>;
 			status = "disabled";
 		};
@@ -359,12 +419,17 @@
 		mmc2: mmc@01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk>,
+				 <&mmc2_sample_clk>,
+				 <&mmc2_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <34>;
 			status = "disabled";
 		};
-
 		usbphy: phy@01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun5i-a13-usb-phy";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 684576cb0f37..7187f42cd29b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -203,30 +203,78 @@
 			clock-output-names = "ms";
 		};
 
-		mmc0_clk: clk@01c20088 {
+		mmc0_clk: clk_mmc@01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
 		};
 
-		mmc1_clk: clk@01c2008c {
+		mmc0_output_clk: clk_mmc_output@01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_output";
+		};
+
+		mmc0_sample_clk: clk_mmc_sample@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_sample";
+		};
+
+		mmc1_clk: clk_mmc@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
 		};
 
-		mmc2_clk: clk@01c20090 {
+		mmc1_output_clk: clk_mmc_output@01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_output";
+		};
+
+		mmc1_sample_clk: clk_mmc_sample@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_sample";
+		};
+
+		mmc2_clk: clk_mmc@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
 		};
 
+		mmc2_output_clk: clk_mmc_output@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_output";
+		};
+
+		mmc2_sample_clk: clk_mmc_sample@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_sample";
+		};
+
 		ts_clk: clk@01c20098 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -324,8 +372,14 @@
 		mmc0: mmc@01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk>,
+				 <&mmc0_sample_clk>,
+				 <&mmc0_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -333,8 +387,14 @@
 		mmc2: mmc@01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk>,
+				 <&mmc2_sample_clk>,
+				 <&mmc2_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <34>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index baf8eff57610..80076b25f272 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -215,6 +215,22 @@
 			clock-output-names = "mmc0";
 		};
 
+		mmc0_output_clk: clk_mmc_output@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_output";
+		};
+
+		mmc0_sample_clk: clk_mmc_sample@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_sample";
+		};
+
 		mmc1_clk: clk@01c2008c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -223,6 +239,22 @@
 			clock-output-names = "mmc1";
 		};
 
+		mmc1_output_clk: clk_mmc_output@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_output";
+		};
+
+		mmc1_sample_clk: clk_mmc_sample@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_sample";
+		};
+
 		mmc2_clk: clk@01c20090 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -231,6 +263,22 @@
 			clock-output-names = "mmc2";
 		};
 
+		mmc2_output_clk: clk_mmc_output@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_output";
+		};
+
+		mmc2_sample_clk: clk_mmc_sample@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_sample";
+		};
+
 		mmc3_clk: clk@01c20094 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -239,6 +287,22 @@
 			clock-output-names = "mmc3";
 		};
 
+		mmc3_output_clk: clk_mmc_output@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_output";
+		};
+
+		mmc3_sample_clk: clk_mmc_sample@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_sample";
+		};
+
 		spi0_clk: clk@01c200a0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -301,8 +365,14 @@
 		mmc0: mmc@01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 8>,
+				 <&mmc0_clk>,
+				 <&mmc0_sample_clk>,
+				 <&mmc0_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			resets = <&ahb1_rst 8>;
 			reset-names = "ahb";
 			interrupts = <0 60 4>;
@@ -312,8 +382,14 @@
 		mmc1: mmc@01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 9>,
+				 <&mmc1_clk>,
+				 <&mmc1_sample_clk>,
+				 <&mmc1_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			resets = <&ahb1_rst 9>;
 			reset-names = "ahb";
 			interrupts = <0 61 4>;
@@ -323,8 +399,14 @@
 		mmc2: mmc@01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 10>,
+				 <&mmc2_clk>,
+				 <&mmc2_sample_clk>,
+				 <&mmc2_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			resets = <&ahb1_rst 10>;
 			reset-names = "ahb";
 			interrupts = <0 62 4>;
@@ -334,8 +416,14 @@
 		mmc3: mmc@01c12000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb1_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 11>,
+				 <&mmc3_clk>,
+				 <&mmc3_sample_clk>,
+				 <&mmc3_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			resets = <&ahb1_rst 11>;
 			reset-names = "ahb";
 			interrupts = <0 63 4>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e87d29e52b66..97886ce62e2d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -239,6 +239,22 @@
 			clock-output-names = "mmc0";
 		};
 
+		mmc0_output_clk: clk_mmc_output@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_output";
+		};
+
+		mmc0_sample_clk: clk_mmc_sample@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&mmc0_clk>;
+			clock-output-names = "mmc0_sample";
+		};
+
 		mmc1_clk: clk@01c2008c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -247,6 +263,22 @@
 			clock-output-names = "mmc1";
 		};
 
+		mmc1_output_clk: clk_mmc_output@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_output";
+		};
+
+		mmc1_sample_clk: clk_mmc_sample@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&mmc1_clk>;
+			clock-output-names = "mmc1_sample";
+		};
+
 		mmc2_clk: clk@01c20090 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -255,6 +287,22 @@
 			clock-output-names = "mmc2";
 		};
 
+		mmc2_output_clk: clk_mmc_output@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_output";
+		};
+
+		mmc2_sample_clk: clk_mmc_sample@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&mmc2_clk>;
+			clock-output-names = "mmc2_sample";
+		};
+
 		mmc3_clk: clk@01c20094 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -263,6 +311,22 @@
 			clock-output-names = "mmc3";
 		};
 
+		mmc3_output_clk: clk_mmc_output@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-output-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_output";
+		};
+
+		mmc3_sample_clk: clk_mmc_sample@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mmc-sample-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&mmc3_clk>;
+			clock-output-names = "mmc3_sample";
+		};
+
 		ts_clk: clk@01c20098 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -464,8 +528,14 @@
 		mmc0: mmc@01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk>,
+				 <&mmc0_sample_clk>,
+				 <&mmc0_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <0 32 4>;
 			status = "disabled";
 		};
@@ -473,8 +543,14 @@
 		mmc1: mmc@01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk>,
+				 <&mmc1_sample_clk>,
+				 <&mmc1_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <0 33 4>;
 			status = "disabled";
 		};
@@ -482,8 +558,14 @@
 		mmc2: mmc@01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk>,
+				 <&mmc2_sample_clk>,
+				 <&mmc2_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <0 34 4>;
 			status = "disabled";
 		};
@@ -491,8 +573,14 @@
 		mmc3: mmc@01c12000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 11>,
+				 <&mmc3_clk>,
+				 <&mmc3_sample_clk>,
+				 <&mmc3_output_clk>;
+			clock-names = "ahb",
+				      "mmc",
+				      "sample",
+				      "output";
 			interrupts = <0 35 4>;
 			status = "disabled";
 		};
-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
