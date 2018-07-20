From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V1 2/3] Documentation: sdhci-msm: Add entries for passing load values
Date: Fri, 20 Jul 2018 16:16:05 +0530
Message-ID: <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..ee34f28 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -26,6 +26,11 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional properties:
+- <supply>-current-level - specifies load levels for supply during BUS_ON
+			and BUS_OFF states in power irq. Should be specified in
+			pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+			Units uA.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -37,6 +42,7 @@ Example:
 
 		vmmc-supply = <&pm8941_l20>;
 		vqmmc-supply = <&pm8941_s3>;
+		vqmmc-current-level = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
