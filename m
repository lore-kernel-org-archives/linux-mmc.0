From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 7/7] mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()
Date: Thu, 14 Apr 2016 11:29:50 +0900
Message-ID: <1460600990-10993-8-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:40503 "EHLO
	conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcDNC33 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 22:29:29 -0400
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Swap the call order of sdhci_alloc_host() and platform_get_irq().
It makes sdhci_alloc_host() the last function that can fail in this
probe method.  So, we can drop the sdhci_free_host() call from the
failure path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 870c3d7..94bdca8 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -120,7 +120,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	struct sdhci_host *host;
 	struct resource *iomem;
 	void __iomem *ioaddr;
-	int ret;
+	int irq, ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
@@ -135,6 +135,13 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ number");
+		ret = irq;
+		goto err;
+	}
+
 	host = sdhci_alloc_host(&pdev->dev,
 		sizeof(struct sdhci_pltfm_host) + priv_size);
 
@@ -144,6 +151,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	}
 
 	host->ioaddr = ioaddr;
+	host->irq = irq;
 	host->hw_name = dev_name(&pdev->dev);
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
@@ -154,13 +162,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->quirks2 = pdata->quirks2;
 	}
 
-	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number");
-		ret = host->irq;
-		goto err_request;
-	}
-
 	/*
 	 * Some platforms need to probe the controller to be able to
 	 * determine which caps should be used.
@@ -171,9 +172,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, host);
 
 	return host;
-
-err_request:
-	sdhci_free_host(host);
 err:
 	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
 	return ERR_PTR(ret);
-- 
1.9.1

