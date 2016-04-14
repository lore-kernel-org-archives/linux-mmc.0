From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 6/7] mmc: sdhci-pltfm: move devm_ioremap_resource() up
Date: Thu, 14 Apr 2016 11:29:49 +0900
Message-ID: <1460600990-10993-7-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:40505 "EHLO
	conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbcDNC33 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 22:29:29 -0400
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Call devm_ioremap_resource() right after platform_get_resource().
This saves the error check of platform_get_resource() because
devm_ioremap_resource() checks if the given resource is NULL.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 94955e1..870c3d7 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -119,11 +119,13 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 {
 	struct sdhci_host *host;
 	struct resource *iomem;
+	void __iomem *ioaddr;
 	int ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem) {
-		ret = -ENOMEM;
+	ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(ioaddr)) {
+		ret = PTR_ERR(ioaddr);
 		goto err;
 	}
 
@@ -141,6 +143,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
+	host->ioaddr = ioaddr;
 	host->hw_name = dev_name(&pdev->dev);
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
@@ -158,12 +161,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_request;
 	}
 
-	host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err_request;
-	}
-
 	/*
 	 * Some platforms need to probe the controller to be able to
 	 * determine which caps should be used.
-- 
1.9.1

