From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 3/7] mmc: sdhci-pltfm: use devm_request_mem_region()
Date: Wed, 20 Apr 2016 11:16:27 +0900
Message-ID: <1461118591-21595-4-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:38230 "EHLO
	conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbcDTCP5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 22:15:57 -0400
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Use the managed variant of request_mem_region().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-pltfm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 24377a3..8527a7c 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -152,8 +152,9 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_request;
 	}
 
-	if (!request_mem_region(iomem->start, resource_size(iomem),
-		mmc_hostname(host->mmc))) {
+	if (!devm_request_mem_region(&pdev->dev, iomem->start,
+				     resource_size(iomem),
+				     mmc_hostname(host->mmc))) {
 		dev_err(&pdev->dev, "cannot request region\n");
 		ret = -EBUSY;
 		goto err_request;
@@ -163,7 +164,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
 		ret = -ENOMEM;
-		goto err_remap;
+		goto err_request;
 	}
 
 	/*
@@ -177,8 +178,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	return host;
 
-err_remap:
-	release_mem_region(iomem->start, resource_size(iomem));
 err_request:
 	sdhci_free_host(host);
 err:
@@ -190,10 +189,8 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 void sdhci_pltfm_free(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	iounmap(host->ioaddr);
-	release_mem_region(iomem->start, resource_size(iomem));
 	sdhci_free_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-- 
1.9.1

