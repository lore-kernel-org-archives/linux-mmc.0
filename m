From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Remove redundant runtime_idle callback
Date: Wed, 28 May 2014 11:44:05 +0200
Message-ID: <1401270245-20163-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:44977 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaE1JoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 05:44:10 -0400
Received: by mail-la0-f45.google.com with SMTP id gl10so7269169lab.18
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 02:44:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

The runtime PM core handles a runtime_idle callback set to NULL as one
returning 0. So, let's just set it to NULL instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d2dbf02..8a1f124 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -180,7 +180,6 @@ static int mmc_bus_resume(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
-
 static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -196,17 +195,10 @@ static int mmc_runtime_resume(struct device *dev)
 
 	return host->bus_ops->runtime_resume(host);
 }
-
-static int mmc_runtime_idle(struct device *dev)
-{
-	return 0;
-}
-
 #endif /* !CONFIG_PM_RUNTIME */
 
 static const struct dev_pm_ops mmc_bus_pm_ops = {
-	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume,
-			mmc_runtime_idle)
+	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
 };
 
-- 
1.7.9.5

