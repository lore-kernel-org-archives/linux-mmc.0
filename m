From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH] dt: Document: Add optional dw_mmc pm bindings
Date: Wed, 07 Nov 2012 16:37:39 +0530
Message-ID: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28589 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab2KGLCz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Nov 2012 06:02:55 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD4004XS6OPY420@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 07 Nov 2012 20:02:54 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MD4007RB6LNNL20@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 07 Nov 2012 20:02:54 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, cjb@laptop.org, linux-mmc@vger.kernel.org, will.newton@imgtec.com

Add documentation for pm capabilties such as MMC_PM_KEEP_POWER
and MMC_PM_WAKE_SDIO_IRQ.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
index 06cd32d..fa6806d 100644
--- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
@@ -47,6 +47,11 @@ Optional properties:
 
 * broken-cd: as documented in mmc core bindings.
 
+* keep-power-in-suspend: Preserves card power during a suspend/resume cycle.
+
+* enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion.
+
+ Samsung Exynos5250 specific properties:
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
@@ -69,6 +74,8 @@ board specific portions as listed below.
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
+		keep-power-in-suspend;
+		enable-sdio-wakeup;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 
-- 
1.6.6.1

