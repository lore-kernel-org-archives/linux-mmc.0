From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/8] mmc: tmio_mmc: Convert from legacy to modern PM ops
Date: Fri,  8 Nov 2013 07:06:10 +0100
Message-ID: <1383890776-6912-3-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:60190 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGG0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:26 -0500
Received: by mail-la0-f42.google.com with SMTP id ep20so1399358lab.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:25 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 8860d4d..42da904 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -23,38 +23,37 @@
 
 #include "tmio_mmc.h"
 
-#ifdef CONFIG_PM
-static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int tmio_mmc_suspend(struct device *dev)
 {
-	const struct mfd_cell *cell = mfd_get_cell(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int ret;
 
-	ret = tmio_mmc_host_suspend(&dev->dev);
+	ret = tmio_mmc_host_suspend(dev);
 
 	/* Tell MFD core it can disable us now.*/
 	if (!ret && cell->disable)
-		cell->disable(dev);
+		cell->disable(pdev);
 
 	return ret;
 }
 
-static int tmio_mmc_resume(struct platform_device *dev)
+static int tmio_mmc_resume(struct device *dev)
 {
-	const struct mfd_cell *cell = mfd_get_cell(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int ret = 0;
 
 	/* Tell the MFD core we are ready to be enabled */
 	if (cell->resume)
-		ret = cell->resume(dev);
+		ret = cell->resume(pdev);
 
 	if (!ret)
-		ret = tmio_mmc_host_resume(&dev->dev);
+		ret = tmio_mmc_host_resume(dev);
 
 	return ret;
 }
-#else
-#define tmio_mmc_suspend NULL
-#define tmio_mmc_resume NULL
 #endif
 
 static int tmio_mmc_probe(struct platform_device *pdev)
@@ -125,15 +124,18 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 
 /* ------------------- device registration ----------------------- */
 
+static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_suspend, tmio_mmc_resume)
+};
+
 static struct platform_driver tmio_mmc_driver = {
 	.driver = {
 		.name = "tmio-mmc",
 		.owner = THIS_MODULE,
+		.pm = &tmio_mmc_dev_pm_ops,
 	},
 	.probe = tmio_mmc_probe,
 	.remove = tmio_mmc_remove,
-	.suspend = tmio_mmc_suspend,
-	.resume = tmio_mmc_resume,
 };
 
 module_platform_driver(tmio_mmc_driver);
-- 
1.7.9.5

