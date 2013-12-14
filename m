From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5] ARM: dts: sun5i: Add new
 sun5i-a13-olinuxino-micro board
Date: Sat, 14 Dec 2013 22:58:13 +0100
Message-ID: <1387058295-20641-4-git-send-email-hdegoede@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBBFJWOKQKGQE5NI4WSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1387058295-20641-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts | 66 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..b663ed7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -255,6 +255,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-hackberry.dtb \
 	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a13-olinuxino.dtb \
+	sun5i-a13-olinuxino-micro.dtb \
 	sun6i-a31-colombus.dtb \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
new file mode 100644
index 0000000..26df7e8
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun5i-a13.dtsi"
+
+/ {
+	model = "Olimex A13-Olinuxino Micro";
+	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
+
+	soc@01c00000 {
+		pinctrl@01c20800 {
+			led_pins_olinuxinom: led_pins@0 {
+				allwinner,pins = "PG9";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		uart1: serial@01c28400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins_b>;
+			status = "okay";
+		};
+
+		i2c0: i2c@01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c@01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c@01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinom>;
+
+		power {
+			gpios = <&pio 6 9 0>;
+			default-state = "on";
+		};
+	};
+};
-- 
1.8.4.2
