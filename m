From: <grygorii.strashko@linaro.org>
Subject: [PATCH] mmc: omap_hsmmc: add hibernation support
Date: Fri, 27 Feb 2015 13:24:34 +0200
Message-ID: <1425036274-9017-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34709 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbB0LYm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 06:24:42 -0500
Received: by lbdu14 with SMTP id u14so16576558lbd.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2015 03:24:41 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>
Cc: nm@ti.com, sumit.semwal@linaro.org, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Russ Dill <Russ.Dill@ti.com>

Setting a dev_pm_ops suspend/resume pair but not a set of
hibernation functions means those pm functions will not be
called upon hibernation.
Fix this by using SET_SYSTEM_SLEEP_PM_OPS, which appropriately
assigns the suspend and hibernation handlers and move
omap_hsmmc_x callbacks under CONFIG_PM_SLEEP to avoid build warnings.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
[Grygorii.Strashko@linaro.org: rebased on top of K4.0]
Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---

original patch: https://github.com/russdill/linux/commit/2ea98def0717f0918426c2004122c63d52cff1b4

 drivers/mmc/host/omap_hsmmc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f84cfb0..9cc1ea3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2236,7 +2236,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -2292,10 +2292,6 @@ static int omap_hsmmc_resume(struct device *dev)
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
 }
-
-#else
-#define omap_hsmmc_suspend	NULL
-#define omap_hsmmc_resume	NULL
 #endif
 
 static int omap_hsmmc_runtime_suspend(struct device *dev)
@@ -2376,8 +2372,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
-	.suspend	= omap_hsmmc_suspend,
-	.resume		= omap_hsmmc_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
 	.runtime_suspend = omap_hsmmc_runtime_suspend,
 	.runtime_resume = omap_hsmmc_runtime_resume,
 };
-- 
1.9.1

