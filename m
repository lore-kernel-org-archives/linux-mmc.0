From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 09/14] MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
Date: Sun,  2 Apr 2017 22:42:39 +0200
Message-ID: <20170402204244.14216-10-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170402204244.14216-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

We set the pin configuration for the jz4780-nand and jz4780-uart
drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

 v2: Changed the devicetree bindings to match the new driver
 v3: No changes
 v4: No changes

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 1652d8d60b1e..fd138d9978c1 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -29,18 +29,30 @@
 
 &uart0 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0>;
 };
 
 &uart1 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart1>;
 };
 
 &uart3 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart2>;
 };
 
 &uart4 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart4>;
 };
 
 &nemc {
@@ -61,6 +73,13 @@
 		ingenic,nemc-tAW = <15>;
 		ingenic,nemc-tSTRV = <100>;
 
+		/*
+		 * Only CLE/ALE are needed for the devices that are connected, rather
+		 * than the full address line set.
+		 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc>;
+
 		nand@1 {
 			reg = <1>;
 
@@ -69,6 +88,9 @@
 			nand-ecc-mode = "hw";
 			nand-on-flash-bbt;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pins_nemc_cs1>;
+
 			partitions {
 				compatible = "fixed-partitions";
 				#address-cells = <2>;
@@ -106,3 +128,41 @@
 &bch {
 	status = "okay";
 };
+
+&pinctrl {
+	pins_uart0: uart0 {
+		function = "uart0";
+		groups = "uart0-data";
+		bias-disable;
+	};
+
+	pins_uart1: uart1 {
+		function = "uart1";
+		groups = "uart1-data";
+		bias-disable;
+	};
+
+	pins_uart2: uart2 {
+		function = "uart2";
+		groups = "uart2-data", "uart2-hwflow";
+		bias-disable;
+	};
+
+	pins_uart4: uart4 {
+		function = "uart4";
+		groups = "uart4-data";
+		bias-disable;
+	};
+
+	pins_nemc: nemc {
+		function = "nemc";
+		groups = "nemc-data", "nemc-cle-ale", "nemc-rd-we", "nemc-frd-fwe";
+		bias-disable;
+	};
+
+	pins_nemc_cs1: nemc-cs1 {
+		function = "nemc-cs1";
+		groups = "nemc-cs1";
+		bias-disable;
+	};
+};
-- 
2.11.0
