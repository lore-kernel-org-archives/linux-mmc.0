From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 4/4] ARM: dts: add HS400 support for Exynos5420 and
 exynos5800
Date: Wed, 31 Dec 2014 12:13:05 +0530
Message-ID: <1420008185-24758-5-git-send-email-alim.akhtar@samsung.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com
List-Id: linux-mmc@vger.kernel.org

From: Seungwon Jeon <tgih.jun@samsung.com>

HS400 timing value set is added for SMDK5420, peach-pit and
exynos5800 peach-pi.
And GPIO line for RCLK should be pull-down state.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 ++++-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts  |    5 ++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    5 ++++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index e9f5a6c..151ae7d 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -568,8 +568,11 @@
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-sdr-timing = <0 4 3>;
 	samsung,dw-mshc-ddr-timing = <0 2 3>;
+	samsung,dw-mshc-hs200-timing = <0 2 3>;
+	samsung,dw-mshc-hs400-timing = <0 2 1>;
+	read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index ba686e4..dd85fe2 100644
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
index 140ea54..685e2a4 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -79,8 +79,11 @@
 		card-detect-delay = <200>;
 		samsung,dw-mshc-sdr-timing = <0 4 3>;
 		samsung,dw-mshc-ddr-timing = <0 2 3>;
+		samsung,dw-mshc-hs200-timing = <0 2 3>;
+		samsung,dw-mshc-hs400-timing = <0 2 1>;
+		read-strobe-delay = <90>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
 	};
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 9a4875b..28d4109 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -556,8 +556,11 @@
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-sdr-timing = <0 4 3>;
 	samsung,dw-mshc-ddr-timing = <0 2 3>;
+	samsung,dw-mshc-hs200-timing = <0 2 3>;
+	samsung,dw-mshc-hs400-timing = <0 2 1>;
+	read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
 };
 
-- 
1.7.9.5
