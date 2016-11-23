From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] mmc: dw_mmc: exynos: fix to call suspend callback
Date: Wed, 23 Nov 2016 18:36:02 +0900
Message-ID: <1479893762-1842-1-git-send-email-jy0922.shim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49556 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbcKWJf1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 04:35:27 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH3014LE9AR5TB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2016 18:35:19 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, jy0922.shim@samsung.com

The dw_mmc-exynos should be RPM_ACTIVE on probe() to call suspend
callback of runtime PM in pm_runtime_force_suspend() during first system
suspend. Also call pm_runtime_get_noresume() on probe() because it
doesn't call suspend/resume callback by runtime PM now.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index e2439a108873..e1335289316c 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -516,10 +516,34 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
+	int ret;
 
 	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
 	drv_data = match->data;
-	return dw_mci_pltfm_register(pdev, drv_data);
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = dw_mci_pltfm_register(pdev, drv_data);
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dw_mci_exynos_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return dw_mci_pltfm_remove(pdev);
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
@@ -535,7 +559,7 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove		= dw_mci_pltfm_remove,
+	.remove		= dw_mci_exynos_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.of_match_table	= dw_mci_exynos_match,
-- 
1.9.1

