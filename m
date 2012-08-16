From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 21:19:29 +0530
Message-ID: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55492 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2HPPdU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Aug 2012 11:33:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

Add device tree based discovery support for Samsung's sdhci controller

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |  146 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a50c205..7fcc642 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -34,6 +34,9 @@
 
 #define MAX_BUS_CLK	(4)
 
+/* Number of gpio's used is max data bus width + command and clock lines */
+#define NUM_GPIOS(x)	(x + 2)
+
 /**
  * struct sdhci_s3c - S3C SDHCI instance
  * @host: The SDHCI host created
@@ -41,6 +44,7 @@
  * @ioarea: The resource created when we claimed the IO area.
  * @pdata: The platform data for this controller.
  * @cur_clk: The index of the current bus clock.
+ * @gpios: List of gpio numbers parsed from device tree.
  * @clk_io: The clock for the internal bus interface.
  * @clk_bus: The clocks that are available for the SD/MMC bus clock.
  */
@@ -52,6 +56,7 @@ struct sdhci_s3c {
 	unsigned int		cur_clk;
 	int			ext_cd_irq;
 	int			ext_cd_gpio;
+	int			*gpios;
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
@@ -419,9 +424,109 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 	}
 }
 
+#ifdef CONFIG_OF
+static int __devinit sdhci_s3c_parse_dt(struct device *dev,
+		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
+{
+	struct device_node *node = dev->of_node;
+	struct sdhci_s3c *ourhost = to_s3c(host);
+	u32 max_width;
+	int gpio, cnt, ret;
+
+	/* if the bus-width property is not specified, assume width as 1 */
+	if (of_property_read_u32(node, "bus-width", &max_width))
+		max_width = 1;
+	pdata->max_width = max_width;
+
+	ourhost->gpios = devm_kzalloc(dev, NUM_GPIOS(pdata->max_width) *
+				sizeof(int), GFP_KERNEL);
+	if (!ourhost->gpios)
+		return -ENOMEM;
+
+	/* get the card detection method */
+	if (of_get_property(node, "samsung,sdhci-cd-internal", NULL))
+		pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
+	else if (of_get_property(node, "samsung,sdhci-cd-gpio", NULL))
+		pdata->cd_type = S3C_SDHCI_CD_GPIO;
+	else if (of_get_property(node, "samsung,sdhci-cd-none", NULL))
+		pdata->cd_type = S3C_SDHCI_CD_NONE;
+	else if (of_get_property(node, "samsung,sdhci-cd-permanent", NULL))
+		pdata->cd_type = S3C_SDHCI_CD_PERMANENT;
+	else
+		pdata->cd_type = S3C_SDHCI_CD_NONE;
+
+	/* get the gpio used for card detection */
+	if (pdata->cd_type == S3C_SDHCI_CD_GPIO ||
+			pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		gpio = of_get_named_gpio(node, "cd-gpios", 0);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(dev, "invalid card detect gpio specified\n");
+			return -EINVAL;
+		}
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_GPIO) {
+		pdata->ext_cd_gpio = gpio;
+		ourhost->ext_cd_gpio = -1;
+		if (of_get_property(node, "cd-inverted", NULL))
+			pdata->ext_cd_gpio_invert = 1;
+	} else if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		ret = gpio_request(gpio, "sdhci-cd");
+		if (ret) {
+			dev_err(dev, "card detect gpio request failed\n");
+			return -EINVAL;
+		}
+		ourhost->ext_cd_gpio = gpio;
+	}
+
+	/* get the gpios for command, clock and data lines */
+	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
+		gpio = of_get_gpio(node, cnt);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(dev, "invalid gpio[%d]\n", cnt);
+			goto err_free_dt_cd_gpio;
+		}
+		ourhost->gpios[cnt] = gpio;
+	}
+
+	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
+		ret = gpio_request(ourhost->gpios[cnt], "sdhci-gpio");
+		if (ret) {
+			dev_err(dev, "gpio[%d] request failed\n", cnt);
+			goto err_free_dt_gpios;
+		}
+	}
+
+	return 0;
+
+ err_free_dt_gpios:
+	while (--cnt >= 0)
+		gpio_free(ourhost->gpios[cnt]);
+ err_free_dt_cd_gpio:
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
+		gpio_free(ourhost->ext_cd_gpio);
+	return -EINVAL;
+}
+#else
+static int __devinit sdhci_s3c_parse_dt(struct device *dev,
+		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
+{
+	return -EINVAL;
+}
+#endif
+
+static const struct of_device_id sdhci_s3c_dt_match[];
+
 static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
 {
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
+		return (struct sdhci_s3c_drv_data *)match->data;
+	}
+#endif
 	return (struct sdhci_s3c_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
@@ -436,7 +541,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq, ptr, clks;
 
-	if (!pdev->dev.platform_data) {
+	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
 		dev_err(dev, "no device data specified\n");
 		return -ENOENT;
 	}
@@ -452,21 +557,28 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		dev_err(dev, "sdhci_alloc_host() failed\n");
 		return PTR_ERR(host);
 	}
+	sc = sdhci_priv(host);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		ret = -ENOMEM;
-		goto err_io_clk;
+		goto err_pdata;
+	}
+
+	if (pdev->dev.of_node) {
+		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
+		if (ret)
+			goto err_pdata;
+	} else {
+		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
+		sc->ext_cd_gpio = -1; /* invalid gpio number */
 	}
-	memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
 
 	drv_data = sdhci_s3c_get_driver_data(pdev);
-	sc = sdhci_priv(host);
 
 	sc->host = host;
 	sc->pdev = pdev;
 	sc->pdata = pdata;
-	sc->ext_cd_gpio = -1; /* invalid gpio number */
 
 	platform_set_drvdata(pdev, host);
 
@@ -631,6 +743,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	clk_put(sc->clk_io);
 
  err_io_clk:
+	for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
+		gpio_free(sc->gpios[ptr]);
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
+		gpio_free(sc->ext_cd_gpio);
+
+ err_pdata:
 	sdhci_free_host(host);
 
 	return ret;
@@ -638,9 +756,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 {
-	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
+	struct s3c_sdhci_platdata *pdata = sc->pdata;
 	int ptr;
 
 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
@@ -665,6 +783,11 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable(sc->clk_io);
 	clk_put(sc->clk_io);
 
+	if (pdev->dev.of_node) {
+		for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
+			gpio_free(sc->gpios[ptr]);
+	}
+
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
 
@@ -737,6 +860,16 @@ static struct platform_device_id sdhci_s3c_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id sdhci_s3c_dt_match[] = {
+	{ .compatible = "samsung,s3c6410-sdhci", },
+	{ .compatible = "samsung,exynos4210-sdhci",
+		.data = &exynos4_sdhci_drv_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
+#endif
+
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
 	.remove		= __devexit_p(sdhci_s3c_remove),
@@ -744,6 +877,7 @@ static struct platform_driver sdhci_s3c_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-sdhci",
+		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
 		.pm	= SDHCI_S3C_PMOPS,
 	},
 };
-- 
1.6.6.rc2

