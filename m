From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable()
Date: Wed,  9 Oct 2013 17:37:39 -0300
Message-ID: <1381351059-30650-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:58880 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3JIUht (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 16:37:49 -0400
Received: by mail-vc0-f182.google.com with SMTP id im17so942492vcb.41
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2013 13:37:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Also, fix the sequence for disabling the clock in the probe error path and
also in the remove funct

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix the naming scheme of goto labels

 drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..32b0586 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -877,14 +877,22 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = imx_data->clk_per;
 
-	clk_prepare_enable(imx_data->clk_per);
-	clk_prepare_enable(imx_data->clk_ipg);
-	clk_prepare_enable(imx_data->clk_ahb);
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto free_sdhci;
+
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_clk_per;
+
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		goto disable_clk_ipg;
 
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
-		goto disable_clk;
+		goto disable_clk_ahb;
 	}
 
 	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
@@ -892,7 +900,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(imx_data->pins_default)) {
 		err = PTR_ERR(imx_data->pins_default);
 		dev_err(mmc_dev(host->mmc), "could not get default state\n");
-		goto disable_clk;
+		goto disable_clk_ahb;
 	}
 
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
@@ -917,7 +925,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		if (!host->mmc->parent->platform_data) {
 			dev_err(mmc_dev(host->mmc), "no board data!\n");
 			err = -EINVAL;
-			goto disable_clk;
+			goto disable_clk_ahb;
 		}
 		imx_data->boarddata = *((struct esdhc_platform_data *)
 					host->mmc->parent->platform_data);
@@ -929,7 +937,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to request write-protect gpio!\n");
-			goto disable_clk;
+			goto disable_clk_ahb;
 		}
 		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 	}
@@ -941,7 +949,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to request card-detect gpio!\n");
-			goto disable_clk;
+			goto disable_clk_ahb;
 		}
 		/* fall through */
 
@@ -990,14 +998,16 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	err = sdhci_add_host(host);
 	if (err)
-		goto disable_clk;
+		goto disable_clk_ahb;
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
+disable_clk_ahb:
 	clk_disable_unprepare(imx_data->clk_ahb);
+disable_clk_ipg:
+	clk_disable_unprepare(imx_data->clk_ipg);
+disable_clk_per:
+	clk_disable_unprepare(imx_data->clk_per);
 free_sdhci:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1012,9 +1022,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
+	clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_per);
 
 	sdhci_pltfm_free(pdev);
 
-- 
1.8.1.2

