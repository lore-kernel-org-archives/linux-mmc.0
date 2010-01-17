From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 8/10] omap_hsmmc: Fix disable timeouts
Date: Sun, 17 Jan 2010 03:33:51 +0200
Message-ID: <20100117013351.17308.25436.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49323 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0AQBee (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:34:34 -0500
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

>From c72533ba49f8810bcb67ac8ebcb57d440480a06b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 14:20:23 +0200
Subject: [PATCH] omap_hsmmc: Fix disable timeouts

Disable timeouts are in msecs not jiffies.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e15d0f4..cb94044 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1620,7 +1620,7 @@ static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
 	if (host->power_mode == MMC_POWER_OFF)
 		return 0;
 
-	return msecs_to_jiffies(OMAP_MMC_SLEEP_TIMEOUT);
+	return OMAP_MMC_SLEEP_TIMEOUT;
 }
 
 /* Handler for [DISABLED -> REGSLEEP / CARDSLEEP] transition */
@@ -1663,7 +1663,7 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	    mmc_slot(host).card_detect ||
 	    (mmc_slot(host).get_cover_state &&
 	     mmc_slot(host).get_cover_state(host->dev, host->slot_id)))
-		return msecs_to_jiffies(OMAP_MMC_OFF_TIMEOUT);
+		return OMAP_MMC_OFF_TIMEOUT;
 
 	return 0;
 }
-- 
1.6.0.4

