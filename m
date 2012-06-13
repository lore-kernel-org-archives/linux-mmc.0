From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/5 v4] mmc: sh_mmcif: simplify and use meaningful label
 names in error-handling
Date: Wed, 13 Jun 2012 15:37:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206131532490.17854@axis700.grange>
References: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63737 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2FMNha (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 09:37:30 -0400
In-Reply-To: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

A check for NULL platform data can be conveniently made in the very
beginning of probing. Replace numbered error-handling labels in .probe()
with meaningful names to make any future reorganisation simpler.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e32da11..d6ffb05 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1241,11 +1241,16 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
 	struct sh_mmcif_host *host;
-	struct sh_mmcif_plat_data *pd;
+	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
 	struct resource *res;
 	void __iomem *reg;
 	char clk_name[8];
 
+	if (!pd) {
+		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
+		return -ENXIO;
+	}
+
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[0] < 0 || irq[1] < 0) {
@@ -1262,16 +1267,11 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ioremap error.\n");
 		return -ENOMEM;
 	}
-	pd = pdev->dev.platform_data;
-	if (!pd) {
-		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
-		ret = -ENXIO;
-		goto clean_up;
-	}
+
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
-		goto clean_up;
+		goto ealloch;
 	}
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1283,7 +1283,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	if (IS_ERR(host->hclk)) {
 		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(host->hclk);
-		goto clean_up1;
+		goto eclkget;
 	}
 	clk_enable(host->hclk);
 	host->clk = clk_get_rate(host->hclk);
@@ -1313,7 +1313,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-		goto clean_up2;
+		goto eresume;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
@@ -1322,17 +1322,17 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:error", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
-		goto clean_up3;
+		goto ereqirq0;
 	}
 	ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:int", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-		goto clean_up4;
+		goto ereqirq1;
 	}
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto clean_up5;
+		goto emmcaddh;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
@@ -1341,20 +1341,19 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
-clean_up5:
+emmcaddh:
 	free_irq(irq[1], host);
-clean_up4:
+ereqirq1:
 	free_irq(irq[0], host);
-clean_up3:
+ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
-clean_up2:
+eresume:
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
-clean_up1:
+eclkget:
 	mmc_free_host(mmc);
-clean_up:
-	if (reg)
-		iounmap(reg);
+ealloch:
+	iounmap(reg);
 	return ret;
 }
 
-- 
1.7.2.5

