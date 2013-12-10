From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH Resend 2/3] mmc: sdhci-pltfm: Use devm_ioremap_resource()
Date: Tue, 10 Dec 2013 17:05:46 +0900
Message-ID: <52A6CB5A.1060901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11477 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab3LJIFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 03:05:45 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXK00AEAZTHQR50@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Dec 2013 17:05:41 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, heiko@sntech.de, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

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
-- 1.7.9.5
-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., Software Center, Samsung Electronics
