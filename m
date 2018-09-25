From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add flag for restoring dll
Date: Tue, 25 Sep 2018 20:34:34 +0530
Message-ID: <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, evgreen@chromium.org, dianders@google.com, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:MULTIMEDIA CARD MMC, SECURE
        DIGITAL SD AND..." <linux-mmc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

The dll settings of SDHC controller needs to be restored whenever
controller clocks are gated. This restoration is needed only on
few SDHCI-MSM controllers. This dt flag indicates whether dll
restoration is needed or not.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3720385..207ce36 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -31,6 +31,8 @@ Optional properties:
 					BUS_OFF states in power irq. Should be specified in
 					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
 					Units uA.
+- qcom,restore-dll-config - Flag indicates that restoration of dll config after clock gating
+			    is needed on given platform. This wouldn't be needed for every MSM.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -49,6 +51,8 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+
+		qcom,restore-dll-config;
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
