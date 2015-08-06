From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/3] mmc: dw_mmc: remove the unused blk_setting
Date: Thu, 06 Aug 2015 16:23:25 +0900
Message-ID: <1438845806-4486-2-git-send-email-jh80.chung@samsung.com>
References: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46420 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbbHFHXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Aug 2015 03:23:30 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN02JGOGJ48840@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Aug 2015 16:23:28 +0900 (KST)
In-reply-to: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

"blk_setting" doesn't use anywhere.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  | 34 +++++++++++++---------------------
 include/linux/mmc/dw_mmc.h |  1 -
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index de88e64..091df65 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2436,28 +2436,20 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret)
 		goto err_host_allocated;
 
-	if (host->pdata->blk_settings) {
-		mmc->max_segs = host->pdata->blk_settings->max_segs;
-		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
-		mmc->max_blk_count = host->pdata->blk_settings->max_blk_count;
-		mmc->max_req_size = host->pdata->blk_settings->max_req_size;
-		mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
+	/* Useful defaults if platform data is unset. */
+	if (host->use_dma) {
+		mmc->max_segs = host->ring_size;
+		mmc->max_blk_size = 65536;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else {
-		/* Useful defaults if platform data is unset. */
-		if (host->use_dma) {
-			mmc->max_segs = host->ring_size;
-			mmc->max_blk_size = 65536;
-			mmc->max_seg_size = 0x1000;
-			mmc->max_req_size = mmc->max_seg_size * host->ring_size;
-			mmc->max_blk_count = mmc->max_req_size / 512;
-		} else {
-			mmc->max_segs = 64;
-			mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
-			mmc->max_blk_count = 512;
-			mmc->max_req_size = mmc->max_blk_size *
-					    mmc->max_blk_count;
-			mmc->max_seg_size = mmc->max_req_size;
-		}
+		mmc->max_segs = 64;
+		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
+		mmc->max_blk_count = 512;
+		mmc->max_req_size = mmc->max_blk_size *
+				    mmc->max_blk_count;
+		mmc->max_seg_size = mmc->max_req_size;
 	}
 
 	if (dw_mci_get_cd(mmc))
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 5be9767..9c06f2d 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -259,7 +259,6 @@ struct dw_mci_board {
 
 	struct dw_mci_dma_ops *dma_ops;
 	struct dma_pdata *data;
-	struct block_settings *blk_settings;
 };
 
 #endif /* LINUX_MMC_DW_MMC_H */
-- 
1.9.1

