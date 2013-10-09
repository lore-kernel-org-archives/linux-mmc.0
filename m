From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
Date: Wed, 09 Oct 2013 09:38:16 +0800
Message-ID: <1381282696.27485.8.camel@phoenix>
References: <1381282567.27485.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55129 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3JIBiU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 21:38:20 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so273084pab.40
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2013 18:38:20 -0700 (PDT)
In-Reply-To: <1381282567.27485.6.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-mmc@vger.kernel.org

It's a NOOP since 2.6.35 and it will be removed one day.
This is not trivial because current code uses hard coded 32 instead of
IRQF_DISABLED in the request_irq call.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
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



