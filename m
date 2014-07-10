From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 4/5] ARM: dts: rockchip: unuse the slot-node and deprecated
 the supports-highspeed for dw-mmc
Date: Thu, 10 Jul 2014 16:08:38 +0900
Message-ID: <1404976119-10777-5-git-send-email-jh80.chung@samsung.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

dw-mmc controller can support multiple slots.
But, there are no use-cases anywhere. So we don't need to support the
slot-node for dw-mmc controller.
And "supports-highspeed" property in dw-mmc is deprecated.
"supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index afb3273..ecea889 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -59,12 +59,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
 			vmmc-supply = <&vcc_sd0>;
-
-			slot@0 {
-				reg = <0>;
-				bus-width = <4>;
-				disable-wp;
-			};
+			bus-width = <4>;
+			disable-wp;
 		};
 
 		dwmmc@10218000 { /* wifi */
@@ -74,12 +70,8 @@
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
-
-			slot@0 {
-				reg = <0>;
-				bus-width = <4>;
-				disable-wp;
-			};
+			bus-width = <4>;
+			disable-wp;
 		};
 
 		gpio-keys {
-- 
1.7.9.5
