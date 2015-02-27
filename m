From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 5/7] mmc: sdhci-bcm-kona: kill the "external_clk" member in driver private struct
Date: Fri, 27 Feb 2015 15:47:29 +0800
Message-ID: <1425023251-4544-6-git-send-email-haokexin@gmail.com>
References: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:38291 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbB0HsO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 02:48:14 -0500
Received: by ykp9 with SMTP id 9so6503396ykp.5
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 23:48:13 -0800 (PST)
In-Reply-To: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

Actually we can use the "clk" in the struct sdhci_pltfm_host. Also
change the "external clock" to "core clock" and kill two redundant
private functions in this driver as suggested by Ray Jui.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
  - s/external clock/core clock/
  - kill the private functions sdhci_bcm_kona_get_max_clk() and sdhci_bcm_kona_get_timeout_clock()

 drivers/mmc/host/sdhci-bcm-kona.c | 46 +++++++++++----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 34bb8f92586e..5bc263b447b2 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -54,7 +54,6 @@
 
 struct sdhci_bcm_kona_dev {
 	struct mutex	write_lock; /* protect back to back writes */
-	struct clk	*external_clk;
 };
 
 
@@ -175,24 +174,6 @@ static void sdhci_bcm_kona_card_event(struct sdhci_host *host)
 	}
 }
 
-/*
- * Get the base clock. Use central clock source for now. Not sure if different
- * clock speed to each dev is allowed
- */
-static unsigned int sdhci_bcm_kona_get_max_clk(struct sdhci_host *host)
-{
-	struct sdhci_bcm_kona_dev *kona_dev;
-	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
-	kona_dev = sdhci_pltfm_priv(pltfm_priv);
-
-	return host->mmc->f_max;
-}
-
-static unsigned int sdhci_bcm_kona_get_timeout_clock(struct sdhci_host *host)
-{
-	return sdhci_bcm_kona_get_max_clk(host);
-}
-
 static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 				u8 power_mode)
 {
@@ -207,8 +188,8 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 
 static struct sdhci_ops sdhci_bcm_kona_ops = {
 	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_bcm_kona_get_max_clk,
-	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
@@ -264,21 +245,21 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
-	/* Get and enable the external clock */
-	kona_dev->external_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(kona_dev->external_clk)) {
-		dev_err(dev, "Failed to get external clock\n");
-		ret = PTR_ERR(kona_dev->external_clk);
+	/* Get and enable the core clock */
+	pltfm_priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pltfm_priv->clk)) {
+		dev_err(dev, "Failed to get core clock\n");
+		ret = PTR_ERR(pltfm_priv->clk);
 		goto err_pltfm_free;
 	}
 
-	if (clk_set_rate(kona_dev->external_clk, host->mmc->f_max) != 0) {
-		dev_err(dev, "Failed to set rate external clock\n");
+	if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
+		dev_err(dev, "Failed to set rate core clock\n");
 		goto err_pltfm_free;
 	}
 
-	if (clk_prepare_enable(kona_dev->external_clk) != 0) {
-		dev_err(dev, "Failed to enable external clock\n");
+	if (clk_prepare_enable(pltfm_priv->clk) != 0) {
+		dev_err(dev, "Failed to enable core clock\n");
 		goto err_pltfm_free;
 	}
 
@@ -333,7 +314,7 @@ err_reset:
 	sdhci_bcm_kona_sd_reset(host);
 
 err_clk_disable:
-	clk_disable_unprepare(kona_dev->external_clk);
+	clk_disable_unprepare(pltfm_priv->clk);
 
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
@@ -346,12 +327,11 @@ static int sdhci_bcm_kona_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
-	struct sdhci_bcm_kona_dev *kona_dev = sdhci_pltfm_priv(pltfm_priv);
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 
-	clk_disable_unprepare(kona_dev->external_clk);
+	clk_disable_unprepare(pltfm_priv->clk);
 
 	sdhci_pltfm_free(pdev);
 
-- 
1.9.3

