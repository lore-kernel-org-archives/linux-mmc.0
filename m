From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 02/11] mmc: bfin_sdh: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:27 +0900
Message-ID: <1454328456-22918-3-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54264 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbcBAMHj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:39 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V02B2KB0PYF90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:37 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

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

