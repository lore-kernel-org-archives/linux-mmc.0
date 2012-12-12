From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 02/14] mmc: sh_mmcif: ensure run-time suspend call is processed before suspend
Date: Wed, 12 Dec 2012 15:38:06 +0100
Message-ID: <1355323098-18061-3-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>
List-Id: linux-mmc@vger.kernel.org

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

With this post-v2.6.35 change applied:

commit a0a1a5fd4fb15ec61117c759fe9f5c16c53d9e9c
Author: Tejun Heo <tj@kernel.org>
Date:   Tue Jun 29 10:07:12 2010 +0200
    workqueue: reimplement workqueue freeze using max_active

freeze_workqueues_begin() was introduced and workqueue now gets frozen
before device drivers suspend operations.

We have to ensure that run-time PM suspend operation completes before
system-wide suspend is started.

igned-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
igned-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 543f6ce..8a188fe 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -982,7 +982,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		if (host->power) {
-			pm_runtime_put(&host->pd->dev);
+			pm_runtime_put_sync(&host->pd->dev);
 			clk_disable(host->hclk);
 			host->power = false;
 			if (ios->power_mode == MMC_POWER_OFF)
-- 
1.7.2.5

