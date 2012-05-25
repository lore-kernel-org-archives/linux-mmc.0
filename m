From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/5 v3] mmc: sh_mmcif: remove redundant .down_pwr() callback
Date: Fri, 25 May 2012 17:14:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251225330.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57868 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab2EYPOm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:14:42 -0400
In-Reply-To: <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

>From the original version of sh_mmcif the .set_pwr() callback has only been
used to turn the card's power on, and the .down_pwr() callback has been
used to turn it off. .set_pwr() can be used for both these tasks, which is
also how it is implemented by the only user of this API: the SH7724 ecovec
board.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bdf42d5..3834b21 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -963,8 +963,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			pm_runtime_put(&host->pd->dev);
 			clk_disable(host->hclk);
 			host->power = false;
-			if (p->down_pwr && ios->power_mode == MMC_POWER_OFF)
-				p->down_pwr(host->pd);
+			if (p->set_pwr && ios->power_mode == MMC_POWER_OFF)
+				p->set_pwr(host->pd, 0);
 		}
 		host->state = STATE_IDLE;
 		return;
-- 
1.7.2.5

