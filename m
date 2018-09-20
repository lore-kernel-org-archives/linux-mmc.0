From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for passing load values
Date: Thu, 20 Sep 2018 11:52:37 +0530
Message-ID: <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: linux-mmc@vger.kernel.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, evgreen@chromium.org, dianders@google.com, Vijay Viswanath <vviswana@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..3720385 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -26,6 +26,11 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional properties:
+- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
+					BUS_OFF states in power irq. Should be specified in
+					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+					Units uA.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -37,6 +42,7 @@ Example:
 
 		vmmc-supply = <&pm8941_l20>;
 		vqmmc-supply = <&pm8941_s3>;
+		qcom,vqmmc-current-level-microamp = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
