From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 19/25] mmc: block: Introduce queue semantics
Date: Fri, 25 Nov 2016 12:07:16 +0200
Message-ID: <1480068442-5169-20-git-send-email-adrian.hunter@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14677 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752985AbcKYKN4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 05:13:56 -0500
In-Reply-To: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/card/block.c | 42 ++++++++++++++------------
 drivers/mmc/card/queue.c | 76 ++++++++++++++++++++++++++++++------------------
 drivers/mmc/card/queue.h | 10 +++++--
 3 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ebc5d2ff8f32..54a018d38cc9 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2039,14 +2039,23 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_blk_request *brq;
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_cur = NULL;
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
 	struct mmc_async_req *areq;
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
 
-	if (!rqc && !mq->mqrq_prev->req)
+	if (rqc) {
+		mqrq_cur = mmc_queue_req_find(mq, rqc);
+		if (!mqrq_cur) {
+			WARN_ON(1);
+			mmc_blk_requeue(mq->queue, rqc);
+			rqc = NULL;
+		}
+	}
+
+	if (!mq->qcnt)
 		return 0;
 
 	if (mqrq_cur)
@@ -2077,11 +2086,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		} else
 			areq = NULL;
 		areq = mmc_start_req(card->host, areq, &status);
-		if (!areq) {
-			if (status == MMC_BLK_NEW_REQUEST)
-				mq->flags |= MMC_QUEUE_NEW_REQUEST;
+		if (!areq)
 			return 0;
-		}
 
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
@@ -2193,6 +2199,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 	} while (ret);
 
+	mmc_queue_req_free(mq, mq_rq);
+
 	return 1;
 
  cmd_abort:
@@ -2211,6 +2219,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		if (mmc_card_removed(card)) {
 			rqc->cmd_flags |= REQ_QUIET;
 			blk_end_request_all(rqc, -EIO);
+			mmc_queue_req_free(mq, mqrq_cur);
 		} else {
 			/*
 			 * If current request is packed, it needs to put back.
@@ -2224,6 +2233,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 	}
 
+	mmc_queue_req_free(mq, mq_rq);
+
 	return 0;
 }
 
@@ -2232,9 +2243,8 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	int ret;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	bool req_is_special = mmc_req_is_special(req);
 
-	if (req && !mq->mqrq_prev->req)
+	if (req && !mq->qcnt)
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
@@ -2247,20 +2257,19 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
-	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
 	if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_secdiscard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
-		if (card->host->areq)
+		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_flush(mq, req);
 	} else {
@@ -2268,13 +2277,8 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) || req_is_special)
-		/*
-		 * Release host when there are no more requests
-		 * and after special request(discard, flush) is done.
-		 * In case sepecial request, there is no reentry to
-		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
-		 */
+	/* Release host when there are no more requests */
+	if (!mq->qcnt)
 		mmc_put_card(card);
 	return ret;
 }
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 50d7bf074887..2570b813c25a 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
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
-			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
-				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
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
@@ -186,6 +194,21 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
+static struct mmc_queue_req *mmc_queue_alloc_mqrqs(struct mmc_queue *mq,
+						   int qdepth)
+{
+	struct mmc_queue_req *mqrq;
+	int i;
+
+	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
+	if (mqrq) {
+		for (i = 0; i < mq->qdepth; i++)
+			mqrq[i].task_id = i;
+	}
+
+	return mqrq;
+}
+
 static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 					unsigned int bouncesz)
 {
@@ -286,12 +309,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		return -ENOMEM;
 
 	mq->qdepth = 2;
-	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
-			   GFP_KERNEL);
+	mq->mqrq = mmc_queue_alloc_mqrqs(mq, mq->qdepth);
 	if (!mq->mqrq)
 		goto blk_cleanup;
-	mq->mqrq_cur = &mq->mqrq[0];
-	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index f17f5e505059..f7bc0ca0b27f 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -49,6 +49,7 @@ struct mmc_queue_req {
 	struct mmc_async_req	mmc_active;
 	enum mmc_packed_type	cmd_type;
 	struct mmc_packed	*packed;
+	int			task_id;
 };
 
 struct mmc_queue {
@@ -57,14 +58,13 @@ struct mmc_queue {
 	struct semaphore	thread_sem;
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
-#define MMC_QUEUE_NEW_REQUEST	(1 << 1)
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
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
@@ -80,4 +80,8 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 
 extern int mmc_access_rpmb(struct mmc_queue *);
 
+extern struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *,
+						struct request *);
+extern void mmc_queue_req_free(struct mmc_queue *, struct mmc_queue_req *);
+
 #endif
-- 
1.9.1

