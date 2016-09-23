From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RFC PATCH 2/2] mmc: dw_mmc-rockchip: add runtime PM support
Date: Fri, 23 Sep 2016 12:17:45 +0800
Message-ID: <1474604265-29837-3-git-send-email-shawn.lin@rock-chips.com>
References: <1474604265-29837-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1474604265-29837-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds runtime PM support for dw_mmc-rockchip.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 25eae35..3ad041c 100644
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
+       pm_runtime_get_sync(&pdev->dev);
+       pm_runtime_disable(&pdev->dev);
+       pm_runtime_put_noidle(&pdev->dev);
+
+       return dw_mci_pltfm_remove(pdev);
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
