From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH 2/9] mmc: dw_mmc-rockchip: add runtime PM support
Date: Sun,  9 Oct 2016 21:58:19 +0800
Message-ID: <1476021506-869-3-git-send-email-shawn.lin@rock-chips.com>
References: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:47267 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcJINyK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2016 09:54:10 -0400
In-Reply-To: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch adds runtime PM support for dw_mmc-rockchip.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 25eae35..28e0220 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -13,6 +13,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/of_address.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "dw_mmc.h"
@@ -325,6 +326,7 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
+	int ret;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -332,16 +334,65 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
 	drv_data = match->data;
 
-	return dw_mci_pltfm_register(pdev, drv_data);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
+	ret = dw_mci_pltfm_register(pdev, drv_data);
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		return ret;
+	}
+
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return 0;
+}
+
+static int dw_mci_rockchip_remove(struct platform_device *pdev)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return dw_mci_pltfm_remove(pdev);
 }
 
+#ifdef CONFIG_PM
+static int dw_mci_rockchip_runtime_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	return dw_mci_runtime_suspend(host);
+}
+
+static int dw_mci_rockchip_runtime_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	return dw_mci_runtime_resume(host);
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend,
+			   dw_mci_rockchip_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
-	.remove		= dw_mci_pltfm_remove,
+	.remove		= dw_mci_rockchip_remove,
 	.driver		= {
 		.name		= "dwmmc_rockchip",
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= &dw_mci_pltfm_pmops,
+		.pm		= &dw_mci_rockchip_dev_pm_ops,
 	},
 };
 
-- 
2.3.7


