From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v5 3/3] ARM: dts: r7s72100: update sdhi clock bindings
Date: Fri, 20 Jan 2017 22:06:04 -0500
Message-ID: <20170121030604.7672-4-chris.brandt@renesas.com>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170121030604.7672-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

The SDHI controller in the RZ/A1 has 2 clock sources per channel and both
need to be enabled/disabled for proper operation. This fixes the fact that
the define for R7S72100_CLK_SDHI1 was not correct to begin with (typo), and
that all 4 clock sources need to be defined an used.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
* add missing clock sources instead of just fixing typo
* changed clock name from "carddetect" to "cd"
---
 arch/arm/boot/dts/r7s72100.dtsi            | 17 ++++++++++++-----
 include/dt-bindings/clock/r7s72100-clock.h |  6 ++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 3dd427d..9d0b8d0 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -153,9 +153,12 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0444 4>;
-			clocks = <&p1_clk>, <&p1_clk>;
-			clock-indices = <R7S72100_CLK_SDHI1 R7S72100_CLK_SDHI0>;
-			clock-output-names = "sdhi1", "sdhi0";
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SDHI00 R7S72100_CLK_SDHI01
+				R7S72100_CLK_SDHI10 R7S72100_CLK_SDHI11
+			>;
+			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
 		};
 	};
 
@@ -478,7 +481,9 @@
 			      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI0>;
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
+			 <&mstp12_clks R7S72100_CLK_SDHI01>;
+		clock-names = "core", "cd";
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -491,7 +496,9 @@
 			      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
 
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI1>;
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
+			 <&mstp12_clks R7S72100_CLK_SDHI11>;
+		clock-names = "core", "cd";
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 29e01ed..f2d8428 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -45,7 +45,9 @@
 #define R7S72100_CLK_SPI4	3
 
 /* MSTP12 */
-#define R7S72100_CLK_SDHI0	3
-#define R7S72100_CLK_SDHI1	2
+#define R7S72100_CLK_SDHI00	3
+#define R7S72100_CLK_SDHI01	2
+#define R7S72100_CLK_SDHI10	1
+#define R7S72100_CLK_SDHI11	0
 
 #endif /* __DT_BINDINGS_CLOCK_R7S72100_H__ */
-- 
2.10.1
