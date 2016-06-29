From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 4/8] mmc: sdhci-msm: Add regulator DT props to sdhci-msm bindings
Date: Wed, 29 Jun 2016 16:50:29 +0530
Message-ID: <1467199233-20506-5-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the DT properties for voltage regulator nodes
for Qualcomm SDHCI driver.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 851e66d..32cea75 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,7 +17,15 @@ Required properties:
 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
 	"core"	- SDC MMC clock (MCLK) (required)
 	"bus"	- SDCC bus voter clock (optional)
+- qcom,<supply>-voltage_level - specifies voltage levels for supply. Should be
+					specified in pairs (min, max), units uV.
+- qcom,<supply>-current_level - specifies load levels for supply in lpm or
+					high power mode (hpm). Should be specified in
+					pairs (lpm, hpm), units uA.
 
+Optional Properties:
+	- qcom,<supply>-always-on - specifies whether supply should be kept "on" always.
+	- qcom,<supply>-lpm_sup - specifies whether supply can be kept in low power mode (lpm).
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -28,7 +36,13 @@ Example:
 		non-removable;
 
 		vdd-supply = <&pm8941_l20>;
+		qcom,vdd-voltage-level = <2950000 2950000>;
+		qcom,vdd-current-level = <200 570000>;
+
 		vdd-io-supply = <&pm8941_s3>;
+		qcom,vdd-io-always-on;
+		qcom,vdd-io-voltage-level = <1800000 1800000>;
+		qcom,vdd-io-current-level = <110 325000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
@@ -45,7 +59,12 @@ Example:
 		cd-gpios = <&msmgpio 62 0x1>;
 
 		vdd-supply = <&pm8941_l21>;
+		qcom,vdd-voltage-level = <2950000 2950000>;
+		qcom,vdd-current-level = <200 800000>;
+
 		vdd-io-supply = <&pm8941_l13>;
+		qcom,vdd-io-voltage-level = <1800000 2950000>;
+		qcom,vdd-io-current-level = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
