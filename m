From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 5/9] mmc: dw_mmc-k3: deploay runtime PM facilities
Date: Sun,  9 Oct 2016 21:49:06 +0800
Message-ID: <1476020951-31292-5-git-send-email-shawn.lin@rock-chips.com>
References: <1476020951-31292-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1476020951-31292-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Let's migrate it to use runtime PM and remove the system
PM callback from this driver. With this patch, it could
handle system PM properly and could also use runtime PM
if we enable it.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc-k3.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 6247894..99b859d 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -162,35 +163,29 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_k3_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int dw_mci_k3_runtime_suspend(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
-	int ret;
-
-	ret = dw_mci_suspend(host);
-	if (!ret)
-		clk_disable_unprepare(host->ciu_clk);
 
-	return ret;
+	return dw_mci_runtime_suspend(host);
 }
 
-static int dw_mci_k3_resume(struct device *dev)
+static int dw_mci_k3_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
-	int ret;
 
-	ret = clk_prepare_enable(host->ciu_clk);
-	if (ret) {
-		dev_err(host->dev, "failed to enable ciu clock\n");
-		return ret;
-	}
-
-	return dw_mci_resume(host);
+	return dw_mci_runtime_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops dw_mci_k3_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_k3_runtime_suspend,
+			   dw_mci_k3_runtime_resume,
+			   NULL)
+};
 
 static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.probe		= dw_mci_k3_probe,
@@ -198,7 +193,7 @@ static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.driver		= {
 		.name		= "dwmmc_k3",
 		.of_match_table	= dw_mci_k3_match,
-		.pm		= &dw_mci_k3_pmops,
+		.pm		= &dw_mci_k3_dev_pm_ops,
 	},
 };
 
-- 
2.3.7
