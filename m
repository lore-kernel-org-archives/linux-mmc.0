From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v11 3/6] ARM: dts: sun4i: Add reg_vmmc0 to sun4i boards
Date: Sat, 10 May 2014 11:34:00 +0200
Message-ID: <1399714443-12459-4-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBGXFW6NQKGQE7G265SQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 arch/arm/boot/dts/sun4i-a10-a1000.dts          | 5 +++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts     | 5 +++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts      | 5 +++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts      | 5 +++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts     | 5 +++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 5 +++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts        | 5 +++++
 7 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 93af306..ec0c98b 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -39,6 +39,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -127,6 +128,10 @@
 		gpio = <&pio 7 15 0>;
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 8581385..f5e2235 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -37,6 +37,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -119,6 +120,10 @@
 		status = "okay";
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 9dc7b1c..d5741a4 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -39,6 +39,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -102,6 +103,10 @@
 		gpio = <&pio 7 19 0>;
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 297b8f6..3529545 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -27,6 +27,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -68,6 +69,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index b7a4218..2c44ddc 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -58,6 +59,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 4b7fd04..afb0d5a 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -36,6 +36,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -110,6 +111,10 @@
 		status = "okay";
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 4d9c3cd..1c1261e 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -37,6 +37,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -78,6 +79,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
-- 
1.9.0
