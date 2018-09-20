From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect sd-card
Date: Thu, 20 Sep 2018 17:58:24 +0000
Message-ID: <20180920175826.1284-6-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

add the Write Protect GPIO property for sdcard, to fix
the warning message during boot time.
of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch to this series.
If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 03fe02ceae66..475c38bbc99e 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -370,6 +370,7 @@
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
 	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1
