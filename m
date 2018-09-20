From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 4/7] ARM: dts: exynos5422: use cd-gpio method to detect sd-card
Date: Thu, 20 Sep 2018 17:58:23 +0000
Message-ID: <20180920175826.1284-5-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

add the Card Detect GPIO property for sdcard detect, to fix
the warning message during boot time.
of_get_named_gpiod_flags: can't parse 'cp-gpios' property of node '/soc/mmc@12220000[0]'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376261.html
Fixed the commit message.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 914ee08c7eb2..03fe02ceae66 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -369,6 +369,7 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
+	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1
