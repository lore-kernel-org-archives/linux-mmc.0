From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: fix clock gating on platforms, implementing
 a .down_pwr() method
Date: Wed, 16 Nov 2011 10:10:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1111161009060.1100@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52600 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab1KPJKn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 04:10:43 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Do not power down the card in .set_ios(), unless MMC_POWER_OFF is 
requested. This fixes the MMCIF interface functionality on ecovec boards.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 557886b..c021482 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -895,7 +895,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (host->power) {
 			pm_runtime_put(&host->pd->dev);
 			host->power = false;
-			if (p->down_pwr)
+			if (p->down_pwr && ios->power_mode == MMC_POWER_OFF)
 				p->down_pwr(host->pd);
 		}
 		host->state = STATE_IDLE;
-- 
1.7.2.5

