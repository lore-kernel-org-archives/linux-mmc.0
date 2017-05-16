From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH RESEND] mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable()
Date: Tue, 16 May 2017 19:08:31 -0300
Message-ID: <1494972511-17655-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35204 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdEPWIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 18:08:44 -0400
Received: by mail-qk0-f194.google.com with SMTP id k74so24827081qke.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2017 15:08:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 23d8b8a..b5c7241 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1250,14 +1250,20 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = imx_data->clk_per;
 	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
-	clk_prepare_enable(imx_data->clk_per);
-	clk_prepare_enable(imx_data->clk_ipg);
-	clk_prepare_enable(imx_data->clk_ahb);
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto free_sdhci;
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_per_clk;
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		goto disable_ipg_clk;
 
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
-		goto disable_clk;
+		goto disable_ahb_clk;
 	}
 
 	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
@@ -1297,13 +1303,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	else
 		err = sdhci_esdhc_imx_probe_nondt(pdev, host, imx_data);
 	if (err)
-		goto disable_clk;
+		goto disable_ahb_clk;
 
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
 	if (err)
-		goto disable_clk;
+		goto disable_ahb_clk;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
@@ -1313,10 +1319,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
+disable_ahb_clk:
 	clk_disable_unprepare(imx_data->clk_ahb);
+disable_ipg_clk:
+	clk_disable_unprepare(imx_data->clk_ipg);
+disable_per_clk:
+	clk_disable_unprepare(imx_data->clk_per);
 free_sdhci:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1393,14 +1401,34 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int err;
 
 	if (!sdhci_sdio_irq_enabled(host)) {
-		clk_prepare_enable(imx_data->clk_per);
-		clk_prepare_enable(imx_data->clk_ipg);
+		err = clk_prepare_enable(imx_data->clk_per);
+		if (err)
+			return err;
+		err = clk_prepare_enable(imx_data->clk_ipg);
+		if (err)
+			goto disable_per_clk;
 	}
-	clk_prepare_enable(imx_data->clk_ahb);
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		goto disable_ipg_clk;
+	err = sdhci_runtime_resume_host(host);
+	if (err)
+		goto disable_ahb_clk;
+
+	return 0;
 
-	return sdhci_runtime_resume_host(host);
+disable_ahb_clk:
+	clk_disable_unprepare(imx_data->clk_ahb);
+disable_ipg_clk:
+	if (!sdhci_sdio_irq_enabled(host))
+		clk_disable_unprepare(imx_data->clk_ipg);
+disable_per_clk:
+	if (!sdhci_sdio_irq_enabled(host))
+		clk_disable_unprepare(imx_data->clk_per);
+	return err;
 }
 #endif
 
-- 
2.7.4

