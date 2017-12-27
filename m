From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] mmc: sdhci_f_sdh30: add ACPI support
Date: Wed, 27 Dec 2017 18:14:20 +0000
Message-ID: <20171227181420.6230-1-ard.biesheuvel@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40418 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdL0SOa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Dec 2017 13:14:30 -0500
Received: by mail-wr0-f196.google.com with SMTP id p17so13638972wre.7
        for <linux-mmc@vger.kernel.org>; Wed, 27 Dec 2017 10:14:30 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The Fujitsu SDH30 SDHCI controller may be described as a SCX0002 ACPI
device on ACPI platforms incorporating the Socionext SynQuacer SoC.

Given that mmc_of_parse() has already been made ACPI/DT agnostic,
making the SDH30 driver ACPI capable is actually rather simple:
all we need to do is make the call to sdhci_get_of_property() [which
does not set any properties we care about] and the clock handling
dependent on whether we are dealing with a DT device, and exposing
the ACPI id via the platform_driver struct and the module metadata.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 53 +++++++++++++-------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 04ca0d33a521..102321a9ea34 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -10,6 +10,7 @@
  * the Free Software Foundation, version 2 of the License.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -146,7 +147,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	sdhci_get_of_property(pdev);
 	host->hw_name = "f_sdh30";
 	host->ops = &sdhci_f_sdh30_ops;
 	host->irq = irq;
@@ -158,25 +158,29 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
-	if (IS_ERR(priv->clk_iface)) {
-		ret = PTR_ERR(priv->clk_iface);
-		goto err;
-	}
+	if (dev_of_node(dev)) {
+		sdhci_get_of_property(pdev);
 
-	ret = clk_prepare_enable(priv->clk_iface);
-	if (ret)
-		goto err;
+		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
+		if (IS_ERR(priv->clk_iface)) {
+			ret = PTR_ERR(priv->clk_iface);
+			goto err;
+		}
 
-	priv->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(priv->clk)) {
-		ret = PTR_ERR(priv->clk);
-		goto err_clk;
-	}
+		ret = clk_prepare_enable(priv->clk_iface);
+		if (ret)
+			goto err;
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		goto err_clk;
+		priv->clk = devm_clk_get(&pdev->dev, "core");
+		if (IS_ERR(priv->clk)) {
+			ret = PTR_ERR(priv->clk);
+			goto err_clk;
+		}
+
+		ret = clk_prepare_enable(priv->clk);
+		if (ret)
+			goto err_clk;
+	}
 
 	/* init vendor specific regs */
 	ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
@@ -217,8 +221,10 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
 			  0xffffffff);
 
-	clk_disable_unprepare(priv->clk_iface);
-	clk_disable_unprepare(priv->clk);
+	if (dev_of_node(priv->dev)) {
+		clk_disable_unprepare(priv->clk_iface);
+		clk_disable_unprepare(priv->clk);
+	}
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
@@ -232,10 +238,19 @@ static const struct of_device_id f_sdh30_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id f_sdh30_acpi_ids[] = {
+	{ "SCX0002" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, f_sdh30_acpi_ids);
+#endif
+
 static struct platform_driver sdhci_f_sdh30_driver = {
 	.driver = {
 		.name = "f_sdh30",
 		.of_match_table = f_sdh30_dt_ids,
+		.acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe	= sdhci_f_sdh30_probe,
-- 
2.11.0

