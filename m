From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 1/6] mmc: dt: add DT binding for big endian controller
Date: Fri, 31 Jul 2015 11:54:20 +0800
Message-ID: <1438314860-47412-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0132.outbound.protection.outlook.com ([157.56.110.132]:1728
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751158AbbGaD72 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jul 2015 23:59:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Add specification of 'big-endian' property. if the controller
is big endian mode, specify this property in device tree node.
The default endian mode is little endian.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 0384fc3..10d0df9f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -47,6 +47,8 @@ Optional properties:
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- big-endian: If the host controller is big-endian mode, specify this property.
+  The default endian mode is little-endian if no 'big-endian' property specified.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.1.0.27.g96db324

