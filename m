From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 12/16] arm64: dts: qcom: msm8916: Add ddr support to sdhc1
Date: Mon, 21 Nov 2016 12:07:22 +0530
Message-ID: <1479710246-26676-13-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds mmc-ddr-1_8v support to DT for sdhc1 of msm8916.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index bd78f0c..971ae5a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -515,6 +515,7 @@
 				 <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
