From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: remove struct block_settings
Date: Thu, 21 Jan 2016 16:06:14 +0800
Message-ID: <1453363574-30802-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35791 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbcAUIKt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 03:10:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch remove struct block_settings since
it never be used anywhere.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/mmc/dw_mmc.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 89df7ab..e1f90b8 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -242,14 +242,6 @@ struct dw_mci_dma_ops {
 
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
-- 
2.3.7


