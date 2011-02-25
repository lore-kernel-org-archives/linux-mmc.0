From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: support aggressive clock gating
Date: Fri, 25 Feb 2011 16:58:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1102251657290.26361@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411Ab1BYP6k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 10:58:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org

To support MMC aggressive clock gating the driver has to stop the interface
clock, when the .set_ios() method is called with .clock == 0.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Tested on ap4evb and ecovec

 drivers/mmc/host/sh_mmcif.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 12884c2..3d735da 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -850,15 +850,15 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 
-	if (ios->power_mode == MMC_POWER_OFF) {
+	if (ios->power_mode == MMC_POWER_UP) {
+		if (p->set_pwr)
+			p->set_pwr(host->pd, ios->power_mode);
+	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
-		if (p->down_pwr)
+		if (ios->power_mode == MMC_POWER_OFF && p->down_pwr)
 			p->down_pwr(host->pd);
 		return;
-	} else if (ios->power_mode == MMC_POWER_UP) {
-		if (p->set_pwr)
-			p->set_pwr(host->pd, ios->power_mode);
 	}
 
 	if (ios->clock)
-- 
1.7.2.3

