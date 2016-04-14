From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/7] mmc: sdhci-pltfm: use devm_ioremap()
Date: Thu, 14 Apr 2016 11:29:47 +0900
Message-ID: <1460600990-10993-5-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:40557 "EHLO
	conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbcDNC3a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 22:29:30 -0400
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Use the managed variant of ioremap().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e4da44a..c81a72d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -166,7 +166,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_request;
 	}
 
-	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
+				    resource_size(iomem));
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
 		ret = -ENOMEM;
@@ -196,7 +197,6 @@ void sdhci_pltfm_free(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 
-	iounmap(host->ioaddr);
 	sdhci_free_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-- 
1.9.1

