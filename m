From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 6/6] ARM: dts: sun7i: Add reg_vcc3v3 to
 sun7i board mmc nodes
Date: Sun, 11 May 2014 09:46:57 +0200
Message-ID: <1399794417-9291-7-git-send-email-hdegoede@redhat.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBB6WXSNQKGQEKYLJXVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399794417-9291-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 1 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 3918e2f..a5ad945 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 9dbb763c..b7e79d0 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 1bfef12..b759630 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -34,6 +34,7 @@
 		mmc0: mmc@01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -43,6 +44,7 @@
 		mmc3: mmc@01c12000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
+			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 11 0>; /* PH11 */
 			cd-inverted;
-- 
1.9.0
