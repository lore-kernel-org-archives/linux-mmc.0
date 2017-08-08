From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: wmt-sdmmc: Handle return value of clk_prepare_enable
Date: Tue,  8 Aug 2017 11:16:38 +0530
Message-ID: <0d9fccf8e14a639274115cc43a97804ef059d8b1.1502171094.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38712 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdHHFrC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 01:47:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@prisktech.co.nz, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 21ebba8..e64f930 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -856,7 +856,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		goto fail5;
 	}
 
-	clk_prepare_enable(priv->clk_sdmmc);
+	ret = clk_prepare_enable(priv->clk_sdmmc);
+	if (ret)
+		goto fail6;
 
 	/* configure the controller to a known 'ready' state */
 	wmt_reset_hardware(mmc);
@@ -866,6 +868,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "WMT SDHC Controller initialized\n");
 
 	return 0;
+fail6:
+	clk_put(priv->clk_sdmmc);
 fail5:
 	free_irq(dma_irq, priv);
 fail4:
-- 
1.9.1

