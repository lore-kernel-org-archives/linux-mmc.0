From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/4] ARM: dts: exynos: unuse the slot-node and deprecated the
 supports-highspeed for dw-mmc
Date: Mon, 30 Jun 2014 16:22:29 +0900
Message-ID: <1404112951-29467-3-git-send-email-jh80.chung@samsung.com>
References: <1404112951-29467-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59359 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaF3HWk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jun 2014 03:22:40 -0400
In-reply-to: <1404112951-29467-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

dw-mmc controller can support multiple slots.
But, there are no use-cases anywhere. So we don't need to support the
slot-node for dw-mmc controller.
And "supports-highspeed" property in dw-mmc is deprecated.
"supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts      |    8 ++------
 arch/arm/boot/dts/exynos4412-origen.dts       |    8 ++------
 arch/arm/boot/dts/exynos4412-trats2.dts       |    8 ++------
 arch/arm/boot/dts/exynos5250-arndale.dts      |   18 +++++------------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |   26 +++++++------------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |   18 +++++------------
 arch/arm/boot/dts/exynos5250-snow.dts         |    6 ++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts    |   18 +++++------------
 arch/arm/boot/dts/exynos5410-smdk5410.dts     |   18 +++++------------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   16 ++++-----------
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   16 ++++-----------
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   16 ++++-----------
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   16 ++++-----------
 13 files changed, 51 insertions(+), 141 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 31db28a..778aec6 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -45,17 +45,13 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	regulator_p3v3 {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e925c9f..de15114 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -137,17 +137,13 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	codec@13400000 {
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 7787844..65ab885 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -520,7 +520,6 @@
 
 	mmc@12550000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		non-removable;
 		card-detect-delay = <200>;
@@ -532,11 +531,8 @@
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		status = "okay";
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	serial@13800000 {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index d0de1f5..42a3590 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -401,7 +401,6 @@
 	mmc_0: mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -410,17 +409,13 @@
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc_2: mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
@@ -428,12 +423,9 @@
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
+		bus-width = <4>;
+		disable-wp;
+		cap-sd-highspeed;
 	};
 
 	i2s0: i2s@03830000 {
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 89ac90f..af51361 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -248,7 +248,6 @@
 
 	mmc@12200000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -256,44 +255,33 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			wp-gpios = <&gpc2 1 0>;
-		};
+		bus-width = <4>;
+		wp-gpios = <&gpc2 1 0>;
+		cap-sd-highspeed;
 	};
 
 	mmc@12230000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		/* See board-specific dts files for pin setup */
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <4>;
+		cap-sd-highspeed;
 	};
 
 	spi_1: spi@12d30000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..e00ffc6 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -282,7 +282,6 @@
 	mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -290,29 +289,22 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
+		bus-width = <4>;
+		disable-wp;
+		cap-sd-highspeed;
 	};
 
 	spi_1: spi@12d30000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 7bd2df1..fb66005 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -240,10 +240,8 @@
 	 */
 	mmc@12230000 {
 		status = "okay";
-		slot@0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
 	};
 
 	i2c@12CD0000 {
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 8c84ab2..a803b60 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -69,7 +69,7 @@
 	num-slots = <1>;
 	broken-cd;
 	bypass-smu;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	supports-hs200-mode; /* 200 Mhz */
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -77,27 +77,19 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 7275bbd..be3e025 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -40,33 +40,25 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 434fd9d..5f37b81 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -50,7 +50,6 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
@@ -58,16 +57,12 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 		vmmc-supply = <&ldo10_reg>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
@@ -75,11 +70,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 		vmmc-supply = <&ldo10_reg>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	hsi2c_4: i2c@12CA0000 {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 7649982..76484a6 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -174,7 +174,7 @@
 	num-slots = <1>;
 	broken-cd;
 	caps2-mmc-hs200-1_8v;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
@@ -183,17 +183,13 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -201,11 +197,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
+	bus-width = <4>;
 };
 
 
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6052aa9..8be3d7b 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -76,34 +76,26 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
 		samsung,dw-mshc-ddr-timing = <0 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <4>;
+		cap-sd-highspeed;
 	};
 
 	dp-controller@145B0000 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 2c2c137..3c52a81 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -172,7 +172,7 @@
 	num-slots = <1>;
 	broken-cd;
 	caps2-mmc-hs200-1_8v;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
@@ -181,17 +181,13 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -199,11 +195,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
+	bus-width = <4>;
 };
 
 
-- 
1.7.9.5

