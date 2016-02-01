From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 05/11] mmc: jz4740_mmc: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:30 +0900
Message-ID: <1454328456-22918-6-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55779 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbcBAMHj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:39 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01SULB0QFCB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 76e8bce..03ddf0e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -660,8 +660,6 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
 		cmdat |= JZ_MMC_CMDAT_DATA_EN;
 		if (cmd->data->flags & MMC_DATA_WRITE)
 			cmdat |= JZ_MMC_CMDAT_WRITE;
-		if (cmd->data->flags & MMC_DATA_STREAM)
-			cmdat |= JZ_MMC_CMDAT_STREAM;
 		if (host->use_dma)
 			cmdat |= JZ_MMC_CMDAT_DMA_EN;
 
-- 
1.9.1

