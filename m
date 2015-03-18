From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v7] ARM: dts: Add HS400 support for exynos5420 and exynos5800
Date: Wed, 18 Mar 2015 16:50:23 +0530
Message-ID: <1426677623-30532-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene@kernel.org
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com, alim.akhtar@samsung.com, javier@dowhile0.org
List-Id: linux-mmc@vger.kernel.org

From: Seungwon Jeon <tgih.jun@samsung.com>

HS400 timing values are added for SMDK5420, exynos5420-peach-pit
and exynos5800-peach-pi boards.
This also adds RCLK GPIO line, this gpio should be in pull-down
state.
This also enables HS400 on peach-pi and this updates the clock frequency
to 800MHz to be set as input clock to controller.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
[Alim: addressed review comments]
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changes in V7:
	 Add back bus1 pin, which was removed during rebase in v6
         as rightly pointed out by Javier[1].

Changes in V6:
	Rebased on kukjin's for-next branch[0] 
	(commit: 77105c8 Merge branch 'v4.0-samsung-fixes-2' into for-next)

[0]: git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
[1]: http://www.spinics.net/lists/arm-kernel/msg406618.html

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 +++-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi  | 7 +++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts  | 5 ++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 7 +++++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 3f4e2fe..0788d08 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -699,8 +699,10 @@
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	samsung,read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_rclk>;
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
index 7a56852..9103f23 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -80,8 +80,11 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
 		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-hs400-timing = <0 2>;
+		samsung,read-strobe-delay = <90>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8
+			     &sd0_rclk>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
 	};
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index c833bac..412f41d 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -654,15 +654,18 @@
 	num-slots = <1>;
 	broken-cd;
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
-	clock-frequency = <400000000>;
+	clock-frequency = <800000000>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	samsung,read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
 };
 
-- 
1.9.1
