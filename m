From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-imx-esdhc: use more devm_* functions
Date: Mon, 26 Nov 2012 14:39:43 +0800
Message-ID: <1353911983-10103-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab2KZGjf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 01:39:35 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7777697pbc.19
        for <linux-mmc@vger.kernel.org>; Sun, 25 Nov 2012 22:39:34 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Use devm_kzalloc, devm_gpio_request_one and devm_request_irq to make
cleanup path simpler.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   56 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index effc2ac..1849461 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -456,10 +456,10 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
+	imx_data = devm_kzalloc(&pdev->dev, sizeof(*imx_data), GFP_KERNEL);
 	if (!imx_data) {
 		err = -ENOMEM;
-		goto err_imx_data;
+		goto free_sdhci;
 	}
 
 	if (of_id)
@@ -470,19 +470,19 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
-		goto err_clk_get;
+		goto free_sdhci;
 	}
 
 	imx_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(imx_data->clk_ahb)) {
 		err = PTR_ERR(imx_data->clk_ahb);
-		goto err_clk_get;
+		goto free_sdhci;
 	}
 
 	imx_data->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(imx_data->clk_per)) {
 		err = PTR_ERR(imx_data->clk_per);
-		goto err_clk_get;
+		goto free_sdhci;
 	}
 
 	pltfm_host->clk = imx_data->clk_per;
@@ -494,7 +494,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
-		goto pin_err;
+		goto disable_clk;
 	}
 
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
@@ -519,7 +519,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		if (!host->mmc->parent->platform_data) {
 			dev_err(mmc_dev(host->mmc), "no board data!\n");
 			err = -EINVAL;
-			goto no_board_data;
+			goto disable_clk;
 		}
 		imx_data->boarddata = *((struct esdhc_platform_data *)
 					host->mmc->parent->platform_data);
@@ -527,7 +527,8 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	/* write_protect */
 	if (boarddata->wp_type == ESDHC_WP_GPIO) {
-		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
+		err = devm_gpio_request_one(&pdev->dev, boarddata->wp_gpio,
+					    GPIOF_IN, "ESDHC_WP");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
 				 "no write-protect pin available!\n");
@@ -543,19 +544,21 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	switch (boarddata->cd_type) {
 	case ESDHC_CD_GPIO:
-		err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
+		err = devm_gpio_request_one(&pdev->dev, boarddata->cd_gpio,
+					    GPIOF_IN, "ESDHC_CD");
 		if (err) {
 			dev_err(mmc_dev(host->mmc),
 				"no card-detect pin available!\n");
-			goto no_card_detect_pin;
+			goto disable_clk;
 		}
 
-		err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
+		err = devm_request_irq(&pdev->dev,
+				 gpio_to_irq(boarddata->cd_gpio), cd_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				 mmc_hostname(host->mmc), host);
 		if (err) {
 			dev_err(mmc_dev(host->mmc), "request irq error\n");
-			goto no_card_detect_irq;
+			goto disable_clk;
 		}
 		/* fall through */
 
@@ -574,27 +577,15 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	err = sdhci_add_host(host);
 	if (err)
-		goto err_add_host;
+		goto disable_clk;
 
 	return 0;
 
-err_add_host:
-	if (gpio_is_valid(boarddata->cd_gpio))
-		free_irq(gpio_to_irq(boarddata->cd_gpio), host);
-no_card_detect_irq:
-	if (gpio_is_valid(boarddata->cd_gpio))
-		gpio_free(boarddata->cd_gpio);
-	if (gpio_is_valid(boarddata->wp_gpio))
-		gpio_free(boarddata->wp_gpio);
-no_card_detect_pin:
-no_board_data:
-pin_err:
+disable_clk:
 	clk_disable_unprepare(imx_data->clk_per);
 	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
-err_clk_get:
-	kfree(imx_data);
-err_imx_data:
+free_sdhci:
 	sdhci_pltfm_free(pdev);
 	return err;
 }
@@ -604,25 +595,14 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 
-	if (gpio_is_valid(boarddata->wp_gpio))
-		gpio_free(boarddata->wp_gpio);
-
-	if (gpio_is_valid(boarddata->cd_gpio)) {
-		free_irq(gpio_to_irq(boarddata->cd_gpio), host);
-		gpio_free(boarddata->cd_gpio);
-	}
-
 	clk_disable_unprepare(imx_data->clk_per);
 	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
 
-	kfree(imx_data);
-
 	sdhci_pltfm_free(pdev);
 
 	return 0;
-- 
1.7.9.5

