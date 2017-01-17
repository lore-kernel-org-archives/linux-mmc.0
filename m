From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 08/13] MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
Date: Wed, 18 Jan 2017 00:14:16 +0100
Message-ID: <20170117231421.16310-9-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

We set the pin configuration for the jz4780-nand and jz4780-uart
drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 1652d8d60b1e..e2cd3ebb7be8 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -29,18 +29,30 @@
 
 &uart0 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0_data>;
 };
 
 &uart1 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart1_data>;
 };
 
 &uart3 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart2_dataplusflow>;
 };
 
 &uart4 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart4_data>;
 };
 
 &nemc {
@@ -61,6 +73,16 @@
 		ingenic,nemc-tAW = <15>;
 		ingenic,nemc-tSTRV = <100>;
 
+		/*
+		 * Only CLE/ALE are needed for the devices that are connected, rather
+		 * than the full address line set.
+		 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc_data
+				 &pins_nemc_cle_ale
+				 &pins_nemc_rd_we
+				 &pins_nemc_frd_fwe>;
+
 		nand@1 {
 			reg = <1>;
 
@@ -69,6 +91,9 @@
 			nand-ecc-mode = "hw";
 			nand-on-flash-bbt;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pins_nemc_cs1>;
+
 			partitions {
 				compatible = "fixed-partitions";
 				#address-cells = <2>;
-- 
2.11.0
