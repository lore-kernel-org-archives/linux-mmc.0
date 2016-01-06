From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 09/12] mmc: sdhci-st: use sdhci_pltfm_init for private allocation
Date: Wed, 6 Jan 2016 11:56:02 +0800
Message-ID: <1452052565-4232-10-git-send-email-jszhang@marvell.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452052565-4232-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-st
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/mmc/host/sdhci-st.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 969c2b0..4604376 100644
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
@@ -368,19 +365,24 @@ static int sdhci_st_probe(struct platform_device *pdev)
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
+	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata,
+				sizeof(*pdata));
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
@@ -398,8 +400,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
 		pdata->top_ioaddr = NULL;
 	}
 
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = pdata;
 	pltfm_host->clk = clk;
 
 	/* Configure the Arasan HC inside the flashSS */
@@ -427,8 +427,8 @@ err_out:
 err_of:
 	sdhci_pltfm_free(pdev);
 err_pltfm_init:
-	if (pdata->rstc)
-		reset_control_assert(pdata->rstc);
+	if (rstc)
+		reset_control_assert(rstc);
 
 	return ret;
 }
@@ -437,7 +437,7 @@ static int sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_pltfm_unregister(pdev);
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
2.7.0.rc3
