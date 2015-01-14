From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 2/2] ARM: dts: Add HS400 support for exynos5420 and
 exynos5800
Date: Wed, 14 Jan 2015 16:00:46 +0530
Message-ID: <1421231446-4776-3-git-send-email-alim.akhtar@samsung.com>
References: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com
List-Id: linux-mmc@vger.kernel.org

From: Seungwon Jeon <tgih.jun@samsung.com>

HS400 timing values are added for SMDK5420, exynos5420-peach-pit
and exynos5800-peach-pi boards.
This also adds RCLK GPIO line, this gpio should be in pull-down
state.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
[Alim: addressed review comments]
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 +++-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts  |    4 +++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    4 +++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 9a050e1..7ffaba8 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -569,8 +569,10 @@
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index ba686e4..8b15316 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -201,6 +201,13 @@
 			samsung,pin-drv = <3>;
 		};
 
+		sd0_rclk: sd0-rclk {
+			samsung,pins = "gpc0-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <3>;
+		};
+
 		sd1_cmd: sd1-cmd {
 			samsung,pins = "gpc1-1";
 			samsung,pin-function = <2>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 8be3d7b..5290e79 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -80,8 +80,10 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
 		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-hs400-timing = <0 2>;
+		read-strobe-delay = <90>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
 	};
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index e8fdda8..fa1c858 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -557,8 +557,10 @@
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
 };
 
-- 
1.7.9.5
