From: Haijun Zhang <haijun.zhang@freescale.com>
Subject: [PATCH] mmc:host: Correct the Register bit in eSDHCI_HOST_CONTROL
Date: Sun, 7 Apr 2013 15:58:02 +0800
Message-ID: <1365321482-31083-1-git-send-email-haijun.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:49817
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161582Ab3DGIdh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 04:33:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <haijun.zhang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

Avoid writting to SDHCI_HOST_CONTROL[DTW] bit by mistake.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index d25f9ab..d33bb95 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -40,7 +40,7 @@
 #define ESDHC_DMA_SYSCTL	0x40c
 #define ESDHC_DMA_SNOOP		0x00000040
 
-#define ESDHC_HOST_CONTROL_RES	0x05
+#define ESDHC_HOST_CONTROL_RES	0x01
 
 static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-- 
1.7.0.4


