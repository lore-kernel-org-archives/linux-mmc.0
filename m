From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 6/7] ARM: dts: drop dw-mshc-ciu-div property from Exynos
Date: Wed, 26 Mar 2014 20:31:50 +0900
Message-ID: <000601cf48e6$fad62590$f08270b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

As dw-mshc-ciu-div is strongly close to timing property,
it is merged with each timing property.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   12 +++++-------
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    5 ++---
 arch/arm/boot/dts/exynos4412-origen.dts            |    5 ++---
 arch/arm/boot/dts/exynos4412-trats2.dts            |    5 ++---
 arch/arm/boot/dts/exynos5250-arndale.dts           |   10 ++++------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   15 ++++++---------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 ++++------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   10 ++++------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   10 ++++------
 9 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 532b1d4..ca1914f 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -19,10 +19,6 @@ Required Properties:
 	- "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
 	  specific extensions.
 
-* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
-  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
-  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
-
 * samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
   in transmit mode and CIU clock phase shift value in receive mode for single
   data rate mode operation. Refer notes below for the order of the cells and the
@@ -38,6 +34,9 @@ Required Properties:
     The order of the cells should be
       - First Cell: CIU clock phase shift value for tx mode.
       - Second Cell: CIU clock phase shift value for rx mode.
+      - Thrid Cell: Specifies the divider value for the card interface
+           unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
+           ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
 
     Valid values for SDR and DDR CIU clock timing for Exynos5250:
       - valid value for tx phase shift and rx phase shift is 0 to 7.
@@ -73,9 +72,8 @@ Example:
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 
 		slot@0 {
 			reg = <0>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 9804fcb..99f32db 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -48,9 +48,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 0>;
+		samsung,dw-mshc-ddr-timing = <1 2 0>;
 
 		slot@0 {
 			reg = <0>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 6bc0539..7c0b535 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -131,9 +131,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 0>;
+		samsung,dw-mshc-ddr-timing = <1 2 0>;
 
 		slot@0 {
 			reg = <0>;
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 4f851cc..556e414 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -451,9 +451,8 @@
 		card-detect-delay = <200>;
 		vmmc-supply = <&vemmc_reg>;
 		clock-frequency = <400000000>;
-		samsung,dw-mshc-ciu-div = <0>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 0>;
+		samsung,dw-mshc-ddr-timing = <1 2 0>;
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		status = "okay";
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index b42e658..dc53b51 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -376,9 +376,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
@@ -394,9 +393,8 @@
 		num-slots = <1>;
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..d550261 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -251,9 +251,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 
@@ -267,9 +266,8 @@
 		num-slots = <1>;
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
@@ -285,9 +283,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		/* See board-specific dts files for pin setup */
 
 		slot@0 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 3e69837..a59a1ae 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -134,9 +134,8 @@
 		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 
@@ -151,9 +150,8 @@
 		num-slots = <1>;
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 7340745..ce2a50f 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -36,9 +36,8 @@
 		broken-cd;
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <0 4>;
-		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-sdr-timing = <0 4 3>;
+		samsung,dw-mshc-ddr-timing = <0 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 
@@ -52,9 +51,8 @@
 		status = "okay";
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index fb5a1e2..3ad4ef3 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -36,9 +36,8 @@
 		broken-cd;
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <0 4>;
-		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-sdr-timing = <0 4 3>;
+		samsung,dw-mshc-ddr-timing = <0 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 
@@ -52,9 +51,8 @@
 		status = "okay";
 		supports-highspeed;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
-- 
1.7.4.1
