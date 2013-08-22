From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH V3] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Thu, 22 Aug 2013 17:21:18 +0530
Message-ID: <1377172278-15161-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the device tree node entries for exynos5420 SOC.
Exynos5420 has a different version of DWMMC controller,so a new
compatible string is used to distinguish it from the prior SOC's.

changes since V2:
	1.dropped num-slots property from node as its not required
	  if number of card slots available is 1.

	2.Move the below properties
		a.fifo-depth
		b.card-detect-delay
		c.samsung,dw-mshc-ciu-div
		d.samsung,dw-mshc-sdr-timing
		e.samsung,dw-mshc-ddr-timing
	from board dts to SOC dts,as these are not board specific properties.

	3.Updated the binding document exynos-dw-mshc.txt.

changes since V1:
	1.disable node by status = disabled in SOC file
	2.enable node by status = okay in board specific file

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    4 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   26 ++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  |   51 ++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 6d1c098..25368e8 100644
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
@@ -31,6 +33,8 @@ Required Properties:
   data rate mode operation. Refer notes below for the order of the cells and the
   valid values.
 
+* bypass-smu: Bypass Security Management Unit of eMMC channel 0 and channel 1.
+
   Notes for the sdr-timing and ddr-timing values:
 
     The order of the cells should be
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index bafba25..bc604d4 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -31,6 +31,32 @@
 		};
 	};
 
+	dwmmc0@12200000 {
+		status = "okay";
+		broken-cd;
+		bypass-smu;
+		supports-highspeed;
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
+		supports-highspeed;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
+
 	dp-controller@145B0000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&dp_hpd>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5353e32..1f08d1b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -22,6 +22,9 @@
 	compatible = "samsung,exynos5420";
 
 	aliases {
+		mshc0 = &dwmmc_0;
+		mshc1 = &dwmmc_1;
+		mshc2 = &dwmmc_2;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
@@ -84,6 +87,54 @@
 		clock-names = "mfc";
 	};
 
+	dwmmc_0: dwmmc0@12200000 {
+		compatible = "samsung,exynos5420-dw-mshc";
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x12200000 0x2000>;
+		clocks = <&clock 351>, <&clock 132>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <0 4>;
+		samsung,dw-mshc-ddr-timing = <0 2>;
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
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <0 4>;
+		samsung,dw-mshc-ddr-timing = <0 2>;
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
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		status = "disabled";
+	};
+
 	mct@101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-- 
1.7.9.5
