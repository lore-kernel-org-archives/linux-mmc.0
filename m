From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 04/12] ARM: dts: qcom: Add clk-rates to sdhc1 & sdhc2
Date: Wed,  5 Oct 2016 20:10:32 +0530
Message-ID: <1475678440-3525-5-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49801 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbcJEOlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2016 10:41:45 -0400
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

Add msm supported clk-rates for all sdhc nodes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 4 ++++
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 41e09c8..b3ce5e5 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -434,6 +434,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
@@ -445,6 +447,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index f9b0d90..6c78f3e 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -566,6 +566,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
@@ -577,6 +579,8 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b5b6014..2f02058 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -512,6 +512,8 @@
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					177770000>;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
@@ -527,6 +529,8 @@
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			bus-width = <4>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8fb4747..cd1ac12 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -410,6 +410,8 @@
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

