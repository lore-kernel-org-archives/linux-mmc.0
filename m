From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 7/9] mmc: dw_mmc-pci: deploy runtime PM facilities
Date: Wed, 12 Oct 2016 10:56:34 +0800
Message-ID: <1476240994-5849-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:43520 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcJLCuQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2016 22:50:16 -0400
In-Reply-To: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Let's migrate it to use runtime PM and remove the system
PM callback from this driver. With this patch, it could
handle system PM properly and could also use runtime PM
if we enable it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- use dw_mci_runtime_* directly

 drivers/mmc/host/dw_mmc-pci.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 4c69fbd..ab82796 100644
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
@@ -79,25 +80,13 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 	dw_mci_remove(host);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_pci_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_mci *host = pci_get_drvdata(pdev);
-
-	return dw_mci_suspend(host);
-}
-
-static int dw_mci_pci_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_mci *host = pci_get_drvdata(pdev);
-
-	return dw_mci_resume(host);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(dw_mci_pci_pmops, dw_mci_pci_suspend, dw_mci_pci_resume);
+static const struct dev_pm_ops dw_mci_pci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
+			   dw_mci_runtime_resume,
+			   NULL)
+};
 
 static const struct pci_device_id dw_mci_pci_id[] = {
 	{ PCI_DEVICE(SYNOPSYS_DW_MCI_VENDOR_ID, SYNOPSYS_DW_MCI_DEVICE_ID) },
@@ -111,7 +100,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   &dw_mci_pci_pmops
+		.pm =   &dw_mci_pci_dev_pm_ops,
 	},
 };
 
-- 
2.3.7


