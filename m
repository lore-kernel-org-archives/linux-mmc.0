From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
Date: Wed, 15 Feb 2012 10:15:40 -0800
Message-ID: <1329329740-7155-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329329740-7155-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47501 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896Ab2BOSPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 13:15:52 -0500
In-Reply-To: <1329329740-7155-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Since most of the work is already done by the core we just need to add
runtime suspend methods and tell the PM core that runtime PM is enabled
for this device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci-s3c.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 84ea6c7..f114725 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 
@@ -545,6 +546,11 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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
@@ -564,6 +570,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
  err_add_host:
 	release_resource(sc->ioarea);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	kfree(sc->ioarea);
 
  err_req_regs:
@@ -602,6 +610,8 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 1);
 
+	pm_runtime_disable(&pdev->dev);
+
 	for (ptr = 0; ptr < 3; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_disable(sc->clk_bus[ptr]);
@@ -637,9 +647,27 @@ static int sdhci_s3c_resume(struct device *dev)
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
1.7.9.rc1

