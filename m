From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: [PATCH] sdhci-esdhc: Make 8BIT bus work.
Date: Mon, 20 Jul 2015 18:19:47 +0200
Message-ID: <1437409187-7039-1-git-send-email-joakim.tjernlund@transmode.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:54026 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbbGTQ0B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jul 2015 12:26:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kevin Hao <haokexin@gmail.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>

Support for 8BIT bus with was added some time ago to sdhci-esdhc but
then missed to remove the 8BIT from the reserved bit mask which made
8BIT non functional.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
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

