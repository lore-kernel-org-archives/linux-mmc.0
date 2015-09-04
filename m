From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/2] ARM: dts: <omap2/3/4/5/dra7>: use "ti,pbias-<platform>" compatible string for pbias
Date: Fri, 4 Sep 2015 17:30:25 +0530
Message-ID: <1441368025-21182-3-git-send-email-kishon@ti.com>
References: <1441368025-21182-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441368025-21182-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use platform specific compatible strings instead of the common
"ti,pbias-omap" compatible string.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi     |    2 +-
 arch/arm/boot/dts/omap2430.dtsi |    2 +-
 arch/arm/boot/dts/omap3.dtsi    |    2 +-
 arch/arm/boot/dts/omap4.dtsi    |    2 +-
 arch/arm/boot/dts/omap5.dtsi    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf..d6bc6db 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -122,7 +122,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-dra7", "ti,pbias-omap";
 						reg = <0xe00 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 2390f38..3961a6f 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -63,7 +63,7 @@
 					};
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap2", "ti,pbias-omap";
 						reg = <0x230 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap2430 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..9af9ae1 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -203,7 +203,7 @@
 		};
 
 		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
+			compatible = "ti,pbias-omap3", "ti,pbias-omap";
 			reg = <0x2b0 0x4>;
 			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index abc4473..5aad7f3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -198,7 +198,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap4", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap4_padconf_global>;
 						pbias_mmc_reg: pbias_mmc_omap4 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b1a1263..76ef595 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -187,7 +187,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap5", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap5_padconf_global>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
-- 
1.7.9.5
