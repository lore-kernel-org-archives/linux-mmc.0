From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/7] mmc: sh_mmcif: Convert to clk_prepare|unprepare
Date: Wed,  2 Oct 2013 10:30:47 +0200
Message-ID: <1380702651-13389-4-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:63971 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3JBIbF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:31:05 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so349553lab.3
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:31:04 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Previously only clk_enable|disable were being used. Adapt properly
to the clock API, by also using clk_prepare|unprepare.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 32bc412..d032b08 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -964,7 +964,7 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 {
-	int ret = clk_enable(host->hclk);
+	int ret = clk_prepare_enable(host->hclk);
 
 	if (!ret) {
 		host->clk = clk_get_rate(host->hclk);
@@ -1018,7 +1018,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		if (host->power) {
 			pm_runtime_put_sync(&host->pd->dev);
-			clk_disable(host->hclk);
+			clk_disable_unprepare(host->hclk);
 			host->power = false;
 			if (ios->power_mode == MMC_POWER_OFF)
 				sh_mmcif_set_power(host, ios);
@@ -1466,7 +1466,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	mutex_init(&host->thread_lock);
 
-	clk_disable(host->hclk);
+	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
@@ -1487,7 +1487,7 @@ ereqirq1:
 ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
 eresume:
-	clk_disable(host->hclk);
+	clk_disable_unprepare(host->hclk);
 eclkupdate:
 	clk_put(host->hclk);
 eclkget:
@@ -1505,7 +1505,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	int irq[2];
 
 	host->dying = true;
-	clk_enable(host->hclk);
+	clk_prepare_enable(host->hclk);
 	pm_runtime_get_sync(&pdev->dev);
 
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
@@ -1530,7 +1530,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	if (irq[1] >= 0)
 		free_irq(irq[1], host);
 
-	clk_disable(host->hclk);
+	clk_disable_unprepare(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

