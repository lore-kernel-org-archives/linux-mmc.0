From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 11/17] ARM: dts: sun6i: Add mmc controller nodes
Date: Tue, 22 Apr 2014 13:01:31 +0200
Message-ID: <1398164497-14212-12-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBRUY3GNAKGQEEAODOHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add nodes for the 4 mmc controllers found on A31 SoCs to
arch/arm/boot/dts/sun6i-a31.dtsi.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 12bcc17..a27afc8 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -269,6 +269,58 @@
 		#size-cells = <1>;
 		ranges;
 
+		mmc0: mmc@01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 8>;
+			reset-names = "ahb";
+			interrupts = <0 60 4>;
+			bus-width = <4>;
+			cd-inverted;
+			status = "disabled";
+		};
+
+		mmc1: mmc@01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 9>;
+			reset-names = "reset";
+			interrupts = <0 61 4>;
+			bus-width = <4>;
+			cd-inverted;
+			status = "disabled";
+		};
+
+		mmc2: mmc@01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 10>;
+			reset-names = "reset";
+			interrupts = <0 62 4>;
+			bus-width = <4>;
+			cd-inverted;
+			status = "disabled";
+		};
+
+		mmc3: mmc@01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb1_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 11>;
+			reset-names = "reset";
+			interrupts = <0 63 4>;
+			bus-width = <4>;
+			cd-inverted;
+			status = "disabled";
+		};
+
 		nmi_intc: interrupt-controller@01f00c0c {
 			compatible = "allwinner,sun6i-a31-sc-nmi";
 			interrupt-controller;
-- 
1.9.0
