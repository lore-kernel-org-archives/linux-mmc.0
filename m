From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 3/3] ARM: dts: exynos: Lower SD card interface voltage to
 2.8v on Odroid X/X2/U3
Date: Wed, 27 Apr 2016 16:00:20 +0200
Message-ID: <1461765620-6833-3-git-send-email-k.kozlowski@samsung.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux.amoon@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Odroid X/X2/U3 schematics say that SD card vmmc regulator
(LDO21/TFLASH) operates on 2.8 V. Mainline U-Boot uses that value as
well. 2.8 V is common on Exynos-based boards. Additionally use some
descriptive name for this regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. None
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 34a5b3daced0..260601d2f72f 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -341,9 +341,9 @@
 			};
 
 			ldo21_reg: LDO21 {
-				regulator-name = "LDO21_3.3V";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-name = "TFLASH_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
 			};
 
-- 
1.9.1
