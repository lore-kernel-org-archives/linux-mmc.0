From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH RESEND] ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
Date: Mon, 04 May 2015 13:28:43 +0200
Message-ID: <1430738923-7435-1-git-send-email-a.hajda@samsung.com>
References: <55473FD1.7060605@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:46782 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbEDL2x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 07:28:53 -0400
In-reply-to: <55473FD1.7060605@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>

The patch adds gpio for detecting presence of MMC card.
It fixes issue with kernel hang when MMC card is missing.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
Hi Krzysztof,

This is 2nd try today, previously there were missing some
addresses in Cc.

The patch is rebased on the latest next.

Regards
Andrzej
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index edc25cf..cb649b1 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -11,6 +11,7 @@
 */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "exynos5800.dtsi"
 
 / {
@@ -306,13 +307,13 @@
 &mmc_0 {
 	status = "okay";
 	mmc-pwrseq = <&emmc_pwrseq>;
-	broken-cd;
+	cd-gpios = <&gpc0 2 GPIO_ACTIVE_LOW>;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 };
-- 
1.9.1

