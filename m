From: Pradeep P V K <ppvk@codeaurora.org>
Subject: [RFC 2/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported strings
Date: Fri,  6 Sep 2019 18:17:17 +0530
Message-ID: <1567774037-2344-3-git-send-email-ppvk@codeaurora.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Pradeep P V K <ppvk@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

Add Bus bandwidth voting supported strings for qcom-sdhci controller.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index da4edb1..8255d92 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -39,6 +39,25 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional Properties:
+* Following bus parameters are required for bus bw voting:
+- interconnects: Pairs of phandles and interconnect provider specifier
+		 to denote the edge source and destination ports of
+		 the interconnect path. Please refer to
+		 Documentation/devicetree/bindings/interconnect/
+		 for more details.
+- interconnect-names: List of interconnect path name strings sorted in the same
+		order as the interconnects property. Consumers drivers will use
+		interconnect-names to match interconnect paths with interconnect
+		specifiers. Please refer to Documentation/devicetree/bindings/
+		interconnect/ for more details.
+- qcom,msm-bus,name: string describing the bus path
+- qcom,msm-bus,num-cases: number of configurations in which sdhc can operate in
+- qcom,msm-bus,num-paths: number of paths to vote for
+- qcom,msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples for 2
+				num-paths) The number of these entries *must*
+				be same as num-cases.
+
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -56,6 +75,19 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+		interconnects = <&qnoc 50 &qnoc 512>,
+				<&qnoc 1 &qnoc 544>;
+		interconnect-names = "sdhc-ddr","cpu-sdhc";
+		qcom,msm-bus,name = "sdhc1";
+		qcom,msm-bus,num-cases = <3>;
+		qcom,msm-bus,num-paths = <2>;
+		qcom,msm-bus,vectors-KBps =
+		/* No Vote */
+		<0 0>, <0 0>,
+		/* 50 MB/s */
+		<130718 200000>, <133320 133320>,
+		/* 200 MB/s */
+		<1338562 4096000>, <1338562 4096000>;
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-- 
1.9.1
