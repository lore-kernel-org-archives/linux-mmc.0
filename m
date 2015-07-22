From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: [PATCHv2 ] sdhci-esdhc: Make 8BIT bus work.
Date: Wed, 22 Jul 2015 16:44:26 +0200
Message-ID: <1437576266-21120-1-git-send-email-joakim.tjernlund@transmode.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:54031 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965204AbbGVOod (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:44:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>

Support for 8BIT bus with was added some time ago to sdhci-esdhc but
then missed to remove the 8BIT from the reserved bit mask which made
8BIT non functional.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Fixes: 66b50a00992d ("mmc: esdhc: Add support for 8-bit bus width and non-removable card")
---

 - v2: Added Fixes: tag
 
 drivers/mmc/host/sdhci-esdhc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 3497cfa..a870c42 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -45,6 +45,6 @@
 #define ESDHC_DMA_SYSCTL	0x40c
 #define ESDHC_DMA_SNOOP		0x00000040
 
-#define ESDHC_HOST_CONTROL_RES	0x05
+#define ESDHC_HOST_CONTROL_RES	0x01
 
 #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
-- 
2.3.6

