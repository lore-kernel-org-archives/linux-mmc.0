From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
Date: Sat, 30 Aug 2014 22:03:08 +0200
Message-ID: <1409428991-2442-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53664 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbaH3UFT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Aug 2014 16:05:19 -0400
In-Reply-To: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Add the sample and output clocks for the MMC phase support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  79 ++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  80 +++++++++++++++++++++++++----
 arch/arm/boot/dts/sun6i-a31.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
 5 files changed, 430 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 380f914b226d..3183436528e1 100644
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
@@ -392,8 +456,14 @@
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
@@ -401,8 +471,14 @@
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
@@ -410,8 +486,14 @@
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
@@ -419,8 +501,14 @@
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
index 531272c0e526..4f5eb763e05a 100644
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
@@ -353,8 +401,14 @@
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
@@ -362,8 +416,14 @@
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
@@ -371,12 +431,17 @@
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
index b131068f4f35..73f99ff6ac6f 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -202,30 +202,78 @@
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
@@ -335,8 +383,14 @@
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
@@ -344,8 +398,14 @@
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
index 1c2ec913e650..574e6f19a0f6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -216,6 +216,22 @@
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
@@ -224,6 +240,22 @@
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
@@ -232,6 +264,22 @@
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
@@ -240,6 +288,22 @@
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
@@ -330,8 +394,14 @@
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
@@ -341,8 +411,14 @@
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
@@ -352,8 +428,14 @@
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
@@ -363,8 +445,14 @@
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
index ec5603da595e..fc0a90d54d63 100644
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
@@ -476,8 +540,14 @@
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
@@ -485,8 +555,14 @@
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
@@ -494,8 +570,14 @@
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
@@ -503,8 +585,14 @@
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
2.0.2

