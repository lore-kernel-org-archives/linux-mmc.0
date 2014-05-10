From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v11 4/6] ARM: dts: sun5i: Add reg_vmmc0 to sun5i boards
Date: Sat, 10 May 2014 11:34:01 +0200
Message-ID: <1399714443-12459-5-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBG7FW6NQKGQEH2JVF2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399714443-12459-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 5 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 5 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index de91308..cde617a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -38,6 +38,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 1 0>; /* PG1 */
 			cd-inverted;
@@ -152,6 +153,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
 		gpio = <&pio 1 10 0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 8515f19..3fdfb60 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -24,6 +24,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 0 0>; /* PG0 */
 			cd-inverted;
@@ -103,6 +104,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
 		gpio = <&pio 6 11 0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 51a9438..a4e22b9 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 0 0>; /* PG0 */
 			cd-inverted;
@@ -101,6 +102,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
 		gpio = <&pio 6 11 0>;
-- 
1.9.0
