From: Beomho Seo <beomho.seo@samsung.com>
Subject: [RESEND PATCH 1/1]  mmc: sdhci-s3c: Use devm_ioremap_resource
Date: Wed, 30 Apr 2014 13:02:04 +0900
Message-ID: <536075BC.4090103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34465 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaD3ECG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 00:02:06 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4T0098YSJFUW50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Apr 2014 13:02:03 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

This patch devm_ioremap_resource for replace request region and ioremap.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e..a54f3e6 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -157,18 +157,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,

 	host->irq = platform_get_irq(pdev, 0);

-	if (!request_mem_region(iomem->start, resource_size(iomem),
-		mmc_hostname(host->mmc))) {
-		dev_err(&pdev->dev, "cannot request region\n");
-		ret = -EBUSY;
-		goto err_request;
-	}
-
-	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
-	if (!host->ioaddr) {
-		dev_err(&pdev->dev, "failed to remap registers\n");
-		ret = -ENOMEM;
-		goto err_remap;
+	host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(host->ioaddr)) {
+		ret = PTR_ERR(host->ioaddr);
+		goto err;
 	}

 	/*
@@ -182,10 +174,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,

 	return host;

-err_remap:
-	release_mem_region(iomem->start, resource_size(iomem));
-err_request:
-	sdhci_free_host(host);
 err:
 	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
 	return ERR_PTR(ret);
@@ -195,10 +183,7 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 void sdhci_pltfm_free(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-	iounmap(host->ioaddr);
-	release_mem_region(iomem->start, resource_size(iomem));
 	sdhci_free_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-- 
1.7.9.5
