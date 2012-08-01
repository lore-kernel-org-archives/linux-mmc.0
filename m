From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 2/3] mmc: dw_mmc: correct mishandling error interrupt
Date: Wed, 01 Aug 2012 09:30:40 +0900
Message-ID: <006401cd6f7c$e16605c0$a4321140$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39328 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2HAAam (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jul 2012 20:30:42 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M8100DLUW30E0D0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:41 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M8100MAYW34C8B0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:41 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Datasheet of SYNOPSYS mentions that DTO(Data Transfer Over) interrupt
will be raised even if some error interrupts, however it is actually
found that DTO does not occur. SYNOPSYS has confirmed this issue.
Current implementation defers the call of tasklet_schedule until DTO
when the error interrupts is happened. This patch fixes error handling.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7baed45..1a5db20 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1580,9 +1580,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			host->data_status = pending;
 			smp_wmb();
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
-			if (!(pending & (SDMMC_INT_DTO | SDMMC_INT_DCRC |
-					 SDMMC_INT_SBE | SDMMC_INT_EBE)))
-				tasklet_schedule(&host->tasklet);
+			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-- 
1.7.0.4


