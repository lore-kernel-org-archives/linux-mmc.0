From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 5/7] mmc: sh_mmcif: Move clock handling into runtime PM callbacks
Date: Tue, 22 Oct 2013 16:07:24 +0200
Message-ID: <1382450846-17144-6-git-send-email-ulf.hansson@linaro.org>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:60042 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3JVOHu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 10:07:50 -0400
Received: by mail-la0-f51.google.com with SMTP id ea20so2776608lab.24
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 07:07:49 -0700 (PDT)
In-Reply-To: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
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
 drivers/mmc/host/sh_mmcif.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index f4532dc..a1f421b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1021,7 +1021,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		if (host->power) {
-			clk_disable_unprepare(host->hclk);
 			host->power = false;
 			if (ios->power_mode == MMC_POWER_OFF)
 				sh_mmcif_set_power(host, ios);
@@ -1032,7 +1031,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			sh_mmcif_clk_update(host);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
 		}
@@ -1441,7 +1439,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		goto eofparse;
 	}
 	ret = sh_mmcif_clk_update(host);
-	if (ret < 0)
+	if (ret)
 		goto eclkupdate;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
@@ -1478,7 +1476,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
@@ -1568,6 +1565,24 @@ static int sh_mmcif_resume(struct device *dev)
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
+	sh_mmcif_clk_update(host);
+	return 0;
+}
+#endif
+
 static const struct of_device_id mmcif_of_match[] = {
 	{ .compatible = "renesas,sh-mmcif" },
 	{ }
@@ -1576,6 +1591,8 @@ MODULE_DEVICE_TABLE(of, mmcif_of_match);
 
 static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sh_mmcif_suspend, sh_mmcif_resume)
+	SET_RUNTIME_PM_OPS(sh_mmcif_runtime_suspend, sh_mmcif_runtime_resume,
+			   NULL)
 };
 
 static struct platform_driver sh_mmcif_driver = {
-- 
1.7.9.5

