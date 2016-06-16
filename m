From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 16 Jun 2016 18:05:09 +0530
Message-ID: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35520 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbcFPMfV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2016 08:35:21 -0400
Received: by mail-pf0-f170.google.com with SMTP id c2so19817918pfa.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2016 05:35:21 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>

Provides runtime PM callbacks to enable and disable clock resources
when idle. Also support system PM callbacks to be called during system
suspend and resume.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0653fe7..f4394c8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
@@ -549,6 +550,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_disable;
 
+	platform_set_drvdata(pdev, msm_host);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 clk_disable:
@@ -580,12 +586,63 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int sdhci_msm_runtime_suspend(struct device *dev)
+{
+	struct sdhci_msm_host *msm_host = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(msm_host->clk);
+	clk_disable_unprepare(msm_host->pclk);
+
+	return 0;
+}
+
+static int sdhci_msm_runtime_resume(struct device *dev)
+{
+	struct sdhci_msm_host *msm_host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(msm_host->clk);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+	ret = clk_prepare_enable(msm_host->pclk);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		clk_disable_unprepare(msm_host->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sdhci_msm_suspend(struct device *dev)
+{
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int sdhci_msm_resume(struct device *dev)
+{
+	pm_runtime_force_resume(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sdhci_msm_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)
+	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume,
+				NULL)
+};
+
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
 	.remove = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
+		   .pm = &sdhci_msm_pm_ops,
 	},
 };
 
-- 
1.8.2.1

