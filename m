From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 06/13] MIPS: jz4780: DTS: Add node for the jz4780-pinctrl driver
Date: Wed, 18 Jan 2017 00:14:14 +0100
Message-ID: <20170117231421.16310-7-paul@crapouillou.net>
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
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 333 +++++++++++++++++++++++++++++++++
 1 file changed, 333 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b868b429add2..0135b2b0c6ad 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -44,6 +44,339 @@
 		#clock-cells = <1>;
 	};
 
+	pinctrl: ingenic-pinctrl@10010000 {
+		compatible = "ingenic,jz4780-pinctrl";
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
+				interrupts = <17>;
+
+				ingenic,pull-ups = <0x3fffffff>;
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
+				interrupts = <16>;
+
+				ingenic,pull-downs = <0x000f0c03>;
+				ingenic,pull-ups   = <0xfff0030c>;
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
+				interrupts = <15>;
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
+				interrupts = <14>;
+
+				ingenic,pull-downs = <0x0000b000>;
+				ingenic,pull-ups   = <0xffff4fff>;
+			};
+
+			gpe: gpe {
+				reg = <0x10010400 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <13>;
+
+				ingenic,pull-downs = <0x00000483>;
+				ingenic,pull-ups   = <0xfffffb7c>;
+			};
+
+			gpf: gpf {
+				reg = <0x10010500 0x100>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&intc>;
+				interrupts = <12>;
+
+				ingenic,pull-downs = <0x00580ff0>;
+				ingenic,pull-ups   = <0xffa7f00f>;
+			};
+		};
+
+		bias-configs {
+			nobias: nobias {
+				bias-disable;
+			};
+
+			pull_up: pull_up {
+				bias-pull-up;
+			};
+
+			pull_down: pull_down {
+				bias-pull-down;
+			};
+		};
+
+		functions {
+			pinfunc-uart0 {
+				pins_uart0_data: uart0-data {
+					ingenic,pins = <&gpf  0 0 &pull_up  /* rxd */
+							&gpf  3 0 &nobias>; /* txd */
+				};
+
+				pins_uart0_dataplusflow: uart0-dataplusflow {
+					ingenic,pins = <&gpf  0 0 &pull_up  /* rxd */
+							&gpf  1 0 &nobias   /* cts */
+							&gpf  2 0 &nobias   /* rts */
+							&gpf  3 0 &nobias>; /* txd */
+				};
+			};
+
+			pinfunc-uart1 {
+				pins_uart1_data: uart1-data {
+					ingenic,pins = <&gpd  26 0 &pull_up  /* rxd */
+							&gpd  28 0 &nobias>; /* txd */
+				};
+
+				pins_uart1_dataplusflow: uart1-dataplusflow {
+					ingenic,pins = <&gpd  26 0 &pull_up  /* rxd */
+							&gpd  27 0 &nobias   /* cts */
+							&gpd  29 0 &nobias   /* rts */
+							&gpd  28 0 &nobias>; /* txd */
+				};
+			};
+
+			pinfunc-uart2 {
+				pins_uart2_data: uart2-data {
+					ingenic,pins = <&gpd  6 1 &nobias  /* rxd */
+							&gpd  7 1 &nobias>; /* txd */
+				};
+
+				pins_uart2_dataplusflow: uart2-dataplusflow {
+					ingenic,pins = <&gpd  6 1 &nobias  /* rxd */
+							&gpd  5 1 &nobias   /* cts */
+							&gpd  4 1 &nobias   /* rts */
+							&gpd  7 1 &nobias>; /* txd */
+				};
+			};
+
+			pinfunc-uart3 {
+				pins_uart3_data: uart3-data {
+					ingenic,pins = <&gpd 12 0 &pull_down /* rxd */
+							&gpe  5 1 &nobias>;  /* txd */
+				};
+
+				pins_uart3_dataplusflow: uart3-dataplusflow {
+					ingenic,pins = <&gpd 12 0 &pull_down /* rxd */
+							&gpe  5 1 &nobias    /* txd */
+							&gpe  8 0 &nobias    /* cts */
+							&gpe  9 0 &nobias>;  /* rts */
+				};
+			};
+
+			pinfunc-uart4 {
+				pins_uart4_data: uart4-data {
+					ingenic,pins = <&gpc 20 2 &pull_up   /* rxd */
+							&gpc 10 2 &nobias>;  /* txd */
+				};
+			};
+
+			pinfunc-msc0 {
+				pins_msc0_pa: msc0-pa {
+					ingenic,pins = <&gpa  4 1 &nobias   /* d4 */
+							&gpa  5 1 &nobias   /* d5 */
+							&gpa  6 1 &nobias   /* d6 */
+							&gpa  7 1 &nobias   /* d7 */
+							&gpa 18 1 &nobias   /* clk */
+							&gpa 19 1 &nobias   /* cmd */
+							&gpa 20 1 &nobias   /* d0 */
+							&gpa 21 1 &nobias   /* d1 */
+							&gpa 22 1 &nobias   /* d2 */
+							&gpa 23 1 &nobias   /* d3 */
+							&gpa 24 1 &nobias>; /* rst */
+				};
+
+				pins_msc0_pe: msc0-pe {
+					ingenic,pins = <&gpe 20 0 &nobias   /* d0 */
+							&gpe 21 0 &nobias   /* d1 */
+							&gpe 22 0 &nobias   /* d2 */
+							&gpe 23 0 &nobias   /* d3 */
+							&gpe 28 0 &nobias   /* clk */
+							&gpe 29 0 &nobias>; /* cmd */
+				};
+			};
+
+			pinfunc-msc1 {
+				pins_msc1_pd: msc1-pd {
+					ingenic,pins = <&gpd 20 0 &nobias   /* d0 */
+							&gpd 21 0 &nobias   /* d1 */
+							&gpd 22 0 &nobias   /* d2 */
+							&gpd 23 0 &nobias   /* d3 */
+							&gpd 24 0 &nobias   /* clk */
+							&gpd 25 0 &nobias>; /* cmd */
+				};
+
+				pins_msc1_pe: msc1-pe {
+					ingenic,pins = <&gpe 20 1 &nobias   /* d0 */
+							&gpe 21 1 &nobias   /* d1 */
+							&gpe 22 1 &nobias   /* d2 */
+							&gpe 23 1 &nobias   /* d3 */
+							&gpe 28 1 &nobias   /* clk */
+							&gpe 29 1 &nobias>; /* cmd */
+				};
+			};
+
+			pinfunc-nemc {
+				pins_nemc_data: nemc-data {
+					ingenic,pins = <&gpa 0 0 &nobias    /* sd0 */
+							&gpa 1 0 &nobias    /* sd1 */
+							&gpa 2 0 &nobias    /* sd2 */
+							&gpa 3 0 &nobias    /* sd3 */
+							&gpa 4 0 &nobias    /* sd4 */
+							&gpa 5 0 &nobias    /* sd5 */
+							&gpa 6 0 &nobias    /* sd6 */
+							&gpa 7 0 &nobias>;  /* sd7 */
+				};
+
+				pins_nemc_cle_ale: nemc-cle-ale {
+					ingenic,pins = <&gpb 0 0 &nobias    /* sa0_cl */
+							&gpb 1 0 &nobias>;  /* sa1_al */
+				};
+
+				pins_nemc_addr: nemc-addr {
+					ingenic,pins = <&gpb 0 0 &nobias    /* sa0_cl */
+							&gpb 1 0 &nobias    /* sa1_al */
+							&gpb 2 0 &nobias    /* sa2 */
+							&gpb 3 0 &nobias    /* sa3 */
+							&gpb 4 0 &nobias    /* sa4 */
+							&gpb 5 0 &nobias>;  /* sa5 */
+				};
+
+				pins_nemc_rd_we: nemc-rd-we {
+					ingenic,pins = <&gpa 16 0 &nobias   /* rd */
+							&gpa 17 0 &nobias>; /* we */
+				};
+
+				pins_nemc_frd_fwe: nemc-frd-fwe {
+					ingenic,pins = <&gpa 18 0 &nobias   /* rd */
+							&gpa 19 0 &nobias>; /* we */
+				};
+
+				pins_nemc_cs1: nemc-cs1 {
+					ingenic,pins = <&gpa 21 0 &nobias>; /* cs1 */
+				};
+
+				pins_nemc_cs6: nemc-cs6 {
+					ingenic,pins = <&gpa 26 0 &nobias>; /* cs6 */
+				};
+			};
+
+			pinfunc-i2c0 {
+				pins_i2c0_data: i2c0-data{
+					ingenic,pins = <&gpd  30 0 &nobias  /* sda */
+							&gpd  31 0 &nobias>; /* sck */
+				};
+			};
+
+			pinfunc-i2c1 {
+				pins_i2c1_data: i2c1-data{
+					ingenic,pins = <&gpe  30 0 &nobias  /* sda */
+							&gpe  31 0 &nobias>; /* sck */
+				};
+			};
+
+			pinfunc-i2c2 {
+				pins_i2c2_data: i2c2-data{
+					ingenic,pins = <&gpf  16 2 &nobias  /* sda */
+							&gpf  17 2 &nobias>; /* sck */
+				};
+			};
+
+			pinfunc-i2c3 {
+				pins_i2c3_data: i2c3-data{
+					ingenic,pins = <&gpd  10 1 &nobias  /* sda */
+							&gpd  11 1 &nobias>; /* sck */
+				};
+			};
+
+			pinfunc-i2c4 {
+				pins_i2c4_data: i2c4-data-pe{
+					ingenic,pins = <&gpe  12 1 &nobias  /* sda */
+							&gpe  13 1 &nobias>; /* sck */
+				};
+
+				pins_i2c4_data_pf: i2c4-data-pf{
+					ingenic,pins = <&gpf 25 1 &nobias /* hdmi_sda */
+							&gpf 24 1 &nobias>; /* hdmi_sck */
+				};
+			};
+
+			pinfunc-cim {
+				pins_cim: cim-pb {
+					ingenic,pins = <&gpb   6 0 &nobias
+							&gpb   7 0 &nobias
+							&gpb   8 0 &nobias
+							&gpb   9 0 &nobias
+							&gpb  10 0 &nobias
+							&gpb  11 0 &nobias
+							&gpb  12 0 &nobias
+							&gpb  13 0 &nobias
+							&gpb  14 0 &nobias
+							&gpb  15 0 &nobias
+							&gpb  16 0 &nobias
+							&gpb  17 0 &nobias>;
+				};
+			};
+		};
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
