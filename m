From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 07/20] mmc: queue: Factor out mmc_queue_reqs_free_bufs()
Date: Tue, 29 Nov 2016 12:09:14 +0200
Message-ID: <1480414167-15577-8-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48807 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757012AbcK2KO7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:14:59 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

In preparation for supporting a queue of requests, factor out
mmc_queue_reqs_free_bufs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
---
 drivers/mmc/card/queue.c | 65 +++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 0a8480f5ea4b..7234cc48097e 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -250,6 +250,27 @@ static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 	return ret;
 }
 
+static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
+{
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
+
+	kfree(mqrq_cur->bounce_sg);
+	mqrq_cur->bounce_sg = NULL;
+	kfree(mqrq_prev->bounce_sg);
+	mqrq_prev->bounce_sg = NULL;
+
+	kfree(mqrq_cur->sg);
+	mqrq_cur->sg = NULL;
+	kfree(mqrq_cur->bounce_buf);
+	mqrq_cur->bounce_buf = NULL;
+
+	kfree(mqrq_prev->sg);
+	mqrq_prev->sg = NULL;
+	kfree(mqrq_prev->bounce_buf);
+	mqrq_prev->bounce_buf = NULL;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -266,8 +287,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
 	int ret;
-	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
-	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -277,8 +296,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	mq->mqrq_cur = mqrq_cur;
-	mq->mqrq_prev = mqrq_prev;
+	mq->mqrq_cur = &mq->mqrq[0];
+	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
@@ -334,27 +353,13 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	if (IS_ERR(mq->thread)) {
 		ret = PTR_ERR(mq->thread);
-		goto free_bounce_sg;
+		goto cleanup_queue;
 	}
 
 	return 0;
- free_bounce_sg:
-	kfree(mqrq_cur->bounce_sg);
-	mqrq_cur->bounce_sg = NULL;
-	kfree(mqrq_prev->bounce_sg);
-	mqrq_prev->bounce_sg = NULL;
 
  cleanup_queue:
-	kfree(mqrq_cur->sg);
-	mqrq_cur->sg = NULL;
-	kfree(mqrq_cur->bounce_buf);
-	mqrq_cur->bounce_buf = NULL;
-
-	kfree(mqrq_prev->sg);
-	mqrq_prev->sg = NULL;
-	kfree(mqrq_prev->bounce_buf);
-	mqrq_prev->bounce_buf = NULL;
-
+	mmc_queue_reqs_free_bufs(mq);
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -363,8 +368,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
 
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
@@ -378,23 +381,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	kfree(mqrq_cur->bounce_sg);
-	mqrq_cur->bounce_sg = NULL;
-
-	kfree(mqrq_cur->sg);
-	mqrq_cur->sg = NULL;
-
-	kfree(mqrq_cur->bounce_buf);
-	mqrq_cur->bounce_buf = NULL;
-
-	kfree(mqrq_prev->bounce_sg);
-	mqrq_prev->bounce_sg = NULL;
-
-	kfree(mqrq_prev->sg);
-	mqrq_prev->sg = NULL;
-
-	kfree(mqrq_prev->bounce_buf);
-	mqrq_prev->bounce_buf = NULL;
+	mmc_queue_reqs_free_bufs(mq);
 
 	mq->card = NULL;
 }
-- 
1.9.1

