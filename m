From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 03/39] mmc: block: Introduce queue semantics
Date: Fri, 10 Feb 2017 14:55:16 +0200
Message-ID: <1486731352-8018-4-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59233 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbdBJNYQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:24:16 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Change from viewing the requests in progress as 'current' and 'previous',
to viewing them as a queue. The current request is allocated to the first
free slot. The presence of incomplete requests is determined from the
count (mq->qcnt) of entries in the queue. Non-read-write requests (i.e.
discards and flushes) are not added to the queue at all and require no
special handling. Also no special handling is needed for the
MMC_BLK_NEW_REQUEST case.

As well as allowing an arbitrarily sized queue, the queue thread function
is significantly simpler.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 42 ++++++++++++++++-----------
 drivers/mmc/core/queue.c | 74 ++++++++++++++++++++++++++++++------------------
 drivers/mmc/core/queue.h | 10 +++++--
 3 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b6d1497c395f..7568e576bba3 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -134,6 +134,13 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md);
 static int get_card_status(struct mmc_card *card, u32 *status, int retries);
 
+static void mmc_blk_requeue(struct request_queue *q, struct request *req)
+{
+	spin_lock_irq(q->queue_lock);
+	blk_requeue_request(q, req);
+	spin_unlock_irq(q->queue_lock);
+}
+
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
@@ -1631,14 +1638,23 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	struct mmc_blk_request *brq;
 	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_cur = NULL;
 	struct mmc_queue_req *mq_rq;
 	struct request *old_req;
 	struct mmc_async_req *new_areq;
 	struct mmc_async_req *old_areq;
 	bool req_pending = true;
 
-	if (!new_req && !mq->mqrq_prev->req)
+	if (new_req) {
+		mqrq_cur = mmc_queue_req_find(mq, new_req);
+		if (!mqrq_cur) {
+			WARN_ON(1);
+			mmc_blk_requeue(mq->queue, new_req);
+			new_req = NULL;
+		}
+	}
+
+	if (!mq->qcnt)
 		return;
 
 	do {
@@ -1667,8 +1683,6 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 * and there is nothing more to do until it is
 			 * complete.
 			 */
-			if (status == MMC_BLK_NEW_REQUEST)
-				mq->new_request = true;
 			return;
 		}
 
@@ -1785,6 +1799,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
 	} while (req_pending);
+
+	mmc_queue_req_free(mq, mq_rq);
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
@@ -1792,9 +1808,8 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	int ret;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	bool req_is_special = mmc_req_is_special(req);
 
-	if (req && !mq->mqrq_prev->req)
+	if (req && !mq->qcnt)
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
@@ -1806,20 +1821,19 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
-	mq->new_request = false;
 	if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		mmc_blk_issue_discard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		mmc_blk_issue_secdiscard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		mmc_blk_issue_flush(mq, req);
 	} else {
@@ -1827,13 +1841,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if ((!req && !mq->new_request) || req_is_special)
-		/*
-		 * Release host when there are no more requests
-		 * and after special request(discard, flush) is done.
-		 * In case sepecial request, there is no reentry to
-		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
-		 */
+	if (!mq->qcnt)
 		mmc_put_card(card);
 }
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 031553c9be04..479638bfb092 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -49,6 +49,35 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
+struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
+					 struct request *req)
+{
+	struct mmc_queue_req *mqrq;
+	int i = ffz(mq->qslots);
+
+	if (i >= mq->qdepth)
+		return NULL;
+
+	mqrq = &mq->mqrq[i];
+	WARN_ON(mqrq->req || mq->qcnt >= mq->qdepth ||
+		test_bit(mqrq->task_id, &mq->qslots));
+	mqrq->req = req;
+	mq->qcnt += 1;
+	__set_bit(mqrq->task_id, &mq->qslots);
+
+	return mqrq;
+}
+
+void mmc_queue_req_free(struct mmc_queue *mq,
+			struct mmc_queue_req *mqrq)
+{
+	WARN_ON(!mqrq->req || mq->qcnt < 1 ||
+		!test_bit(mqrq->task_id, &mq->qslots));
+	mqrq->req = NULL;
+	mq->qcnt -= 1;
+	__clear_bit(mqrq->task_id, &mq->qslots);
+}
+
 static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
@@ -59,7 +88,7 @@ static int mmc_queue_thread(void *d)
 
 	down(&mq->thread_sem);
 	do {
-		struct request *req = NULL;
+		struct request *req;
 
 		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -72,38 +101,17 @@ static int mmc_queue_thread(void *d)
 			 * Dispatch queue is empty so set flags for
 			 * mmc_request_fn() to wake us up.
 			 */
-			if (mq->mqrq_prev->req)
+			if (mq->qcnt)
 				cntx->is_waiting_last_req = true;
 			else
 				mq->asleep = true;
 		}
-		mq->mqrq_cur->req = req;
 		spin_unlock_irq(q->queue_lock);
 
-		if (req || mq->mqrq_prev->req) {
-			bool req_is_special = mmc_req_is_special(req);
-
+		if (req || mq->qcnt) {
 			set_current_state(TASK_RUNNING);
 			mmc_blk_issue_rq(mq, req);
 			cond_resched();
-			if (mq->new_request) {
-				mq->new_request = false;
-				continue; /* fetch again */
-			}
-
-			/*
-			 * Current request becomes previous request
-			 * and vice versa.
-			 * In case of special requests, current request
-			 * has been finished. Do not assign it to previous
-			 * request.
-			 */
-			if (req_is_special)
-				mq->mqrq_cur->req = NULL;
-
-			mq->mqrq_prev->brq.mrq.data = NULL;
-			mq->mqrq_prev->req = NULL;
-			swap(mq->mqrq_prev, mq->mqrq_cur);
 		} else {
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
@@ -208,6 +216,20 @@ static void mmc_queue_free_mqrqs(struct mmc_queue_req *mqrq, int qdepth)
 	kfree(mqrq);
 }
 
+static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
+{
+	struct mmc_queue_req *mqrq;
+	int i;
+
+	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
+	if (mqrq) {
+		for (i = 0; i < qdepth; i++)
+			mqrq[i].task_id = i;
+	}
+
+	return mqrq;
+}
+
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
 				       unsigned int bouncesz)
@@ -307,7 +329,7 @@ static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
 	if (card->mqrq)
 		return -EINVAL;
 
-	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
+	mqrq = mmc_queue_alloc_mqrqs(qdepth);
 	if (!mqrq)
 		return -ENOMEM;
 
@@ -368,8 +390,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	mq->mqrq = card->mqrq;
 	mq->qdepth = card->qdepth;
-	mq->mqrq_cur = &mq->mqrq[0];
-	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 298ead2b4245..871796c3f406 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -34,21 +34,21 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	areq;
+	int			task_id;
 };
 
 struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
-	bool			new_request;
 	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
 	struct mmc_queue_req	*mqrq;
-	struct mmc_queue_req	*mqrq_cur;
-	struct mmc_queue_req	*mqrq_prev;
 	int			qdepth;
+	int			qcnt;
+	unsigned long		qslots;
 };
 
 extern int mmc_queue_alloc_shared_queue(struct mmc_card *card);
@@ -66,4 +66,8 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 
 extern int mmc_access_rpmb(struct mmc_queue *);
 
+extern struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *,
+						struct request *);
+extern void mmc_queue_req_free(struct mmc_queue *, struct mmc_queue_req *);
+
 #endif
-- 
1.9.1

