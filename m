From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/7] mmc: sdhci-pltfm: use devm_request_mem_region()
Date: Thu, 14 Apr 2016 11:29:46 +0900
Message-ID: <1460600990-10993-4-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Use the managed variant of request_mem_region().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3354a53..e4da44a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -158,8 +158,9 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
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
@@ -169,7 +170,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
 		ret = -ENOMEM;
-		goto err_remap;
+		goto err_request;
 	}
 
 	/*
@@ -183,8 +184,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	return host;
 
-err_remap:
-	release_mem_region(iomem->start, resource_size(iomem));
 err_request:
 	sdhci_free_host(host);
 err:
@@ -196,10 +195,8 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
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
