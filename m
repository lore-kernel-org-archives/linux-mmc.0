From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/6] mmc: sh-mmcif: use devm_ for clock management
Date: Wed,  4 Jun 2014 12:42:10 +0100
Message-ID: <1401882133-11050-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45914 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752049AbaFDLm3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:29 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

Use the devm_clk_get() code to get the clock and allow it to be freed
automatically on release.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 3ed54c8..ae278a5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1389,7 +1389,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto eofparse;
+		goto err_host;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1419,19 +1419,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	host->power = false;
 
-	host->hclk = clk_get(&pdev->dev, NULL);
+	host->hclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->hclk)) {
 		ret = PTR_ERR(host->hclk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto eclkget;
+		goto err_pm;
 	}
 	ret = sh_mmcif_clk_update(host);
 	if (ret < 0)
-		goto eclkupdate;
+		goto err_pm;
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-		goto eresume;
+		goto err_clk;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
@@ -1482,13 +1482,11 @@ ereqirq1:
 	free_irq(irq[0], host);
 ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
-eresume:
+err_clk:
 	clk_disable_unprepare(host->hclk);
-eclkupdate:
-	clk_put(host->hclk);
-eclkget:
+err_pm:
 	pm_runtime_disable(&pdev->dev);
-eofparse:
+err_host:
 	mmc_free_host(mmc);
 	return ret;
 }
-- 
2.0.0.rc2

