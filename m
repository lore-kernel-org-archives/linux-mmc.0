From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: [PATCH v2 5/6] ARM: dts: sun4i: Add support for mmc
Date: Tue, 04 Feb 2014 20:25:41 +0100
Message-ID: <20140204192537.29809.35842.stgit@dizzy-6.o2s.ch>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD2JL37LXEKRBP75YSLQKGQEJSCS5CY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140204191648.29809.14611.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      |    8 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    8 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |   54 ++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index d4b081d..a879ef3 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -35,6 +35,14 @@
 			};
 		};
 
+		mmc0: mmc@01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
 			emac_power_pin_a1000: emac_power_pin@0 {
 				allwinner,pins = "PH15";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index b139ee6..20b976a 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -33,6 +33,14 @@
 			};
 		};
 
+		mmc0: mmc@01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
 			led_pins_cubieboard: led_pins@0 {
 				allwinner,pins = "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 040bb0e..c941ca3 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -330,6 +330,46 @@
 			#size-cells = <0>;
 		};
 
+		mmc0: mmc@01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <32>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc@01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <33>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc@01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <34>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc@01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <35>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
@@ -400,6 +440,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0@0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
+
+			mmc0_cd_pin_reference_design: mmc0_cd_pin@0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer@01c20c00 {
