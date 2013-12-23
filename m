From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] mmc: sirf: enable combined dma buffer
Date: Mon, 23 Dec 2013 21:22:04 +0800
Message-ID: <1387804924-3372-2-git-send-email-21cnbao@gmail.com>
References: <1387804924-3372-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40520 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab3LWNWn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 08:22:43 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so3407295pab.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Dec 2013 05:22:42 -0800 (PST)
In-Reply-To: <1387804924-3372-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>, Barry Song <Barry.Song@csr.com>

From: Bin Shi <Bin.Shi@csr.com>

To take advantage of combined dma buffer, enable
SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER to lift
read/write performance.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 696122c..2933ae4 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -8,6 +8,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -38,6 +39,7 @@ static struct sdhci_pltfm_data sdhci_sirf_pdata = {
 		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		SDHCI_QUIRK_DELAY_AFTER_POWER,
+	.quirks2 = SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER,
 };
 
 static int sdhci_sirf_probe(struct platform_device *pdev)
@@ -75,6 +77,11 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_prepare;
 
+	host->combined_dma_buffer = dma_alloc_coherent(&pdev->dev,
+		SZ_1M, &host->combined_dma_addr, GFP_KERNEL | GFP_DMA);
+	if (!host->combined_dma_buffer)
+		goto err_request_dma;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_sdhci_add;
@@ -97,6 +104,9 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 err_request_cd:
 	sdhci_remove_host(host, 0);
 err_sdhci_add:
+	dma_free_coherent(&pdev->dev, SZ_1M, host->combined_dma_buffer,
+				    host->combined_dma_addr);
+err_request_dma:
 	clk_disable_unprepare(priv->clk);
 err_clk_prepare:
 	sdhci_pltfm_free(pdev);
@@ -114,6 +124,9 @@ static int sdhci_sirf_remove(struct platform_device *pdev)
 	if (gpio_is_valid(priv->gpio_cd))
 		mmc_gpio_free_cd(host->mmc);
 
+	dma_free_coherent(&pdev->dev, SZ_1M, host->combined_dma_buffer,
+				    host->combined_dma_addr);
+
 	clk_disable_unprepare(priv->clk);
 	return 0;
 }
-- 
1.7.5.4

