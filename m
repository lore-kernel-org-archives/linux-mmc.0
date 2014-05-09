From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 4/6] mmc: omap_hsmmc: use devm_ioremap_resource
Date: Fri, 9 May 2014 22:16:51 +0530
Message-ID: <1399654013-28262-5-git-send-email-balajitk@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756928AbaEIQrG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 12:47:06 -0400
In-Reply-To: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

With devm_ioremap_resource conversion release_mem_region, iounmap can be
removed in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6179fe3..140425c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1851,6 +1851,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	unsigned tx_req, rx_req;
 	struct pinctrl *pinctrl;
 	const struct omap_mmc_of_data *data;
+	void __iomem *base;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1881,9 +1882,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, resource_size(res), pdev->name);
-	if (res == NULL)
-		return -EBUSY;
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	ret = omap_hsmmc_gpio_init(pdata);
 	if (ret)
@@ -1904,7 +1905,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->irq	= irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
-	host->base	= ioremap(host->mapbase, SZ_4K);
+	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
@@ -2104,21 +2105,16 @@ err_irq:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 err1:
-	iounmap(host->base);
 	mmc_free_host(mmc);
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
 static int omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
@@ -2138,13 +2134,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		clk_disable_unprepare(host->dbclk);
 
 	omap_hsmmc_gpio_free(host->pdata);
-	iounmap(host->base);
 	mmc_free_host(host->mmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-
 	return 0;
 }
 
-- 
1.7.5.4

