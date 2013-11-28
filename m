From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH Resend 2/2] mmc: sdhci-pltfm: Use devm_ioremap_resource()
Date: Thu, 28 Nov 2013 20:24:23 +0900
Message-ID: <529727E7.7000803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34209 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab3K1LYY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Nov 2013 06:24:24 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWZ00F2X10NMD00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 28 Nov 2013 20:24:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, heiko@sntech.de

Use devm_ioremap_resource for replace request region and ioremap.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..3e6c25c 100644
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

-- 
Best Regards,

Beomho Seo
