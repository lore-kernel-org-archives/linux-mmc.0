From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 7/9] mmc: dw_mmc-pci: deploay runtime PM facilities
Date: Sun,  9 Oct 2016 21:50:52 +0800
Message-ID: <1476021052-31395-1-git-send-email-shawn.lin@rock-chips.com>
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

 drivers/mmc/host/dw_mmc-pci.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 4c69fbd..61789b1 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -79,25 +80,31 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 	dw_mci_remove(host);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_pci_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int dw_mci_pci_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_mci *host = pci_get_drvdata(pdev);
 
-	return dw_mci_suspend(host);
+	return dw_mci_runtime_suspend(host);
 }
 
-static int dw_mci_pci_resume(struct device *dev)
+static int dw_mci_pci_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_mci *host = pci_get_drvdata(pdev);
 
-	return dw_mci_resume(host);
+	return dw_mci_runtime_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(dw_mci_pci_pmops, dw_mci_pci_suspend, dw_mci_pci_resume);
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops dw_mci_pci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_pci_runtime_suspend,
+			   dw_mci_pci_runtime_resume,
+			   NULL)
+};
 
 static const struct pci_device_id dw_mci_pci_id[] = {
 	{ PCI_DEVICE(SYNOPSYS_DW_MCI_VENDOR_ID, SYNOPSYS_DW_MCI_DEVICE_ID) },
@@ -111,7 +118,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   &dw_mci_pci_pmops
+		.pm =   &dw_mci_pci_dev_pm_ops,
 	},
 };
 
-- 
2.3.7
