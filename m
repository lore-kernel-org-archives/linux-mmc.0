From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 37/38] ARM: cubox-i: add support for SD UHS-1 cards
Date: Wed, 23 Apr 2014 20:09:19 +0100
Message-ID: <E1Wd2Xn-0003wm-Ei@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140423185534.GA26756-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index c2a24888a276..c928c0a5e3cc 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -111,6 +111,28 @@
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
 			>;
 		};
+
+		pinctrl_cubox_i_usdhc2_100mhz: cubox-i-usdhc2-100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170b9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100b9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170b9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170b9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170b9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130b9
+			>;
+		};
+
+		pinctrl_cubox_i_usdhc2_200mhz: cubox-i-usdhc2-200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170f9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100f9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170f9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170f9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170f9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130f9
+			>;
+		};
 	};
 };
 
@@ -131,8 +153,10 @@
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
+	pinctrl-1 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_200mhz>;
 	vmmc-supply = <&reg_3p3v>;
 	cd-gpios = <&gpio1 4 0>;
 	status = "okay";
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
