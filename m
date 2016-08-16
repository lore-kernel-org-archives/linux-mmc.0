From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v2 8/8] arm64: dts: qcom: msm8916: Add ddr support to sdhc1
Date: Tue, 16 Aug 2016 17:11:08 +0530
Message-ID: <1471347668-22978-9-git-send-email-riteshh@codeaurora.org>
References: <1471347668-22978-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471347668-22978-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds mmc-ddr-1_8v support to DT for sdhc1 of msm8916.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5161740..514c61e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -390,6 +390,7 @@
 			clock-names = "core", "iface";
 			clk-rates = <400000 25000000 50000000 100000000
 					177770000>;
+			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
