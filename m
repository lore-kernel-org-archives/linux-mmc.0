From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 07/10] ARM: dts: sun8i: a83t: Add MMC
 controller device nodes
Date: Mon, 24 Jul 2017 21:59:02 +0800
Message-ID: <20170724135905.28855-8-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBNH227FQKGQEKE2VWSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170724135905.28855-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The A83T has 3 MMC controllers. The third one is a bit special, as it
supports a wider 8-bit bus, and a "new timing mode".

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index beed05e10a3b..21ab668abfac 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -182,6 +182,65 @@
 			#dma-cells = <1>;
 		};
 
+		mmc0: mmc@1c0f000 {
+			compatible = "allwinner,sun8i-a83t-mmc",
+				     "allwinner,sun7i-a20-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@1c10000 {
+			compatible = "allwinner,sun8i-a83t-mmc",
+				     "allwinner,sun7i-a20-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>,
+				 <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@1c11000 {
+			compatible = "allwinner,sun8i-a83t-emmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>,
+				 <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-a83t-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.13.3
