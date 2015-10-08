From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v6, 1/4] mmc: dt: add DT binding for little-endian eSDHC host controller
Date: Thu, 8 Oct 2015 18:36:23 +0800
Message-ID: <1444300583-26539-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0141.outbound.protection.outlook.com ([65.55.169.141]:56960
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751261AbbJHKmw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Oct 2015 06:42:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com, arnd@arndb.de
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v4:
	- Added this mmc DT documentation patch
Changes for v5:
	- Updated DT documentation fsl-esdhc.txt instead of mmc.txt
	- Used 'big-endian' as default endian mode
Changes for v6: None
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

