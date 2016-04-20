From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 7/7] mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()
Date: Wed, 20 Apr 2016 11:16:31 +0900
Message-ID: <1461118591-21595-8-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:38424 "EHLO
	conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbcDTCQC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 22:16:02 -0400
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Swap the call order of sdhci_alloc_host() and platform_get_irq().
It makes sdhci_alloc_host() the last function that can fail in the
sdhci_pltfm_init().  So, we can drop the sdhci_free_host() call from
the failure path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-pltfm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 1d74db8..64f287a 100644
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
@@ -129,6 +129,13 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ number\n");
+		ret = irq;
+		goto err;
+	}
+
 	host = sdhci_alloc_host(&pdev->dev,
 		sizeof(struct sdhci_pltfm_host) + priv_size);
 
@@ -138,6 +145,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	}
 
 	host->ioaddr = ioaddr;
+	host->irq = irq;
 	host->hw_name = dev_name(&pdev->dev);
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
@@ -148,13 +156,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->quirks2 = pdata->quirks2;
 	}
 
-	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number\n");
-		ret = host->irq;
-		goto err_request;
-	}
-
 	/*
 	 * Some platforms need to probe the controller to be able to
 	 * determine which caps should be used.
@@ -165,9 +166,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
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

