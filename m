From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/4] mmc: dw_mmc: remove the blk-settings structure
Date: Fri, 05 Sep 2014 14:14:58 +0900
Message-ID: <1409894100-4713-3-git-send-email-jh80.chung@samsung.com>
References: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaIEFPG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 01:15:06 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBE00KC6X92CKB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Sep 2014 14:15:02 +0900 (KST)
In-reply-to: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

It don't use anywhere. So it's meaningless.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   13 +++----------
 include/linux/mmc/dw_mmc.h |    9 ---------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b8e0ca8..0d31a8c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2287,27 +2287,20 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret)
 		goto err_host_allocated;
 
-	if (host->pdata->blk_settings) {
-		mmc->max_segs = host->pdata->blk_settings->max_segs;
-		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
-		mmc->max_blk_count = host->pdata->blk_settings->max_blk_count;
-		mmc->max_req_size = host->pdata->blk_settings->max_req_size;
-		mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
-	} else {
+
+	if (IS_ENABLED(CONFIG_MMC_DW_IDMAC)) {
 		/* Useful defaults if platform data is unset. */
-#ifdef CONFIG_MMC_DW_IDMAC
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65536;
 		mmc->max_blk_count = host->ring_size;
 		mmc->max_seg_size = 0x1000;
 		mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
-#else
+	} else {
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
 		mmc->max_blk_count = 512;
 		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 		mmc->max_seg_size = mmc->max_req_size;
-#endif /* CONFIG_MMC_DW_IDMAC */
 	}
 
 	if (dw_mci_get_cd(mmc))
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 0013669..6dcc1c1 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -224,14 +224,6 @@ struct dw_mci_dma_ops {
 
 struct dma_pdata;
 
-struct block_settings {
-	unsigned short	max_segs;	/* see blk_queue_max_segments */
-	unsigned int	max_blk_size;	/* maximum size of one mmc block */
-	unsigned int	max_blk_count;	/* maximum number of blocks in one req*/
-	unsigned int	max_req_size;	/* maximum number of bytes in one req*/
-	unsigned int	max_seg_size;	/* see blk_queue_max_segment_size */
-};
-
 /* Board platform data */
 struct dw_mci_board {
 	u32 num_slots;
@@ -254,7 +246,6 @@ struct dw_mci_board {
 
 	struct dw_mci_dma_ops *dma_ops;
 	struct dma_pdata *data;
-	struct block_settings *blk_settings;
 };
 
 #endif /* LINUX_MMC_DW_MMC_H */
-- 
1.7.9.5

