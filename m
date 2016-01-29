From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 03/12] mmc: bfin_sdh: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 13:06:02 +0900
Message-ID: <1454040371-31625-4-git-send-email-jh80.chung@samsung.com>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43544 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbcA2EGT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:06:19 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P02V634QIEPE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:06:18 +0900 (KST)
In-reply-to: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/bfin_sdh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 2b7f37e..526231e 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -126,9 +126,6 @@ static int sdh_setup_data(struct sdh_host *host, struct mmc_data *data)
 	length = data->blksz * data->blocks;
 	bfin_write_SDH_DATA_LGTH(length);
 
-	if (data->flags & MMC_DATA_STREAM)
-		data_ctl |= DTX_MODE;
-
 	if (data->flags & MMC_DATA_READ)
 		data_ctl |= DTX_DIR;
 	/* Only supports power-of-2 block size */
-- 
1.9.1

