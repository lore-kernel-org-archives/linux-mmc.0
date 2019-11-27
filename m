From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V1 1/2] dt-bindings: mmc: sdhci-msm: Add compatible string for sc7180
Date: Wed, 27 Nov 2019 11:49:59 +0000
Message-ID: <0101016eacb255af-3985262d-9b7e-4813-88c2-61838406e12c-000000@us-west-2.amazonses.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, cang@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

Add sc7180 SoC specific compatible strings for qcom-sdhci controller.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index da4edb1..7ee639b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -19,6 +19,7 @@ Required properties:
 		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
+		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
 	but doing that should be considered a deprecated practice.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
