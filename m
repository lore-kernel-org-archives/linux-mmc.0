From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 6/9] mmc: dw_mmc-exynos: deploy runtime PM facilities
Date: Wed, 12 Oct 2016 10:55:55 +0800
Message-ID: <1476240955-5808-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1476240643-5701-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

Changes in v2:
- minor fix since I change the argument for dw_mci_runtime_*

 drivers/mmc/host/dw_mmc-exynos.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 7ab3d74..e2439a1 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -17,6 +17,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "dw_mmc.h"
@@ -161,20 +162,13 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_exynos_suspend(struct device *dev)
-{
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	return dw_mci_suspend(host);
-}
-
-static int dw_mci_exynos_resume(struct device *dev)
+#ifdef CONFIG_PM
+static int dw_mci_exynos_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
 	dw_mci_exynos_config_smu(host);
-	return dw_mci_resume(host);
+	return dw_mci_runtime_resume(dev);
 }
 
 /**
@@ -211,10 +205,8 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 	return 0;
 }
 #else
-#define dw_mci_exynos_suspend		NULL
-#define dw_mci_exynos_resume		NULL
 #define dw_mci_exynos_resume_noirq	NULL
-#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
 static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 {
@@ -531,7 +523,11 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
+			   dw_mci_exynos_runtime_resume,
+			   NULL)
 	.resume_noirq = dw_mci_exynos_resume_noirq,
 	.thaw_noirq = dw_mci_exynos_resume_noirq,
 	.restore_noirq = dw_mci_exynos_resume_noirq,
-- 
2.3.7
