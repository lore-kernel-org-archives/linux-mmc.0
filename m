From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for passing load values
Date: Mon,  8 Oct 2018 18:48:58 +0530
Message-ID: <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..cb22178 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,6 +25,10 @@ Required properties:
 	"xo"	- TCXO clock (optional)
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
+- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
+					BUS_OFF states in power irq. Should be specified in
+					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+					Units uA.
 
 Example:
 
@@ -36,7 +40,9 @@ Example:
 		non-removable;
 
 		vmmc-supply = <&pm8941_l20>;
+		qcom,vmmc-current-level-microamp = <200 570000>;
 		vqmmc-supply = <&pm8941_s3>;
+		qcom,vqmmc-current-level-microamp = <200 325000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
@@ -53,7 +59,9 @@ Example:
 		cd-gpios = <&msmgpio 62 0x1>;
 
 		vmmc-supply = <&pm8941_l21>;
+		qcom,vmmc-current-level-microamp = <200 800000>;
 		vqmmc-supply = <&pm8941_l13>;
+		qcom,vqmmc-current-level-microamp = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
