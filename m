From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/7] mmc: sd_mmcif: Move clock handling into runtime PM callbacks
Date: Wed,  2 Oct 2013 10:30:49 +0200
Message-ID: <1380702651-13389-6-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:60401 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3JBIbL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:31:11 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so340236lab.41
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:31:09 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Implement callbacks for runtime suspend|resume and leave the clock
to be handled from there.

The .set_ios function is still capable of using the interal registers
to gate the clock when the frequency is zero, but the operations needed
towards the clk API is now handled from the runtime callbacks.

>From now on, CONFIG_PM_RUNTIME is required handle power save with full
clock gating at request inactivity.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   47 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index f4532dc..e234856 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -964,19 +964,6 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sh_mmcif_start_cmd(host, mrq);
 }
 
-static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
-{
-	int ret = clk_prepare_enable(host->hclk);
-
-	if (!ret) {
-		host->clk = clk_get_rate(host->hclk);
-		host->mmc->f_max = host->clk / 2;
-		host->mmc->f_min = host->clk / 512;
-	}
-
-	return ret;
-}
-
 static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -1021,7 +1008,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		if (host->power) {
-			clk_disable_unprepare(host->hclk);
 			host->power = false;
 			if (ios->power_mode == MMC_POWER_OFF)
 				sh_mmcif_set_power(host, ios);
@@ -1032,7 +1018,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			sh_mmcif_clk_update(host);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
 		}
@@ -1440,9 +1425,16 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto eofparse;
 	}
-	ret = sh_mmcif_clk_update(host);
-	if (ret < 0)
+
+	ret = clk_prepare_enable(host->hclk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable clock: %d\n", ret);
 		goto eclkupdate;
+	}
+
+	host->clk = clk_get_rate(host->hclk);
+	host->mmc->f_max = host->clk / 2;
+	host->mmc->f_min = host->clk / 512;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
@@ -1478,7 +1470,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
@@ -1568,6 +1559,24 @@ static int sh_mmcif_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int sh_mmcif_runtime_suspend(struct device *dev)
+{
+	struct sh_mmcif_host *host = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(host->hclk);
+	return 0;
+}
+
+static int sh_mmcif_runtime_resume(struct device *dev)
+{
+	struct sh_mmcif_host *host = dev_get_drvdata(dev);
+
+	clk_prepare_enable(host->hclk);
+	return 0;
+}
+#endif
+
 static const struct of_device_id mmcif_of_match[] = {
 	{ .compatible = "renesas,sh-mmcif" },
 	{ }
@@ -1576,6 +1585,8 @@ MODULE_DEVICE_TABLE(of, mmcif_of_match);
 
 static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sh_mmcif_suspend, sh_mmcif_resume)
+	SET_RUNTIME_PM_OPS(sh_mmcif_runtime_suspend, sh_mmcif_runtime_resume,
+			   NULL)
 };
 
 static struct platform_driver sh_mmcif_driver = {
-- 
1.7.9.5

