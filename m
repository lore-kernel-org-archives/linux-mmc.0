From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 2/6] dt: move guts devicetree doc out of powerpc directory
Date: Mon, 14 Dec 2015 12:24:23 +0800
Message-ID: <1450067067-44869-3-git-send-email-yangbo.lu@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:50903
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752234AbbLNEcK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Dec 2015 23:32:10 -0500
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Move guts devicetree doc to Documentation/devicetree/bindings/soc/
since it's used by not only PowerPC but also ARM. Add a specification
for 'little-endian' property.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- Added this patch
---
 Documentation/devicetree/bindings/{powerpc/fsl => soc}/guts.txt | 3 +++
 1 file changed, 3 insertions(+)
 rename Documentation/devicetree/bindings/{powerpc/fsl => soc}/guts.txt (90%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/guts.txt
similarity index 90%
rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
rename to Documentation/devicetree/bindings/soc/guts.txt
index b71b203..6ae2269 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/soc/guts.txt
@@ -25,6 +25,9 @@ Recommended properties:
  - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
    registers, for those SOCs that have a PAMU device.
 
+ - little-endian : Indicates that the global utilities block is little
+   endian mode. And it's big endian mode in default.
+
 Examples:
 	global-utilities@e0000 {	/* global utilities block */
 		compatible = "fsl,mpc8548-guts";
-- 
2.1.0.27.g96db324

