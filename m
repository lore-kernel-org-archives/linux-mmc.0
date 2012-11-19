From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 2/4] mmc: dt: Add optional pm properties to core binding
Date: Mon, 19 Nov 2012 10:26:19 +0530
Message-ID: <1353300981-24652-3-git-send-email-a.kesavan@samsung.com>
References: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18408 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab2KSEwE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 23:52:04 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDP00E4RXIQS1J0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:02 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDP00338XGFP3E0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:02 +0900 (KST)
In-reply-to: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

Add documentation for pm capabilties such as MMC_PM_KEEP_POWER
and MMC_PM_WAKE_SDIO_IRQ.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8e2e0ba..1b6a1f8 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -21,6 +21,8 @@ Optional properties:
 - cd-inverted: when present, polarity on the cd gpio line is inverted
 - wp-inverted: when present, polarity on the wp gpio line is inverted
 - max-frequency: maximum operating clock frequency
+- keep-power-in-suspend: Preserves card power during a suspend/resume cycle
+- enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
 Example:
 
@@ -33,4 +35,6 @@ sdhci@ab000000 {
 	cd-inverted;
 	wp-gpios = <&gpio 70 0>;
 	max-frequency = <50000000>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
 }
-- 
1.6.6.1

