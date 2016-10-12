From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 8/9] mmc: dw_mmc-pltfm: deploy runtime PM facilities
Date: Wed, 12 Oct 2016 10:56:46 +0800
Message-ID: <1476241006-5891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:43565 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcJLCu1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2016 22:50:27 -0400
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

 drivers/mmc/host/dw_mmc-pltfm.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index c0bb0c7..b486fef 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -57,26 +58,13 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
-#ifdef CONFIG_PM_SLEEP
-/*
- * TODO: we should probably disable the clock to the card in the suspend path.
- */
-static int dw_mci_pltfm_suspend(struct device *dev)
-{
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	return dw_mci_suspend(host);
-}
-
-static int dw_mci_pltfm_resume(struct device *dev)
-{
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	return dw_mci_resume(host);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
+const struct dev_pm_ops dw_mci_pltfm_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
+			   dw_mci_runtime_resume,
+			   NULL)
+};
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
-- 
2.3.7


