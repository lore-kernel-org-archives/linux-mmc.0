From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v5, 3/5] dt: move guts devicetree doc out of powerpc directory
Date: Fri, 4 Mar 2016 17:38:39 +0800
Message-ID: <1457084321-10003-4-git-send-email-yangbo.lu@nxp.com>
References: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0080.outbound.protection.outlook.com ([65.55.169.80]:51595
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751557AbcCDKDs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 05:03:48 -0500
In-Reply-To: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, scott.wood@nxp.com, leoyang.li@nxp.com, xiaobo.xie@nxp.com, Rob Herring <robh+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>

Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/
since it's used by not only PowerPC but also ARM. And add a specification
for 'little-endian' property.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- Added this patch
Changes for v5:
	- Modified the description for little-endian property
---
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt | 3 +++
 1 file changed, 3 insertions(+)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
similarity index 91%
rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
index b71b203..07adca9 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
@@ -25,6 +25,9 @@ Recommended properties:
  - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
    registers, for those SOCs that have a PAMU device.
 
+ - little-endian : Indicates that the global utilities block is little
+   endian. The default is big endian.
+
 Examples:
 	global-utilities@e0000 {	/* global utilities block */
 		compatible = "fsl,mpc8548-guts";
-- 
2.1.0.27.g96db324

