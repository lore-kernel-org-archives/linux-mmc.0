From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
Date: Sat,  3 Mar 2012 00:46:42 +0000
Message-ID: <1330735602-22409-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <4F51697C.40408@samsung.com>
 <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Since most of the work is already done by the core we just need to add
runtime suspend methods and tell the PM core that runtime PM is enabled
for this device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci-s3c.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 46152d6..6926ac9 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 
@@ -721,6 +722,11 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->host_caps2)
 		host->mmc->caps2 |= pdata->host_caps2;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, 1);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
@@ -740,6 +746,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
  err_add_host:
 	release_resource(sc->ioarea);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	kfree(sc->ioarea);
 
  err_req_regs:
@@ -784,6 +792,8 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 1);
 
+	pm_runtime_disable(&pdev->dev);
+
 	for (ptr = 0; ptr < 3; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_disable(sc->clk_bus[ptr]);
@@ -824,9 +834,27 @@ static int sdhci_s3c_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int sdhci_s3c_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_runtime_suspend_host(host);
+}
+
+static int sdhci_s3c_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_runtime_resume_host(host);
+}
+#endif
+
 #ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_s3c_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
+	SET_RUNTIME_PM_OPS(sdhci_s3c_runtime_suspend, sdhci_s3c_runtime_resume,
+			   NULL)
 };
 
 #define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
-- 
1.7.9.1
