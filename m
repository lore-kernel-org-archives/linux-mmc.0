From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-spear: Simplify by adding build dependency to CONFIG_OF
Date: Thu,  5 Mar 2015 16:33:00 +0100
Message-ID: <1425569580-20347-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38684 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585AbbCEPdJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 10:33:09 -0500
Received: by lbiz12 with SMTP id z12so29250243lbi.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 07:33:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Viresh Kumar <viresh.linux@gmail.com>
Cc: linux-mmc@vger.kernel.org, spear-devel@list.st.com

This driver is used on SoCs which are using CONFIG_OF. By adding a
compile dependency in the Kconfig, it enables us to simplify some code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-spear.c | 20 ++++----------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2f850ac..7f4db90 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -255,6 +255,7 @@ config MMC_SDHCI_PXAV2
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
+	depends on OF
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the ST SPEAR range
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 22e5826..f482f7f 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -44,7 +44,6 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-#ifdef CONFIG_OF
 static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -66,16 +65,9 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
 
 	return pdata;
 }
-#else
-static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
 
 static int sdhci_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct spear_sdhci *sdhci;
@@ -124,14 +116,10 @@ static int sdhci_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Error setting desired clk, clk=%lu\n",
 				clk_get_rate(sdhci->clk));
 
-	if (np) {
-		sdhci->data = sdhci_probe_config_dt(pdev);
-		if (IS_ERR(sdhci->data)) {
-			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-			goto disable_clk;
-		}
-	} else {
-		sdhci->data = dev_get_platdata(&pdev->dev);
+	sdhci->data = sdhci_probe_config_dt(pdev);
+	if (IS_ERR(sdhci->data)) {
+		dev_err(&pdev->dev, "DT: Failed to get pdata\n");
+		goto disable_clk;
 	}
 
 	/*
-- 
1.9.1

