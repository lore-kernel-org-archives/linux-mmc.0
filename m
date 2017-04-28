From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: [PATCH v5 09/14] MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
Date: Fri, 28 Apr 2017 22:08:19 +0200
Message-ID: <20170428200824.10906-10-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170428200824.10906-1-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

We set the pin configuration for the jz4780-nand and jz4780-uart
drivers.

Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

 v2: Changed the devicetree bindings to match the new driver
 v3: No changes
 v4: No changes
 v5: No changes

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
