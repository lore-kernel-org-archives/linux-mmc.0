From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 07/11] mmc: pxamci: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:53 +0900
Message-ID: <1454046057-32318-8-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36357 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcA2FlE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:04 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01GRE94C5790@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:00 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
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

