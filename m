From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible string for sdcdc10 DLL
Date: Mon,  8 Oct 2018 18:55:37 +0530
Message-ID: <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On the SDHC-MSM controllers which makes use of sdcdc10 variant DLLs,
the DLL configuration needs to be restored whenever controller clocks
are gated. This new compatible string denotes the sdhc-msm controller
variant which uses sdcdc10 DLL.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3720385..49b0a43 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -6,7 +6,11 @@ and the properties used by the sdhci-msm driver.
 Required properties:
 - compatible: Should contain:
 		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
+		"qcom,sdhci-msm-v4-sdcdc10" for sdcc versions < 5.0 and
+		which makes use of sdcdc10 variant DLLs.
 		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		"qcom,sdhci-msm-v5-sdcdc10" for sdcc versions >= 5.0 and
+		which makes use of sdcdc10 variant DLLs.
 		For SDCC version 5.0.0, MCI registers are removed from SDCC
 		interface and some registers are moved to HC. New compatible
 		string is added to support this change - "qcom,sdhci-msm-v5".
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
