From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 3/3] ARM: dts: exynos5422-odroidxu3: add eMMC reset line
Date: Mon, 02 Feb 2015 09:33:48 +0100
Message-ID: <1422866028-27891-4-git-send-email-m.szyprowski@samsung.com>
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
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index a519c863248d..790fb4ce295d 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -264,6 +264,13 @@
 		};
 	};
 
+	emmc_pwrseq: pwrseq {
+		pinctrl-0 = <&emmc_nrst_pin>;
+		pinctrl-names = "default";
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpd1 0 1>;
+	};
+
 	i2c_2: i2c@12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
@@ -298,6 +305,7 @@
 
 &mmc_0 {
 	status = "okay";
+	mmc-pwrseq = <&emmc_pwrseq>;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -330,6 +338,15 @@
 	};
 };
 
+&pinctrl_1 {
+	emmc_nrst_pin: emmc-nrst {
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
