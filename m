From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4] mmc: tegra: add sdhci tegra suspend and resume
Date: Thu, 11 Apr 2019 12:18:19 -0700
Message-ID: <1555010299-19141-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: skomatineni@nvidia.com, talho@nvidia.com, anrao@nvidia.com, bbiswas@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds suspend and resume PM ops for tegra SDHCI.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eafaaefab4a6..f608417ae967 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1611,11 +1611,67 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
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
+	if (ret) {
+		cqhci_resume(host->mmc);
+		return ret;
+	}
+
+	clk_disable_unprepare(pltfm_host->clk);
+	return 0;
+}
+
+static int __maybe_unused sdhci_tegra_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		goto disable_clk;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_resume(host->mmc);
+		if (ret)
+			goto suspend_host;
+	}
+
+	return 0;
+
+suspend_host:
+	sdhci_suspend_host(host);
+disable_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	return ret;
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
