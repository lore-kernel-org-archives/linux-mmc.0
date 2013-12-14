From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: sun7i: Add support for mmc
Date: Sat, 14 Dec 2013 22:58:15 +0100
Message-ID: <1387058295-20641-6-git-send-email-hdegoede@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBCNJWOKQKGQETDNZRVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 16 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 16 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 32 +++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 34 +++++++++++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..6aef299 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -34,7 +34,23 @@
 			};
 		};
 
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_cubieboard2>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_cubieboard2: mmc0_cd_pin@0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubieboard2: led_pins@0 {
 				allwinner,pins = "PH20", "PH21";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8a1009d..302c785 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -19,7 +19,23 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc@01c00000 {
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_cubietruck>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_cubietruck: mmc0_cd_pin@0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubietruck: led_pins@0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index ead3013..f271db9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -34,7 +34,39 @@
 			};
 		};
 
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_olinuxinom>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
+		sdc3: sdc@01c12000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc3_pins_a>;
+			pinctrl-1 = <&mmc3_cd_pin_olinuxinom>;
+			cd-gpios = <&pio 7 11 0>; /* PH11 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxinom: mmc0_cd_pin@0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			mmc3_cd_pin_olinuxinom: mmc3_cd_pin@0 {
+				allwinner,pins = "PH11";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PH2";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0552a64..4416cac 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -303,6 +303,26 @@
 			#size-cells = <0>;
 		};
 
+		sdc0: sdc@01c0f000 {
+			compatible = "allwinner,sun5i-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 32 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		sdc3: sdc@01c12000 {
+			compatible = "allwinner,sun5i-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb_gates 11>, <&mmc3>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 35 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
@@ -366,6 +386,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			sdc0_pins_a: sdc0@0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <3>;
+				allwinner,pull = <1>;
+			};
+
+			sdc3_pins_a: sdc3@0 {
+				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
+				allwinner,function = "mmc3";
+				allwinner,drive = <3>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer@01c20c00 {
-- 
1.8.4.2
