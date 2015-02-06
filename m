From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 4/7] mmc: sdhci-sirf: kill the "clk" member in driver private struct
Date: Fri,  6 Feb 2015 11:15:19 +0800
Message-ID: <1423192522-6056-5-git-send-email-haokexin@gmail.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35773 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbbBFDPp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:45 -0500
Received: by mail-yh0-f46.google.com with SMTP id c41so5135762yho.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 19:15:44 -0800 (PST)
In-Reply-To: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <baohua@kernel.org>, Kevin Hao <haokexin@gmail.com>

Actually we can use the "clk" in the struct sdhci_pltfm_host.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-sirf.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index f6f82ec3618d..51b31208f559 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -20,15 +20,13 @@
 #define SIRF_TUNING_COUNT 128
 
 struct sdhci_sirf_priv {
-	struct clk *clk;
 	int gpio_cd;
 };
 
 static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	return clk_get_rate(priv->clk);
+	return clk_get_rate(pltfm_host->clk);
 }
 
 static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
@@ -162,13 +160,13 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
+	pltfm_host->clk = clk;
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->clk = clk;
 	priv->gpio_cd = gpio_cd;
 
 	sdhci_get_of_property(pdev);
 
-	ret = clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(pltfm_host->clk);
 	if (ret)
 		goto err_clk_prepare;
 
@@ -195,7 +193,7 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 err_request_cd:
 	sdhci_remove_host(host, 0);
 err_sdhci_add:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 err_clk_prepare:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -205,11 +203,9 @@ static int sdhci_sirf_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
+	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_unregister(pdev);
-
-	clk_disable_unprepare(priv->clk);
 	return 0;
 }
 
@@ -218,14 +214,13 @@ static int sdhci_sirf_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
 
-	clk_disable(priv->clk);
+	clk_disable(pltfm_host->clk);
 
 	return 0;
 }
@@ -234,10 +229,9 @@ static int sdhci_sirf_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = clk_enable(priv->clk);
+	ret = clk_enable(pltfm_host->clk);
 	if (ret) {
 		dev_dbg(dev, "Resume: Error enabling clock\n");
 		return ret;
-- 
1.9.3

