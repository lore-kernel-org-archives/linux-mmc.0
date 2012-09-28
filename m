From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: mmc: dw_mmc: remove the compiling warning
Date: Fri, 28 Sep 2012 19:13:11 +0900
Message-ID: <00ff01cd9d61$dd516520$97f42f60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61982 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab2I1KNM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:13:12 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MB200F591PW5VY0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 19:13:11 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MB2002611PZW2A0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 19:13:11 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

This patch removes the following warning.
drivers/mmc/host/dw_mmc.c:1976: warning: passing argument 1 of
'_dev_info' from incompatible pointer type

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a23af77..026cf92 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1973,7 +1973,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	/* Determine which DMA interface to use */
 #ifdef CONFIG_MMC_DW_IDMAC
 	host->dma_ops = &dw_mci_idmac_ops;
-	dev_info(&host->dev, "Using internal DMA controller.\n");
+	dev_info(host->dev, "Using internal DMA controller.\n");
 #endif
 
 	if (!host->dma_ops)
-- 
1.7.0.4


