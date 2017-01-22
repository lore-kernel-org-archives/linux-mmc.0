From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl and gpio drivers
Date: Sun, 22 Jan 2017 15:49:39 +0100
Message-ID: <20170122144947.16158-7-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

For a description of the pinctrl devicetree node, please read
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

For a description of the gpio devicetree nodes, please read
Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 194 +++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

v2: Changed the devicetree bindings to match the new driver

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 3e1587f1f77a..960e060eb725 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -55,6 +55,200 @@
 		clock-names = "rtc";
 	};
 
+	pinctrl: ingenic-pinctrl@10010000 {
+		compatible = "ingenic,jz4740-pinctrl";
+		reg = <0x10010000 0x400>;
+
+		ingenic,pull-ups   = <0xffffffff 0xffffffff 0xffffffff 0xdfffffff>;
+		ingenic,pull-downs = <0x00000000 0x00000000 0x00000000 0x00000000>;
+
+		functions {
+			mmc {
+				mmc-1bit {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x69 0 0x68 0 0x6a 0>;
+				};
+
+				mmc-4bit {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x6b 0 0x6c 0 0x6d 0>;
+				};
+			};
+
+			uart0 {
+				uart0-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x7a 1 0x79 1>;
+				};
+
+				uart0-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0x7e 1 0x7f 1>;
+				};
+			};
+
+			uart1 {
+				uart1-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x7e 2 0x7f 2>;
+				};
+			};
+
+			lcd {
+				lcd-8bit {
+					/* LCD_DATA0 ... LCD_DATA7, PCLK, HSYNC, VSYNC */
+					ingenic,pins = <0x40 0 0x41 0 0x42 0 0x43 0
+									0x44 0 0x45 0 0x46 0 0x47 0
+									0x52 0 0x53 0 0x54 0>;
+				};
+
+				lcd-16bit {
+					/* LCD_DATA8 ... LCD_DATA15, DE */
+					ingenic,pins = <0x48 0 0x49 0 0x4a 0 0x4b 0
+									0x4c 0 0x4d 0 0x4e 0 0x4f 0
+									0x55 0>;
+				};
+
+				lcd-18bit {
+					/* LCD_DATA16, LCD_DATA17 */
+					ingenic,pins = <0x50 0 0x51 0>;
+				};
+
+				lcd-18bit-tft {
+					/* PS, REV, CLS, SPL */
+					ingenic,pins = <0x56 0 0x57 0 0x31 0 0x32 0>;
+				};
+
+				lcd-no-pins {
+					ingenic,pins = <>;
+				};
+			};
+
+			nand {
+				nand {
+					/* CS1, CS2, CS3, CS4 */
+					ingenic,pins = <0x39 0 0x3a 0 0x3b 0 0x3c 0>;
+				};
+			};
+
+			pwm0 {
+				pwm0 {
+					ingenic,pins = <0x77 0>;
+				};
+			};
+
+			pwm1 {
+				pwm1 {
+					ingenic,pins = <0x78 0>;
+				};
+			};
+
+			pwm2 {
+				pwm2 {
+					ingenic,pins = <0x79 0>;
+				};
+			};
+
+			pwm3 {
+				pwm3 {
+					ingenic,pins = <0x7a 0>;
+				};
+			};
+
+			pwm4 {
+				pwm4 {
+					ingenic,pins = <0x7b 0>;
+				};
+			};
+
+			pwm5 {
+				pwm5 {
+					ingenic,pins = <0x7c 0>;
+				};
+			};
+
+			pwm6 {
+				pwm6 {
+					ingenic,pins = <0x7e 0>;
+				};
+			};
+
+			pwm7 {
+				pwm7 {
+					ingenic,pins = <0x7f 0>;
+				};
+			};
+		};
+	};
+
+	gpa: gpio-controller@10010000 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010000 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		base = <0x00>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
+
+	gpb: gpio-controller@10010100 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010100 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		#gpio-cells = <2>;
+
+		base = <0x20>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27>;
+	};
+
+	gpc: gpio-controller@10010200 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010200 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 64 32>;
+		#gpio-cells = <2>;
+
+		base = <0x40>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <26>;
+	};
+
+	gpd: gpio-controller@10010300 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010300 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 96 32>;
+		#gpio-cells = <2>;
+
+		base = <0x60>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <25>;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
