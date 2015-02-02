From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 2/3] ARM: dts: exynos4412-odroid*: add eMMC reset line
Date: Mon, 02 Feb 2015 09:33:47 +0100
Message-ID: <1422866028-27891-3-git-send-email-m.szyprowski@samsung.com>
References: <1422866028-27891-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422866028-27891-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds reset-gpios property to the eMMC slot, so the MMC driver
is able to properly reset eMMC card on system restart and thus fixes
system hang on software reboot.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ffcf17bbf63b..c97ffbf0a6be 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -57,10 +57,18 @@
 				<19200000>;
 	};
 
+	emmc_pwrseq: pwrseq {
+		pinctrl-0 = <&sd1_cd>;
+		pinctrl-names = "default";
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpk1 2 1>;
+	};
+
 	mmc@12550000 {
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		vmmc-supply = <&ldo20_reg &buck8_reg>;
+		mmc-pwrseq = <&emmc_pwrseq>;
 		status = "okay";
 
 		num-slots = <1>;
@@ -392,6 +400,12 @@
 	};
 };
 
+/* RSTN signal for eMMC */
+&sd1_cd {
+	samsung,pin-pud = <0>;
+	samsung,pin-drv = <0>;
+};
+
 &pinctrl_1 {
 	gpio_power_key: power_key {
 		samsung,pins = "gpx1-3";
-- 
1.9.2
