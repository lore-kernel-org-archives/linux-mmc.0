From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 3/4] mmc: dw_mmc: fix the wrong sequence
Date: Tue, 22 May 2012 13:01:13 +0900
Message-ID: <006a01cd37cf$874fbc00$95ef3400$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36121 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2EVEBO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 00:01:14 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E0076OOGUAU80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:13 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E004S2OI1X7H0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:13 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

Setting host->data to NULL is incorrect sequence in
dw_mci_command_complete. This early setting makes
the skip of dma_unmap_sg in dw_mci_dma_cleanup.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 98fe023..b070ee5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -941,8 +941,8 @@ static void dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd
 			mdelay(20);
 
 		if (cmd->data) {
-			host->data = NULL;
 			dw_mci_stop_dma(host);
+			host->data = NULL;
 		}
 	}
 }
-- 
1.7.0.4


