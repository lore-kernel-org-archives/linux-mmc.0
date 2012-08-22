From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ARM: dts: imx51-babbage: fix esdhc cd/wp properties
Date: Wed, 22 Aug 2012 21:58:07 +0800
Message-ID: <1345643887-30606-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38569 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2HVN5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 09:57:45 -0400
Received: by dady13 with SMTP id y13so804953dad.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 06:57:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, stable@vger.kernel.org

The binding doc and dts use properties "fsl,{cd,wp}-internal" while
esdhc driver uses "fsl,{cd,wp}-controller".  Fix binding doc and dts
to get them match driver code.

Reported-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: <stable@vger.kernel.org>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    8 ++++----
 arch/arm/boot/dts/imx51-babbage.dts                |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 70cd49b..1dd6225 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -10,8 +10,8 @@ Required properties:
 - compatible : Should be "fsl,<chip>-esdhc"
 
 Optional properties:
-- fsl,cd-internal : Indicate to use controller internal card detection
-- fsl,wp-internal : Indicate to use controller internal write protection
+- fsl,cd-controller : Indicate to use controller internal card detection
+- fsl,wp-controller : Indicate to use controller internal write protection
 
 Examples:
 
@@ -19,8 +19,8 @@ esdhc@70004000 {
 	compatible = "fsl,imx51-esdhc";
 	reg = <0x70004000 0x4000>;
 	interrupts = <1>;
-	fsl,cd-internal;
-	fsl,wp-internal;
+	fsl,cd-controller;
+	fsl,wp-controller;
 };
 
 esdhc@70008000 {
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index cd86177..59d9789 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -25,8 +25,8 @@
 		aips@70000000 { /* aips-1 */
 			spba@70000000 {
 				esdhc@70004000 { /* ESDHC1 */
-					fsl,cd-internal;
-					fsl,wp-internal;
+					fsl,cd-controller;
+					fsl,wp-controller;
 					status = "okay";
 				};
 
-- 
1.7.5.4

