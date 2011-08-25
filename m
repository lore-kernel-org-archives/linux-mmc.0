From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH 1/2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Thu, 25 Aug 2011 16:53:34 +0800
Message-ID: <1314262414-31787-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:11476
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752320Ab1HYJ4A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 05:56:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>, Shengzhou Liu <b36685@freescale.com>, Chris Ball <cjb@laptop.org>

The mmc_delay() is a wrapper function for mdelay() and msleep().

    o mdelay() -- block the system when busy-waiting.
    o msleep() -- suspend the currently running task to enable CPU
                  to process other tasks, so it is non-blocking
                  regarding the whole system.

When the desired delay time is more than a period of timer interrupt,
just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
CPU when busy wait.

Signed-off-by: Shengzhou Liu <b36685@freescale.com>
Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-esdhc.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..42b1d9eb 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver generics for OF and pltfm.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -14,6 +14,8 @@
 #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
 #define _DRIVERS_MMC_SDHCI_ESDHC_H
 
+#include "../core/core.h"
+
 /*
  * Ops and quirks for the Freescale eSDHC controller.
  */
@@ -73,7 +75,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(100);
+	mmc_delay(100);
 out:
 	host->clock = clock;
 }
-- 
1.7.5.1


