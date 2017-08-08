From: Doug Wilson <doug.lkml@gmail.com>
Subject: [PATCH] omap/hsmmc: constify dev_pm_ops
Date: Tue,  8 Aug 2017 16:44:17 +0530
Message-ID: <1502190857-3762-1-git-send-email-doug.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Wilson <doug.lkml@gmail.com>, Doug Wilson <doug.wilson@gmail.com>
List-Id: linux-mmc@vger.kernel.org

dev_pm_ops is not supposed to change at runtime. Marking it
constant.

Signed-off-by: Doug Wilson <doug.wilson@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 04ff3c9..a280c7f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2322,7 +2322,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
+static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
 	.runtime_suspend = omap_hsmmc_runtime_suspend,
 	.runtime_resume = omap_hsmmc_runtime_resume,
-- 
2.7.4
