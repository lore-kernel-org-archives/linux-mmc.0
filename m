From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 1/4] mmc: dw_mmc: fix the transmission handling in IDMAC
Date: Tue, 22 May 2012 13:00:55 +0900
Message-ID: <006801cd37cf$7ca2e2a0$75e8a7e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35975 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab2EVEA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 00:00:56 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E00523OH47X90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:00:55 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E00FP4OHJLY00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:00:55 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

DTO interrupt can be later than transmit interrupt(IDMAC)
in case of write. Current handling of idmac interrupt sets
EVENT_DATA_COMPLETE as well as EVENT_XFER_COMPLETE regardless
DTO rising. This makes the current request be finished in tasklet
and permits the next request even though current data transfer
is still in progress. As a result, sequence is broken and lock-up
happens. Setting EVENT_DATA_COMPLETE is not proper after IDMAC
interrupt. It should be taken after DTO interrupt is generated.

Reported-by: Dmitry Shmidt <dimitrysh@android.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9bbf45f..b46faf0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1623,7 +1623,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
 		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI);
 		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
-		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 		host->dma_ops->complete(host);
 	}
 #endif
-- 
1.7.0.4


