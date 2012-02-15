From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system suspend
Date: Wed, 15 Feb 2012 10:15:39 -0800
Message-ID: <1329329740-7155-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47502 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915Ab2BOSPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 13:15:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

This matches current best practice as one can have runtime PM enabled
without system sleep and CONFIG_PM is defined for both.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci-s3c.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index b19e7d4..84ea6c7 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 
 #include <linux/mmc/host.h>
 
@@ -620,8 +621,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_s3c_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -635,10 +635,11 @@ static int sdhci_s3c_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
+#endif
 
+#ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_s3c_pmops = {
-	.suspend	= sdhci_s3c_suspend,
-	.resume		= sdhci_s3c_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
 };
 
 #define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
-- 
1.7.9.rc1

