From: Balaji T K <balajitk@ti.com>
Subject: [PATCHv4 3/3] MMC: OMAP: HSMMC: Remove unused iclk
Date: Fri, 1 Jul 2011 22:09:36 +0530
Message-ID: <1309538376-23260-4-git-send-email-balajitk@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

After runtime conversion to handle clk,
iclk node is not used
However fclk node is still used to get clock rate.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3d01e3f..aae4105 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -145,7 +145,6 @@ struct omap_hsmmc_host {
 	struct	mmc_command	*cmd;
 	struct	mmc_data	*data;
 	struct	clk		*fclk;
-	struct	clk		*iclk;
 	struct	clk		*dbclk;
 	/*
 	 * vcc == configured supply
@@ -1853,17 +1852,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->irq_lock);
 
-	host->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(host->iclk)) {
-		ret = PTR_ERR(host->iclk);
-		host->iclk = NULL;
-		goto err1;
-	}
 	host->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
 		host->fclk = NULL;
-		clk_put(host->iclk);
 		goto err1;
 	}
 
@@ -2021,7 +2013,6 @@ err_irq:
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	clk_put(host->fclk);
-	clk_put(host->iclk);
 	if (host->got_dbclk) {
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
@@ -2057,7 +2048,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		pm_runtime_put_sync(host->dev);
 		pm_runtime_disable(host->dev);
 		clk_put(host->fclk);
-		clk_put(host->iclk);
 		if (host->got_dbclk) {
 			clk_disable(host->dbclk);
 			clk_put(host->dbclk);
-- 
1.7.0.4

