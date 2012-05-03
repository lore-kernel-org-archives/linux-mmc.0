From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/29] mmc: sh_mmcif: remove redundant .down_pwr() callback
Date: Thu,  3 May 2012 17:05:30 +0200
Message-ID: <1336057558-11031-2-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

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
index ed59392..19c7576 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -957,8 +957,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

