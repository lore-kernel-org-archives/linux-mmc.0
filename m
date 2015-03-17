From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 5/5] arm64: dts: mediatek: Add MT8173 MMC dts
Date: Tue, 17 Mar 2015 11:13:55 +0800
Message-ID: <1426562035-16709-6-git-send-email-chaotian.jing@mediatek.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1426562035-16709-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Add node mmc0 and mmc1

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 115 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  19 ++++-
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index b3c9e0f..dd40705 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -262,3 +262,118 @@
 		};
 	};
 };
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>,
+				<MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
+				bias-pull-up;
+		};
+		pins_clk {
+			pinmux =  <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
+				bias-pull-down;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+
+		pins_insert {
+			pinmux = <MT8173_PIN_132_I2S0_DATA1__FUNC_GPIO132>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0@0{
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>,
+				<MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1@0 {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
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
+	cap-sd-highspeed;
+	sd-uhs-sdr25;
+	cd-gpios = <&pio 132 0>;
+	vmmc-supply = <&mt6397_vmch_reg>;
+	vqmmc-supply = <&mt6397_vmc_reg>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b79267d..9bd78c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -247,7 +247,24 @@
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
-	};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8173-mmc","mediatek,mt8135-mmc";
+			reg = <0 0x11230000 0 0x108>;
+			interrupts = <0 71 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg PERI_MSDC30_0>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8173-mmc","mediatek,mt8135-mmc";
+			reg = <0 0x11240000 0 0x108>;
+			interrupts = <0 72 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg PERI_MSDC30_1>;
+			clock-names = "source";
+			status = "disabled";
+		};
+	};
 };
 
-- 
1.8.1.1.dirty
