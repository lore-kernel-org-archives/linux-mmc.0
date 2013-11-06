From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] mmc: tmio_mmc: Convert from legacy to modern PM ops
Date: Wed,  6 Nov 2013 09:27:05 +0100
Message-ID: <1383726425-9836-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63643 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab3KFI1N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 03:27:13 -0500
Received: by mail-wi0-f169.google.com with SMTP id cb5so4472550wib.4
        for <linux-mmc@vger.kernel.org>; Wed, 06 Nov 2013 00:27:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Adopted to review comments from Guennadi Liakhovetski.

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

