From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v10 08/15] ARM: dts: sun5i: Enable mmc
 controller on various A10s and A13 boards
Date: Fri,  2 May 2014 17:57:22 +0200
Message-ID: <1399046249-19472-9-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBCUBR6NQKGQE5NT4KFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The cd pin settings have been taken from the original firmware fex files,
and have been confirmed to work on the actual boards.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 32 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 16 ++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 16 ++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 23611b7..de91308 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -35,6 +35,24 @@
 			};
 		};
 
+		mmc0: mmc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 1 0>; /* PG1 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		mmc1: mmc@01c10000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 13 0>; /* PG13 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy@01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			status = "okay";
@@ -49,6 +67,20 @@
 		};
 
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin@0 {
+				allwinner,pins = "PG1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			mmc1_cd_pin_olinuxino_micro: mmc1_cd_pin@0 {
+				allwinner,pins = "PG13";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PE3";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 11169d5..8515f19 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -21,6 +21,15 @@
 	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
 
 	soc@01c00000 {
+		mmc0: mmc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy@01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			status = "okay";
@@ -35,6 +44,13 @@
 		};
 
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxinom: mmc0_cd_pin@0 {
+				allwinner,pins = "PG0";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			led_pins_olinuxinom: led_pins@0 {
 				allwinner,pins = "PG9";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 7a9187b..51a9438 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -20,6 +20,15 @@
 	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
 	soc@01c00000 {
+		mmc0: mmc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy@01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			status = "okay";
@@ -34,6 +43,13 @@
 		};
 
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxino: mmc0_cd_pin@0 {
+				allwinner,pins = "PG0";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PG9";
 				allwinner,function = "gpio_out";
-- 
1.9.0
