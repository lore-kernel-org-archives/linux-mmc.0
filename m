From: Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
Date: Sun, 27 Apr 2014 18:25:31 +0800
Message-ID: <1398594331.6291.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:51749 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaD0KZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Apr 2014 06:25:51 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so6998476veb.28
        for <linux-mmc@vger.kernel.org>; Sun, 27 Apr 2014 03:25:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

It's a NOOP since 2.6.35 and it will be removed one day.
This is not trivial because current code uses hard coded 32 instead of
IRQF_DISABLED in the request_irq call.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on:
http://www.spinics.net/lists/linux-mmc/msg22644.html

 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5501c9f..8a48a50 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -829,7 +829,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		goto fail3;
 	}
 
-	ret = request_irq(dma_irq, wmt_mci_dma_isr, 32, "sdmmc", priv);
+	ret = request_irq(dma_irq, wmt_mci_dma_isr, 0, "sdmmc", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Register DMA IRQ fail\n");
 		goto fail4;
-- 
1.8.1.2



