From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
Date: Mon, 04 May 2015 13:03:11 +0200
Message-ID: <1430737391-7202-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52110 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbEDLDe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 07:03:34 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNT004RLO1V1590@mailout2.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 May 2015 12:03:31 +0100 (BST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The patch adds gpio for detecting presence of MMC card.
It fixes issue with kernel hang when MMC card is missing.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
Hi Krzysztof,

It is rebased on the latest next.

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

