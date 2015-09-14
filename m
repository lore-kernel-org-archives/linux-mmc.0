From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 3/6] mmc: dt: add DT bindings for Freescale eSDHC
Date: Mon, 14 Sep 2015 19:43:44 +0800
Message-ID: <1442231024-10660-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0139.outbound.protection.outlook.com ([207.46.100.139]:46603
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752483AbbINMEh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 08:04:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Document Freescale eSDHC 'adapter-type' and 'peripheral-frequency'
properties.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index b7943f3..2006408 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -22,6 +22,18 @@ Optional properties:
   - voltage-ranges : two cells are required, first cell specifies minimum
     slot voltage (mV), second cell specifies maximum slot voltage (mV).
     Several ranges could be specified.
+  - adapter-tye: specifies SDHC Adapter card type. The Adapter card types are
+    as below.
+	TYPE_1      0x1   /* eMMC Card Rev4.5 */
+	TYPE_2      0x2   /* SD/MMC Legacy Card */
+	TYPE_3      0x3   /* eMMC Card Rev4.4 */
+	TYPE_4      0x4   /* Reserved */
+	TYPE_5      0x5   /* MMC Card */
+	TYPE_6      0x6   /* SD Card Rev2.0 Rev3.0 */
+	NO_ADAPTER  0x7   /* No Card is Present*/
+  - peripheral-frequency: specifies peripheral clock frequency value.
+
+
 
 Example:
 
-- 
2.1.0.27.g96db324

