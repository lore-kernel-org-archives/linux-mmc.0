From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V3 6/6] dts: doc: rename rpm_requests to respect DT naming conventions
Date: Tue, 24 Jan 2017 01:36:28 -0800
Message-ID: <1485250588-24698-7-git-send-email-jeremymc@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

Node names cannot have an underscore '_' in the name.
Simply rename 'rpm_request' nodes to 'rpm-request' and
adjust associated documentation to reflect reality.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt              | 2 +-
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt        | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt         | 6 +++---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt             | 2 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                      | 2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                                 | 2 +-
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts            | 2 +-
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts               | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                                 | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                               | 2 +-
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi                       | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 87d3714..7154858 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -24,7 +24,7 @@ Example:
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8916";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index 4e3dfb5..6b984cc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -187,7 +187,7 @@ see regulator.txt.
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index a48049c..30e1c75 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -11,7 +11,7 @@ RPM node itself.
 
 = SUBDEVICES
 
-The RPM exposes resources to its subnodes.  The rpm_requests node must be
+The RPM exposes resources to its subnodes.  The rpm-requests node must be
 present and this subnode may contain children that designate regulator
 resources.
 
@@ -29,7 +29,7 @@ resources.
 	Definition: must be "rpm_requests"
 
 Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
-for information on the regulator subnodes that can exist under the rpm_requests.
+for information on the regulator subnodes that can exist under the rpm-requests.
 
 Example:
 
@@ -48,7 +48,7 @@ Example:
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
index ea1dc75..3d4a61c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
@@ -82,7 +82,7 @@ The following example represents a smd node, with one edge representing the
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index ad51df2..ccae434 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -126,7 +126,7 @@
 
 	smd {
 		rpm {
-			rpm_requests {
+			rpm-requests {
 				pm8841-regulators {
 					s1 {
 						regulator-min-microvolt = <675000>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 80d4886..002fd69 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -461,7 +461,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 382bcc3..a24c6b4 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -19,7 +19,7 @@
 
 	smd {
 		rpm {
-			rpm_requests {
+			rpm-requests {
 				pm8841-regulators {
 					s1 {
 						regulator-min-microvolt = <675000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index e7c1577..ec937c9 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -60,7 +60,7 @@
 
 	smd {
 		rpm {
-			rpm_requests {
+			rpm-requests {
 				pm8841-regulators {
 					s1 {
 						regulator-min-microvolt = <675000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 49d579f..0c09049 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -672,7 +672,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f8ff327..69eb846 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -866,7 +866,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8916";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
index e9765e1..9b6ce50 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
@@ -13,7 +13,7 @@
 
 &smd_rpm {
 	rpm {
-		rpm_requests {
+		rpm-requests {
 			pm8994-regulators {
 
 				vdd_l1-supply = <&pm8994_s1>;
-- 
2.6.1
