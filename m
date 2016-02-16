From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v5 10/13] mmc: sdhci-st: use sdhci_pltfm_init for private allocation
Date: Tue, 16 Feb 2016 21:08:28 +0800
Message-ID: <1455628111-5583-11-git-send-email-jszhang@marvell.com>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-st
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-st.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 969c2b0..320e1c2 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -251,7 +251,7 @@ static int sdhci_st_set_dll_for_clock(struct sdhci_host *host)
 {
 	int ret = 0;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 
 	if (host->clock > CLK_TO_CHECK_DLL_LOCK) {
 		st_mmcss_set_dll(pdata->top_ioaddr);
@@ -265,7 +265,7 @@ static void sdhci_st_set_uhs_signaling(struct sdhci_host *host,
 					unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	int ret = 0;
 
@@ -357,10 +357,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	int ret = 0;
 	u16 host_version;
 	struct resource *res;
-
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
+	struct reset_control *rstc;
 
 	clk =  devm_clk_get(&pdev->dev, "mmc");
 	if (IS_ERR(clk)) {
@@ -368,19 +365,23 @@ static int sdhci_st_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	pdata->rstc = devm_reset_control_get(&pdev->dev, NULL);
-	if (IS_ERR(pdata->rstc))
-		pdata->rstc = NULL;
+	rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(rstc))
+		rstc = NULL;
 	else
-		reset_control_deassert(pdata->rstc);
+		reset_control_deassert(rstc);
 
-	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, sizeof(*pdata));
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "Failed sdhci_pltfm_init\n");
 		ret = PTR_ERR(host);
 		goto err_pltfm_init;
 	}
 
+	pltfm_host = sdhci_priv(host);
+	pdata = sdhci_pltfm_priv(pltfm_host);
+	pdata->rstc = rstc;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed mmc_of_parse\n");
@@ -398,8 +399,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
 		pdata->top_ioaddr = NULL;
 	}
 
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = pdata;
 	pltfm_host->clk = clk;
 
 	/* Configure the Arasan HC inside the flashSS */
@@ -427,8 +426,8 @@ err_out:
 err_of:
 	sdhci_pltfm_free(pdev);
 err_pltfm_init:
-	if (pdata->rstc)
-		reset_control_assert(pdata->rstc);
+	if (rstc)
+		reset_control_assert(rstc);
 
 	return ret;
 }
@@ -437,13 +436,14 @@ static int sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
+	struct reset_control *rstc = pdata->rstc;
 	int ret;
 
 	ret = sdhci_pltfm_unregister(pdev);
 
-	if (pdata->rstc)
-		reset_control_assert(pdata->rstc);
+	if (rstc)
+		reset_control_assert(rstc);
 
 	return ret;
 }
@@ -453,7 +453,7 @@ static int sdhci_st_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 	int ret = sdhci_suspend_host(host);
 
 	if (ret)
@@ -471,7 +471,7 @@ static int sdhci_st_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 	struct device_node *np = dev->of_node;
 
 	clk_prepare_enable(pltfm_host->clk);
-- 
2.7.0
