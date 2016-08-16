From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 13/30] mmc: queue: Allocate queue of size qdepth
Date: Tue, 16 Aug 2016 13:44:23 +0300
Message-ID: <1471344280-16663-14-git-send-email-adrian.hunter@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbcHPKuX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:50:23 -0400
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
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
index 6ef9fb6df6c5..5a117298c139 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2420,9 +2420,9 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
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
index c73afcd9d346..bdc95d1af7ca 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -271,7 +271,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -282,6 +282,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		return -ENOMEM;
 
 	mq->qdepth = 2;
+	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
+			   GFP_KERNEL);
+	if (!mq->mqrq)
+		goto blk_cleanup;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
@@ -346,6 +350,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
  cleanup_queue:
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
+blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -368,6 +375,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
 
 	mq->card = NULL;
 }
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index dde9f22f7528..f2e99e4c0482 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -62,7 +62,7 @@ struct mmc_queue {
 	int			(*issue_fn)(struct mmc_queue *, struct request *);
 	void			*data;
 	struct request_queue	*queue;
-	struct mmc_queue_req	mqrq[2];
+	struct mmc_queue_req	*mqrq;
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
 	int			qdepth;
-- 
1.9.1

