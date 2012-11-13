From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 1/2] mmc: host: sdhci-s3c: Use devm_gpio_request to request
 GPIOs
Date: Tue, 13 Nov 2012 11:30:18 +0100
Message-ID: <1352802619-29547-2-git-send-email-t.figa@samsung.com>
References: <1352802619-29547-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11520 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab2KMKbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 05:31:00 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDF004FH9634K80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:33 +0900 (KST)
Received: from mcdsrvbld02.digital.local ([106.116.37.23])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDF0004096MWE80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:33 +0900 (KST)
In-reply-to: <1352802619-29547-1-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

The set of GPIO pins used by sdhci-s3c driver varies between
configurations, such as card detect method, pinctrl availability, etc.
This overly complicates the code requesting and freeing GPIO pins, which
must check which pins are used, when freeing them.

This patch modifies the sdhci-s3c driver to use devm_gpio_request to
free requested pins automatically after unbinding the driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..039ed99 100644
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
@@ -585,7 +577,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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

