From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/3] ARM: dts: exynos: Define vqmmc for eMMC card on Odroid
 X/X2/U3
Date: Wed, 27 Apr 2016 14:19:12 +0200
Message-ID: <1461759553-10119-2-git-send-email-k.kozlowski@samsung.com>
References: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The eMMC card vmmc-supply contained incorrectly two regulators: LDO20
and buck8.  The second one is ignored. Additionally the buck8 is not
supplying the eMMC host but LAN (SMSC95xx). Instead the LDO22 should be
used.

Fix this by defining proper vmmc and vqmmc supplies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3d0d44581fbd..55d766f28202 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -347,6 +347,14 @@
 				regulator-boot-on;
 			};
 
+			/* VDDQ for MSHC (eMMC card) */
+			ldo22_reg: LDO22 {
+				regulator-name = "VDDQ_MMC4_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-boot-on;
+			};
+
 			ldo25_reg: LDO25 {
 				regulator-name = "VDDQ_LCD_1.8V";
 				regulator-min-microvolt = <1800000>;
@@ -456,7 +464,8 @@
 &mshc_0 {
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
-	vmmc-supply = <&ldo20_reg &buck8_reg>;
+	vmmc-supply = <&ldo20_reg>;
+	vqmmc-supply = <&ldo22_reg>;
 	mmc-pwrseq = <&emmc_pwrseq>;
 	status = "okay";
 
-- 
1.9.1
