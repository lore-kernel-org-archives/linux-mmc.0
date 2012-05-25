From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3 v3] mmc: sh_mmcif: re-read the clock frequency every time the clock is turned on
Date: Fri, 25 May 2012 17:45:19 +0200
Message-ID: <1337960752-4944-5-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

With aggressive clock gating the clock can be disabled during interface
inactivity. During this time its frequency can be changed by another its
user. Therefore when the interface is activated again and the clock is
re-enabled, its frequency has to be re-read.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: also move clk_enable() inside sh_mmcif_clk_update(), check its return 
value in .probe()

 drivers/mmc/host/sh_mmcif.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e5e8198..bdf42d5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -916,6 +916,19 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sh_mmcif_start_cmd(host, mrq);
 }
 
+static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
+{
+	int ret = clk_enable(host->hclk);
+
+	if (!ret) {
+		host->clk = clk_get_rate(host->hclk);
+		host->mmc->f_max = host->clk / 2;
+		host->mmc->f_min = host->clk / 512;
+	}
+
+	return ret;
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
@@ -961,7 +974,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!host->power) {
 			if (p->set_pwr)
 				p->set_pwr(host->pd, ios->power_mode);
-			clk_enable(host->hclk);
+			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
@@ -1314,10 +1327,9 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get clock \"%s\": %d\n", clk_name, ret);
 		goto eclkget;
 	}
-	clk_enable(host->hclk);
-	host->clk = clk_get_rate(host->hclk);
-	mmc->f_max = host->clk / 2;
-	mmc->f_min = host->clk / 512;
+	ret = sh_mmcif_clk_update(host);
+	if (ret < 0)
+		goto eclkupdate;
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
@@ -1359,6 +1371,7 @@ ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
 eresume:
 	clk_disable(host->hclk);
+eclkupdate:
 	clk_put(host->hclk);
 eclkget:
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
