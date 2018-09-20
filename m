From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 2/7] ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid XU3/XU4
Date: Thu, 20 Sep 2018 17:58:21 +0000
Message-ID: <20180920175826.1284-3-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
regulator min value to 1.8V. Without these changes sdcard will failed
to detect on booting when UHS-I tuning is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376262.html
Fixed the commit message.
drop the ramp-delay changes.
drop the vmmc-supply/vqmmc-supply changes.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 3a58c935c52a..01593f4537ae 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -224,7 +224,7 @@
 
 			ldo13_reg: LDO13 {
 				regulator-name = "vddq_mmc2";
-				regulator-min-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
 			};
 
-- 
2.17.1
