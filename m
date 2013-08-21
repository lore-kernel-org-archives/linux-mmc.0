From: yuvaraj.cd@gmail.com
Subject: [PATCH V2 1/2] ARM: dts: remove dwmmc nodes from exynos5 common dts file.
Date: Wed, 21 Aug 2013 12:07:38 +0530
Message-ID: <52146040.87c5440a.4207.5aff@mx.google.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com
Cc: ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Exynos5 series SOC's 5250 and 5420 have different versions of
DWMMC controller.So there is a new compatible string to distinguish
between them.So these nodes should be moved out of Exynos5 series
common device tree source.

Changes since V1: none

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi |   21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 6afa57d..24140f0 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -50,27 +50,6 @@
 		interrupts = <1 9 0xf04>;
 	};
 
-	dwmmc_0: dwmmc0@12200000 {
-		compatible = "samsung,exynos5250-dw-mshc";
-		interrupts = <0 75 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	dwmmc_1: dwmmc1@12210000 {
-		compatible = "samsung,exynos5250-dw-mshc";
-		interrupts = <0 76 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	dwmmc_2: dwmmc2@12220000 {
-		compatible = "samsung,exynos5250-dw-mshc";
-		interrupts = <0 77 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
 	serial@12C00000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C00000 0x100>;
-- 
1.7.9.5
