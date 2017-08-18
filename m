From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-msm: Utilize bulk clock API
Date: Fri, 18 Aug 2017 10:55:05 -0700
Message-ID: <20170818175506.5035-2-bjorn.andersson@linaro.org>
References: <20170818175506.5035-1-bjorn.andersson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170818175506.5035-1-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

By stuffing the runtime controlled clocks into a clk_bulk_data array we
can utilize the newly introduced bulk clock operations and clean up the
error paths. This allow us to handle additional clocks in subsequent
patch, without the added complexity.

Cc: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index fc73e56eb1e2..71e01cbc38b6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -131,6 +131,7 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
+	struct clk_bulk_data bulk_clks[2];
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -1167,16 +1168,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto bus_clk_disable;
 	}
 
-	ret = clk_prepare_enable(msm_host->pclk);
-	if (ret)
-		goto bus_clk_disable;
-
 	/* Setup SDC MMC clock */
 	msm_host->clk = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(msm_host->clk)) {
 		ret = PTR_ERR(msm_host->clk);
 		dev_err(&pdev->dev, "SDC MMC clk setup failed (%d)\n", ret);
-		goto pclk_disable;
+		goto bus_clk_disable;
 	}
 
 	/*
@@ -1194,9 +1191,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "core clock boost failed\n");
 
-	ret = clk_prepare_enable(msm_host->clk);
+	msm_host->bulk_clks[0].clk = msm_host->clk;
+	msm_host->bulk_clks[1].clk = msm_host->pclk;
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
+				      msm_host->bulk_clks);
 	if (ret)
-		goto pclk_disable;
+		goto bus_clk_disable;
 
 	core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	msm_host->core_mem = devm_ioremap_resource(&pdev->dev, core_memres);
@@ -1290,9 +1291,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 clk_disable:
-	clk_disable_unprepare(msm_host->clk);
-pclk_disable:
-	clk_disable_unprepare(msm_host->pclk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
+				   msm_host->bulk_clks);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
@@ -1315,8 +1315,8 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	clk_disable_unprepare(msm_host->clk);
-	clk_disable_unprepare(msm_host->pclk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
+				   msm_host->bulk_clks);
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
 	sdhci_pltfm_free(pdev);
@@ -1330,8 +1330,8 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
-	clk_disable_unprepare(msm_host->clk);
-	clk_disable_unprepare(msm_host->pclk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
+				   msm_host->bulk_clks);
 
 	return 0;
 }
@@ -1341,21 +1341,9 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-	int ret;
 
-	ret = clk_prepare_enable(msm_host->clk);
-	if (ret) {
-		dev_err(dev, "clk_enable failed for core_clk: %d\n", ret);
-		return ret;
-	}
-	ret = clk_prepare_enable(msm_host->pclk);
-	if (ret) {
-		dev_err(dev, "clk_enable failed for iface_clk: %d\n", ret);
-		clk_disable_unprepare(msm_host->clk);
-		return ret;
-	}
-
-	return 0;
+	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
+				       msm_host->bulk_clks);
 }
 #endif
 
-- 
2.12.0
