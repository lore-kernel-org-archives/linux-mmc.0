From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 11/16] mmc: omap_hsmmc: ensure pbias configuration is always done
Date: Fri,  6 May 2011 12:14:10 +0300
Message-ID: <1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45082 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab1EFJPE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 05:15:04 -0400
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

Go through the driver's set_power() functions rather than
calling regulator_enable/disable() directly because otherwise
pbias configuration for MMC1 is not done.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4f6e552..8aa9440 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -445,15 +445,14 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		* framework is fixed, we need a workaround like this
 		* (which is safe for MMC, but not in general).
 		*/
-		if (regulator_is_enabled(host->vcc) > 0) {
-			regulator_enable(host->vcc);
-			regulator_disable(host->vcc);
-		}
-		if (host->vcc_aux) {
-			if (regulator_is_enabled(reg) > 0) {
-				regulator_enable(reg);
-				regulator_disable(reg);
-			}
+		if (regulator_is_enabled(host->vcc) > 0 ||
+		    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
+			int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
+
+			mmc_slot(host).set_power(host->dev, host->slot_id,
+						 1, vdd);
+			mmc_slot(host).set_power(host->dev, host->slot_id,
+						 0, 0);
 		}
 	}
 
-- 
1.7.0.4

