From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v3 5/5] ARM: dts: add supports-idmac property
Date: Wed,  5 Aug 2015 16:18:50 +0800
Message-ID: <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>, Govindraj Raja <govind>
List-Id: linux-mmc@vger.kernel.org

DesignWare MMC Controller's transfer mode should be decided
at runtime instead of compile-time. Add "supports-idmac" for
all platforms that use internal dma mode to enable this feature
at runtime.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/exynos3250-monk.dts              | 1 +
 arch/arm/boot/dts/exynos3250-rinato.dts            | 1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 1 +
 arch/arm/boot/dts/exynos4412-origen.dts            | 1 +
 arch/arm/boot/dts/exynos4412-trats2.dts            | 1 +
 arch/arm/boot/dts/exynos4x12.dtsi                  | 1 +
 arch/arm/boot/dts/exynos5250-arndale.dts           | 2 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          | 2 ++
 arch/arm/boot/dts/exynos5250-snow.dts              | 3 +++
 arch/arm/boot/dts/exynos5250-spring.dts            | 2 ++
 arch/arm/boot/dts/exynos5260-xyref5260.dts         | 2 ++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          | 2 ++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 2 ++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 3 +++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 2 ++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 3 +++
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  | 2 ++
 arch/arm/boot/dts/rk3288-evb.dtsi                  | 2 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 3 +++
 arch/arm/boot/dts/rk3288-popmetal.dts              | 2 ++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    | 2 ++
 22 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index a5863ac..7bc707d 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -414,6 +414,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
+	supports-idmac;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 031853b..5a14c92 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -591,6 +591,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
+	supports-idmac;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ca7d168..ff0657a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -473,6 +473,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 84c7631..6639d74 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -483,6 +483,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index afc199d..2edac0b 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -891,6 +891,7 @@
 	status = "okay";
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &pmu_system_controller {
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index b77dac61..f6d3d50 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -204,6 +204,7 @@
 		fifo-depth = <0x80>;
 		clocks = <&clock CLK_SDMMC4>, <&clock CLK_SCLK_MMC4>;
 		clock-names = "biu", "ciu";
+		supports-idmac;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7e728a1..e2fc6ed 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -531,6 +531,7 @@
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -546,6 +547,7 @@
 	bus-width = <4>;
 	disable-wp;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 4fe186d..2bf8d86 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -357,6 +357,7 @@
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -371,6 +372,7 @@
 	bus-width = <4>;
 	disable-wp;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b7f4122..bee1181 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -540,6 +540,7 @@
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -554,6 +555,7 @@
 	bus-width = <4>;
 	wp-gpios = <&gpc2 1 GPIO_ACTIVE_HIGH>;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 /*
@@ -574,6 +576,7 @@
 	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4 &wifi_en &wifi_rst>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	supports-idmac;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index d03f9b8..5b6fdf3 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -439,6 +439,7 @@
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 /*
@@ -457,6 +458,7 @@
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 3daef94..061f0af 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -78,6 +78,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -92,4 +93,5 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	disable-wp;
+	supports-idmac;
 };
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index be3e025..e208ef3 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -47,6 +47,7 @@
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	bus-width = <8>;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -59,6 +60,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	bus-width = <4>;
 	disable-wp;
+	supports-idmac;
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index eeb4ac2..6134efa 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -360,6 +360,7 @@
 	vmmc-supply = <&ldo10_reg>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -374,6 +375,7 @@
 	vqmmc-supply = <&ldo13_reg>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8f4d76c..1ea4898 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -704,6 +704,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
+	supports-idmac;
 };
 
 &mmc_1 {
@@ -724,6 +725,7 @@
 	cap-sd-highspeed;
 	mmc-pwrseq = <&mmc1_pwrseq>;
 	vqmmc-supply = <&buck10_reg>;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -738,6 +740,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
+	supports-idmac;
 };
 
 
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 98871f9..06b353a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -371,6 +371,7 @@
 		     &sd0_rclk>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -383,6 +384,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 8adf455..05e1324 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -413,6 +413,7 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -425,6 +426,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	supports-idmac;
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7d5b386..1c1f4f1 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -667,6 +667,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_rclk>;
 	bus-width = <8>;
+	supports-idmac;
 };
 
 &mmc_1 {
@@ -687,6 +688,7 @@
 	cap-sd-highspeed;
 	mmc-pwrseq = <&mmc1_pwrseq>;
 	vqmmc-supply = <&buck10_reg>;
+	supports-idmac;
 };
 
 &mmc_2 {
@@ -701,6 +703,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
+	supports-idmac;
 };
 
 
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index c52722b..e7ce31d 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -424,6 +424,7 @@
 			clocks = <&clock HIX5HD2_MMC_CIU_RST>,
 				 <&clock HIX5HD2_MMC_BIU_CLK>;
 			clock-names = "ciu", "biu";
+			supports-idmac;
 		};
 
 		sd: mmc@1820000 {
@@ -433,6 +434,7 @@
 			clocks = <&clock HIX5HD2_SD_CIU_RST>,
 				 <&clock HIX5HD2_SD_BIU_CLK>;
 			clock-names = "ciu","biu";
+			supports-idmac;
 		};
 
 		gmac0: ethernet@1840000 {
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 844a6fb..c15d976 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -165,6 +165,7 @@
 	cap-mmc-highspeed;
 	disable-wp;
 	non-removable;
+	supports-idmac;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
@@ -182,6 +183,7 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	disable-wp;			/* wp not hooked up */
+	supports-idmac;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0b42372..286212b 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -170,6 +170,7 @@
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	disable-wp;
+	supports-idmac;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
@@ -439,6 +440,7 @@
 	bus-width = <4>;
 	disable-wp;
 	non-removable;
+	supports-idmac;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
@@ -452,6 +454,7 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	disable-wp;
+	supports-idmac;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index d582811..e39b975 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -104,6 +104,7 @@
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	disable-wp;
+	supports-idmac;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
@@ -117,6 +118,7 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	disable-wp;                     /* wp not hooked up */
+	supports-idmac;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 5424cc4..399e4d9 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -58,6 +58,7 @@
 	broken-cd;
 	cap-mmc-highspeed;
 	non-removable;
+	supports-idmac;
 	card-detect-delay = <200>;
 	clock-frequency = <800000000>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -81,4 +82,5 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	disable-wp;
+	supports-idmac;
 };
-- 
2.3.7
