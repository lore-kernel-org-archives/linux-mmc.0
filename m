From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] ARM: dts: exynos5422-odroidxu3: add eMMC reset line
Date: Wed, 28 Jan 2015 14:59:55 +0100
Message-ID: <1422453595-21160-5-git-send-email-m.szyprowski@samsung.com>
References: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds reset-gpios property to the eMMC slot, so the MMC driver
is able to properly reset eMMC card on system restart and thus fixes
system hang on software reboot.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index a519c863248d..bafbc4e19adc 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -298,13 +298,15 @@
 
 &mmc_0 {
 	status = "okay";
+	reset-gpios = <&gpd1 0 0>;
+	reset-invered;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &emmc_nrst>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 };
@@ -330,6 +332,15 @@
 	};
 };
 
+&pinctrl_1 {
+	emmc_nrst: emmc-nrst {
+		samsung,pins = "gpd1-0";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
-- 
1.9.2
