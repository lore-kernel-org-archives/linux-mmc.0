From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/3] ARM: dts: exynos: Define vqmmc for SD card and allow
 disabling regulators on Odroid X/X2/U3
Date: Wed, 27 Apr 2016 14:19:11 +0200
Message-ID: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:19643 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcD0MTa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 08:19:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The SD-card vmmc-supply contained incorrectly two regulators. The second
one is ignored. Fix this by defining proper vmmc and vqmmc supplies.
Additionally these regulators do not have to be always on, so allow
disabling them to reduce energy consumption.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index cab0f07d7d28..3d0d44581fbd 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -249,7 +249,6 @@
 				regulator-name = "VDDQ_MMC2_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
 				regulator-boot-on;
 			};
 
@@ -345,7 +344,6 @@
 				regulator-name = "LDO21_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
 				regulator-boot-on;
 			};
 
@@ -482,7 +480,8 @@
 	bus-width = <4>;
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	pinctrl-names = "default";
-	vmmc-supply = <&ldo4_reg &ldo21_reg>;
+	vmmc-supply = <&ldo21_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 	cd-gpios = <&gpk2 2 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 	status = "okay";
-- 
1.9.1

