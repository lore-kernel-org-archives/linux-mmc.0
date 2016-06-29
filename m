From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 2/8] mmc: sdhci-msm: Fix the regulator binding name
Date: Wed, 29 Jun 2016 16:50:27 +0530
Message-ID: <1467199233-20506-3-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

QUALCOMM sdhci-msm driver follows a pwr_irq method
(deviation from regular standard) for any pwr related
operations (which also involves regulator settings changes).

vmmc/vqmmc regulator names are used by core layer,
so change the names to vdd/vdd-io so that it can
be used by sdhci-msm driver alone.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 485483a..851e66d 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -27,8 +27,8 @@ Example:
 		bus-width = <8>;
 		non-removable;
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+		vdd-supply = <&pm8941_l20>;
+		vdd-io-supply = <&pm8941_s3>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
@@ -44,8 +44,8 @@ Example:
 		bus-width = <4>;
 		cd-gpios = <&msmgpio 62 0x1>;
 
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
+		vdd-supply = <&pm8941_l21>;
+		vdd-io-supply = <&pm8941_l13>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
