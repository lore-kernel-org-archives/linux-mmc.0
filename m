From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: [PATCH v6 6/8] ARM: dts: sun4i: Add support for mmc
Date: Sun, 16 Feb 2014 00:33:48 +0100
Message-ID: <20140215233348.30460.61331.stgit@dizzy-6.o2s.ch>
References: <20140215233011.30460.27261.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD2JL37LXEKRBXXS76LQKGQEVT7OQII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140215233011.30460.27261.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?utf-8?b?TMOzcGV6?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      |    8 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    8 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |   54 ++++++++++++++++++++++++=
++++
 3 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4=
i-a10-a1000.dts
index d4b081d..a879ef3 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -35,6 +35,14 @@
 			};
 		};
=20
+		mmc0: mmc@01c0f000 {
+			pinctrl-names =3D "default", "default";
+			pinctrl-0 =3D <&mmc0_pins_a>;
+			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
+			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
+			status =3D "okay";
+		};
+
 		pinctrl@01c20800 {
 			emac_power_pin_a1000: emac_power_pin@0 {
 				allwinner,pins =3D "PH15";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts=
/sun4i-a10-cubieboard.dts
index b139ee6..20b976a 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -33,6 +33,14 @@
 			};
 		};
=20
+		mmc0: mmc@01c0f000 {
+			pinctrl-names =3D "default", "default";
+			pinctrl-0 =3D <&mmc0_pins_a>;
+			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
+			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
+			status =3D "okay";
+		};
+
 		pinctrl@01c20800 {
 			led_pins_cubieboard: led_pins@0 {
 				allwinner,pins =3D "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10=
.dtsi
index 9044c53..cd14961 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -330,6 +330,46 @@
 			#size-cells =3D <0>;
 		};
=20
+		mmc0: mmc@01c0f000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c0f000 0x1000>;
+			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <32>;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		mmc1: mmc@01c10000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c10000 0x1000>;
+			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <33>;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		mmc2: mmc@01c11000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c11000 0x1000>;
+			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <34>;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		mmc3: mmc@01c12000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c12000 0x1000>;
+			clocks =3D <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <35>;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible =3D "allwinner,sun4i-ic";
 			reg =3D <0x01c20400 0x400>;
@@ -400,6 +440,20 @@
 				allwinner,drive =3D <0>;
 				allwinner,pull =3D <0>;
 			};
+
+			mmc0_pins_a: mmc0@0 {
+				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function =3D "mmc0";
+				allwinner,drive =3D <3>;
+				allwinner,pull =3D <0>;
+			};
+
+			mmc0_cd_pin_reference_design: mmc0_cd_pin@0 {
+				allwinner,pins =3D "PH1";
+				allwinner,function =3D "gpio_in";
+				allwinner,drive =3D <0>;
+				allwinner,pull =3D <1>;
+			};
 		};
=20
 		timer@01c20c00 {

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
