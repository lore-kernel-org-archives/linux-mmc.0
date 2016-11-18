From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2] mmc: dw_mmc: fix the error handling for dma operation
Date: Fri, 18 Nov 2016 20:16:59 +0900
Message-ID: <20161118111659.21483-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51098 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbcKRLRE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 06:17:04 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGU01APV4NW4940@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Nov 2016 20:17:01 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

When dma->start is failed,then it has to fall back to PIO mode
for current transfer.

But Host controller was already set to bits relevant to DMA operation.
If needs to use the PIO mode, Host controller has to stop the DMA
operation. (It's more stable than now.)

When it occurred error, it's not running any request.

Fixes: 3fc7eaef44db ("mmc: dw_mmc: Add external dma interface support")
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changelog on V2
- Change the Fiexes Commit Id

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

