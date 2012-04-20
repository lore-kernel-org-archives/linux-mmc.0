From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/5] mmc: sh_mmcif: remove redundant .down_pwr() callback
Date: Fri, 20 Apr 2012 18:59:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204201838360.3974@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
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

