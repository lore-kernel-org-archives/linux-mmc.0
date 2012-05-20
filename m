From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 3/4] mmc: dw_mmc: fix the wrong sequence
Date: Sun, 20 May 2012 13:27:40 +0900
Message-ID: <003401cd3640$e4767df0$ad6379d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47571 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2ETE1l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 00:27:41 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4B007XY0E4F590@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 20 May 2012 13:27:40 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4B00GJI0E4Y310@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 20 May 2012 13:27:40 +0900 (KST)
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
index 44aa292..f2f8463 100644
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


