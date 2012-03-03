From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system suspend
Date: Sat,  3 Mar 2012 00:46:41 +0000
Message-ID: <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <4F51697C.40408@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F51697C.40408@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

This matches current best practice as one can have runtime PM enabled
without system sleep and CONFIG_PM is defined for both.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci-s3c.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index ea0767e..46152d6 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/pm.h>
 
 #include <linux/mmc/host.h>
 
@@ -807,8 +808,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_s3c_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -822,10 +822,11 @@ static int sdhci_s3c_resume(struct device *dev)
 
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
1.7.9.1
