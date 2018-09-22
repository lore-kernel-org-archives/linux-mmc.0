From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv4 3/6] ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
Date: Sat, 22 Sep 2018 07:52:35 +0000
Message-ID: <20180922075238.884-5-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

set the max-frequency to 200MHz for optimal performace.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
This patch is new to this series.

microSD card.
root@odroid:~# sudo cat /sys/kernel/debug/mmc1/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            16 (2.8 ~ 2.9 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 15ab380e5fcf..a80b6c045154 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -501,6 +501,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1
