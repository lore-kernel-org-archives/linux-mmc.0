From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V4 09/11] mmc: block: Add CQE support
Date: Tue, 1 Aug 2017 16:57:01 +0800
Message-ID: <94c83722-0933-0d09-204e-905c3d83552e@rock-chips.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:45439 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHAI5U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 04:57:20 -0400
In-Reply-To: <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Adrian,

On 2017/7/21 17:49, Adrian Hunter wrote:
> Add CQE support to the block driver, including:
> 	- optionally using DCMD for flush requests
> 	- manually issuing discard requests
> 	- issuing read / write requests to the CQE
> 	- supporting block-layer timeouts
> 	- handling recovery
> 	- supporting re-tuning
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   drivers/mmc/core/block.c | 195 ++++++++++++++++++++++++++++++++-
>   drivers/mmc/core/block.h |   7 ++
>   drivers/mmc/core/queue.c | 273 ++++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/mmc/core/queue.h |  42 +++++++-
>   4 files changed, 510 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 915290c74363..2d25115637b7 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -109,6 +109,7 @@ struct mmc_blk_data {
>   #define MMC_BLK_WRITE		BIT(1)
>   #define MMC_BLK_DISCARD		BIT(2)
>   #define MMC_BLK_SECDISCARD	BIT(3)
> +#define MMC_BLK_CQE_RECOVERY	BIT(4)
>   
>   	/*
>   	 * Only set in main mmc_blk_data associated
> @@ -1612,6 +1613,198 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>   		*do_data_tag_p = do_data_tag;
>   }
>   
> +#define MMC_CQE_RETRIES 2
> +
> +void mmc_blk_cqe_complete_rq(struct request *req)
> +{
> +	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq = &mqrq->brq.mrq;
> +	struct request_queue *q = req->q;
> +	struct mmc_queue *mq = q->queuedata;
> +	struct mmc_host *host = mq->card->host;
> +	unsigned long flags;
> +	bool put_card;
> +	int err;
> +
> +	mmc_cqe_post_req(host, mrq);
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +
> +	mq->cqe_in_flight[mmc_cqe_issue_type(host, req)] -= 1;
> +
> +	put_card = mmc_cqe_tot_in_flight(mq) == 0;
> +
> +	if (mrq->cmd && mrq->cmd->error)
> +		err = mrq->cmd->error;
> +	else if (mrq->data && mrq->data->error)
> +		err = mrq->data->error;
> +	else
> +		err = 0;
> +
> +	if (err) {
> +		if (mqrq->retries++ < MMC_CQE_RETRIES)
> +			blk_requeue_request(q, req);
> +		else
> +			__blk_end_request_all(req, BLK_STS_IOERR);
> +	} else if (mrq->data) {
> +		if (__blk_end_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
> +			blk_requeue_request(q, req);
> +	} else {
> +		__blk_end_request_all(req, BLK_STS_OK);
> +	}
> +
> +	mmc_cqe_kick_queue(mq);
> +
> +	spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +	if (put_card)
> +		mmc_put_card(mq->card);
> +}
> +
> +void mmc_blk_cqe_recovery(struct mmc_queue *mq)
> +{
> +	struct mmc_card *card = mq->card;
> +	struct mmc_host *host = card->host;
> +	int err;
> +
> +	mmc_get_card(card);
> +
> +	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
> +
> +	mq->cqe_in_recovery = true;
> +
> +	err = mmc_cqe_recovery(host);
> +	if (err)
> +		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> +	else
> +		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> +
> +	mq->cqe_in_recovery = false;
> +
> +	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
> +
> +	mmc_put_card(card);
> +}
> +
> +static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
> +{
> +	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
> +						  brq.mrq);
> +	struct request *req = mmc_queue_req_to_req(mqrq);
> +	struct request_queue *q = req->q;
> +	struct mmc_queue *mq = q->queuedata;
> +
> +	/*
> +	 * Block layer timeouts race with completions which means the normal
> +	 * completion path cannot be used during recovery.
> +	 */
> +	if (mq->cqe_in_recovery)
> +		mmc_blk_cqe_complete_rq(req);
> +	else
> +		blk_complete_request(req);
> +}
> +
> +static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +	mrq->done = mmc_blk_cqe_req_done;
> +	return mmc_cqe_start_req(host, mrq);
> +}
> +
> +static struct mmc_request *mmc_blk_cqe_prep_dcmd(struct mmc_queue_req *mqrq,
> +						 struct request *req)
> +{
> +	struct mmc_blk_request *brq = &mqrq->brq;
> +
> +	memset(brq, 0, sizeof(*brq));
> +
> +	brq->mrq.cmd = &brq->cmd;
> +	brq->mrq.tag = req->tag;
> +
> +	return &brq->mrq;
> +}
> +
> +static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
> +{
> +	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
> +
> +	mrq->cmd->opcode = MMC_SWITCH;
> +	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +			(EXT_CSD_FLUSH_CACHE << 16) |
> +			(1 << 8) |
> +			EXT_CSD_CMD_SET_NORMAL;
> +	mrq->cmd->flags = MMC_CMD_AC | MMC_RSP_R1B;
> +
> +	return mmc_blk_cqe_start_req(mq->card->host, mrq);
> +}
> +
> +static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
> +{
> +	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +
> +	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
> +
> +	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> +}
> +
> +enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq, struct request *req)
> +{
> +	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_card *card = md->queue.card;
> +	struct mmc_host *host = card->host;
> +	int ret;
> +
> +	ret = mmc_blk_part_switch(card, md);
> +	if (ret)
> +		return MMC_REQ_FAILED_TO_START;
> +
> +	switch (mmc_cqe_issue_type(host, req)) {
> +	case MMC_ISSUE_SYNC:
> +		ret = host->cqe_ops->cqe_wait_for_idle(host);
> +		if (ret)
> +			return MMC_REQ_BUSY;
> +		switch (req_op(req)) {
> +		case REQ_OP_DRV_IN:
> +		case REQ_OP_DRV_OUT:
> +			mmc_blk_issue_drv_op(mq, req);
> +			break;
> +		case REQ_OP_DISCARD:
> +			mmc_blk_issue_discard_rq(mq, req);
> +			break;
> +		case REQ_OP_SECURE_ERASE:
> +			mmc_blk_issue_secdiscard_rq(mq, req);
> +			break;
> +		case REQ_OP_FLUSH:
> +			mmc_blk_issue_flush(mq, req);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			return MMC_REQ_FAILED_TO_START;
> +		}
> +		return MMC_REQ_FINISHED;
> +	case MMC_ISSUE_DCMD:
> +	case MMC_ISSUE_ASYNC:
> +		switch (req_op(req)) {
> +		case REQ_OP_FLUSH:
> +			ret = mmc_blk_cqe_issue_flush(mq, req);
> +			break;
> +		case REQ_OP_READ:
> +		case REQ_OP_WRITE:
> +			ret = mmc_blk_cqe_issue_rw_rq(mq, req);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			ret = -EINVAL;
> +		}
> +		if (!ret)
> +			return MMC_REQ_STARTED;
> +		return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return MMC_REQ_FAILED_TO_START;
> +	}
> +}
> +
>   static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>   			       struct mmc_card *card,
>   			       int disable_multi,
> @@ -2035,7 +2228,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   	INIT_LIST_HEAD(&md->part);
>   	md->usage = 1;
>   
> -	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
> +	ret = mmc_init_queue(&md->queue, card, &md->lock, subname, area_type);
>   	if (ret)
>   		goto err_putdisk;
>   
> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
> index 860ca7c8df86..d7b3d7008b00 100644
> --- a/drivers/mmc/core/block.h
> +++ b/drivers/mmc/core/block.h
> @@ -6,4 +6,11 @@
>   
>   void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
>   
> +enum mmc_issued;
> +
> +enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq,
> +				     struct request *req);
> +void mmc_blk_cqe_complete_rq(struct request *rq);
> +void mmc_blk_cqe_recovery(struct mmc_queue *mq);
> +
>   #endif
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index affa7370ba82..0cb7b0e8ee58 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -36,10 +36,254 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>   		return BLKPREP_KILL;
>   
>   	req->rq_flags |= RQF_DONTPREP;
> +	req_to_mmc_queue_req(req)->retries = 0;
>   
>   	return BLKPREP_OK;
>   }
>   
> +static void mmc_cqe_request_fn(struct request_queue *q)
> +{
> +	struct mmc_queue *mq = q->queuedata;
> +	struct request *req;
> +
> +	if (!mq) {
> +		while ((req = blk_fetch_request(q)) != NULL) {
> +			req->rq_flags |= RQF_QUIET;
> +			__blk_end_request_all(req, BLK_STS_IOERR);
> +		}
> +		return;
> +	}
> +
> +	if (mq->asleep && !mq->cqe_busy)
> +		wake_up_process(mq->thread);
> +}
> +
> +static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
> +{
> +	/* Allow only 1 DCMD at a time */
> +	return mq->cqe_in_flight[MMC_ISSUE_DCMD];
> +}
> +
> +void mmc_cqe_kick_queue(struct mmc_queue *mq)
> +{
> +	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
> +		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
> +
> +	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
> +
> +	if (mq->asleep && !mq->cqe_busy)
> +		__blk_run_queue(mq->queue);
> +}
> +
> +static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
> +{
> +	return host->caps2 & MMC_CAP2_CQE_DCMD;
> +}
> +
> +enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
> +				       struct request *req)
> +{
> +	switch (req_op(req)) {
> +	case REQ_OP_DRV_IN:
> +	case REQ_OP_DRV_OUT:
> +	case REQ_OP_DISCARD:
> +	case REQ_OP_SECURE_ERASE:
> +		return MMC_ISSUE_SYNC;
> +	case REQ_OP_FLUSH:
> +		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
> +	default:
> +		return MMC_ISSUE_ASYNC;
> +	}
> +}
> +
> +static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
> +{
> +	if (!mq->cqe_recovery_needed) {
> +		mq->cqe_recovery_needed = true;
> +		wake_up_process(mq->thread);
> +	}
> +}
> +
> +static void mmc_cqe_recovery_notifier(struct mmc_host *host,
> +				      struct mmc_request *mrq)
> +{
> +	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
> +						  brq.mrq);
> +	struct request *req = mmc_queue_req_to_req(mqrq);
> +	struct request_queue *q = req->q;
> +	struct mmc_queue *mq = q->queuedata;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	__mmc_cqe_recovery_notifier(mq);
> +	spin_unlock_irqrestore(q->queue_lock, flags);
> +}
> +
> +static int mmc_cqe_thread(void *d)
> +{
> +	struct mmc_queue *mq = d;
> +	struct request_queue *q = mq->queue;
> +	struct mmc_card *card = mq->card;
> +	struct mmc_host *host = card->host;
> +	unsigned long flags;
> +	int get_put = 0;
> +
> +	current->flags |= PF_MEMALLOC;
> +
> +	down(&mq->thread_sem);
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	while (1) {
> +		struct request *req = NULL;
> +		enum mmc_issue_type issue_type;
> +		bool retune_ok = false;
> +
> +		if (mq->cqe_recovery_needed) {
> +			spin_unlock_irqrestore(q->queue_lock, flags);
> +			mmc_blk_cqe_recovery(mq);
> +			spin_lock_irqsave(q->queue_lock, flags);
> +			mq->cqe_recovery_needed = false;
> +		}
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (!kthread_should_stop())
> +			req = blk_peek_request(q);
> +
> +		if (req) {
> +			issue_type = mmc_cqe_issue_type(host, req);
> +			switch (issue_type) {
> +			case MMC_ISSUE_DCMD:
> +				if (mmc_cqe_dcmd_busy(mq)) {
> +					mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
> +					req = NULL;
> +					break;
> +				}
> +				/* Fall through */
> +			case MMC_ISSUE_ASYNC:
> +				if (blk_queue_start_tag(q, req)) {
> +					mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
> +					req = NULL;
> +				}
> +				break;
> +			default:
> +				/*
> +				 * Timeouts are handled by mmc core, so set a
> +				 * large value to avoid races.
> +				 */
> +				req->timeout = 600 * HZ;
> +				blk_start_request(req);
> +				break;
> +			}
> +			if (req) {
> +				mq->cqe_in_flight[issue_type] += 1;
> +				if (mmc_cqe_tot_in_flight(mq) == 1)
> +					get_put += 1;
> +				if (mmc_cqe_qcnt(mq) == 1)
> +					retune_ok = true;
> +			}
> +		}
> +

Just a thought that mmc_cq_thread is a little heavy for manage in-flight
request, so could we kick the check back to blk layer like this in the
prepare and unprepare hook?


--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -25,22 +25,59 @@

  #define MMC_QUEUE_BOUNCESZ	65536

+static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq);
+static inline bool mmc_cqe_can_dcmd(struct mmc_host *host);
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req);
+
  /*
   * Prepare a MMC request. This just filters out odd stuff.
   */
  static int mmc_prep_request(struct request_queue *q, struct request *req)
  {
  	struct mmc_queue *mq = q->queuedata;
+	enum mmc_issue_type issue_type;

  	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
  		return BLKPREP_KILL;

+	if (mq->card->host->cqe_enabled) {
+		issue_type = mmc_cqe_issue_type(mq->card->host, req);
+		if ((issue_type == MMC_ISSUE_DCMD && mmc_cqe_dcmd_busy(mq))) {
+			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
+			return BLKPREP_DEFER;
+		} else if (issue_type == MMC_ISSUE_ASYNC &&
+				   mq->cqe_in_flight[issue_type] >=
+				   mq->queue->queue_tags->max_depth) {
+			mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
+			return BLKPREP_DEFER;
+		}
+	}
+
  	req->rq_flags |= RQF_DONTPREP;
  	req_to_mmc_queue_req(req)->retries = 0;

  	return BLKPREP_OK;
  }

+static void mmc_unprep_request(struct request_queue *q, struct request 
*req)
+{
+	struct mmc_queue *mq = q->queuedata;
+	enum mmc_issue_type issue_type;
+
+	if (!mq->card->host->cqe_enabled)
+		return;
+
+	issue_type = mmc_cqe_issue_type(mq->card->host, req);
+	if (issue_type == MMC_ISSUE_DCMD &&
+		(mq->cqe_busy & MMC_CQE_DCMD_BUSY) &&
+		!mmc_cqe_dcmd_busy(mq))
+		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
+	else if (issue_type == MMC_ISSUE_ASYNC)
+		mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
+}
+
+
  static void mmc_cqe_request_fn(struct request_queue *q)
  {
  	struct mmc_queue *mq = q->queuedata;
@@ -66,11 +103,6 @@ static inline bool mmc_cqe_dcmd_busy(struct 
mmc_queue *mq)

  void mmc_cqe_kick_queue(struct mmc_queue *mq)
  {
-	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
-		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
-
-	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
-
  	if (mq->asleep && !mq->cqe_busy)
  		__blk_run_queue(mq->queue);
  }
@@ -151,21 +183,9 @@ static int mmc_cqe_thread(void *d)

  		if (req) {
  			issue_type = mmc_cqe_issue_type(host, req);
-			switch (issue_type) {
-			case MMC_ISSUE_DCMD:
-				if (mmc_cqe_dcmd_busy(mq)) {
-					mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
-					req = NULL;
-					break;
-				}
-				/* Fall through */
-			case MMC_ISSUE_ASYNC:
-				if (blk_queue_start_tag(q, req)) {
-					mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
-					req = NULL;
-				}
-				break;
-			default:
+			if (issue_type == MMC_ISSUE_DCMD || issue_type == MMC_ISSUE_ASYNC) {
+				blk_queue_start_tag(q, req);
+			} else {
  				/*
  				 * Timeouts are handled by mmc core, so set a
  				 * large value to avoid races.
@@ -174,13 +194,12 @@ static int mmc_cqe_thread(void *d)
  				blk_start_request(req);
  				break;
  			}
-			if (req) {
-				mq->cqe_in_flight[issue_type] += 1;
-				if (mmc_cqe_tot_in_flight(mq) == 1)
-					get_put += 1;
-				if (mmc_cqe_qcnt(mq) == 1)
-					retune_ok = true;
-			}
+
+			mq->cqe_in_flight[issue_type] += 1;
+			if (mmc_cqe_tot_in_flight(mq) == 1)
+				get_put += 1;
+			if (mmc_cqe_qcnt(mq) == 1)
+				retune_ok = true;
  		}

  		mq->asleep = !req;
@@ -523,6 +542,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct 
mmc_card *card,
  	}

  	blk_queue_prep_rq(mq->queue, mmc_prep_request);
+	blk_queue_unprep_rq(mq->queue, mmc_unprep_request);
  	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
  	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
  	if (mmc_can_erase(card))



> +		mq->asleep = !req;
> +
> +		spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +		if (req) {
> +			enum mmc_issued issued;
> +
> +			set_current_state(TASK_RUNNING);
> +
> +			if (get_put) {
> +				get_put = 0;
> +				mmc_get_card(card);
> +			}
> +
> +			if (host->need_retune && retune_ok &&
> +			    !host->hold_retune)
> +				host->retune_now = true;
> +			else
> +				host->retune_now = false;
> +
> +			issued = mmc_blk_cqe_issue_rq(mq, req);
> +
> +			cond_resched();
> +
> +			spin_lock_irqsave(q->queue_lock, flags);
> +
> +			switch (issued) {
> +			case MMC_REQ_STARTED:
> +				break;
> +			case MMC_REQ_BUSY:
> +				blk_requeue_request(q, req);
> +				goto finished;
> +			case MMC_REQ_FAILED_TO_START:
> +				__blk_end_request_all(req, BLK_STS_IOERR);
> +				/* Fall through */
> +			case MMC_REQ_FINISHED:
> +finished:
> +				mq->cqe_in_flight[issue_type] -= 1;
> +				if (mmc_cqe_tot_in_flight(mq) == 0)
> +					get_put = -1;
> +			}
> +		} else {
> +			if (get_put < 0) {
> +				get_put = 0;
> +				mmc_put_card(card);
> +			}
> +			/*
> +			 * Do not stop with requests in flight in case recovery
> +			 * is needed.
> +			 */
> +			if (kthread_should_stop() &&
> +			    !mmc_cqe_tot_in_flight(mq)) {
> +				set_current_state(TASK_RUNNING);
> +				break;
> +			}
> +			up(&mq->thread_sem);
> +			schedule();
> +			down(&mq->thread_sem);
> +			spin_lock_irqsave(q->queue_lock, flags);
> +		}
> +	} /* loop */
> +	up(&mq->thread_sem);
> +
> +	return 0;
> +}
> +
> +static enum blk_eh_timer_return __mmc_cqe_timed_out(struct request *req)
> +{
> +	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq = &mqrq->brq.mrq;
> +	struct mmc_queue *mq = req->q->queuedata;
> +	struct mmc_host *host = mq->card->host;
> +	enum mmc_issue_type issue_type = mmc_cqe_issue_type(host, req);
> +	bool recovery_needed = false;
> +
> +	switch (issue_type) {
> +	case MMC_ISSUE_ASYNC:
> +	case MMC_ISSUE_DCMD:
> +		if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
> +			if (recovery_needed)
> +				__mmc_cqe_recovery_notifier(mq);
> +			return BLK_EH_RESET_TIMER;
> +		}
> +		/* No timeout */
> +		return BLK_EH_HANDLED;
> +	default:
> +		/* Timeout is handled by mmc core */
> +		return BLK_EH_RESET_TIMER;
> +	}
> +}
> +
> +static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
> +{
> +	struct mmc_queue *mq = req->q->queuedata;
> +
> +	if (mq->cqe_recovery_needed)
> +		return BLK_EH_RESET_TIMER;
> +
> +	return __mmc_cqe_timed_out(req);
> +}
> +
>   static int mmc_queue_thread(void *d)
>   {
>   	struct mmc_queue *mq = d;
> @@ -233,11 +477,12 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
>    * Initialise a MMC card request queue.
>    */
>   int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> -		   spinlock_t *lock, const char *subname)
> +		   spinlock_t *lock, const char *subname, int area_type)
>   {
>   	struct mmc_host *host = card->host;
>   	u64 limit = BLK_BOUNCE_HIGH;
>   	int ret = -ENOMEM;
> +	bool use_cqe = host->cqe_enabled && area_type != MMC_BLK_DATA_AREA_RPMB;
>   
>   	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>   		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> @@ -247,7 +492,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>   	if (!mq->queue)
>   		return -ENOMEM;
>   	mq->queue->queue_lock = lock;
> -	mq->queue->request_fn = mmc_request_fn;
> +	mq->queue->request_fn = use_cqe ? mmc_cqe_request_fn : mmc_request_fn;
>   	mq->queue->init_rq_fn = mmc_init_request;
>   	mq->queue->exit_rq_fn = mmc_exit_request;
>   	mq->queue->cmd_size = sizeof(struct mmc_queue_req);
> @@ -259,6 +504,24 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>   		return ret;
>   	}
>   
> +	if (use_cqe) {
> +		int q_depth = card->ext_csd.cmdq_depth;
> +
> +		if (q_depth > host->cqe_qdepth)
> +			q_depth = host->cqe_qdepth;
> +
> +		ret = blk_queue_init_tags(mq->queue, q_depth, NULL,
> +					  BLK_TAG_ALLOC_FIFO);
> +		if (ret)
> +			goto cleanup_queue;
> +
> +		blk_queue_softirq_done(mq->queue, mmc_blk_cqe_complete_rq);
> +		blk_queue_rq_timed_out(mq->queue, mmc_cqe_timed_out);
> +		blk_queue_rq_timeout(mq->queue, 60 * HZ);
> +
> +		host->cqe_recovery_notifier = mmc_cqe_recovery_notifier;
> +	}
> +
>   	blk_queue_prep_rq(mq->queue, mmc_prep_request);
>   	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
>   	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
> @@ -280,9 +543,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>   
>   	sema_init(&mq->thread_sem, 1);
>   
> -	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
> -		host->index, subname ? subname : "");
> -
> +	mq->thread = kthread_run(use_cqe ? mmc_cqe_thread : mmc_queue_thread,
> +				 mq, "mmcqd/%d%s", host->index,
> +				 subname ? subname : "");
>   	if (IS_ERR(mq->thread)) {
>   		ret = PTR_ERR(mq->thread);
>   		goto cleanup_queue;
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 361b46408e0f..8e9273d977c0 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -7,6 +7,20 @@
>   #include <linux/mmc/core.h>
>   #include <linux/mmc/host.h>
>   
> +enum mmc_issued {
> +	MMC_REQ_STARTED,
> +	MMC_REQ_BUSY,
> +	MMC_REQ_FAILED_TO_START,
> +	MMC_REQ_FINISHED,
> +};
> +
> +enum mmc_issue_type {
> +	MMC_ISSUE_SYNC,
> +	MMC_ISSUE_DCMD,
> +	MMC_ISSUE_ASYNC,
> +	MMC_ISSUE_MAX,
> +};
> +
>   static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request *rq)
>   {
>   	return blk_mq_rq_to_pdu(rq);
> @@ -53,6 +67,7 @@ struct mmc_queue_req {
>   	int			drv_op_result;
>   	struct mmc_blk_ioc_data	**idata;
>   	unsigned int		ioc_count;
> +	int			retries;
>   };
>   
>   struct mmc_queue {
> @@ -70,10 +85,17 @@ struct mmc_queue {
>   	 * associated mmc_queue_req data.
>   	 */
>   	int			qcnt;
> +	/* Following are defined for a Command Queue Engine */
> +	int			cqe_in_flight[MMC_ISSUE_MAX];
> +	unsigned int		cqe_busy;
> +	bool			cqe_recovery_needed;
> +	bool			cqe_in_recovery;
> +#define MMC_CQE_DCMD_BUSY	BIT(0)
> +#define MMC_CQE_QUEUE_FULL	BIT(1)
>   };
>   
>   extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> -			  const char *);
> +			  const char *, int);
>   extern void mmc_cleanup_queue(struct mmc_queue *);
>   extern void mmc_queue_suspend(struct mmc_queue *);
>   extern void mmc_queue_resume(struct mmc_queue *);
> @@ -85,4 +107,22 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
>   
>   extern int mmc_access_rpmb(struct mmc_queue *);
>   
> +void mmc_cqe_kick_queue(struct mmc_queue *mq);
> +
> +enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
> +				       struct request *req);
> +
> +static inline int mmc_cqe_tot_in_flight(struct mmc_queue *mq)
> +{
> +	return mq->cqe_in_flight[MMC_ISSUE_SYNC] +
> +	       mq->cqe_in_flight[MMC_ISSUE_DCMD] +
> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
> +}
> +
> +static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
> +{
> +	return mq->cqe_in_flight[MMC_ISSUE_DCMD] +
> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
> +}
> +
>   #endif
> 

