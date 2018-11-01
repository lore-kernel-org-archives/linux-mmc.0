From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible string for SDM845 SOC
Date: Thu,  1 Nov 2018 17:36:38 +0530
Message-ID: <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:MULTIMEDIA CARD MMC, SECURE
        DIGITAL SD AND..." <linux-mmc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..f2ffbeb 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: Should contain:
 		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
 		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		"qcom,sdm845-sdhci" for sdm845 SOC
 		For SDCC version 5.0.0, MCI registers are removed from SDCC
 		interface and some registers are moved to HC. New compatible
 		string is added to support this change - "qcom,sdhci-msm-v5".
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
