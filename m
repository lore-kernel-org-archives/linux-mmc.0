From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 7/7] mmc: host: sdhci-sprd: Add MMC packed request support
Date: Mon, 22 Jul 2019 21:09:42 +0800
Message-ID: <8331abb05ff0587f01093884cc2ba4f0d2a377cc.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Enable the ADMA3 transfer mode as well as adding packed operations
to support MMC packed requests to improve IO performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a1..44ea3cc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_PACKED
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 80a9055..e5651fd 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -524,10 +524,18 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_USE_ADMA3_SUPPORT,
 	.ops = &sdhci_sprd_ops,
 };
 
+static const struct mmc_packed_ops packed_ops = {
+	.packed_algo = mmc_packed_algo_rw,
+	.prepare_hardware = sdhci_prepare_packed,
+	.unprepare_hardware = sdhci_unprepare_packed,
+	.packed_request = sdhci_packed_request,
+};
+
 static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -642,10 +650,14 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
-	ret = __sdhci_add_host(host);
+	ret = mmc_packed_init(host->mmc, &packed_ops, 10);
 	if (ret)
 		goto err_cleanup_host;
 
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto err_packed;
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -653,6 +665,9 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		__func__, host->version);
 	return 0;
 
+err_packed:
+	mmc_packed_exit(host->mmc);
+
 err_cleanup_host:
 	sdhci_cleanup_host(host);
 
@@ -680,6 +695,7 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	struct mmc_host *mmc = host->mmc;
 
+	mmc_packed_exit(mmc);
 	mmc_remove_host(mmc);
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
@@ -702,6 +718,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_packed_queue_stop(host->mmc->packed);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -730,6 +747,7 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host);
+	mmc_packed_queue_start(host->mmc->packed);
 	return 0;
 
 clk_disable:
-- 
1.7.9.5
