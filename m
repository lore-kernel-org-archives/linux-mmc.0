From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Date: Mon, 1 Apr 2019 22:27:33 -0700
Message-ID: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds suspend and resume PM ops for tegra SDHCI.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eafaaefab4a6..68263ea4a93e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_tegra_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+	return 0;
+}
+
+static int sdhci_tegra_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	clk_prepare_enable(pltfm_host->clk);
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		return ret;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		return cqhci_resume(host->mmc);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
+			 sdhci_tegra_resume);
+
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
 		.name	= "sdhci-tegra",
 		.of_match_table = sdhci_tegra_dt_match,
-		.pm	= &sdhci_pltfm_pmops,
+		.pm	= &sdhci_tegra_dev_pm_ops,
 	},
 	.probe		= sdhci_tegra_probe,
 	.remove		= sdhci_tegra_remove,
-- 
2.7.4
