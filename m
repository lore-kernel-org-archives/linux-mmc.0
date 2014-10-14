From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/7] mmc: core: Convert the mmc_driver to use the modern PM ops
Date: Tue, 14 Oct 2014 13:45:16 +0200
Message-ID: <1413287120-10914-4-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:38827 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:36 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so8438873lab.35
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:35 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Instead of having specific mmc system PM callbacks for the mmc driver,
let's convert to use the common ones.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 16 ++++++++--------
 drivers/mmc/core/bus.c   | 14 ++++----------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1fa4c80..67a37a7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2516,15 +2516,17 @@ static void mmc_blk_shutdown(struct mmc_card *card)
 	_mmc_blk_suspend(card);
 }
 
-#ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card)
+#ifdef CONFIG_PM_SLEEP
+static int mmc_blk_suspend(struct device *dev)
 {
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	return _mmc_blk_suspend(card);
 }
 
-static int mmc_blk_resume(struct mmc_card *card)
+static int mmc_blk_resume(struct device *dev)
 {
 	struct mmc_blk_data *part_md;
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
@@ -2540,19 +2542,17 @@ static int mmc_blk_resume(struct mmc_card *card)
 	}
 	return 0;
 }
-#else
-#define	mmc_blk_suspend	NULL
-#define mmc_blk_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(mmc_blk_pm_ops, mmc_blk_suspend, mmc_blk_resume);
+
 static struct mmc_driver mmc_driver = {
 	.drv		= {
 		.name	= "mmcblk",
+		.pm	= &mmc_blk_pm_ops,
 	},
 	.probe		= mmc_blk_probe,
 	.remove		= mmc_blk_remove,
-	.suspend	= mmc_blk_suspend,
-	.resume		= mmc_blk_resume,
 	.shutdown	= mmc_blk_shutdown,
 };
 
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 8a1f124..2f37528 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -145,16 +145,13 @@ static void mmc_bus_shutdown(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int mmc_bus_suspend(struct device *dev)
 {
-	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_host *host = card->host;
 	int ret;
 
-	if (dev->driver && drv->suspend) {
-		ret = drv->suspend(card);
-		if (ret)
-			return ret;
-	}
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
 
 	ret = host->bus_ops->suspend(host);
 	return ret;
@@ -162,7 +159,6 @@ static int mmc_bus_suspend(struct device *dev)
 
 static int mmc_bus_resume(struct device *dev)
 {
-	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_host *host = card->host;
 	int ret;
@@ -172,9 +168,7 @@ static int mmc_bus_resume(struct device *dev)
 		pr_warn("%s: error %d during resume (card was removed?)\n",
 			mmc_hostname(host), ret);
 
-	if (dev->driver && drv->resume)
-		ret = drv->resume(card);
-
+	ret = pm_generic_resume(dev);
 	return ret;
 }
 #endif
-- 
1.9.1

