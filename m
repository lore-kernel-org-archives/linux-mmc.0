From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 07/11] mmc: pxamci: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:32 +0900
Message-ID: <1454328456-22918-8-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58814 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbcBAMHj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:39 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01QYQB0QKC90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index ce08896..4285d3a 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -191,9 +191,6 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 
 	host->data = data;
 
-	if (data->flags & MMC_DATA_STREAM)
-		nob = 0xffff;
-
 	writel(nob, host->base + MMC_NOB);
 	writel(data->blksz, host->base + MMC_BLKLEN);
 
@@ -443,9 +440,6 @@ static void pxamci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cmdat |= CMDAT_DATAEN | CMDAT_DMAEN;
 		if (mrq->data->flags & MMC_DATA_WRITE)
 			cmdat |= CMDAT_WRITE;
-
-		if (mrq->data->flags & MMC_DATA_STREAM)
-			cmdat |= CMDAT_STREAM;
 	}
 
 	pxamci_start_cmd(host, mrq->cmd, cmdat);
-- 
1.9.1

