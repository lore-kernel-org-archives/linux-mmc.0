From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3 v3] mmc: sh_mmcif: fix clock management
Date: Fri, 25 May 2012 17:14:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251132010.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251123380.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab2EYPOV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:14:21 -0400
In-Reply-To: <Pine.LNX.4.64.1205251123380.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Regardless, whether the MMC bus clock is the same, as the PM clock on this
specific interface, it has to be managed separately. Its proper management
should also include enabling and disabling of the clock, whenever the
interface is becoming active or going idle respectively.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   46 +++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 01db31c..e5e8198 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -948,6 +948,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		if (host->power) {
 			pm_runtime_put(&host->pd->dev);
+			clk_disable(host->hclk);
 			host->power = false;
 			if (p->down_pwr && ios->power_mode == MMC_POWER_OFF)
 				p->down_pwr(host->pd);
@@ -960,6 +961,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!host->power) {
 			if (p->set_pwr)
 				p->set_pwr(host->pd, ios->power_mode);
+			clk_enable(host->hclk);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
@@ -1284,22 +1286,11 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->addr	= reg;
 	host->timeout	= 1000;
 
-	snprintf(clk_name, sizeof(clk_name), "mmc%d", pdev->id);
-	host->hclk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(host->hclk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		ret = PTR_ERR(host->hclk);
-		goto eclkget;
-	}
-	clk_enable(host->hclk);
-	host->clk = clk_get_rate(host->hclk);
 	host->pd = pdev;
 
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
-	mmc->f_max = host->clk / 2;
-	mmc->f_min = host->clk / 512;
 	if (pd->ocr)
 		mmc->ocr_avail = pd->ocr;
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
@@ -1311,18 +1302,30 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	mmc->max_blk_count = mmc->max_req_size / mmc->max_blk_size;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	sh_mmcif_sync_reset(host);
 	platform_set_drvdata(pdev, host);
 
 	pm_runtime_enable(&pdev->dev);
 	host->power = false;
 
+	snprintf(clk_name, sizeof(clk_name), "mmc%d", pdev->id);
+	host->hclk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(host->hclk)) {
+		ret = PTR_ERR(host->hclk);
+		dev_err(&pdev->dev, "cannot get clock \"%s\": %d\n", clk_name, ret);
+		goto eclkget;
+	}
+	clk_enable(host->hclk);
+	host->clk = clk_get_rate(host->hclk);
+	mmc->f_max = host->clk / 2;
+	mmc->f_min = host->clk / 512;
+
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
 		goto eresume;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
+	sh_mmcif_sync_reset(host);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
 	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:error", host);
@@ -1336,6 +1339,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		goto ereqirq1;
 	}
 
+	clk_disable(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
@@ -1354,9 +1358,10 @@ ereqirq1:
 ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
 eresume:
-	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
+	clk_put(host->hclk);
 eclkget:
+	pm_runtime_disable(&pdev->dev);
 	mmc_free_host(mmc);
 ealloch:
 	iounmap(reg);
@@ -1369,6 +1374,7 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	int irq[2];
 
 	host->dying = true;
+	clk_enable(host->hclk);
 	pm_runtime_get_sync(&pdev->dev);
 
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
@@ -1394,9 +1400,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
+	clk_disable(host->hclk);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -1405,24 +1411,18 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int sh_mmcif_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
+	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 	int ret = mmc_suspend_host(host->mmc);
 
-	if (!ret) {
+	if (!ret)
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
-		clk_disable(host->hclk);
-	}
 
 	return ret;
 }
 
 static int sh_mmcif_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
-
-	clk_enable(host->hclk);
+	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 
 	return mmc_resume_host(host->mmc);
 }
-- 
1.7.2.5

