From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND v2] mmc: sdhci-pxav3: add pm runtime support
Date: Fri,  1 Feb 2013 17:48:30 +0800
Message-ID: <1359712110-20452-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:45804 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755721Ab3BAJrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Feb 2013 04:47:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>

Change-Id: Iacc46aedfb9cd4ee0ddeb1866f90f857541beb3f
Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   97 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3d20c10..62dcf61 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -32,10 +32,14 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
+#define PXAV3_RPM_DELAY_MS     50
+
 #define SD_CLOCK_BURST_SIZE_SETUP		0x10A
 #define SDCLK_SEL	0x100
 #define SDCLK_DELAY_SHIFT	9
@@ -303,9 +307,19 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+			PXAV3_RPM_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, 1);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
+		pm_runtime_forbid(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
 		goto err_add_host;
 	}
 
@@ -318,6 +332,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 0);
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_add_host:
@@ -336,7 +352,9 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
+	pm_runtime_get_sync(&pdev->dev);
 	sdhci_remove_host(host, 1);
+	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
@@ -349,6 +367,83 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_pxav3_suspend(struct device *dev)
+{
+	int ret;
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(dev);
+	ret = sdhci_suspend_host(host);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int sdhci_pxav3_resume(struct device *dev)
+{
+	int ret;
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(dev);
+	ret = sdhci_resume_host(host);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static int sdhci_pxav3_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	unsigned long flags;
+
+	if (pltfm_host->clk) {
+		spin_lock_irqsave(&host->lock, flags);
+		host->runtime_suspended = true;
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		clk_disable_unprepare(pltfm_host->clk);
+	}
+
+	return 0;
+}
+
+static int sdhci_pxav3_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	unsigned long flags;
+
+	if (pltfm_host->clk) {
+		clk_prepare_enable(pltfm_host->clk);
+
+		spin_lock_irqsave(&host->lock, flags);
+		host->runtime_suspended = false;
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops sdhci_pxav3_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
+	SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
+		sdhci_pxav3_runtime_resume, NULL)
+};
+
+#define SDHCI_PXAV3_PMOPS (&sdhci_pxav3_pmops)
+
+#else
+#define SDHCI_PXAV3_PMOPS NULL
+#endif
+
 static struct platform_driver sdhci_pxav3_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav3",
@@ -356,7 +451,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.of_match_table = sdhci_pxav3_of_match,
 #endif
 		.owner	= THIS_MODULE,
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= SDHCI_PXAV3_PMOPS,
 	},
 	.probe		= sdhci_pxav3_probe,
 	.remove		= sdhci_pxav3_remove,
-- 
1.7.9.5

