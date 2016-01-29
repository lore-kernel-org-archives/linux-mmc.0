From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 05/11] mmc: jz4740_mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:51 +0900
Message-ID: <1454046057-32318-6-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47237 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcA2FlC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:02 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01EYV94CX470@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:00 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

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

