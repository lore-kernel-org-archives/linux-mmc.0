From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy" instead of
 "clock-freq-min-max"
Date: Thu, 03 Nov 2016 15:21:32 +0900
Message-ID: <20161103062135.10697-11-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

In drivers/mmc/core/host.c, there is "max-frequency" property.
It should be same behavior. So Use the "max-frequency" instead of
"clock-freq-min-max".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
 arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
index be4d6aa..4bd2ee8 100644
--- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
+++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
@@ -28,7 +28,7 @@
 	vqmmc-supply = <&ldo3_reg>;
 	card-detect-delay = <200>;
 	clock-frequency = <100000000>;
-	clock-freq-min-max = <400000 100000000>;
+	max-frequency = <100000000>;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index a70819b..59c89d7 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -310,7 +310,7 @@
 	card-detect-delay = <200>;
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
-	clock-freq-min-max = <400000 100000000>;
+	max-frequency = <100000000>;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 66f04f6..cccfe4b 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -435,7 +435,7 @@
 	card-detect-delay = <200>;
 	vmmc-supply = <&vemmc_reg>;
 	clock-frequency = <100000000>;
-	clock-freq-min-max = <400000 100000000>;
+	max-frequency = <100000000>;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3967ee5..548413e 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -649,7 +649,7 @@
 	card-detect-delay = <200>;
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
-	clock-freq-min-max = <400000 100000000>;
+	max-frequency = <100000000>;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-- 
2.10.1
