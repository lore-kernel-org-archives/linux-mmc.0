From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v5, 1/4] mmc: dt: add DT binding for little-endian eSDHC host controller
Date: Mon, 28 Sep 2015 14:35:01 +0800
Message-ID: <1443422101-12964-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:23373
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750843AbbI1GlL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Sep 2015 02:41:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v5:
	- Redefined io accessors for both BE and LE eSDHC
Changes for v4:
	- Moved endian mode checking back to sdhci-pltfm driver
Changes for v3:
	- Moved endian mode checking to generic mmc host driver
---
 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index b7943f3..dedfb02 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -22,6 +22,8 @@ Optional properties:
   - voltage-ranges : two cells are required, first cell specifies minimum
     slot voltage (mV), second cell specifies maximum slot voltage (mV).
     Several ranges could be specified.
+  - little-endian : If the host controller is little-endian mode, specify
+    this property. The default endian mode is big-endian.
 
 Example:
 
-- 
2.1.0.27.g96db324

