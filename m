From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCHv2] mmc: dw_mmc: fix the error handling for dma operation
Date: Mon, 21 Nov 2016 10:51:48 +0900
Message-ID: <20161121015148.5699-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35008 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbcKUBvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2016 20:51:52 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGY01ZA1YI6JO80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Nov 2016 10:51:49 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

When dma->start is failed,then it has to fall back to PIO mode
for current transfer.

But Host controller was already set to bits relevant to DMA operation.
If needs to use the PIO mode, Host controller has to stop the DMA
operation. (It's more stable than now.)

When it occurred error, it's not running any request.

Fixes: 3fc7eaef44db ("mmc: dw_mmc: Add external dma interface support")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changelog on V2
- Change the Fixes Commit Id
- Added the Marek's Reported-by tags

 drivers/mmc/host/dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 50a674b..df478ae 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1058,6 +1058,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
 	if (host->dma_ops->start(host, sg_len)) {
+		host->dma_ops->stop(host);
 		/* We can't do DMA, try PIO for this one */
 		dev_dbg(host->dev,
 			"%s: fall back to PIO mode for current transfer\n",
-- 
2.10.1

