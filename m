From: Randy Li <ayaka@soulik.info>
Subject: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Wed, 28 Dec 2016 23:34:48 +0800
Message-ID: <1482939288-14950-1-git-send-email-ayaka@soulik.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, shawn.lin@rock-chips.com, randy.li@rock-chips.com, ulf.hansson@linaro.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Randy Li <ayaka@soulik.info>
List-Id: linux-mmc@vger.kernel.org

This reverts commit f90142683f04bcb0729bf0df67a5e29562b725b9.
It is reported that making RK3288 can't boot from eMMC/MMC.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 41 +++-----------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 9a46e46..3189234 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -14,7 +14,6 @@
 #include <linux/mmc/dw_mmc.h>
 #include <linux/of_address.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "dw_mmc.h"
@@ -327,7 +326,6 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
-	int ret;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -335,49 +333,16 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
 	drv_data = match->data;
 
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
-	ret = dw_mci_pltfm_register(pdev, drv_data);
-	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
-		pm_runtime_put_noidle(&pdev->dev);
-		return ret;
-	}
-
-	pm_runtime_put_autosuspend(&pdev->dev);
-
-	return 0;
+	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-static int dw_mci_rockchip_remove(struct platform_device *pdev)
-{
-	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
-	return dw_mci_pltfm_remove(pdev);
-}
-
-static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
-};
-
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
-	.remove		= dw_mci_rockchip_remove,
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_rockchip",
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= &dw_mci_rockchip_dev_pm_ops,
+		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
 
-- 
2.7.4
