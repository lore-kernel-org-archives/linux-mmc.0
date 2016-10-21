From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH v5] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Fri, 21 Oct 2016 12:12:04 +0530
Message-ID: <20161021064204.10889-1-pramod.gurav@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33058 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbcJUGmO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 02:42:14 -0400
Received: by mail-pf0-f172.google.com with SMTP id 128so51658940pfz.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 23:42:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, riteshh@codeaurora.org, Pramod Gurav <pramod.gurav@linaro.org>

Provides runtime PM callbacks to enable and disable clock resources
when idle. Also support system PM callbacks to be called during system
suspend and resume.

Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
Tested-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
Tested on DB410C.

Changes in v5:
- Added pm_runtime_mark_last_busy in probe before calling autosuspend
- included clock names in error logs
- Used micro instead of constant for autosuspend delay
- Removed platform_set_drvdata in probe as sdhci_pltfm_init does it.
- Aligned PM ops structure with the parenthesis

Changes in v4:
- Remove calls to sdhci_runtime_resume_host/sdhci_runtime_suspend_host
  from runtime callbacks as sdhc msm controller is capable of restoring
  it's register values after clocks are disabled and re-enabled.

Changes in v3:
- Added CONFIG_PM around runtime pm function.
- Replaced msm suspend/resume with generic function directly
- Use SET_SYSTEM_SLEEP_PM_OPS instead of late version

Changes in v2:
- Moved pm_rutime enabling before adding host
- Handled pm_rutime in remove
- Changed runtime handling with reference from sdhci-of-at91.c

 drivers/mmc/host/sdhci-msm.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ef44a2a..795f16f 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
@@ -68,6 +69,7 @@
 #define CMUX_SHIFT_PHASE_SHIFT	24
 #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
 
+#define MSM_MMC_AUTOSUSPEND_DELAY_MS	50
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -658,12 +660,26 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 MSM_MMC_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto clk_disable;
+		goto pm_runtime_disable;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
+pm_runtime_disable:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 clk_disable:
 	clk_disable_unprepare(msm_host->clk);
 pclk_disable:
@@ -685,6 +701,11 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 		    0xffffffff);
 
 	sdhci_remove_host(host, dead);
+
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	clk_disable_unprepare(msm_host->clk);
 	clk_disable_unprepare(msm_host->pclk);
 	if (!IS_ERR(msm_host->bus_clk))
@@ -693,12 +714,57 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int sdhci_msm_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	clk_disable_unprepare(msm_host->clk);
+	clk_disable_unprepare(msm_host->pclk);
+
+	return 0;
+}
+
+static int sdhci_msm_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_prepare_enable(msm_host->clk);
+	if (ret) {
+		dev_err(dev, "clk_enable failed for core_clk: %d\n", ret);
+		return ret;
+	}
+	ret = clk_prepare_enable(msm_host->pclk);
+	if (ret) {
+		dev_err(dev, "clk_enable failed for iface_clk: %d\n", ret);
+		clk_disable_unprepare(msm_host->clk);
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sdhci_msm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
+			   sdhci_msm_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
 	.remove = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
+		   .pm = &sdhci_msm_pm_ops,
 	},
 };
 
-- 
2.9.3

