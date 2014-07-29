From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/5] ARM: dts: Add emmc and sdmmc to the rk3288 device tree
Date: Tue, 29 Jul 2014 13:31:52 -0700
Message-ID: <1406665916-23396-2-git-send-email-dianders@chromium.org>
References: <1406665916-23396-1-git-send-email-dianders@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406665916-23396-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This adds support for the sdmmc and emmc ports on the rk3288 using the
currently posted driver from Addy at:
  https://patchwork.kernel.org/patch/4520631/

Note:
* This is not baesd on Jaehoon's patch series removing the slot node,
  but it does use new syntax like putting the bus width at the top
  level and using the new cap-mmc-highspeed / cap-sd-highspeed.  A
  future patch will modify this one to remove the slot node.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3ef8951..fd77a65 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -78,6 +78,28 @@
 		clock-frequency = <24000000>;
 	};
 
+	sdmmc: dwmmc@ff0c0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0c0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	emmc: dwmmc@ff0f0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0f0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	i2c1: i2c@ff140000 {
 		compatible = "rockchip,rk3288-i2c";
 		reg = <0xff140000 0x1000>;
-- 
2.0.0.526.g5318336

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
