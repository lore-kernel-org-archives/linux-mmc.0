From: yuvaraj.cd@gmail.com
Subject: [PATCH V2 2/2] ARM: dts: Add dwmmc nodes in SOC specific dts file
Date: Wed, 21 Aug 2013 12:07:39 +0530
Message-ID: <52146043.87c5440a.4207.5b07@mx.google.com>
References: <1377067059-28096-1-git-send-email-a>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1377067059-28096-1-git-send-email-a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com
Cc: ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Exynos5 series SOC's have different versions of DWMMC controller.
So dwmmc device nodes moved from Exynos5 SOC's common dts file to
SOC specific dts file.

changes since V1:
	1.disable node by status = disabled in SOC file
	2.enable node by status = okay in board specific file

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   10 ++--------
 arch/arm/boot/dts/exynos5250.dtsi         |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 2538b32..bd19d55d 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -141,6 +141,7 @@
 	};
 
 	dwmmc0@12200000 {
+		status = "okay";
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
@@ -158,11 +159,8 @@
 		};
 	};
 
-	dwmmc1@12210000 {
-		status = "disabled";
-	};
-
 	dwmmc2@12220000 {
+		status = "okay";
 		num-slots = <1>;
 		supports-highspeed;
 		fifo-depth = <0x80>;
@@ -180,10 +178,6 @@
 		};
 	};
 
-	dwmmc3@12230000 {
-		status = "disabled";
-	};
-
 	spi_0: spi@12d20000 {
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 1eec646..b1b6f61 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -387,21 +387,36 @@
 	};
 
 	dwmmc_0: dwmmc0@12200000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x12200000 0x1000>;
 		clocks = <&clock 280>, <&clock 139>;
 		clock-names = "biu", "ciu";
+		status = "disabled";
 	};
 
 	dwmmc_1: dwmmc1@12210000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 76 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x12210000 0x1000>;
 		clocks = <&clock 281>, <&clock 140>;
 		clock-names = "biu", "ciu";
+		status = "disabled";
 	};
 
 	dwmmc_2: dwmmc2@12220000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x12220000 0x1000>;
 		clocks = <&clock 282>, <&clock 141>;
 		clock-names = "biu", "ciu";
+		status = "disabled";
 	};
 
 	dwmmc_3: dwmmc3@12230000 {
@@ -412,6 +427,7 @@
 		#size-cells = <0>;
 		clocks = <&clock 283>, <&clock 142>;
 		clock-names = "biu", "ciu";
+		status = "disabled";
 	};
 
 	i2s0: i2s@03830000 {
-- 
1.7.9.5
