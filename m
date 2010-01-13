From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 7/8] omap_hsmmc: fix disable timeouts
Date: Wed, 13 Jan 2010 13:41:03 +0200
Message-ID: <20100113114103.7615.80699.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21002 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab0AMLlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2010 06:41:13 -0500
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

>From 9c232fcf9aab259a6b3b33497396a94249f747f3 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 14:20:23 +0200
Subject: [PATCH] omap_hsmmc: fix disable timeouts

Disable timeouts are in msecs not jiffies.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1b2df82..677be61 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1699,7 +1699,7 @@ static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
 	if (host->power_mode == MMC_POWER_OFF)
 		return 0;
 
-	return msecs_to_jiffies(OMAP_MMC_SLEEP_TIMEOUT);
+	return OMAP_MMC_SLEEP_TIMEOUT;
 }
 
 /* Handler for [DISABLED -> REGSLEEP / CARDSLEEP] transition */
@@ -1742,7 +1742,7 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	    mmc_slot(host).card_detect ||
 	    (mmc_slot(host).get_cover_state &&
 	     mmc_slot(host).get_cover_state(host->dev, host->slot_id)))
-		return msecs_to_jiffies(OMAP_MMC_OFF_TIMEOUT);
+		return OMAP_MMC_OFF_TIMEOUT;
 
 	return 0;
 }
-- 
1.6.0.4

