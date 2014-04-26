From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v9 17/17] ARM: dts: sun7i: Add basic support for
 the Cubietruck WiFi module
Date: Sat, 26 Apr 2014 12:16:21 +0200
Message-ID: <1398507381-5614-18-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBLMP52NAKGQEWGQKIOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1398507381-5614-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
The IC also takes a power enable signal via GPIO.

The WiFi module supports out-of-band interrupt signaling via GPIO,
but this is not supported in this patch.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 2a7b0dd..270bac0 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -29,6 +29,14 @@
 			status = "okay";
 		};
 
+		mmc3: mmc@01c12000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc3_pins_a>;
+			vmmc-supply = <&reg_vmmc3>;
+			non-removable;
+			status = "okay";
+		};
+
 		usbphy: phy@01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
@@ -57,6 +65,18 @@
 		};
 
 		pinctrl@01c20800 {
+			mmc3_pins_a: mmc3@0 {
+				/* AP6210 requires pull-up */
+				allwinner,pull = <1>;
+			};
+
+			vmmc3_pin_cubietruck: vmmc3_pin@0 {
+				allwinner,pins = "PH9";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 {
 				allwinner,pins = "PH12";
 				allwinner,function = "gpio_out";
@@ -148,4 +168,15 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_vmmc3: vmmc3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc3_pin_cubietruck>;
+		regulator-name = "vmmc3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 9 0>;
+	};
 };
-- 
1.9.0
