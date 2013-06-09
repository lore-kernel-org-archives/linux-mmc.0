From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] mmc: jz4740: Use managed resources
Date: Sun,  9 Jun 2013 21:10:05 +0200
Message-ID: <1370805005-8104-6-git-send-email-lars@metafoo.de>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1040 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab3FITG6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:58 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Use managed resources for the mmio memory region and the clock. Makes the code a
bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index e904e6e..0308c9f 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -121,7 +121,6 @@ struct jz4740_mmc_host {
 	int irq;
 	int card_detect_irq;
 
-	struct resource *mem;
 	void __iomem *base;
 	struct mmc_request *req;
 	struct mmc_command *cmd;
@@ -755,6 +754,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	struct mmc_host *mmc;
 	struct jz4740_mmc_host *host;
 	struct jz4740_mmc_platform_data *pdata;
+	struct resource *res;
 
 	pdata = pdev->dev.platform_data;
 
@@ -774,39 +774,25 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_host;
 	}
 
-	host->clk = clk_get(&pdev->dev, "mmc");
+	host->clk = devm_clk_get(&pdev->dev, "mmc");
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		dev_err(&pdev->dev, "Failed to get mmc clock\n");
 		goto err_free_host;
 	}
 
-	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!host->mem) {
-		ret = -ENOENT;
-		dev_err(&pdev->dev, "Failed to get base platform memory\n");
-		goto err_clk_put;
-	}
-
-	host->mem = request_mem_region(host->mem->start,
-					resource_size(host->mem), pdev->name);
-	if (!host->mem) {
-		ret = -EBUSY;
-		dev_err(&pdev->dev, "Failed to request base memory region\n");
-		goto err_clk_put;
-	}
-
-	host->base = ioremap_nocache(host->mem->start, resource_size(host->mem));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->base = devm_ioremap_resource(&pdev->dev, res);
 	if (!host->base) {
 		ret = -EBUSY;
 		dev_err(&pdev->dev, "Failed to ioremap base memory\n");
-		goto err_release_mem_region;
+		goto err_free_host;
 	}
 
 	ret = jz_gpio_bulk_request(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request mmc pins: %d\n", ret);
-		goto err_iounmap;
+		goto err_free_host;
 	}
 
 	ret = jz4740_mmc_request_gpios(mmc, pdev);
@@ -863,12 +849,6 @@ err_free_gpios:
 	jz4740_mmc_free_gpios(pdev);
 err_gpio_bulk_free:
 	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-err_iounmap:
-	iounmap(host->base);
-err_release_mem_region:
-	release_mem_region(host->mem->start, resource_size(host->mem));
-err_clk_put:
-	clk_put(host->clk);
 err_free_host:
 	mmc_free_host(mmc);
 
@@ -890,11 +870,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	jz4740_mmc_free_gpios(pdev);
 	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
-	iounmap(host->base);
-	release_mem_region(host->mem->start, resource_size(host->mem));
-
-	clk_put(host->clk);
-
 	mmc_free_host(host->mmc);
 
 	return 0;
-- 
1.8.2.1

