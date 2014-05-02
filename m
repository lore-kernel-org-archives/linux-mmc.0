From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v10 09/15] ARM: dts: sun6i: Add mmc clocks
Date: Fri,  2 May 2014 17:57:23 +0200
Message-ID: <1399046249-19472-10-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBDEBR6NQKGQEZKY5RAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add clk-nodes for the mmc clocks.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 1cfaf52..f2bb07c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -206,6 +206,38 @@
 					"apb2_uart4", "apb2_uart5";
 		};
 
+		mmc0_clk: clk@01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk@01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk@01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc2";
+		};
+
+		mmc3_clk: clk@01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc3";
+		};
+
 		spi0_clk: clk@01c200a0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
-- 
1.9.0
