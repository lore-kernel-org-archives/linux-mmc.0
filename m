From: Viswanath Puttagunta <vishp@ti.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: Errata i705: SD hot unplug
Date: Thu, 24 May 2012 15:14:25 -0500
Message-ID: <1337890467-32573-2-git-send-email-vishp@ti.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55494 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756132Ab2EXUOb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 May 2012 16:14:31 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4OKEVC6014570
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
Received: from DFLE71.ent.ti.com (dfle71.ent.ti.com [128.247.5.62])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4OKEUis010788
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:30 -0500
In-Reply-To: <1337890467-32573-1-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux-mmc <linux-mmc@vger.kernel.org>
Cc: T Krishnamoorthy Balaji <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>, Viswanath Puttagunta <vishp@ti.com>

Turn off IO & PBIAS cells and then SD card VMMC as soon
as we get disconnect interrupt. Failure to do so might
cause current spikes (latch-up issue) which can potentially
burn the IO cells.

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 56d4499..61d830f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1177,10 +1177,17 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 		carddetect = -ENOSYS;
 	}
 
-	if (carddetect)
+	if (carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	else
-		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
+	} else {
+		if ((MMC_POWER_OFF != host->power_mode) &&
+				(mmc_slot(host).set_power != NULL)) {
+			mmc_slot(host).set_power(host->dev, host->slot_id,
+						0, 0);
+			host->power_mode = MMC_POWER_OFF;
+		}
+		mmc_detect_change(host->mmc, 0);
+	}
 	return IRQ_HANDLED;
 }
 
-- 
1.7.4.1

