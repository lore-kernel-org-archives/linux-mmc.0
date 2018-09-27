From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 5/6] ARM: dts: exynos: update maximum frequency for emmc to 200MHz
Date: Thu, 27 Sep 2018 14:07:37 +0000
Message-ID: <20180927140738.1006-6-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Set the max-frequency to 200MHz for optimal performace of eMMC.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
eMMC

root@odroid:~# sudo cat /sys/kernel/debug/mmc0/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            7 (1.65 - 1.95 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e522edb2bb82..1f2d3987dde1 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -392,6 +392,7 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo18_reg>;
 	vqmmc-supply = <&ldo3_reg>;
 };
-- 
2.17.1
