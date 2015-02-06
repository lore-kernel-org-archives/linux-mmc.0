From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 3/7] mmc: tegra: use devm help functions to get the clk and gpio
Date: Fri,  6 Feb 2015 11:15:18 +0800
Message-ID: <1423192522-6056-4-git-send-email-haokexin@gmail.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:43329 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbbBFDPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:43 -0500
In-Reply-To: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, Kevin Hao <haokexin@gmail.com>

Simplify the error and remove path.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f3778d58d1cd..0643f66b4e14 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -286,7 +286,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		goto err_parse_dt;
 
 	if (gpio_is_valid(tegra_host->power_gpio)) {
-		rc = gpio_request(tegra_host->power_gpio, "sdhci_power");
+		rc = devm_gpio_request(&pdev->dev, tegra_host->power_gpio,
+				       "sdhci_power");
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate power gpio\n");
@@ -295,7 +296,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		gpio_direction_output(tegra_host->power_gpio, 1);
 	}
 
-	clk = clk_get(mmc_dev(host->mmc), NULL);
+	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
 		dev_err(mmc_dev(host->mmc), "clk err\n");
 		rc = PTR_ERR(clk);
@@ -312,10 +313,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 err_add_host:
 	clk_disable_unprepare(pltfm_host->clk);
-	clk_put(pltfm_host->clk);
 err_clk_get:
-	if (gpio_is_valid(tegra_host->power_gpio))
-		gpio_free(tegra_host->power_gpio);
 err_power_req:
 err_parse_dt:
 err_alloc_tegra_host:
@@ -327,16 +325,11 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 
-	if (gpio_is_valid(tegra_host->power_gpio))
-		gpio_free(tegra_host->power_gpio);
-
 	clk_disable_unprepare(pltfm_host->clk);
-	clk_put(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
 
-- 
1.9.3

