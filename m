From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value
Date: Mon, 28 Apr 2014 08:58:31 +0800
Message-ID: <1398646711.10750.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:59593 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaD1A6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Apr 2014 20:58:36 -0400
Received: by mail-vc0-f178.google.com with SMTP id hu19so7213057vcb.37
        for <linux-mmc@vger.kernel.org>; Sun, 27 Apr 2014 17:58:35 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 34231d5..3605c37 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -852,7 +852,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
 						   mmc->max_blk_count * 16,
 						   &priv->dma_desc_device_addr,
-						   208);
+						   GFP_KERNEL);
 	if (!priv->dma_desc_buffer) {
 		dev_err(&pdev->dev, "DMA alloc fail\n");
 		ret = -EPERM;
-- 
1.8.1.2



