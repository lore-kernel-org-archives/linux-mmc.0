From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/11] ARM: dts: sun7i: Add OOB irq support to
 boards with broadcom sdio wifi
Date: Mon, 26 May 2014 09:48:06 +0200
Message-ID: <1401090486-4414-12-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBYXDROOAKGQEQSD5SHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401090486-4414-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 12 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 3931986..d3dcd8e 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -31,12 +31,24 @@
 		};
 
 		mmc3: mmc@01c12000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc3_pins_a>;
 			vmmc-supply = <&reg_vmmc3>;
 			bus-width = <4>;
 			non-removable;
 			status = "okay";
+
+			brcmf: bcrmf@1 {
+				reg = <1>;
+				compatible = "brcm,bcm43xx-fmac";
+				interrupt-parent = <&pio>;
+				interrupts = <10 8>; /* PH10 / EINT10 */
+				interrupt-names = "host-wake";
+				status = "okay";
+			};
 		};
 
 		usbphy: phy@01c13400 {
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 4aad09c..806f236 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -29,12 +29,24 @@
 		};
 
 		mmc3: mmc@01c12000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc3_pins_a>;
 			vmmc-supply = <&reg_vmmc3>;
 			bus-width = <4>;
 			non-removable;
 			status = "okay";
+
+			brcmf: bcrmf@1 {
+				reg = <1>;
+				compatible = "brcm,bcm43xx-fmac";
+				interrupt-parent = <&pio>;
+				interrupts = <10 8>; /* PH10 / EINT10 */
+				interrupt-names = "host-wake";
+				status = "okay";
+			};
 		};
 
 		usbphy: phy@01c13400 {
-- 
1.9.3
