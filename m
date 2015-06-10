From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 5/7] ARM: mediatek: dts: Add emmc support to mt8135
Date: Wed, 10 Jun 2015 10:24:46 +0800
Message-ID: <1433903088-14407-6-git-send-email-chaotian.jing@mediatek.com>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1433903088-14407-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Add emmc node for mt8135.dtsi & mt8135-evbp1.dts

Signed-off-by: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/mt8135-evbp1.dts | 158 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |  55 +++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
index 357a91f..043d997 100644
--- a/arch/arm/boot/dts/mt8135-evbp1.dts
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -24,6 +24,164 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	vmmc-supply = <&mt6397_vemc_3v3_reg>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	vmmc-supply = <&mt6397_vmch_reg>;
+	vqmmc-supply = <&mt6397_vmc_reg>;
+	cd-gpios = <&pio 63 0>;
+	cap-sd-highspeed;
+	sd-uhs-sdr25;
+};
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_9_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8135_PIN_8_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8135_PIN_7_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8135_PIN_6_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8135_PIN_3_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8135_PIN_2_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8135_PIN_1_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8135_PIN_4_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins_rst {
+			pinmux = <MT8135_PIN_33_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				<MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				<MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				<MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				<MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down;
+		};
+
+		pins_insi {
+			pinmux = <MT8135_PIN_63_MSDC1_INSI__FUNC_MSDC1_INSI>;
+			bias-pull-up;
+		};
+	};
+
+	mmc2_pins_default: mmc2default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+				<MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+				<MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+				<MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+				<MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			bias-pull-down;
+		};
+
+		pins_insi {
+			pinmux = <MT8135_PIN_65_MSDC2_INSI__FUNC_MSDC2_INSI>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0@0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_9_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8135_PIN_8_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8135_PIN_7_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8135_PIN_6_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8135_PIN_3_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8135_PIN_2_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8135_PIN_1_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8135_PIN_4_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_rst {
+			pinmux = <MT8135_PIN_33_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1@0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				<MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				<MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				<MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				<MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+	};
+
+	mmc2_pins_uhs: mmc2@0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+				<MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+				<MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+				<MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+				<MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
 &pwrap {
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index fec0ac5..9cc42f0 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -78,6 +78,12 @@
 		compatible = "simple-bus";
 		ranges;
 
+		clk_null: clk_null {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
 		system_clk: dummy13m {
 			compatible = "fixed-clock";
 			clock-frequency = <13000000>;
@@ -241,5 +247,54 @@
 			status = "disabled";
 		};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11230000 0 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC20_1>,
+				 <&clk_null>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11240000 0 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC20_2>,
+				 <&clk_null>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc2: mmc@11250000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11250000 0 0x1000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_1>,
+				 <&clk_null>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc3: mmc@11260000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11260000 0 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_2>,
+				 <&clk_null>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc4: mmc@11270000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11270000 0 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_3>,
+				 <&clk_null>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.1.1.dirty
