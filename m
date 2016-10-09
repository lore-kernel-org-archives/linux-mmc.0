From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH 6/9] mmc: dw_mmc-exynos: deploay runtime PM facilities
Date: Sun,  9 Oct 2016 22:01:58 +0800
Message-ID: <1476021721-923-2-git-send-email-shawn.lin@rock-chips.com>
References: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
 <1476021721-923-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:43173 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbcJIN4n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2016 09:56:43 -0400
In-Reply-To: <1476021721-923-1-git-send-email-shawn.lin@rock-chips.com>
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

 drivers/mmc/host/dw_mmc-exynos.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 7ab3d74..189fd38 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -17,6 +17,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "dw_mmc.h"
@@ -161,20 +162,20 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_exynos_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int dw_mci_exynos_runtime_suspend(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	return dw_mci_suspend(host);
+	return dw_mci_runtime_suspend(host);
 }
 
-static int dw_mci_exynos_resume(struct device *dev)
+static int dw_mci_exynos_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
 	dw_mci_exynos_config_smu(host);
-	return dw_mci_resume(host);
+	return dw_mci_runtime_resume(host);
 }
 
 /**
@@ -211,10 +212,8 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
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
@@ -531,7 +530,11 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_exynos_runtime_suspend,
+			   dw_mci_exynos_runtime_resume,
+			   NULL)
 	.resume_noirq = dw_mci_exynos_resume_noirq,
 	.thaw_noirq = dw_mci_exynos_resume_noirq,
 	.restore_noirq = dw_mci_exynos_resume_noirq,
-- 
2.3.7


