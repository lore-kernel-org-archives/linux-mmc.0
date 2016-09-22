From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 2/7] mmc-mq: remove async requests support
Date: Thu, 22 Sep 2016 15:57:05 +0200
Message-ID: <1474552630-28314-3-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c |  62 ++++++++++++--------------
 drivers/mmc/card/queue.c | 113 +++++++++++++++--------------------------------
 drivers/mmc/card/queue.h |   5 +--
 drivers/mmc/core/bus.c   |   2 -
 drivers/mmc/core/core.c  | 110 +++++++++------------------------------------
 drivers/mmc/core/core.h  |   2 -
 include/linux/mmc/card.h |   1 -
 include/linux/mmc/host.h |  15 -------
 8 files changed, 85 insertions(+), 225 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ce56930..1d4a09f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1192,7 +1192,7 @@ int mmc_access_rpmb(struct mmc_queue *mq)
 	return false;
 }
 
-static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -1230,13 +1230,14 @@ out:
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
+	mmc_queue_req_free(mq, mqrq);
 	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
 
 static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
-				       struct request *req)
+				       struct request *req, struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -1297,12 +1298,13 @@ out_retry:
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
+	mmc_queue_req_free(mq, mqrq);
 	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
 
-static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -1312,6 +1314,7 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
+	mmc_queue_req_free(mq, mqrq);
 	blk_end_request_all(req, ret);
 
 	return ret ? 0 : 1;
@@ -1918,6 +1921,7 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
 	int idx = packed->idx_failure, i = 0;
 	int ret = 0;
 
+	BUG();
 	BUG_ON(!packed);
 
 	while (!list_empty(&packed->list)) {
@@ -1981,7 +1985,7 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
 	mmc_blk_clear_packed(mq_rq);
 }
 
-static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
+static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -1990,20 +1994,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mqrq_cur = NULL;
 	struct mmc_queue_req *mq_rq;
-	struct request *req;
+	struct request *rqc = NULL, *req;
 	struct mmc_async_req *areq;
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
 
 	pr_info("%s: enter\n", __func__);
-	if (rqc) {
-		mqrq_cur = mmc_queue_req_find(mq, rqc);
-		if (!mqrq_cur) {
-			WARN_ON(1);
-			mmc_blk_requeue(mq->queue, rqc);
-			rqc = NULL;
-		}
-	}
+	mqrq_cur = mqrq;
+	rqc = mqrq_cur->req;
 
 	if (!mq->qcnt) {
 		pr_info("%s: exit (0) (!mq->qcnt)\n", __func__);
@@ -2059,10 +2057,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 			if (mmc_packed_cmd(mq_rq->cmd_type)) {
 				ret = mmc_blk_end_packed_req(mq_rq);
+				mmc_queue_req_free(mq, mq_rq); //
+				pr_info("%s: freeing mqrq (packed)\n", __func__); //
 				break;
 			} else {
-				ret = blk_end_request(req, 0,
-						brq->data.bytes_xfered);
+				int bytes = brq->data.bytes_xfered;
+				mmc_queue_req_free(mq, mq_rq); //
+				pr_info("%s: freeing mqrq\n", __func__); //
+				ret = blk_end_request(req, 0, bytes);
 			}
 
 			/*
@@ -2153,9 +2155,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 	} while (ret);
 
-	mmc_queue_req_free(mq, mq_rq);
-
-	pr_info("%s: exit (1)\n", __func__);
+	pr_info("%s: exit (1==ok)\n", __func__);
 	return 1;
 
  cmd_abort:
@@ -2194,7 +2194,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 0;
 }
 
-static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq)
 {
 	int ret;
 	struct mmc_blk_data *md = mq->data;
@@ -2203,9 +2203,10 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	pr_info("%s: enter\n", __func__);
 
-	if (req && !mq->qcnt)
-		/* claim host only for the first request */
-		mmc_get_card(card);
+	BUG_ON(!req);
+
+	/* claim host only for the first request */
+	mmc_get_card(card);
 
 	pr_info("%s: mmc_blk_part_switch\n", __func__);
 	ret = mmc_blk_part_switch(card, md);
@@ -2219,28 +2220,21 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	if (cmd_flags & REQ_DISCARD) {
 		pr_info("%s: DISCARD rq\n", __func__);
-		/* complete ongoing async transfer before issuing discard */
-		if (mq->qcnt)
-			mmc_blk_issue_rw_rq(mq, NULL);
 		if (req->cmd_flags & REQ_SECURE)
-			ret = mmc_blk_issue_secdiscard_rq(mq, req);
+			ret = mmc_blk_issue_secdiscard_rq(mq, req, mqrq);
 		else
-			ret = mmc_blk_issue_discard_rq(mq, req);
+			ret = mmc_blk_issue_discard_rq(mq, req, mqrq);
 	} else if (cmd_flags & REQ_FLUSH) {
 		pr_info("%s: FLUSH rq\n", __func__);
-		/* complete ongoing async transfer before issuing flush */
-		if (mq->qcnt)
-			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_flush(mq, req);
+		ret = mmc_blk_issue_flush(mq, req, mqrq);
 	} else {
 		pr_info("%s: RW rq\n", __func__);
-		ret = mmc_blk_issue_rw_rq(mq, req);
+		ret = mmc_blk_issue_rw_rq(mq, mqrq);
 	}
 
 out:
 	/* Release host when there are no more requests */
-	if (!mq->qcnt)
-		mmc_put_card(card);
+	mmc_put_card(card);
 	pr_info("%s: exit\n", __func__);
 	return ret;
 }
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 5a016ce..e9c9bbf 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -52,15 +52,22 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 	struct mmc_queue_req *mqrq;
 	int i = ffz(mq->qslots);
 
+	pr_info("%s: enter (%d)\n", __func__, i);
+
+	WARN_ON(i >= mq->qdepth);
 	if (i >= mq->qdepth)
 		return NULL;
 
+////	spin_lock_irq(req->q->queue_lock);
 	mqrq = &mq->mqrq[i];
 	WARN_ON(mqrq->req || mq->qcnt >= mq->qdepth ||
 		test_bit(mqrq->task_id, &mq->qslots));
 	mqrq->req = req;
 	mq->qcnt += 1;
 	__set_bit(mqrq->task_id, &mq->qslots);
+////	spin_unlock_irq(req->q->queue_lock);
+
+	pr_info("%s: exit\n", __func__);
 
 	return mqrq;
 }
@@ -68,60 +75,17 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 void mmc_queue_req_free(struct mmc_queue *mq,
 			struct mmc_queue_req *mqrq)
 {
+	struct request *req;
+	pr_info("%s: enter\n", __func__);
+	req = mqrq->req;
+	spin_lock_irq(req->q->queue_lock);
 	WARN_ON(!mqrq->req || mq->qcnt < 1 ||
 		!test_bit(mqrq->task_id, &mq->qslots));
 	mqrq->req = NULL;
 	mq->qcnt -= 1;
 	__clear_bit(mqrq->task_id, &mq->qslots);
-}
-
-static int mmc_queue_thread(void *d)
-{
-	struct mmc_queue *mq = d;
-	struct request_queue *q = mq->queue;
-	struct mmc_context_info *cntx = &mq->card->host->context_info;
-
-	current->flags |= PF_MEMALLOC;
-
-	down(&mq->thread_sem);
-	do {
-		struct request *req;
-
-		spin_lock_irq(q->queue_lock);
-		set_current_state(TASK_INTERRUPTIBLE);
-		req = blk_fetch_request(q);
-		mq->asleep = false;
-		cntx->is_waiting_last_req = false;
-		cntx->is_new_req = false;
-		if (!req) {
-			/*
-			 * Dispatch queue is empty so set flags for
-			 * mmc_request_fn() to wake us up.
-			 */
-			if (mq->qcnt)
-				cntx->is_waiting_last_req = true;
-			else
-				mq->asleep = true;
-		}
-		spin_unlock_irq(q->queue_lock);
-
-		if (req || mq->qcnt) {
-			set_current_state(TASK_RUNNING);
-			mq->issue_fn(mq, req);
-			cond_resched();
-		} else {
-			if (kthread_should_stop()) {
-				set_current_state(TASK_RUNNING);
-				break;
-			}
-			up(&mq->thread_sem);
-			schedule();
-			down(&mq->thread_sem);
-		}
-	} while (1);
-	up(&mq->thread_sem);
-
-	return 0;
+	spin_unlock_irq(req->q->queue_lock);
+	pr_info("%s: exit\n", __func__);
 }
 
 /*
@@ -134,7 +98,7 @@ static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
-	struct mmc_context_info *cntx;
+	struct mmc_queue_req *mqrq_cur = NULL;
 
 	if (!mq) {
 		while ((req = blk_fetch_request(q)) != NULL) {
@@ -143,16 +107,28 @@ static void mmc_request_fn(struct request_queue *q)
 		}
 		return;
 	}
-
-	cntx = &mq->card->host->context_info;
-
-	if (cntx->is_waiting_last_req) {
-		cntx->is_new_req = true;
-		wake_up_interruptible(&cntx->wait);
+repeat:
+	req = blk_fetch_request(q);
+	if (req && req->cmd_type == REQ_TYPE_FS) {
+		mqrq_cur = mmc_queue_req_find(mq, req);
+		if (!mqrq_cur) {
+			pr_info("%s: command already queued (%d)\n", __func__, mq->qcnt);
+//			WARN_ON(1);
+//			spin_unlock_irq(q->queue_lock);
+			blk_requeue_request(mq->queue, req);
+//			spin_lock_irq(q->queue_lock);
+			req = NULL;
+		}
 	}
-
-	if (mq->asleep)
-		wake_up_process(mq->thread);
+	if (!req) {
+		pr_info("%s: no request\n", __func__);
+		return;
+	}
+	spin_unlock_irq(q->queue_lock);
+	mq->issue_fn(mq, req, mqrq_cur);
+	spin_lock_irq(q->queue_lock);
+	goto repeat;
+//#endif
 }
 
 static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
@@ -305,7 +281,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	mq->qdepth = 2;
+	mq->qdepth = 1;
 	mq->mqrq = mmc_queue_alloc_mqrqs(mq, mq->qdepth);
 	if (!mq->mqrq)
 		goto blk_cleanup;
@@ -357,16 +333,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			goto cleanup_queue;
 	}
 
-	sema_init(&mq->thread_sem, 1);
-
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
-		host->index, subname ? subname : "");
-
-	if (IS_ERR(mq->thread)) {
-		ret = PTR_ERR(mq->thread);
-		goto cleanup_queue;
-	}
-
 	return 0;
 
  cleanup_queue:
@@ -386,9 +352,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
-	/* Then terminate our worker thread */
-	kthread_stop(mq->thread);
-
 	/* Empty the queue */
 	spin_lock_irqsave(q->queue_lock, flags);
 	q->queuedata = NULL;
@@ -468,8 +431,6 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
 		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		down(&mq->thread_sem);
 	}
 }
 
@@ -485,8 +446,6 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	if (mq->flags & MMC_QUEUE_SUSPENDED) {
 		mq->flags &= ~MMC_QUEUE_SUSPENDED;
 
-		up(&mq->thread_sem);
-
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
 		spin_unlock_irqrestore(q->queue_lock, flags);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 1afd5da..c52fa88 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -47,13 +47,10 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
-	struct task_struct	*thread;
-	struct semaphore	thread_sem;
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
-	bool			asleep;
 
-	int			(*issue_fn)(struct mmc_queue *, struct request *);
+	int			(*issue_fn)(struct mmc_queue *, struct request *, struct mmc_queue_req *mqrq);
 	void			*data;
 	struct request_queue	*queue;
 	struct mmc_queue_req	*mqrq;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c64266f..949e569 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -346,8 +346,6 @@ int mmc_add_card(struct mmc_card *card)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-	mmc_init_context_info(card->host);
-
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
 	device_enable_async_suspend(&card->dev);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d2d8d9b..7496c22 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/kernel.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -44,6 +45,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "../card/queue.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -407,19 +409,11 @@ out:
 EXPORT_SYMBOL(mmc_start_bkops);
 
 /*
- * mmc_wait_data_done() - done callback for data request
- * @mrq: done data request
+ * mmc_wait_done() - done callback for request
+ * @mrq: done request
  *
  * Wakes up mmc context, passed as a callback to host controller driver
  */
-static void mmc_wait_data_done(struct mmc_request *mrq)
-{
-	struct mmc_context_info *context_info = &mrq->host->context_info;
-
-	context_info->is_done_rcv = true;
-	wake_up_interruptible(&context_info->wait);
-}
-
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(&mrq->completion);
@@ -438,36 +432,15 @@ static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
 }
 
 /*
- *__mmc_start_data_req() - starts data request
+ *__mmc_start_req() - starts request
  * @host: MMC host to start the request
- * @mrq: data request to start
+ * @mrq: request to start
  *
  * Sets the done callback to be called when request is completed by the card.
- * Starts data mmc request execution
+ * Starts mmc request execution
  * If an ongoing transfer is already in progress, wait for the command line
  * to become available before sending another command.
  */
-static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
-{
-	int err;
-
-	mmc_wait_ongoing_tfr_cmd(host);
-
-	mrq->done = mmc_wait_data_done;
-	mrq->host = host;
-
-	init_completion(&mrq->cmd_completion);
-
-	err = mmc_start_request(host, mrq);
-	if (err) {
-		mrq->cmd->error = err;
-		mmc_complete_cmd(mrq);
-		mmc_wait_data_done(mrq);
-	}
-
-	return err;
-}
-
 static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
@@ -478,6 +451,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
+	mrq->host = host;
 
 	init_completion(&mrq->cmd_completion);
 
@@ -485,7 +459,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err) {
 		mrq->cmd->error = err;
 		mmc_complete_cmd(mrq);
-		complete(&mrq->completion);
+		mmc_wait_done(mrq);
 	}
 
 	pr_info("%s: exit\n", __func__);
@@ -508,21 +482,17 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 				      struct mmc_request *mrq,
 				      struct mmc_async_req *next_req)
 {
+	struct mmc_queue_req *mq_mrq = container_of(next_req, struct mmc_queue_req,
+						    mmc_active);
 	struct mmc_command *cmd;
-	struct mmc_context_info *context_info = &host->context_info;
 	int err;
 
 	pr_info("%s: enter\n", __func__);
 
 	while (1) {
-		wait_event_interruptible(context_info->wait,
-//				context_info->is_done_rcv);
-				(context_info->is_done_rcv ||
-				 context_info->is_new_req));
+		wait_for_completion(&mrq->completion);
 		pr_info("%s: waiting done\n", __func__);
-		context_info->is_waiting_last_req = false;
-		if (context_info->is_done_rcv) {
-			context_info->is_done_rcv = false;
+		if (1) {
 			cmd = mrq->cmd;
 
 			if (!cmd->error || !cmd->retries ||
@@ -540,11 +510,6 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 				__mmc_start_request(host, mrq);
 				continue; /* wait for done/new event again */
 			}
-		} else if (context_info->is_new_req) {
-			if (!next_req) {
-				pr_info("%s: exit (!next_req)\n", __func__);
-				return MMC_BLK_NEW_REQUEST;
-			}
 		}
 	}
 	mmc_retune_release(host);
@@ -614,10 +579,7 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
-	if (host->areq)
-		return host->context_info.is_done_rcv;
-	else
-		return completion_done(&mrq->completion);
+	return completion_done(&mrq->completion);
 }
 EXPORT_SYMBOL(mmc_is_req_done);
 
@@ -688,18 +650,12 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq, !host->areq);
 	}
 
+	if (areq) //
+		start_err = __mmc_start_req(host, areq->mrq); //
+
+	host->areq = areq; //
 	if (host->areq) {
 		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
-		if (err == MMC_BLK_NEW_REQUEST) {
-			if (error)
-				*error = err;
-			/*
-			 * The previous request was not completed,
-			 * nothing to return
-			 */
-			pr_info("%s: exit (NULL)\n", __func__);
-			return NULL;
-		}
 		/*
 		 * Check BKOPS urgency for each R1 response
 		 */
@@ -720,24 +676,14 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		}
 	}
 
-	if (!err && areq)
-		start_err = __mmc_start_data_req(host, areq->mrq);
-
 	if (host->areq) {
 		host->areq->pre_req_done = false;
 		mmc_post_req(host, host->areq->mrq, 0);
 	}
 
-	 /* Cancel a prepared request if it was not started. */
-	if ((err || start_err) && areq) {
-		areq->pre_req_done = false;
-		mmc_post_req(host, areq->mrq, -EINVAL);
-	}
 
-	if (err)
-		host->areq = NULL;
-	else
-		host->areq = areq;
+	data = host->areq; //
+	host->areq = NULL; //
 
 	if (error)
 		*error = err;
@@ -2960,22 +2906,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
 }
 #endif
 
-/**
- * mmc_init_context_info() - init synchronization context
- * @host: mmc host
- *
- * Init struct context_info needed to implement asynchronous
- * request mechanism, used by mmc core, host driver and mmc requests
- * supplier.
- */
-void mmc_init_context_info(struct mmc_host *host)
-{
-	host->context_info.is_new_req = false;
-	host->context_info.is_done_rcv = false;
-	host->context_info.is_waiting_last_req = false;
-	init_waitqueue_head(&host->context_info.wait);
-}
-
 static int __init mmc_init(void)
 {
 	int ret;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 0fa86a2..34e664b 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -84,8 +84,6 @@ void mmc_remove_host_debugfs(struct mmc_host *host);
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
-void mmc_init_context_info(struct mmc_host *host);
-
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
 int mmc_hs400_to_hs200(struct mmc_card *card);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 3d7434e..810f318 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -219,7 +219,6 @@ enum mmc_blk_status {
 	MMC_BLK_DATA_ERR,
 	MMC_BLK_ECC_ERR,
 	MMC_BLK_NOMEDIUM,
-	MMC_BLK_NEW_REQUEST,
 };
 
 /* The number of MMC physical partitions.  These consist of:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9fb00b7..1a46cbd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -193,20 +193,6 @@ struct mmc_slot {
 	void *handler_priv;
 };
 
-/**
- * mmc_context_info - synchronization details for mmc context
- * @is_done_rcv		wake up reason was done request
- * @is_new_req		wake up reason was new request
- * @is_waiting_last_req	mmc context waiting for single running request
- * @wait		wait queue
- */
-struct mmc_context_info {
-	bool			is_done_rcv;
-	bool			is_new_req;
-	bool			is_waiting_last_req;
-	wait_queue_head_t	wait;
-};
-
 struct regulator;
 struct mmc_pwrseq;
 
@@ -380,7 +366,6 @@ struct mmc_host {
 	struct dentry		*debugfs_root;
 
 	struct mmc_async_req	*areq;		/* active async req */
-	struct mmc_context_info	context_info;	/* async synchronization info */
 
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
-- 
1.9.1
