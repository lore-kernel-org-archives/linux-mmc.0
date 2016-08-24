From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v4 9/9] arm64: dts: qcom: msm8916: Add ddr support to sdhc1
Date: Wed, 24 Aug 2016 15:33:44 +0530
Message-ID: <1472033024-14890-10-git-send-email-riteshh@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds mmc-ddr-1_8v support to DT for sdhc1 of msm8916.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6f2c0b8..41e4ce4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -462,6 +462,7 @@
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
