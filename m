From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v3 4/9] arm64: dts: qcom: msm8916: Add clk-rates to sdhc1 & sdhc2
Date: Fri, 19 Aug 2016 10:06:19 +0530
Message-ID: <1471581384-18961-5-git-send-email-riteshh@codeaurora.org>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add supported msm8916 supported clk-rates for sdhc1 & sdhc2
in DT.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9681200..5161740 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -388,6 +388,8 @@
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					177770000>;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
@@ -403,6 +405,8 @@
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>;
 			clock-names = "core", "iface";
+			clk-rates = <400000 25000000 50000000 100000000
+					200000000>;
 			bus-width = <4>;
 			status = "disabled";
 		};
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
