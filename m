From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: sirf: fix sdhci_pltfm_init sequence
Date: Tue, 04 Jun 2013 00:02:13 +0200
Message-ID: <24753444.e6CjWoyOih@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58268 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758640Ab3FCWCG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 18:02:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christian Daudt <csd@broadcom.com>, Barry Song <Baohua.Song@csr.com>, Chris Ball <cjb@laptop.org>

Patch "mmc: sdhci: Add size for caller in init+register" changed the
interface for sdhci_pltfm_init, while patch "mmc: sdhci-sirf: add mmc
host sdhci-pltfm based driver for SiRF SoCs" added a new driver
with the old interface.

This changes the sirf driver to use the new interface, avoiding
one warning, and simplifying the init sequence. Since we're here
already, this also adds an error path for failed clk_prepare_enable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Daudt <csd@broadcom.com>
Cc: Barry Song <Baohua.Song@csr.com>
Cc: Chris Ball <cjb@laptop.org>
----
This needs an Ack from Barry before it can get applied.

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 09805af..cc80f26 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -24,7 +24,7 @@ struct sdhci_sirf_priv {
 static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	return clk_get_rate(priv->clk);
 }
 
@@ -47,6 +47,8 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_sirf_priv *priv;
 	struct pinctrl *pinctrl;
+	struct clk *clk;
+	int gpio_cd;
 	int ret;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
@@ -55,38 +57,31 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 		return PTR_ERR(pinctrl);
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_sirf_priv),
-		GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "unable to allocate private data");
-		return -ENOMEM;
-	}
-
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get clock");
-		return PTR_ERR(priv->clk);
+		return PTR_ERR(clk);
 	}
 
-	if (pdev->dev.of_node) {
-		priv->gpio_cd = of_get_named_gpio(pdev->dev.of_node,
-			"cd-gpios", 0);
-	} else {
-		priv->gpio_cd = -EINVAL;
-	}
+	if (pdev->dev.of_node)
+		gpio_cd = of_get_named_gpio(pdev->dev.of_node, "cd-gpios", 0);
+	else
+		gpio_cd = -EINVAL;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);
-	if (IS_ERR(host)) {
-		ret = PTR_ERR(host);
-		goto err_sdhci_pltfm_init;
-	}
+	host = sdhci_pltfm_init(pdev, &sdhci_sirf_pdata, sizeof(struct sdhci_sirf_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = priv;
+	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->clk = clk;
+	priv->gpio_cd = gpio_cd;
 
 	sdhci_get_of_property(pdev);
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		goto err_clk_prepare;
 
 	ret = sdhci_add_host(host);
 	if (ret)
@@ -111,8 +106,8 @@ err_request_cd:
 	sdhci_remove_host(host, 0);
 err_sdhci_add:
 	clk_disable_unprepare(priv->clk);
+err_clk_prepare:
 	sdhci_pltfm_free(pdev);
-err_sdhci_pltfm_init:
 	return ret;
 }
 
@@ -120,7 +115,7 @@ static int sdhci_sirf_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_pltfm_unregister(pdev);
 
@@ -136,7 +131,7 @@ static int sdhci_sirf_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
@@ -152,7 +147,7 @@ static int sdhci_sirf_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = clk_enable(priv->clk);

