From: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 4/4] dts: doc: rename rpm_requests to respect DT naming conventions
Date: Mon, 16 Jan 2017 16:58:49 -0800
Message-ID: <1484614729-26751-5-git-send-email-jeremymc@redhat.com>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484614729-26751-1-git-send-email-jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, git-LJ92rlH3Dns@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Node names cannot have an underscore '_' in the name.
Simply rename 'rpm_request' nodes to 'rpm-request'.

Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
index a7235e9..845dd57 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -25,7 +25,7 @@ Example:
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8916";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index 126989b..e4799a4 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -171,7 +171,7 @@ see regulator.txt.
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
index 97d9b3e..34b05c3 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
@@ -75,7 +75,7 @@ The following example represents a smd node, with one edge representing the
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
index 39eb7a4..ac3ec7d 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -457,7 +457,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index c0fb4a6..890566b 100644
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
index d210947..cb9cd53 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -668,7 +668,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ed15e87..247fc51 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -812,7 +812,7 @@
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-msm8916";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
index d556aae..36fc582 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
@@ -13,7 +13,7 @@
 
 &smd-rpm {
 	rpm {
-		rpm_requests {
+		rpm-requests {
 			pm8994-regulators {
 
 				vdd_l1-supply = <&pm8994_s1>;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
