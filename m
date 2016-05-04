From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: queue: allocate the scatterlist with a correct value
Date: Wed, 04 May 2016 14:31:31 +0900
Message-ID: <1462339891-10477-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32841 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDFbg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 01:31:36 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6N01DKU0OMW770@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 May 2016 14:31:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If host->max is lower than PAGE_CACHE_SIZE, it should allocate
the scatterlist with incorrect size.
To prevent illegal behavior, fixed the scatterlist size for mmc_alloc_sg().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/card/queue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6f4323c..0353f99 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -276,12 +276,14 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
-		mqrq_cur->sg = mmc_alloc_sg(host->max_segs, &ret);
+		mqrq_cur->sg =
+			mmc_alloc_sg(mq->queue->limits.max_segments, &ret);
 		if (ret)
 			goto cleanup_queue;
 
 
-		mqrq_prev->sg = mmc_alloc_sg(host->max_segs, &ret);
+		mqrq_prev->sg =
+			mmc_alloc_sg(mq->queue->limits.max_segments, &ret);
 		if (ret)
 			goto cleanup_queue;
 	}
-- 
1.9.1

