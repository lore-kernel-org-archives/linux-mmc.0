From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: add a quirk to disable pm_runtime if needed
Date: Sat, 16 Feb 2013 13:12:27 +0800
Message-ID: <1360991547-20448-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:54719 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741Ab3BPFNU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Feb 2013 00:13:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

For some sdio cards, clock need to alwasys on during working.
So pm_runtime need to be disabled for this case.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   58 ++++++++++++++++++++++++++--------------
 include/linux/mmc/sdhci.h      |    1 +
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a0cdbc5..24fc327 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -300,18 +300,23 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_suspend_ignore_children(&pdev->dev, 1);
-	pm_runtime_get_noresume(&pdev->dev);
+	if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN)) {
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+		pm_runtime_set_autosuspend_delay(&pdev->dev,
+			PXAV3_RPM_DELAY_MS);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_suspend_ignore_children(&pdev->dev, 1);
+		pm_runtime_get_noresume(&pdev->dev);
+	}
 
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-		pm_runtime_forbid(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
+		if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN)) {
+			pm_runtime_forbid(&pdev->dev);
+			pm_runtime_disable(&pdev->dev);
+		}
 		goto err_add_host;
 	}
 
@@ -324,7 +329,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 0);
 	}
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN))
+		pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
@@ -344,9 +350,13 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
-	pm_runtime_get_sync(&pdev->dev);
-	sdhci_remove_host(host, 1);
-	pm_runtime_disable(&pdev->dev);
+	if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN)) {
+		pm_runtime_get_sync(&pdev->dev);
+		sdhci_remove_host(host, 1);
+		pm_runtime_disable(&pdev->dev);
+	} else {
+		sdhci_remove_host(host, 1);
+	}
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
@@ -365,10 +375,14 @@ static int sdhci_pxav3_suspend(struct device *dev)
 	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
-	pm_runtime_get_sync(dev);
-	ret = sdhci_suspend_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN)) {
+		pm_runtime_get_sync(dev);
+		ret = sdhci_suspend_host(host);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	} else {
+		ret = sdhci_suspend_host(host);
+	}
 
 	return ret;
 }
@@ -378,10 +392,14 @@ static int sdhci_pxav3_resume(struct device *dev)
 	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
-	pm_runtime_get_sync(dev);
-	ret = sdhci_resume_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(host->quirks2 & SDHCI_QUIRK2_PM_RUNTIME_BROKEN)) {
+		pm_runtime_get_sync(dev);
+		ret = sdhci_resume_host(host);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	} else {
+		ret = sdhci_resume_host(host);
+	}
 
 	return ret;
 }
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..3fd6c8c 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -95,6 +95,7 @@ struct sdhci_host {
 /* The system physically doesn't support 1.8v, even if the host does */
 #define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
 #define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
+#define SDHCI_QUIRK2_PM_RUNTIME_BROKEN			(1<<4)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.9.5

