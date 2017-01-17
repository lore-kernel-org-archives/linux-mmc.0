From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 05/13] MIPS: jz4740: DTS: Add node for the jz4740-pinctrl driver
Date: Wed, 18 Jan 2017 00:14:13 +0100
Message-ID: <20170117231421.16310-6-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

For a description of the devicetree node, please read
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 275 +++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 3e1587f1f77a..c014a7159a2a 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -55,6 +55,281 @@
 		clock-names = "rtc";
 	};
 
+	pinctrl: ingenic-pinctrl@10010000 {
+		compatible = "ingenic,jz4740-pinctrl";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio-chips {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gpa: gpa {
+				reg = <0x10010000 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <28>;
+
+				ingenic,pull-ups = <0xffffffff>;
+			};
+
+			gpb: gpb {
+				reg = <0x10010100 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <27>;
+
+				ingenic,pull-ups = <0xffffffff>;
+			};
+
+			gpc: gpc {
+				reg = <0x10010200 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <26>;
+
+				ingenic,pull-ups = <0xffffffff>;
+			};
+
+			gpd: gpd {
+				reg = <0x10010300 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <25>;
+
+				ingenic,pull-ups = <0xdfffffff>;
+			};
+		};
+
+		bias-configs {
+			nobias: pincfg-nobias {
+				bias-disable;
+			};
+
+			pull_up: pincfg-pull-up {
+				bias-pull-up;
+			};
+
+			pull_down: pincfg-pull-down {
+				bias-pull-down;
+			};
+		};
+
+		functions {
+			pinfunc-msc {
+				pins_msc_4bit: pins-msc-4bit {
+					ingenic,pins = <&gpd 8 0 &nobias
+							&gpa 9 0 &nobias
+							&gpa 10 0 &nobias
+							&gpa 11 0 &nobias
+							&gpa 12 0 &nobias
+							&gpa 13 0 &nobias>;
+				};
+			};
+
+			pinfunc-uart0 {
+				pins_uart0_data: pins-uart0-data {
+					ingenic,pins = <&gpd 26 1 &pull_up  /* rxd */
+							&gpd 25 1 &nobias>; /* txd */
+				};
+
+				pins_uart0_dataplusflow: uart0-dataplusflow {
+					ingenic,pins = <&gpd 26 1 &pull_up  /* rxd */
+							&gpd 25 1 &nobias   /* txd */
+							&gpd 31 0 &nobias   /* rts */
+							&gpd 30 0 &nobias>; /* cts */
+				};
+			};
+
+			pinfunc-uart1 {
+				pins_uart1_data: uart1-data {
+					ingenic,pins = <&gpd 30 2 &pull_up   /* rxd */
+							&gpd 31 2 &nobias>;  /* txd */
+				};
+			};
+
+			pinfunc-lcd {
+				pins_lcd_8bit: pins-lcd-8bit {
+					ingenic,pins = <&gpc  0 0 &nobias	/* LCD_DATA0 */
+							&gpc  1 0 &nobias
+							&gpc  2 0 &nobias
+							&gpc  3 0 &nobias
+							&gpc  4 0 &nobias
+							&gpc  5 0 &nobias
+							&gpc  6 0 &nobias
+							&gpc  7 0 &nobias	/* LCD_DATA7 */
+							&gpc 18 0 &nobias	/* PCLK */
+							&gpc 19 0 &nobias	/* HSYNC */
+							&gpc 20 0 &nobias>;	/* VSYNC */
+				};
+
+				pins_lcd_16bit: pins-lcd-16bit {
+					ingenic,pins = <&gpc  0 0 &nobias	/* LCD_DATA0 */
+							&gpc  1 0 &nobias
+							&gpc  2 0 &nobias
+							&gpc  3 0 &nobias
+							&gpc  4 0 &nobias
+							&gpc  5 0 &nobias
+							&gpc  6 0 &nobias
+							&gpc  7 0 &nobias
+							&gpc  8 0 &nobias
+							&gpc  9 0 &nobias
+							&gpc 10 0 &nobias
+							&gpc 11 0 &nobias
+							&gpc 12 0 &nobias
+							&gpc 13 0 &nobias
+							&gpc 14 0 &nobias
+							&gpc 15 0 &nobias	/* LCD_DATA15 */
+							&gpc 18 0 &nobias	/* PCLK */
+							&gpc 19 0 &nobias	/* HSYNC */
+							&gpc 20 0 &nobias	/* VSYNC */
+							&gpc 21 0 &nobias>;	/* DE */
+				};
+
+				pins_lcd_18bit: pins-lcd-18bit {
+					ingenic,pins = <&gpc  0 0 &nobias	/* LCD_DATA0 */
+							&gpc  1 0 &nobias
+							&gpc  2 0 &nobias
+							&gpc  3 0 &nobias
+							&gpc  4 0 &nobias
+							&gpc  5 0 &nobias
+							&gpc  6 0 &nobias
+							&gpc  7 0 &nobias
+							&gpc  8 0 &nobias
+							&gpc  9 0 &nobias
+							&gpc 10 0 &nobias
+							&gpc 11 0 &nobias
+							&gpc 12 0 &nobias
+							&gpc 13 0 &nobias
+							&gpc 14 0 &nobias
+							&gpc 15 0 &nobias
+							&gpc 16 0 &nobias
+							&gpc 17 0 &nobias	/* LCD_DATA17 */
+							&gpc 18 0 &nobias	/* PCLK */
+							&gpc 19 0 &nobias	/* HSYNC */
+							&gpc 20 0 &nobias	/* VSYNC */
+							&gpc 21 0 &nobias>;	/* DE */
+				};
+
+				pins_lcd_special_tft: pins-lcd-special-tft {
+					ingenic,pins = <&gpc  0 0 &nobias	/* LCD_DATA0 */
+							&gpc  1 0 &nobias
+							&gpc  2 0 &nobias
+							&gpc  3 0 &nobias
+							&gpc  4 0 &nobias
+							&gpc  5 0 &nobias
+							&gpc  6 0 &nobias
+							&gpc  7 0 &nobias
+							&gpc  8 0 &nobias
+							&gpc  9 0 &nobias
+							&gpc 10 0 &nobias
+							&gpc 11 0 &nobias
+							&gpc 12 0 &nobias
+							&gpc 13 0 &nobias
+							&gpc 14 0 &nobias
+							&gpc 15 0 &nobias
+							&gpc 16 0 &nobias
+							&gpc 17 0 &nobias	/* LCD_DATA17 */
+							&gpc 18 0 &nobias	/* PCLK */
+							&gpc 19 0 &nobias	/* HSYNC */
+							&gpc 20 0 &nobias	/* VSYNC */
+							&gpc 21 0 &nobias	/* DE */
+							&gpc 22 0 &nobias	/* PS */
+							&gpc 23 0 &nobias	/* REV */
+							&gpb 17 0 &nobias	/* CLS */
+							&gpb 18 0 &nobias>;	/* SPL */
+				};
+
+				pinfunc_lcd_nopins: pins-lcd-no-pins {
+					ingenic,pins = <>;
+				};
+			};
+
+			pinfunc-nand {
+				pins_nand: pins-nand {
+					ingenic,pins = <&gpb 25 0 &nobias
+							&gpb 26 0 &nobias
+							&gpb 27 0 &nobias
+							&gpb 28 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm0 {
+				pins_pwm0: pins-pwm0 {
+					ingenic,pins = <&gpd 23 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm1 {
+				pins_pwm1: pins-pwm1 {
+					ingenic,pins = <&gpd 24 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm2 {
+				pins_pwm2: pins-pwm2 {
+					ingenic,pins = <&gpd 25 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm3 {
+				pins_pwm3: pins-pwm3 {
+					ingenic,pins = <&gpd 26 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm4 {
+				pins_pwm4: pins-pwm4 {
+					ingenic,pins = <&gpd 27 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm5 {
+				pins_pwm5: pins-pwm5 {
+					ingenic,pins = <&gpd 28 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm6 {
+				pins_pwm6: pins-pwm6 {
+					ingenic,pins = <&gpd 30 0 &nobias>;
+				};
+			};
+
+			pinfunc-pwm7 {
+				pins_pwm7: pins-pwm7 {
+					ingenic,pins = <&gpd 31 0 &nobias>;
+				};
+			};
+		};
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
