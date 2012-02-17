From: Hyeonsu@vger.kernel.org, Kim@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: remove EVENT_DATA_COMPLETE in idma mode
Date: Fri, 17 Feb 2012 19:36:22 +0900
Message-ID: <1329474982-5278-1-git-send-email-hyeonsu.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45458 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab2BQKg3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2012 05:36:29 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZJ00J3T9G5SW10@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:36:28 +0900 (KST)
Received: from localhost.localdomain ([165.213.219.99])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZJ009B29GRMP80@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:36:28 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com, Hyeonsu Kim <hyeonsu.kim@samsung.com>

From: Hyeonsu Kim <hyeonsu.kim@samsung.com>

Why need to set EVENT_DATA_COMPLETE bit in here?
I think this is duplication bit-set.
because The bit is already set when occur SDMMC_INT_DATA_OVER interrupt.

In my case (I use dw_mmc for sd card), the bit brings about data transfer fault.
So I want to know your idea about the bit-set.

Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0e34279..edc60d1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1550,7 +1550,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
 		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI);
 		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
-		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 		host->dma_ops->complete(host);
 	}
 #endif
-- 
1.7.5.4

