From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 4/7] mmc: sdhci-sirf: kill the "clk" member in driver private struct
Date: Fri, 27 Feb 2015 15:47:28 +0800
Message-ID: <1425023251-4544-5-git-send-email-haokexin@gmail.com>
References: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:44399 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbbB0HsJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 02:48:09 -0500
Received: by ykp131 with SMTP id 131so6487305ykp.11
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 23:48:08 -0800 (PST)
In-Reply-To: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <baohua@kernel.org>

Actually we can use the "clk" in the struct sdhci_pltfm_host.
With this change we can also kill the private function for get
max clock in this driver.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Also kill the private sdhci_sirf_get_max_clk().

 drivers/mmc/host/sdhci-sirf.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index f6f82ec3618d..c30d6f3dd9aa 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -20,17 +20,9 @@
 #define SIRF_TUNING_COUNT 128
 
 struct sdhci_sirf_priv {
-	struct clk *clk;
 	int gpio_cd;
 };
 
-static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_sirf_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	return clk_get_rate(priv->clk);
-}
-
 static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -122,7 +114,7 @@ retry:
 static struct sdhci_ops sdhci_sirf_ops = {
 	.platform_execute_tuning = sdhci_sirf_execute_tuning,
 	.set_clock = sdhci_set_clock,
-	.get_max_clock	= sdhci_sirf_get_max_clk,
+	.get_max_clock	= sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_sirf_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -162,13 +154,13 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
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
 
@@ -195,7 +187,7 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 err_request_cd:
 	sdhci_remove_host(host, 0);
 err_sdhci_add:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 err_clk_prepare:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -205,11 +197,9 @@ static int sdhci_sirf_remove(struct platform_device *pdev)
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
 
@@ -218,14 +208,13 @@ static int sdhci_sirf_suspend(struct device *dev)
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
@@ -234,10 +223,9 @@ static int sdhci_sirf_resume(struct device *dev)
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

