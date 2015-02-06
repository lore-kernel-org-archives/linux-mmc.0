From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 2/7] mmc: sdhci-dove: kill the driver specific private struct
Date: Fri,  6 Feb 2015 11:15:17 +0800
Message-ID: <1423192522-6056-3-git-send-email-haokexin@gmail.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:35097 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbBFDPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:40 -0500
Received: by mail-yh0-f49.google.com with SMTP id v1so5128599yhn.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 19:15:40 -0800 (PST)
In-Reply-To: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>

There is only one "clk" member in this driver specific private struct.
Actually we can use the "clk" member in the struct sdhci_pltfm_host,
and then kill this struct completely.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-dove.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 0a7aeb162497..f78440ef1ba4 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -28,10 +28,6 @@
 
 #include "sdhci-pltfm.h"
 
-struct sdhci_dove_priv {
-	struct clk *clk;
-};
-
 static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
 {
 	u16 ret;
@@ -84,27 +80,17 @@ static int sdhci_dove_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
-	struct sdhci_dove_priv *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_dove_priv),
-			    GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "unable to allocate private data");
-		return -ENOMEM;
-	}
-
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-
 	host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = priv;
+	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 
-	if (!IS_ERR(priv->clk))
-		clk_prepare_enable(priv->clk);
+	if (!IS_ERR(pltfm_host->clk))
+		clk_prepare_enable(pltfm_host->clk);
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
@@ -117,7 +103,7 @@ static int sdhci_dove_probe(struct platform_device *pdev)
 	return 0;
 
 err_sdhci_add:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
@@ -126,12 +112,10 @@ static int sdhci_dove_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_dove_priv *priv = pltfm_host->priv;
 
+	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_unregister(pdev);
 
-	clk_disable_unprepare(priv->clk);
-
 	return 0;
 }
 
-- 
1.9.3

