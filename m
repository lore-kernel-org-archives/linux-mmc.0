From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
Date: Mon, 31 Jul 2017 21:56:47 +0900
Message-ID: <1501505809-393-2-git-send-email-yamada.masahiro@socionext.com>
References: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This commit provides similar cleanups as commit 83eacdfa2529 ("mmc:
sdhci: disable the clock in sdhci_pltfm_unregister()") did for
unregister hooks.

Some drivers duplicate code to handle pltfm_host->clk in their own
hooks.  The clock can be handled in sdhci_pltfm.c so that drivers
can reuse sdhci_pltfm_pmops.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------------------------
 drivers/mmc/host/sdhci-pltfm.c   | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-sirf.c    | 39 +--------------------------------------
 3 files changed, 17 insertions(+), 75 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index e2f638338e8f..6d461fcdd663 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -21,41 +21,6 @@
 
 #include "sdhci-pltfm.h"
 
-#ifdef CONFIG_PM_SLEEP
-
-static int sdhci_brcmstb_suspend(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int res;
-
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	res = sdhci_suspend_host(host);
-	if (res)
-		return res;
-	clk_disable_unprepare(pltfm_host->clk);
-	return res;
-}
-
-static int sdhci_brcmstb_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int err;
-
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		return err;
-	return sdhci_resume_host(host);
-}
-
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
-			sdhci_brcmstb_resume);
-
 static const struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -131,7 +96,7 @@ MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
-		.pm	= &sdhci_brcmstb_pmops,
+		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e090d8c42ddb..be9a79d62e22 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -212,16 +212,30 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 static int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	return sdhci_suspend_host(host);
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
 }
 
 static int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
 
 	return sdhci_resume_host(host);
 }
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index c251c6c0a112..dd4680a0ada4 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -230,43 +230,6 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_sirf_suspend(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int ret;
-
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	ret = sdhci_suspend_host(host);
-	if (ret)
-		return ret;
-
-	clk_disable(pltfm_host->clk);
-
-	return 0;
-}
-
-static int sdhci_sirf_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int ret;
-
-	ret = clk_enable(pltfm_host->clk);
-	if (ret) {
-		dev_dbg(dev, "Resume: Error enabling clock\n");
-		return ret;
-	}
-
-	return sdhci_resume_host(host);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(sdhci_sirf_pm_ops, sdhci_sirf_suspend, sdhci_sirf_resume);
-
 static const struct of_device_id sdhci_sirf_of_match[] = {
 	{ .compatible = "sirf,prima2-sdhc" },
 	{ }
@@ -276,7 +239,7 @@ MODULE_DEVICE_TABLE(of, sdhci_sirf_of_match);
 static struct platform_driver sdhci_sirf_driver = {
 	.driver		= {
 		.name	= "sdhci-sirf",
-		.of_match_table = sdhci_sirf_of_match,
+		.of_match_table = sdhci_pltfm_pmops,
 		.pm	= &sdhci_sirf_pm_ops,
 	},
 	.probe		= sdhci_sirf_probe,
-- 
2.7.4
