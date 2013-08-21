From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH V2] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Wed, 21 Aug 2013 12:05:32 +0530
Message-ID: <1377066933-28058-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33260 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3HUGgB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 02:36:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com
Cc: ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

This patch adds the device tree node entries for exynos5420 SOC.
Exynos5420 has a different version of DWMMC controller,so a new
compatible string is used to distinguish it from the prior SOC's.

changes since V1:
	1.disable node by status = disabled in SOC file
	2.enable node by status = okay in board specific file

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    2 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   39 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  |   36 ++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 6d1c098..84cd56f 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -16,6 +16,8 @@ Required Properties:
 	  specific extensions.
 	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
 	  specific extensions.
+	- "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
+	  specific extensions.
 
 * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
   unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 08607df..0b2e464 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -30,4 +30,43 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	dwmmc0@12200000 {
+		status = "okay";
+		num-slots = <1>;
+		broken-cd;
+		bypass-smu;
+		supports-highspeed;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <0 4>;
+		samsung,dw-mshc-ddr-timing = <0 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
+	};
+
+	dwmmc2@12220000 {
+		status = "okay";
+		num-slots = <1>;
+		supports-highspeed;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
+
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9e90d1e..d9220c3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -19,6 +19,9 @@
 	compatible = "samsung,exynos5420";
 
 	aliases {
+		mshc0 = &dwmmc_0;
+		mshc1 = &dwmmc_1;
+		mshc2 = &dwmmc_2;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
@@ -65,6 +68,39 @@
 		#clock-cells = <1>;
 	};
 
+	dwmmc_0: dwmmc0@12200000 {
+		compatible = "samsung,exynos5420-dw-mshc";
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x12200000 0x2000>;
+		clocks = <&clock 351>, <&clock 132>;
+		clock-names = "biu", "ciu";
+		status = "disabled";
+	};
+
+	dwmmc_1: dwmmc1@12210000 {
+		compatible = "samsung,exynos5420-dw-mshc";
+		interrupts = <0 76 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x12210000 0x2000>;
+		clocks = <&clock 352>, <&clock 133>;
+		clock-names = "biu", "ciu";
+		status = "disabled";
+	};
+
+	dwmmc_2: dwmmc2@12220000 {
+		compatible = "samsung,exynos5420-dw-mshc";
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x12220000 0x2000>;
+		clocks = <&clock 353>, <&clock 134>;
+		clock-names = "biu", "ciu";
+		status = "disabled";
+	};
+
 	mct@101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-- 
1.7.9.5

