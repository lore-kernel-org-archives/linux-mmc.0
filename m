From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v9 14/17] ARM: dts: sun7i: Add mmc controller nodes
Date: Sat, 26 Apr 2014 12:16:18 +0200
Message-ID: <1398507381-5614-15-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBIUP52NAKGQEFNCTMLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1398507381-5614-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add nodes for the 4 mmc controllers found on A20 SoCs to
arch/arm/boot/dts/sun7i-a20.dtsi.

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20=
.dtsi
index 32efc10..d7e4cac 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -447,6 +447,42 @@
 			#size-cells =3D <0>;
 		};
=20
+		mmc0: mmc@01c0f000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c0f000 0x1000>;
+			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <0 32 4>;
+			status =3D "disabled";
+		};
+
+		mmc1: mmc@01c10000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c10000 0x1000>;
+			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <0 33 4>;
+			status =3D "disabled";
+		};
+
+		mmc2: mmc@01c11000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c11000 0x1000>;
+			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <0 34 4>;
+			status =3D "disabled";
+		};
+
+		mmc3: mmc@01c12000 {
+			compatible =3D "allwinner,sun5i-a13-mmc";
+			reg =3D <0x01c12000 0x1000>;
+			clocks =3D <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names =3D "ahb", "mod";
+			interrupts =3D <0 35 4>;
+			status =3D "disabled";
+		};
+
 		usbphy: phy@01c13400 {
 			#phy-cells =3D <1>;
 			compatible =3D "allwinner,sun7i-a20-usb-phy";
--=20
1.9.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
