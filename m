From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v4 4/9] ARM: dts: qcom: Add clk-rates to sdhc1 & sdhc2
Date: Wed, 24 Aug 2016 15:33:39 +0530
Message-ID: <1472033024-14890-5-git-send-email-riteshh@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add msm supported clk-rates for all sdhc nodes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 4 ++++
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7c2df06..dd7a92d 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -315,6 +315,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
@@ -326,6 +328,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 561d4d1..c5f7ac4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -447,6 +447,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
@@ -458,6 +460,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 11bdc24..6f2c0b8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -460,6 +460,8 @@
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					177770000>;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
@@ -475,6 +477,8 @@
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			bus-width = <4>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 55ec3e8..f774e4c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -258,6 +258,8 @@
 			 clock-names = "iface", "core";
 			 clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 			 <&gcc GCC_SDCC2_APPS_CLK>;
+			 clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			 bus-width = <4>;
 		 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
