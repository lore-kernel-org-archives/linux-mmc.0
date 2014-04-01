From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 3/6] mmc: sh-mmcif: use devm_ for clock management
Date: Tue,  1 Apr 2014 13:01:43 +0100
Message-ID: <1396353706-31864-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Use the devm_clk_get() code to get the clock and allow it to be freed
automatically on release.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bb8e4e6..fbd7364 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1391,7 +1391,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto eofparse;
+		goto err_host;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1421,19 +1421,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
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
 
@@ -1484,13 +1484,11 @@ ereqirq1:
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
1.9.0

