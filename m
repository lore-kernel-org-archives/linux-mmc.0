From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 9/10] omap_hsmmc: Ensure regulator enable / disable are paired
Date: Sun, 17 Jan 2010 03:33:58 +0200
Message-ID: <20100117013358.17308.45866.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37165 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0AQBec (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:34:32 -0500
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

>From aab14d3bf93b2b44d2f9ac09752666cc8857bf0e Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 15 Jan 2010 22:10:10 +0200
Subject: [PATCH] omap_hsmmc: Ensure regulator enable / disable are paired

Stop using 'regulator_is_enabled()' and just pair enables
with disables so that the regulator reference counts can
work correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index cb94044..d2fad58 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -296,11 +296,8 @@ static int omap_hsmmc_23_set_power(struct device *dev, int slot, int power_on,
 				ret = mmc_regulator_set_ocr(host->vcc, 0);
 		}
 	} else {
-		if (host->vcc_aux) {
-			ret = regulator_is_enabled(host->vcc_aux);
-			if (ret > 0)
-				ret = regulator_disable(host->vcc_aux);
-		}
+		if (host->vcc_aux)
+			ret = regulator_disable(host->vcc_aux);
 		if (ret == 0)
 			ret = mmc_regulator_set_ocr(host->vcc, 0);
 	}
@@ -1975,7 +1972,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
-	host->power_mode = -1;
+	host->power_mode = MMC_POWER_OFF;
 
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
-- 
1.6.0.4

