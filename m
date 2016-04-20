From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 4/7] mmc: sdhci-pltfm: use devm_ioremap()
Date: Wed, 20 Apr 2016 11:16:28 +0900
Message-ID: <1461118591-21595-5-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Use the managed variant of ioremap().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-pltfm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 8527a7c..5213287 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -160,7 +160,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_request;
 	}
 
-	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
+				    resource_size(iomem));
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
 		ret = -ENOMEM;
@@ -190,7 +191,6 @@ void sdhci_pltfm_free(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 
-	iounmap(host->ioaddr);
 	sdhci_free_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-- 
1.9.1
