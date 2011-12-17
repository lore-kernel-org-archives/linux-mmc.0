From: Dmitry Shmidt <dimitrysh@google.com>
Subject: [PATCH] mmc: Set suspend/resume bus operations if CONFIG_PM_RUNTIME is used
Date: Fri, 16 Dec 2011 17:52:18 -0800
Message-ID: <20111219223534.B9D4A38333@ushik.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:47805 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1LSWff (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 17:35:35 -0500
Received: by ghrr15 with SMTP id r15so515089ghr.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2011 14:35:35 -0800 (PST)
Received: from ushik.mtv.corp.google.com (ushik.mtv.corp.google.com [172.18.102.96])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 246C21E004D
	for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2011 14:35:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
---
 drivers/mmc/core/bus.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 393d817..e07d6c9 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -120,18 +120,19 @@ static int mmc_bus_remove(struct device *dev)
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, pm_message_t state)
+static int mmc_bus_pm_suspend(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	int ret = 0;
+	pm_message_t state = { PM_EVENT_SUSPEND };
 
 	if (dev->driver && drv->suspend)
 		ret = drv->suspend(card, state);
 	return ret;
 }
 
-static int mmc_bus_resume(struct device *dev)
+static int mmc_bus_pm_resume(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -143,7 +144,6 @@ static int mmc_bus_resume(struct device *dev)
 }
 
 #ifdef CONFIG_PM_RUNTIME
-
 static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -162,21 +162,13 @@ static int mmc_runtime_idle(struct device *dev)
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
@@ -184,9 +176,7 @@ static struct bus_type mmc_bus_type = {
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
-	.suspend	= mmc_bus_suspend,
-	.resume		= mmc_bus_resume,
-	.pm		= MMC_PM_OPS_PTR,
+	.pm		= &mmc_bus_pm_ops,
 };
 
 int mmc_register_bus(void)
-- 
1.7.3.1

