From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 04/16] ARM: dts: Add xo to sdhc clock node on qcom platforms
Date: Mon, 21 Nov 2016 12:07:14 +0530
Message-ID: <1479710246-26676-5-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add xo entry to sdhc clock node on all qcom platforms.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 16 ++++++++++------
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 ++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  9 +++++----
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 39eb7a4..80d4886 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -182,13 +182,13 @@
 	};
 
 	clocks {
-		xo_board {
+		xo_board: xo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
@@ -416,8 +416,10 @@
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 123 0>, <0 138 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			status = "disabled";
 		};
 
@@ -427,8 +429,10 @@
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 125 0>, <0 221 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
-			clock-names = "core", "iface";
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d210947..49d579f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -220,13 +220,13 @@
 	};
 
 	clocks {
-		xo_board {
+		xo_board: xo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
@@ -558,8 +558,10 @@
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 123 0>, <0 138 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			status = "disabled";
 		};
 
@@ -569,8 +571,10 @@
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 125 0>, <0 221 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
-			clock-names = "core", "iface";
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 466ca57..bd78f0c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -512,8 +512,9 @@
 			interrupts = <0 123 0>, <0 138 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+				 <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
@@ -527,8 +528,9 @@
 			interrupts = <0 125 0>, <0 221 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>;
-			clock-names = "core", "iface";
+				 <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
 			bus-width = <4>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 338f82a..699f073 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -192,14 +192,14 @@
 	};
 
 	clocks {
-		xo_board {
+		xo_board: xo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
 			clock-output-names = "xo_board";
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32764>;
@@ -347,9 +347,10 @@
 			 interrupts = <0 125 0>, <0 221 0>;
 			 interrupt-names = "hc_irq", "pwr_irq";
 
-			 clock-names = "iface", "core";
+			 clock-names = "iface", "core", "xo";
 			 clocks = <&gcc GCC_SDCC2_AHB_CLK>,
-			 <&gcc GCC_SDCC2_APPS_CLK>;
+			 <&gcc GCC_SDCC2_APPS_CLK>,
+			 <&xo_board>;
 			 bus-width = <4>;
 		 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
