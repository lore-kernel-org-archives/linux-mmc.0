From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] mmc: mediatek: Fixed size in dma_free_coherent
Date: Wed, 24 May 2017 09:53:52 +0200
Message-ID: <1495612432-16669-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35132 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760220AbdEXHyV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2017 03:54:21 -0400
Received: by mail-wm0-f41.google.com with SMTP id b84so54025634wmh.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2017 00:54:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, matthias.bgg@gmail.com
Cc: Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>

From: Phong LE <ple@baylibre.com>

The dma gpd dma_free_coherent call size in invalid.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Signed-off-by: Phong LE <ple@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5c1e178..5a672a5 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1774,7 +1774,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	pm_runtime_put_noidle(host->dev);
 	dma_free_coherent(&pdev->dev,
-			sizeof(struct mt_gpdma_desc),
+			2 * sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			host->dma.bd, host->dma.bd_addr);
-- 
2.7.4

