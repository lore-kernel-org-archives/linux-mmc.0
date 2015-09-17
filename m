From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 3/8] mmc: dt: add DT bindings for Freescale eSDHC
Date: Thu, 17 Sep 2015 13:50:49 +0800
Message-ID: <1442469054-23644-3-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:6417
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbbIQF51 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 01:57:27 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
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

