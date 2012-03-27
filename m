From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 2/3] mmc/sdhci-spear: Use devm_* derivatives
Date: Tue, 27 Mar 2012 08:40:35 +0530
Message-ID: <c12200e3f3dbedf9c01fdf6766d27d2ed61c727b.1332817654.git.viresh.kumar@st.com>
References: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:36484 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756910Ab2C0D1r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 23:27:47 -0400
In-Reply-To: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

This patch replaces normal calls to resource allocation routines with devm_*()
derivative of those routines. This removes the need to free those resources
inside the driver.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mmc/host/sdhci-spear.c |   80 ++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 15191c1..1fe32df 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -82,18 +82,18 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (!request_mem_region(iomem->start, resource_size(iomem),
-				"spear-sdhci")) {
+	if (!devm_request_mem_region(&pdev->dev, iomem->start,
+				resource_size(iomem), "spear-sdhci")) {
 		ret = -EBUSY;
 		dev_dbg(&pdev->dev, "cannot request region\n");
 		goto err;
 	}
 
-	sdhci = kzalloc(sizeof(*sdhci), GFP_KERNEL);
+	sdhci = devm_kzalloc(&pdev->dev, sizeof(*sdhci), GFP_KERNEL);
 	if (!sdhci) {
 		ret = -ENOMEM;
 		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
-		goto err_kzalloc;
+		goto err;
 	}
 
 	/* clk enable */
@@ -101,13 +101,13 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
-		goto err_clk_get;
+		goto err;
 	}
 
 	ret = clk_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto err_clk_enb;
+		goto put_clk;
 	}
 
 	/* overwrite platform_data */
@@ -122,7 +122,7 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		dev_dbg(&pdev->dev, "error allocating host\n");
-		goto err_alloc_host;
+		goto disable_clk;
 	}
 
 	host->hw_name = "sdhci";
@@ -130,17 +130,18 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	host->irq = platform_get_irq(pdev, 0);
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
 
-	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
+			resource_size(iomem));
 	if (!host->ioaddr) {
 		ret = -ENOMEM;
 		dev_dbg(&pdev->dev, "failed to remap registers\n");
-		goto err_ioremap;
+		goto free_host;
 	}
 
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
-		goto err_add_host;
+		goto free_host;
 	}
 
 	platform_set_drvdata(pdev, host);
@@ -159,11 +160,12 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	if (sdhci->data->card_power_gpio >= 0) {
 		int val = 0;
 
-		ret = gpio_request(sdhci->data->card_power_gpio, "sdhci");
+		ret = devm_gpio_request(&pdev->dev,
+				sdhci->data->card_power_gpio, "sdhci");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
 					sdhci->data->card_power_gpio);
-			goto err_pgpio_request;
+			goto set_drvdata;
 		}
 
 		if (sdhci->data->power_always_enb)
@@ -175,60 +177,48 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
 					sdhci->data->card_power_gpio);
-			goto err_pgpio_direction;
+			goto set_drvdata;
 		}
 	}
 
 	if (sdhci->data->card_int_gpio >= 0) {
-		ret = gpio_request(sdhci->data->card_int_gpio, "sdhci");
+		ret = devm_gpio_request(&pdev->dev, sdhci->data->card_int_gpio,
+				"sdhci");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto err_igpio_request;
+			goto set_drvdata;
 		}
 
 		ret = gpio_direction_input(sdhci->data->card_int_gpio);
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto err_igpio_direction;
+			goto set_drvdata;
 		}
-		ret = request_irq(gpio_to_irq(sdhci->data->card_int_gpio),
+		ret = devm_request_irq(&pdev->dev,
+				gpio_to_irq(sdhci->data->card_int_gpio),
 				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
 				mmc_hostname(host->mmc), pdev);
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto err_igpio_request_irq;
+			goto set_drvdata;
 		}
 
 	}
 
 	return 0;
 
-err_igpio_request_irq:
-err_igpio_direction:
-	if (sdhci->data->card_int_gpio >= 0)
-		gpio_free(sdhci->data->card_int_gpio);
-err_igpio_request:
-err_pgpio_direction:
-	if (sdhci->data->card_power_gpio >= 0)
-		gpio_free(sdhci->data->card_power_gpio);
-err_pgpio_request:
+set_drvdata:
 	platform_set_drvdata(pdev, NULL);
 	sdhci_remove_host(host, 1);
-err_add_host:
-	iounmap(host->ioaddr);
-err_ioremap:
+free_host:
 	sdhci_free_host(host);
-err_alloc_host:
+disable_clk:
 	clk_disable(sdhci->clk);
-err_clk_enb:
+put_clk:
 	clk_put(sdhci->clk);
-err_clk_get:
-	kfree(sdhci);
-err_kzalloc:
-	release_mem_region(iomem->start, resource_size(iomem));
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -237,35 +227,19 @@ err:
 static int __devexit sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
-	int dead;
+	int dead = 0;
 	u32 scratch;
 
-	if (sdhci->data) {
-		if (sdhci->data->card_int_gpio >= 0) {
-			free_irq(gpio_to_irq(sdhci->data->card_int_gpio), pdev);
-			gpio_free(sdhci->data->card_int_gpio);
-		}
-
-		if (sdhci->data->card_power_gpio >= 0)
-			gpio_free(sdhci->data->card_power_gpio);
-	}
-
 	platform_set_drvdata(pdev, NULL);
-	dead = 0;
 	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
 	if (scratch == (u32)-1)
 		dead = 1;
 
 	sdhci_remove_host(host, dead);
-	iounmap(host->ioaddr);
 	sdhci_free_host(host);
 	clk_disable(sdhci->clk);
 	clk_put(sdhci->clk);
-	kfree(sdhci);
-	if (iomem)
-		release_mem_region(iomem->start, resource_size(iomem));
 
 	return 0;
 }
-- 
1.7.10.rc2.10.gb47606

