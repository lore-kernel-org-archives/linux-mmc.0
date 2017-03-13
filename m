From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 21/22] mmc: block: Add CQE support
Date: Mon, 13 Mar 2017 14:36:52 +0200
Message-ID: <1489408613-26915-22-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752745AbdCMMoS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:44:18 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Add CQE support to the block driver, including:
	- optionally using DCMD for flush requests
	- manually issuing discard requests
	- issuing read / write requests to the CQE
	- supporting block-layer timeouts
	- handling recovery
	- supporting re-tuning

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 202 ++++++++++++++++++++++++++++++-
 drivers/mmc/core/block.h |   7 ++
 drivers/mmc/core/queue.c | 300 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/queue.h |  43 ++++++-
 4 files changed, 545 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 105b87aa8ffc..946862c65551 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -109,6 +109,7 @@ struct mmc_blk_data {
 #define MMC_BLK_WRITE		BIT(1)
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
+#define MMC_BLK_CQE_RECOVERY	BIT(4)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1561,6 +1562,205 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		*do_data_tag_p = do_data_tag;
 }
 
+#define MMC_CQE_RETRIES 2
+
+void mmc_blk_cqe_complete_rq(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req->special;
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	unsigned long flags;
+	bool put_card;
+	int err;
+
+	mmc_cqe_post_req(host, mrq);
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	mq->cqe_in_flight[mmc_cqe_issue_type(host, req)] -= 1;
+
+	put_card = mmc_cqe_tot_in_flight(mq) == 0;
+
+	mmc_queue_clr_special(req);
+
+	if (mrq->cmd && mrq->cmd->error)
+		err = mrq->cmd->error;
+	else if (mrq->data && mrq->data->error)
+		err = mrq->data->error;
+	else
+		err = 0;
+
+	if (err) {
+		/*
+		 * !req->retries means we have not seen this request before, so
+		 * we add 1 to the number of retries and compare to 1 to decide
+		 * whether or not to retry.
+		 */
+		if (!req->retries)
+			req->retries = MMC_CQE_RETRIES + 1;
+		if (--req->retries >= 1)
+			blk_requeue_request(q, req);
+		else
+			__blk_end_request_all(req, -EIO);
+	} else if (mrq->data) {
+		if (__blk_end_request(req, 0, mrq->data->bytes_xfered))
+			blk_requeue_request(q, req);
+	} else {
+		__blk_end_request_all(req, 0);
+	}
+
+	mmc_cqe_kick_queue(mq);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	if (put_card)
+		mmc_put_card(mq->card);
+}
+
+void mmc_blk_cqe_recovery(struct mmc_queue *mq)
+{
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	int err, i;
+
+	mmc_get_card(card);
+
+	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
+
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used so tell CQE to forget the requests.
+	 */
+	err = mmc_cqe_recovery(host, true);
+
+	/* Then complete all requests directly */
+	for (i = 0; i < mq->qdepth; i++) {
+		struct mmc_queue_req *mqrq = &mq->mqrq[i];
+
+		if (mqrq->req) {
+			__mmc_cqe_request_done(host, &mqrq->brq.mrq);
+			mmc_blk_cqe_complete_rq(mqrq->req);
+		}
+	}
+
+	if (err)
+		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
+	else
+		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+
+	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
+
+	mmc_put_card(card);
+}
+
+static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+
+	blk_complete_request(mqrq->req);
+}
+
+static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mrq->done = mmc_blk_cqe_req_done;
+	return mmc_cqe_start_req(host, mrq);
+}
+
+static struct mmc_request *mmc_blk_cqe_prep_dcmd(struct mmc_queue_req *mqrq)
+{
+	struct mmc_blk_request *brq = &mqrq->brq;
+
+	memset(brq, 0, sizeof(*brq));
+
+	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.tag = mqrq->req->tag;
+
+	return &brq->mrq;
+}
+
+static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req->special;
+	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq);
+
+	mrq->cmd->opcode = MMC_SWITCH;
+	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(EXT_CSD_FLUSH_CACHE << 16) |
+			(1 << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
+	mrq->cmd->flags = MMC_CMD_AC | MMC_RSP_R1B;
+
+	return mmc_blk_cqe_start_req(mq->card->host, mrq);
+}
+
+static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req->special;
+
+	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
+
+	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
+}
+
+enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+	struct mmc_host *host = card->host;
+	int ret;
+
+	ret = mmc_blk_part_switch(card, md);
+	if (ret)
+		return MMC_REQ_FAILED_TO_START;
+
+	switch (mmc_cqe_issue_type(host, req)) {
+	case MMC_ISSUE_SYNC:
+		ret = host->cqe_ops->cqe_wait_for_idle(host);
+		if (ret)
+			return MMC_REQ_BUSY;
+		switch (req_op(req)) {
+		case REQ_OP_DISCARD:
+			mmc_blk_issue_discard_rq(mq, req);
+			break;
+		case REQ_OP_SECURE_ERASE:
+			mmc_blk_issue_secdiscard_rq(mq, req);
+			break;
+		case REQ_OP_FLUSH:
+			mmc_blk_issue_flush(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return MMC_REQ_FAILED_TO_START;
+		}
+		return MMC_REQ_FINISHED;
+	case MMC_ISSUE_DCMD:
+	case MMC_ISSUE_ASYNC:
+		mmc_queue_set_special(mq, req);
+		switch (req_op(req)) {
+		case REQ_OP_FLUSH:
+			ret = mmc_blk_cqe_issue_flush(mq, req);
+			break;
+		case REQ_OP_READ:
+		case REQ_OP_WRITE:
+			ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			ret = -EINVAL;
+		}
+		if (!ret)
+			return MMC_REQ_STARTED;
+		mmc_queue_clr_special(req);
+		return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
+	default:
+		WARN_ON_ONCE(1);
+		return MMC_REQ_FAILED_TO_START;
+	}
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -1960,7 +2160,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, &md->lock, subname, area_type);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..d7b3d7008b00 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -6,4 +6,11 @@
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
+enum mmc_issued;
+
+enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq,
+				     struct request *req);
+void mmc_blk_cqe_complete_rq(struct request *rq);
+void mmc_blk_cqe_recovery(struct mmc_queue *mq);
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 3423b7acf744..58bd67bc5876 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -69,6 +69,273 @@ void mmc_queue_req_free(struct mmc_queue *mq,
 	__clear_bit(mqrq->task_id, &mq->qslots);
 }
 
+static void mmc_cqe_request_fn(struct request_queue *q)
+{
+	struct mmc_queue *mq = q->queuedata;
+	struct request *req;
+
+	if (!mq) {
+		while ((req = blk_fetch_request(q)) != NULL) {
+			req->rq_flags |= RQF_QUIET;
+			__blk_end_request_all(req, -EIO);
+		}
+		return;
+	}
+
+	if (mq->asleep && !mq->cqe_busy)
+		wake_up_process(mq->thread);
+}
+
+static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
+{
+	/* Allow only 1 DCMD at a time */
+	return mq->cqe_in_flight[MMC_ISSUE_DCMD];
+}
+
+static inline bool mmc_cqe_queue_full(struct mmc_queue *mq)
+{
+	return mmc_cqe_qcnt(mq) >= mq->qdepth;
+}
+
+void mmc_cqe_kick_queue(struct mmc_queue *mq)
+{
+	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
+		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
+
+	if ((mq->cqe_busy & MMC_CQE_QUEUE_FULL) && !mmc_cqe_queue_full(mq))
+		mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
+
+	if (mq->asleep && !mq->cqe_busy)
+		__blk_run_queue(mq->queue);
+}
+
+static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_CQE_DCMD;
+}
+
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+		return MMC_ISSUE_SYNC;
+	case REQ_OP_FLUSH:
+		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
+	default:
+		return MMC_ISSUE_ASYNC;
+	}
+}
+
+void mmc_queue_set_special(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = &mq->mqrq[req->tag];
+
+	mqrq->req = req;
+	req->special = mqrq;
+}
+
+void mmc_queue_clr_special(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req->special;
+
+	if (!mqrq)
+		return;
+
+	mqrq->req = NULL;
+	req->special = NULL;
+}
+
+static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
+{
+	if (!mq->cqe_recovery_needed) {
+		mq->cqe_recovery_needed = true;
+		wake_up_process(mq->thread);
+	}
+}
+
+static void mmc_cqe_recovery_notifier(struct mmc_host *host,
+				      struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mqrq->req;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	__mmc_cqe_recovery_notifier(mq);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
+static int mmc_cqe_thread(void *d)
+{
+	struct mmc_queue *mq = d;
+	struct request_queue *q = mq->queue;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	unsigned long flags;
+	int get_put = 0;
+
+	current->flags |= PF_MEMALLOC;
+
+	down(&mq->thread_sem);
+	spin_lock_irqsave(q->queue_lock, flags);
+	while (1) {
+		struct request *req = NULL;
+		enum mmc_issue_type issue_type;
+		bool retune_ok = false;
+
+		if (mq->cqe_recovery_needed) {
+			spin_unlock_irqrestore(q->queue_lock, flags);
+			mmc_blk_cqe_recovery(mq);
+			spin_lock_irqsave(q->queue_lock, flags);
+			mq->cqe_recovery_needed = false;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (!kthread_should_stop())
+			req = blk_peek_request(q);
+
+		if (req) {
+			issue_type = mmc_cqe_issue_type(host, req);
+			switch (issue_type) {
+			case MMC_ISSUE_DCMD:
+				if (mmc_cqe_dcmd_busy(mq)) {
+					mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
+					req = NULL;
+					break;
+				}
+				/* Fall through */
+			case MMC_ISSUE_ASYNC:
+				if (blk_queue_start_tag(q, req)) {
+					mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
+					req = NULL;
+				}
+				break;
+			default:
+				/*
+				 * Timeouts are handled by mmc core, so set a
+				 * large value to avoid races.
+				 */
+				req->timeout = 600 * HZ;
+				req->special = NULL;
+				blk_start_request(req);
+				break;
+			}
+			if (req) {
+				mq->cqe_in_flight[issue_type] += 1;
+				if (mmc_cqe_tot_in_flight(mq) == 1)
+					get_put += 1;
+				if (mmc_cqe_qcnt(mq) == 1)
+					retune_ok = true;
+			}
+		}
+
+		mq->asleep = !req;
+
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		if (req) {
+			enum mmc_issued issued;
+
+			set_current_state(TASK_RUNNING);
+
+			if (get_put) {
+				get_put = 0;
+				mmc_get_card(card);
+			}
+
+			if (host->need_retune && retune_ok &&
+			    !host->hold_retune)
+				host->retune_now = true;
+			else
+				host->retune_now = false;
+
+			issued = mmc_blk_cqe_issue_rq(mq, req);
+
+			cond_resched();
+
+			spin_lock_irqsave(q->queue_lock, flags);
+
+			switch (issued) {
+			case MMC_REQ_STARTED:
+				break;
+			case MMC_REQ_BUSY:
+				blk_requeue_request(q, req);
+				goto finished;
+			case MMC_REQ_FAILED_TO_START:
+				__blk_end_request_all(req, -EIO);
+				/* Fall through */
+			case MMC_REQ_FINISHED:
+finished:
+				mq->cqe_in_flight[issue_type] -= 1;
+				if (mmc_cqe_tot_in_flight(mq) == 0)
+					get_put = -1;
+			}
+		} else {
+			if (get_put < 0) {
+				get_put = 0;
+				mmc_put_card(card);
+			}
+			/*
+			 * Do not stop with requests in flight in case recovery
+			 * is needed.
+			 */
+			if (kthread_should_stop() &&
+			    !mmc_cqe_tot_in_flight(mq)) {
+				set_current_state(TASK_RUNNING);
+				break;
+			}
+			up(&mq->thread_sem);
+			schedule();
+			down(&mq->thread_sem);
+			spin_lock_irqsave(q->queue_lock, flags);
+		}
+	} /* loop */
+	up(&mq->thread_sem);
+
+	return 0;
+}
+
+static enum blk_eh_timer_return __mmc_cqe_timed_out(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req->special;
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct mmc_queue *mq = req->q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_cqe_issue_type(host, req);
+	bool recovery_needed = false;
+
+	switch (issue_type) {
+	case MMC_ISSUE_ASYNC:
+	case MMC_ISSUE_DCMD:
+		if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
+			if (recovery_needed)
+				__mmc_cqe_recovery_notifier(mq);
+			return BLK_EH_RESET_TIMER;
+		}
+		/* No timeout */
+		return BLK_EH_HANDLED;
+	default:
+		/* Timeout is handled by mmc core */
+		return BLK_EH_RESET_TIMER;
+	}
+}
+
+static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
+{
+	struct mmc_queue *mq = req->q->queuedata;
+
+	if (!req->special || mq->cqe_recovery_needed)
+		return BLK_EH_RESET_TIMER;
+
+	return __mmc_cqe_timed_out(req);
+}
+
 static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
@@ -365,20 +632,43 @@ int mmc_queue_alloc_shared_queue(struct mmc_card *card)
  * Initialise a MMC card request queue.
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
+		   spinlock_t *lock, const char *subname, int area_type)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	int ret = -ENOMEM;
+	bool use_cqe = host->cqe_enabled && area_type != MMC_BLK_DATA_AREA_RPMB;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	mq->card = card;
-	mq->queue = blk_init_queue(mmc_request_fn, lock);
+
+	mq->queue = blk_init_queue(use_cqe ?
+				   mmc_cqe_request_fn : mmc_request_fn, lock);
 	if (!mq->queue)
 		return -ENOMEM;
 
+	if (use_cqe) {
+		int q_depth = card->ext_csd.cmdq_depth;
+
+		if (q_depth > host->cqe_qdepth)
+			q_depth = host->cqe_qdepth;
+		if (q_depth > card->qdepth)
+			q_depth = card->qdepth;
+
+		ret = blk_queue_init_tags(mq->queue, q_depth, NULL,
+					  BLK_TAG_ALLOC_FIFO);
+		if (ret)
+			goto cleanup_queue;
+
+		blk_queue_softirq_done(mq->queue, mmc_blk_cqe_complete_rq);
+		blk_queue_rq_timed_out(mq->queue, mmc_cqe_timed_out);
+		blk_queue_rq_timeout(mq->queue, 60 * HZ);
+
+		host->cqe_recovery_notifier = mmc_cqe_recovery_notifier;
+	}
+
 	mq->mqrq = card->mqrq;
 	mq->qdepth = card->qdepth;
 	mq->queue->queuedata = mq;
@@ -404,9 +694,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	sema_init(&mq->thread_sem, 1);
 
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
-		host->index, subname ? subname : "");
-
+	mq->thread = kthread_run(use_cqe ? mmc_cqe_thread : mmc_queue_thread,
+				 mq, "mmcqd/%d%s", host->index,
+				 subname ? subname : "");
 	if (IS_ERR(mq->thread)) {
 		ret = PTR_ERR(mq->thread);
 		goto cleanup_queue;
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 871796c3f406..8bfb3cbea572 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -14,6 +14,13 @@ static inline bool mmc_req_is_special(struct request *req)
 		 req_op(req) == REQ_OP_SECURE_ERASE);
 }
 
+enum mmc_issued {
+	MMC_REQ_STARTED,
+	MMC_REQ_BUSY,
+	MMC_REQ_FAILED_TO_START,
+	MMC_REQ_FINISHED,
+};
+
 struct task_struct;
 struct mmc_blk_data;
 
@@ -37,6 +44,13 @@ struct mmc_queue_req {
 	int			task_id;
 };
 
+enum mmc_issue_type {
+	MMC_ISSUE_SYNC,
+	MMC_ISSUE_DCMD,
+	MMC_ISSUE_ASYNC,
+	MMC_ISSUE_MAX,
+};
+
 struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
@@ -49,12 +63,18 @@ struct mmc_queue {
 	int			qdepth;
 	int			qcnt;
 	unsigned long		qslots;
+	/* Following are defined for a Command Queue Engine */
+	int			cqe_in_flight[MMC_ISSUE_MAX];
+	unsigned int		cqe_busy;
+	bool			cqe_recovery_needed;
+#define MMC_CQE_DCMD_BUSY	BIT(0)
+#define MMC_CQE_QUEUE_FULL	BIT(1)
 };
 
 extern int mmc_queue_alloc_shared_queue(struct mmc_card *card);
 extern void mmc_queue_free_shared_queue(struct mmc_card *card);
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+			  const char *, int);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
@@ -70,4 +90,25 @@ extern struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *,
 						struct request *);
 extern void mmc_queue_req_free(struct mmc_queue *, struct mmc_queue_req *);
 
+void mmc_queue_set_special(struct mmc_queue *mq, struct request *req);
+void mmc_queue_clr_special(struct request *req);
+
+void mmc_cqe_kick_queue(struct mmc_queue *mq);
+
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req);
+
+static inline int mmc_cqe_tot_in_flight(struct mmc_queue *mq)
+{
+	return mq->cqe_in_flight[MMC_ISSUE_SYNC] +
+	       mq->cqe_in_flight[MMC_ISSUE_DCMD] +
+	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
+}
+
+static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
+{
+	return mq->cqe_in_flight[MMC_ISSUE_DCMD] +
+	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
+}
+
 #endif
-- 
1.9.1

