From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] ARM: dts: sun5i: add mmc support
Date: Sat, 14 Dec 2013 22:58:14 +0100
Message-ID: <1387058295-20641-5-git-send-email-hdegoede@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBBVJWOKQKGQE2QCJDGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 34 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 16 +++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 16 +++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 17 ++++++++++++
 5 files changed, 115 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 3c9f8b3..e53fb12 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -34,7 +34,39 @@
 			};
 		};
 
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_olinuxino_micro>;
+			cd-gpios = <&pio 6 1 0>; /* PG1 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
+		sdc1: sdc@01c10000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc1_pins_a>;
+			pinctrl-1 = <&mmc1_cd_pin_olinuxino_micro>;
+			cd-gpios = <&pio 6 13 0>; /* PG13 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin@0 {
+				allwinner,pins = "PG1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			mmc1_cd_pin_olinuxino_micro: mmc1_cd_pin@0 {
+				allwinner,pins = "PG13";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PE3";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 83e183c..fdbc290 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -274,6 +274,26 @@
 			#size-cells = <0>;
 		};
 
+		sdc0: sdc@01c0f000 {
+			compatible = "allwinner,sun5i-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0>;
+			clock-names = "ahb", "mod";
+			interrupts = <32>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		sdc1: sdc@01c10000 {
+			compatible = "allwinner,sun5i-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>, <&mmc1>;
+			clock-names = "ahb", "mod";
+			interrupts = <33>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
@@ -344,6 +364,20 @@
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
+			sdc1_pins_a: sdc1@0 {
+				allwinner,pins = "PG3","PG4","PG5","PG6","PG7","PG8";
+				allwinner,function = "mmc1";
+				allwinner,drive = <3>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer@01c20c00 {
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 26df7e8..247cd79 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -19,7 +19,23 @@
 	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
 
 	soc@01c00000 {
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_olinuxinom>;
+			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxinom: mmc0_cd_pin@0 {
+				allwinner,pins = "PG0";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_olinuxinom: led_pins@0 {
 				allwinner,pins = "PG9";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 9e508dc..ce22c81 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -23,7 +23,23 @@
 	};
 
 	soc@01c00000 {
+		sdc0: sdc@01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_olinuxino>;
+			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			mmc0_cd_pin_olinuxino: mmc0_cd_pin@0 {
+				allwinner,pins = "PG0";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PG9";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 0bb4300..0ca0819 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -255,6 +255,16 @@
 		#size-cells = <1>;
 		ranges;
 
+		sdc0: sdc@01c0f000 {
+			compatible = "allwinner,sun5i-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0>;
+			clock-names = "ahb", "mod";
+			interrupts = <32>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
@@ -307,6 +317,13 @@
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
 		};
 
 		timer@01c20c00 {
-- 
1.8.4.2
