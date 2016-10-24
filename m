From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 08/25] mmc: queue: Allocate queue of size qdepth
Date: Mon, 24 Oct 2016 11:37:23 +0300
Message-ID: <1477298260-5064-9-git-send-email-adrian.hunter@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936089AbcJXInG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 04:43:06 -0400
In-Reply-To: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Now that the queue resources are allocated according to the size of the
queue, it is possible to allocate the queue to be an arbitrary size.

A side-effect is that deallocation of 'packed' resources must be done
before deallocation of the queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c |  2 +-
 drivers/mmc/card/queue.c | 11 ++++++++++-
 drivers/mmc/card/queue.h |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 485fba5ab6c0..85c9f14a2c53 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2421,9 +2421,9 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
-		mmc_cleanup_queue(&md->queue);
 		if (md->flags & MMC_BLK_PACKED_CMD)
 			mmc_packed_clean(&md->queue);
+		mmc_cleanup_queue(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 000274523446..8d35948acec2 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -275,7 +275,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -286,6 +286,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		return -ENOMEM;
 
 	mq->qdepth = 2;
+	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
+			   GFP_KERNEL);
+	if (!mq->mqrq)
+		goto blk_cleanup;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
@@ -350,6 +354,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
  cleanup_queue:
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
+blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -372,6 +379,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
 
 	mq->card = NULL;
 }
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index e99eecc1032b..299553c15d01 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -60,7 +60,7 @@ struct mmc_queue {
 	bool			asleep;
 	void			*data;
 	struct request_queue	*queue;
-	struct mmc_queue_req	mqrq[2];
+	struct mmc_queue_req	*mqrq;
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
 	int			qdepth;
-- 
1.9.1

