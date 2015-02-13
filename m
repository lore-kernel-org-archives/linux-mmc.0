From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH RESEND] ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
Date: Fri, 13 Feb 2015 08:48:54 +0100
Message-ID: <1423813734-20664-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, kgene@kernel.org, javier@dowhile0.org
List-Id: linux-mmc@vger.kernel.org

The patch adds gpio for detecting presence of MMC card.
It fixes issue with kernel hang due when MMC card is missing.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi,

This is just resend of the patch with added mmc ML and dw-mmc maintainers.

Javier, I have no access to peach-pi(t) schematics, so I do not know if they
have mmc-cd line connected to gpc0-2 gpio, but I guess it could be the case.
You could check if similar patches will fix the issue for them.

Regards
Andrzej

 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 47ec9bf..a563811 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -11,6 +11,7 @@
 */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "exynos5800.dtsi"
 
 / {
@@ -355,13 +356,13 @@
 
 &mmc_0 {
 	status = "okay";
-	broken-cd;
+	cd-gpios = <&gpc0 2 GPIO_ACTIVE_LOW>;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_cd>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 };
-- 
1.9.1
