From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] mmc: sdhci-spear: Convert to use sdhci_pltfm_* APIs
Date: Sat, 31 Aug 2013 14:41:59 +0800
Message-ID: <1377931319.10324.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63653 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3HaGmF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Aug 2013 02:42:05 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2692715pdj.16
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2013 23:42:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>, linux-mmc@vger.kernel.org, spear-devel@list.st.com

This patch refactors the code to use sdhci_pltfm_* APIs instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Viresh,
Looks like this driver can be converted to use sdhci_pltfm_* APIs instead of
open-coded. I don't have this hardware, any chance to test if this patch works?

Thanks,
Axel

 drivers/mmc/host/Kconfig       |   2 +-
 drivers/mmc/host/sdhci-spear.c | 114 +++++++++++++----------------------------
 2 files changed, 36 insertions(+), 80 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b8ce939..152336b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -229,7 +229,7 @@ config MMC_SDHCI_PXAV2
 
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
-	depends on MMC_SDHCI && PLAT_SPEAR
+	depends on MMC_SDHCI_PLTFM && PLAT_SPEAR
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the ST SPEAR range
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8..f1fc416 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -28,6 +28,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-spear.h>
 #include <linux/io.h>
+#include "sdhci-pltfm.h"
 #include "sdhci.h"
 
 struct spear_sdhci {
@@ -35,17 +36,14 @@ struct spear_sdhci {
 	struct sdhci_plat_data *data;
 };
 
-/* sdhci ops */
-static const struct sdhci_ops sdhci_pltfm_ops = {
-	/* Nothing to do for now. */
-};
-
 /* gpio card detection interrupt handler */
 static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spear_sdhci *sdhci = sdhci_pltfm_priv(pltfm_host);
+
 	unsigned long gpio_irq_type;
 	int val;
 
@@ -101,47 +99,39 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
 }
 #endif
 
+static const struct sdhci_pltfm_data sdhci_spear_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_ADMA,
+};
+
 static int sdhci_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host;
-	struct resource *iomem;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct spear_sdhci *sdhci;
 	int ret;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem) {
-		ret = -ENOMEM;
-		dev_dbg(&pdev->dev, "memory resource not defined\n");
-		goto err;
-	}
-
-	if (!devm_request_mem_region(&pdev->dev, iomem->start,
-				resource_size(iomem), "spear-sdhci")) {
-		ret = -EBUSY;
-		dev_dbg(&pdev->dev, "cannot request region\n");
+	host = sdhci_pltfm_init(pdev, &sdhci_spear_pdata, sizeof(*sdhci));
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
 		goto err;
 	}
 
-	sdhci = devm_kzalloc(&pdev->dev, sizeof(*sdhci), GFP_KERNEL);
-	if (!sdhci) {
-		ret = -ENOMEM;
-		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
-		goto err;
-	}
+	pltfm_host = sdhci_priv(host);
+	sdhci = sdhci_pltfm_priv(pltfm_host);
 
 	/* clk enable */
-	sdhci->clk = clk_get(&pdev->dev, NULL);
+	sdhci->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
-		goto err;
+		goto free_sdhci_pltfm;
 	}
 
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto put_clk;
+		goto free_sdhci_pltfm;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -153,46 +143,19 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = sdhci_probe_config_dt(pdev);
 		if (IS_ERR(sdhci->data)) {
 			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-			return -ENODEV;
+			ret = PTR_ERR(sdhci->data);
+			goto disable_clk;
 		}
 	} else {
 		sdhci->data = dev_get_platdata(&pdev->dev);
 	}
 
-	pdev->dev.platform_data = sdhci;
-
-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
-	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
-
-	if (IS_ERR(host)) {
-		ret = PTR_ERR(host);
-		dev_dbg(&pdev->dev, "error allocating host\n");
-		goto disable_clk;
-	}
-
-	host->hw_name = "sdhci";
-	host->ops = &sdhci_pltfm_ops;
-	host->irq = platform_get_irq(pdev, 0);
-	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
-
-	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
-			resource_size(iomem));
-	if (!host->ioaddr) {
-		ret = -ENOMEM;
-		dev_dbg(&pdev->dev, "failed to remap registers\n");
-		goto free_host;
-	}
-
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
-		goto free_host;
+		goto disable_clk;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	/*
 	 * It is optional to use GPIOs for sdhci Power control & sdhci card
 	 * interrupt detection. If sdhci->data is NULL, then use original sdhci
@@ -212,7 +175,7 @@ static int sdhci_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
 					sdhci->data->card_power_gpio);
-			goto set_drvdata;
+			goto remove_host;
 		}
 
 		if (sdhci->data->power_always_enb)
@@ -224,7 +187,7 @@ static int sdhci_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
 					sdhci->data->card_power_gpio);
-			goto set_drvdata;
+			goto remove_host;
 		}
 	}
 
@@ -234,14 +197,14 @@ static int sdhci_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto set_drvdata;
+			goto remove_host;
 		}
 
 		ret = gpio_direction_input(sdhci->data->card_int_gpio);
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto set_drvdata;
+			goto remove_host;
 		}
 		ret = devm_request_irq(&pdev->dev,
 				gpio_to_irq(sdhci->data->card_int_gpio),
@@ -250,21 +213,19 @@ static int sdhci_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
 					sdhci->data->card_int_gpio);
-			goto set_drvdata;
+			goto remove_host;
 		}
 
 	}
 
 	return 0;
 
-set_drvdata:
+remove_host:
 	sdhci_remove_host(host, 1);
-free_host:
-	sdhci_free_host(host);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
-put_clk:
-	clk_put(sdhci->clk);
+free_sdhci_pltfm:
+	sdhci_pltfm_free(pdev);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -273,18 +234,11 @@ err:
 static int sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
-	int dead = 0;
-	u32 scratch;
-
-	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
-	if (scratch == (u32)-1)
-		dead = 1;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spear_sdhci *sdhci = sdhci_pltfm_priv(pltfm_host);
 
-	sdhci_remove_host(host, dead);
-	sdhci_free_host(host);
+	sdhci_pltfm_unregister(pdev);
 	clk_disable_unprepare(sdhci->clk);
-	clk_put(sdhci->clk);
 
 	return 0;
 }
@@ -293,7 +247,8 @@ static int sdhci_remove(struct platform_device *pdev)
 static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spear_sdhci *sdhci = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
@@ -306,7 +261,8 @@ static int sdhci_suspend(struct device *dev)
 static int sdhci_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spear_sdhci *sdhci = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = clk_enable(sdhci->clk);
-- 
1.8.1.2



