From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 1/2] mmc: host: sdhci-s3c: Use devm_gpio_request to request
 GPIOs
Date: Fri, 16 Nov 2012 15:28:16 +0100
Message-ID: <1353076097-22498-2-git-send-email-t.figa@samsung.com>
References: <1353076097-22498-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59100 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2KPO2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 09:28:54 -0500
In-reply-to: <1353076097-22498-1-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

The set of GPIO pins used by sdhci-s3c driver varies between
configurations, such as card detect method, pinctrl availability, etc.
This overly complicates the code requesting and freeing GPIO pins, which
must check which pins are used, when freeing them.

This patch modifies the sdhci-s3c driver to use devm_gpio_request to
free requested pins automatically after unbinding the driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..75f85fd 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -406,7 +406,7 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 	struct s3c_sdhci_platdata *pdata = sc->pdata;
 	struct device *dev = &sc->pdev->dev;
 
-	if (gpio_request(pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
+	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
 		sc->ext_cd_gpio = pdata->ext_cd_gpio;
 		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
 		if (sc->ext_cd_irq &&
@@ -487,7 +487,7 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 		if (of_get_property(node, "cd-inverted", NULL))
 			pdata->ext_cd_gpio_invert = 1;
 	} else if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		ret = gpio_request(gpio, "sdhci-cd");
+		ret = devm_gpio_request(dev, gpio, "sdhci-cd");
 		if (ret) {
 			dev_err(dev, "card detect gpio request failed\n");
 			return -EINVAL;
@@ -501,28 +501,20 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 		gpio = of_get_gpio(node, cnt);
 		if (!gpio_is_valid(gpio)) {
 			dev_err(dev, "invalid gpio[%d]\n", cnt);
-			goto err_free_dt_cd_gpio;
+			return -EINVAL;
 		}
 		ourhost->gpios[cnt] = gpio;
 	}
 
 	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
-		ret = gpio_request(ourhost->gpios[cnt], "sdhci-gpio");
+		ret = devm_gpio_request(dev, ourhost->gpios[cnt], "sdhci-gpio");
 		if (ret) {
 			dev_err(dev, "gpio[%d] request failed\n", cnt);
-			goto err_free_dt_gpios;
+			return -EINVAL;
 		}
 	}
 
 	return 0;
-
- err_free_dt_gpios:
-	while (--cnt >= 0)
-		gpio_free(ourhost->gpios[cnt]);
- err_free_dt_cd_gpio:
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
-		gpio_free(ourhost->ext_cd_gpio);
-	return -EINVAL;
 }
 #else
 static int __devinit sdhci_s3c_parse_dt(struct device *dev,
@@ -579,13 +571,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		ret = -ENOMEM;
-		goto err_pdata;
+		goto err_pdata_io_clk;
 	}
 
 	if (pdev->dev.of_node) {
 		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
 		if (ret)
-			goto err_pdata;
+			goto err_pdata_io_clk;
 	} else {
 		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
 		sc->ext_cd_gpio = -1; /* invalid gpio number */
@@ -603,7 +595,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (IS_ERR(sc->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(sc->clk_io);
-		goto err_io_clk;
+		goto err_pdata_io_clk;
 	}
 
 	/* enable the local io clock and keep it running for the moment. */
@@ -765,13 +757,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	clk_disable(sc->clk_io);
 	clk_put(sc->clk_io);
 
- err_io_clk:
-	for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
-		gpio_free(sc->gpios[ptr]);
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
-		gpio_free(sc->ext_cd_gpio);
-
- err_pdata:
+ err_pdata_io_clk:
 	sdhci_free_host(host);
 
 	return ret;
@@ -790,9 +776,6 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	if (sc->ext_cd_irq)
 		free_irq(sc->ext_cd_irq, sc);
 
-	if (gpio_is_valid(sc->ext_cd_gpio))
-		gpio_free(sc->ext_cd_gpio);
-
 #ifdef CONFIG_PM_RUNTIME
 	clk_enable(sc->clk_io);
 #endif
@@ -812,11 +795,6 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable(sc->clk_io);
 	clk_put(sc->clk_io);
 
-	if (pdev->dev.of_node) {
-		for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
-			gpio_free(sc->gpios[ptr]);
-	}
-
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.8.0

