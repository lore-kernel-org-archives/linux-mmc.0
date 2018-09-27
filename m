From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 4/6] ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU3/XU4
Date: Thu, 27 Sep 2018 14:07:36 +0000
Message-ID: <20180927140738.1006-5-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add SD card write-protect pin configuration to be sure that it will be
properly pulled down to indicate write access.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes since v4:
1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
   Marek Szyprowski feedback).
2. Pull pin down.
3. change the subject and commit message.
Sorry Krzysztof if I have copied your commit message to describe the
changes.
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 7 +++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index dda8ca2d2324..b82af7c89654 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -289,6 +289,13 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
+
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpc4-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_2 {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index a80b6c045154..54811960e322 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -498,7 +498,7 @@
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
-- 
2.17.1
