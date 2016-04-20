From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 5/7] mmc: sdhci-pltfm: use devm_ioremap_resource()
Date: Wed, 20 Apr 2016 11:16:29 +0900
Message-ID: <1461118591-21595-6-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The chain of devm_request_mem_region() and devm_ioremap() can be
replaced with devm_ioremap_resource().  Also, we can drop the error
messages because devm_ioremap_resource() displays similar messages
on error.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-pltfm.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 5213287..caa05d7 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -152,19 +152,9 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_request;
 	}
 
-	if (!devm_request_mem_region(&pdev->dev, iomem->start,
-				     resource_size(iomem),
-				     mmc_hostname(host->mmc))) {
-		dev_err(&pdev->dev, "cannot request region\n");
-		ret = -EBUSY;
-		goto err_request;
-	}
-
-	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
-				    resource_size(iomem));
-	if (!host->ioaddr) {
-		dev_err(&pdev->dev, "failed to remap registers\n");
-		ret = -ENOMEM;
+	host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(host->ioaddr)) {
+		ret = PTR_ERR(host->ioaddr);
 		goto err_request;
 	}
 
-- 
1.9.1
