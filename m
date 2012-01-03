From: Dmitry Shmidt <dimitrysh@google.com>
Subject: [PATCH V2] mmc: Set suspend/resume bus operations if CONFIG_PM_RUNTIME is used
Date: Tue, 3 Jan 2012 14:47:05 -0800
Message-ID: <20120103231445.9CA943835D@ushik.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f74.google.com ([209.85.161.74]:36757 "EHLO
	mail-fx0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab2ACXXI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2012 18:23:08 -0500
Received: by faar15 with SMTP id r15so531307faa.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jan 2012 15:23:06 -0800 (PST)
Received: from ushik.mtv.corp.google.com (ushik.mtv.corp.google.com [172.18.102.96])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 43B895C0060
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jan 2012 15:14:46 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
---
 drivers/mmc/card/block.c |    2 +-
 drivers/mmc/core/bus.c   |   25 +++++++------------------
 include/linux/mmc/card.h |    2 +-
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1e0e27c..969d49b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1677,7 +1677,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 }
 
 #ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
+static int mmc_blk_suspend(struct mmc_card *card)
 {
 	struct mmc_blk_data *part_md;
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6be4924..13ca498 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -122,18 +122,18 @@ static int mmc_bus_remove(struct device *dev)
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, pm_message_t state)
+static int mmc_bus_pm_suspend(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	int ret = 0;
 
 	if (dev->driver && drv->suspend)
-		ret = drv->suspend(card, state);
+		ret = drv->suspend(card);
 	return ret;
 }
 
-static int mmc_bus_resume(struct device *dev)
+static int mmc_bus_pm_resume(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -145,7 +145,6 @@ static int mmc_bus_resume(struct device *dev)
 }
 
 #ifdef CONFIG_PM_RUNTIME
-
 static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -164,21 +163,13 @@ static int mmc_runtime_idle(struct device *dev)
 {
 	return pm_runtime_suspend(dev);
 }
+#endif /* CONFIG_PM_RUNTIME */
 
 static const struct dev_pm_ops mmc_bus_pm_ops = {
-	.runtime_suspend	= mmc_runtime_suspend,
-	.runtime_resume		= mmc_runtime_resume,
-	.runtime_idle		= mmc_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_pm_suspend, mmc_bus_pm_resume)
+	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, mmc_runtime_idle)
 };
 
-#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
-
-#else /* !CONFIG_PM_RUNTIME */
-
-#define MMC_PM_OPS_PTR	NULL
-
-#endif /* !CONFIG_PM_RUNTIME */
-
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_attrs	= mmc_dev_attrs,
@@ -186,9 +177,7 @@ static struct bus_type mmc_bus_type = {
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
-	.suspend	= mmc_bus_suspend,
-	.resume		= mmc_bus_resume,
-	.pm		= MMC_PM_OPS_PTR,
+	.pm		= &mmc_bus_pm_ops,
 };
 
 int mmc_register_bus(void)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c8ef9bc..80caf1d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -455,7 +455,7 @@ struct mmc_driver {
 	struct device_driver drv;
 	int (*probe)(struct mmc_card *);
 	void (*remove)(struct mmc_card *);
-	int (*suspend)(struct mmc_card *, pm_message_t);
+	int (*suspend)(struct mmc_card *);
 	int (*resume)(struct mmc_card *);
 };
 
-- 
1.7.3.1

