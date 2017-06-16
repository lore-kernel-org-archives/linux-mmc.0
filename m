From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 2/2] mmc: sdhci-of-at91: set clocks and presets after resume from deepest PM
Date: Fri, 16 Jun 2017 09:29:29 +0200
Message-ID: <20170616072929.3266-2-quentin.schulz@free-electrons.com>
References: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ludovic.desroches@microchip.com, ulf.hansson@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com
List-Id: linux-mmc@vger.kernel.org

This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
SoC's SDHCI controller.

When resuming from deepest state, it is required to restore preset
registers as the registers are lost since VDD core has been shut down
when entering deepest state on the SAMA5D2. The clocks need to be
reconfigured as well.

The other registers and init process are taken care of by the SDHCI
core.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index fb8c6011f13d..300513fc1068 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -207,6 +207,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 }
 
 #ifdef CONFIG_PM
+static int sdhci_at91_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = sdhci_suspend_host(host);
+
+	if (host->runtime_suspended)
+		return ret;
+
+	clk_disable_unprepare(priv->gck);
+	clk_disable_unprepare(priv->hclock);
+	clk_disable_unprepare(priv->mainck);
+
+	return ret;
+}
+
+static int sdhci_at91_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = sdhci_at91_set_clks_presets(dev);
+	if (ret)
+		return ret;
+
+	return sdhci_resume_host(host);
+}
+
 static int sdhci_at91_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -256,8 +287,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, sdhci_at91_resume)
 	SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
 			   sdhci_at91_runtime_resume,
 			   NULL)
-- 
2.11.0
