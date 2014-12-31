From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 3/4] ARM: dts: drop dw-mshc-ciu-div property from Exynos
Date: Wed, 31 Dec 2014 12:13:04 +0530
Message-ID: <1420008185-24758-4-git-send-email-alim.akhtar@samsung.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com
List-Id: linux-mmc@vger.kernel.org

From: Seungwon Jeon <tgih.jun@samsung.com>

As dw-mshc-ciu-div is strongly close to timing property,
it is merged with each timing property.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts           |    5 ++---
 arch/arm/boot/dts/exynos3250-rinato.dts         |    5 ++---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    5 ++---
 arch/arm/boot/dts/exynos4412-origen.dts         |    5 ++---
 arch/arm/boot/dts/exynos4412-trats2.dts         |    5 ++---
 arch/arm/boot/dts/exynos5250-arndale.dts        |   10 ++++------
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   10 ++++------
 arch/arm/boot/dts/exynos5250-snow.dts           |   15 ++++++---------
 arch/arm/boot/dts/exynos5250-spring.dts         |   10 ++++------
 arch/arm/boot/dts/exynos5260-xyref5260.dts      |   10 ++++------
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |   10 ++++------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |   10 ++++------
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   10 ++++------
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |   10 ++++------
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   10 ++++------
 15 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 24822aa..faeca4f 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -390,9 +390,8 @@
 	vmmc-supply = <&vemmc_reg>;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <400000 100000000>;
-	samsung,dw-mshc-ciu-div = <1>;
-	samsung,dw-mshc-sdr-timing = <0 1>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <0 1 1>;
+	samsung,dw-mshc-ddr-timing = <1 2 1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 80aa8b4..8578d26 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -493,9 +493,8 @@
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <400000 100000000>;
-	samsung,dw-mshc-ciu-div = <1>;
-	samsung,dw-mshc-sdr-timing = <0 1>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <0 1 1>;
+	samsung,dw-mshc-ddr-timing = <1 2 1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3fbf588..5d82a81 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -66,9 +66,8 @@
 		num-slots = <1>;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index de15114..bd4a672 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -139,9 +139,8 @@
 		num-slots = <1>;
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 29231b4..fada9f6 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -559,9 +559,8 @@
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
index 7e728a1..afbe508 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -523,9 +523,8 @@
 	num-slots = <1>;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	vmmc-supply = <&mmc_reg>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
@@ -537,9 +536,8 @@
 	status = "okay";
 	num-slots = <1>;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	vmmc-supply = <&mmc_reg>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bc27cc2..6c2180e 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -347,9 +347,8 @@
 	num-slots = <1>;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
@@ -360,9 +359,8 @@
 	status = "okay";
 	num-slots = <1>;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index effaf2a..812959c 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -498,9 +498,8 @@
 	num-slots = <1>;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
@@ -511,9 +510,8 @@
 	status = "okay";
 	num-slots = <1>;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	bus-width = <4>;
@@ -530,9 +528,8 @@
 	num-slots = <1>;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index f027754..5bac70b 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -432,9 +432,8 @@
 	supports-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 
@@ -454,9 +453,8 @@
 	supports-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
 
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index a803b60..6ee8b86 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -72,9 +72,8 @@
 	cap-mmc-highspeed;
 	supports-hs200-mode; /* 200 Mhz */
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <0 4>;
-	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-sdr-timing = <0 4 3>;
+	samsung,dw-mshc-ddr-timing = <0 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
@@ -85,9 +84,8 @@
 	num-slots = <1>;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index be3e025..e0956b2 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -43,9 +43,8 @@
 	cap-mmc-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	bus-width = <8>;
 };
 
@@ -54,9 +53,8 @@
 	num-slots = <1>;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	bus-width = <4>;
 	disable-wp;
 };
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index aa7a7d7..2e7ecce 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -51,9 +51,8 @@
 		status = "okay";
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <0 4>;
-		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-sdr-timing = <0 4 3>;
+		samsung,dw-mshc-ddr-timing = <0 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 		vmmc-supply = <&ldo10_reg>;
@@ -64,9 +63,8 @@
 	mmc@12220000 {
 		status = "okay";
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 		vmmc-supply = <&ldo19_reg>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 9a050e1..e9f5a6c 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -566,9 +566,8 @@
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <0 4>;
-	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-sdr-timing = <0 4 3>;
+	samsung,dw-mshc-ddr-timing = <0 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
@@ -580,9 +579,8 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 8be3d7b..140ea54 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -77,9 +77,8 @@
 		status = "okay";
 		broken-cd;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <0 4>;
-		samsung,dw-mshc-ddr-timing = <0 2>;
+		samsung,dw-mshc-sdr-timing = <0 4 3>;
+		samsung,dw-mshc-ddr-timing = <0 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 		bus-width = <8>;
@@ -89,9 +88,8 @@
 	mmc@12220000 {
 		status = "okay";
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 		bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index e8fdda8..9a4875b 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -554,9 +554,8 @@
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <0 4>;
-	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-sdr-timing = <0 4 3>;
+	samsung,dw-mshc-ddr-timing = <0 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
@@ -568,9 +567,8 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3 3>;
+	samsung,dw-mshc-ddr-timing = <1 2 3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	bus-width = <4>;
-- 
1.7.9.5
