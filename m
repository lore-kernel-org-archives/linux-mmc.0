From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 7/7] ARM: dts: add HS400 support for Exynos5420
Date: Fri, 21 Mar 2014 23:04:49 +0900
Message-ID: <002101cf450e$861697c0$9243c740$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

HS400 timing value set is added for SMDK5420.
And GPIO line for RCLK should be pull-down state.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    6 ++++++
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    5 ++++-
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index ca1914f..39c3014 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -29,6 +29,9 @@ Required Properties:
   data rate mode operation. Refer notes below for the order of the cells and the
   valid values.
 
+* samsung,dw-mshc-hs200-timing: Similar with dw-mshc-sdr-timing.
+* samsung,dw-mshc-hs400-timing: Similar with dw-mshc-ddr-timing.
+
   Notes for the sdr-timing and ddr-timing values:
 
     The order of the cells should be
@@ -45,6 +48,9 @@ Required Properties:
       - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
         phase shift clocks should be 0.
 
+* read-strobe-delay: RCLK (Data strobe) delay to control HS400 mode
+  (Latency value for delay line in Read path)
+
 Required properties for a slot:
 
 * gpios: specifies a list of gpios used for command, clock and data bus. The
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index e62c8eb..51233ee 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -194,6 +194,13 @@
 			samsung,pin-drv = <3>;
 		};
 
+		sd0_rclk: sd0-rclk {
+			samsung,pins = "gpc0-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <3>;
+		};
+
 		sd1_clk: sd1-clk {
 			samsung,pins = "gpc1-0";
 			samsung,pin-function = <2>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 3ad4ef3..4796d44 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -38,8 +38,11 @@
 		card-detect-delay = <200>;
 		samsung,dw-mshc-sdr-timing = <0 4 3>;
 		samsung,dw-mshc-ddr-timing = <0 2 3>;
+		samsung,dw-mshc-hs200-timing = <0 2 3>;
+		samsung,dw-mshc-hs400-timing = <0 2 1>;
+		read-strobe-delay = <90>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 
 		slot@0 {
 			reg = <0>;
-- 
1.7.4.1
