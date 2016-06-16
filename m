From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH RFC 02/10] mmc: queue: initialization of command queue
Date: Thu, 16 Jun 2016 16:55:40 +0800
Message-ID: <9ebd359b-7f2d-2c09-0f32-fbde98edb9e2@rock-chips.com>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
 <1465995674-15816-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60687 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcFPI4R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2016 04:56:17 -0400
In-Reply-To: <1465995674-15816-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>

On 2016/6/15 21:01, Ritesh Harjani wrote:
> From: Asutosh Das <asutoshd@codeaurora.org>
>
> Command Queueing (CQ) feature is introduced to eMMC
> standard in revision 5.1. CQ includes new commands
> for issuing tasks to the device, for ordering the
> execution of previously issued tasks and for
> additional task management functions.
>
> The idea is to keep the legacy and CQ code as discrete
> as possible. Hence, a separate queue is created for CQ

I have no idea as most of code is a duplication of the

.
> The issuing path is non-blocking since several requests
> (max. 32) can be queued at a time.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> [subhashj@codeaurora.org: fixed trivial merge conflicts & compilation
> error]
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/card/block.c |   2 +-
>  drivers/mmc/card/queue.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/card/queue.h |  10 ++-
>  include/linux/mmc/host.h |  19 +++++
>  4 files changed, 216 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 8a0147d..1b69424 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2218,7 +2218,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	INIT_LIST_HEAD(&md->part);
>  	md->usage = 1;
>
> -	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
> +	ret = mmc_init_queue(&md->queue, card, &md->lock, subname, area_type);
>  	if (ret)
>  		goto err_putdisk;
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 6f4323c..d4deab5 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -46,6 +46,70 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>  	return BLKPREP_OK;
>  }
>
> +static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host,
> +					struct mmc_cmdq_context_info *ctx)
> +{
> +	if (test_bit(CMDQ_STATE_ERR, &ctx->curr_state)) {
> +		pr_debug("%s: %s: skip pulling reqs: state: %lu\n",
> +			 mmc_hostname(host), __func__, ctx->curr_state);
> +		return false;
> +	} else {
> +		return true;
> +	}

I believe a checkpatch warning here,

you don't need a else branch here, should return true directly.

> +}
> +
> +static int mmc_cmdq_thread(void *d)
> +{
> +	struct mmc_queue *mq = d;
> +	struct request_queue *q = mq->queue;
> +	struct mmc_card *card = mq->card;
> +
> +	struct request *req;
> +	struct mmc_host *host = card->host;
> +	struct mmc_cmdq_context_info *ctx = &host->cmdq_ctx;
> +	unsigned long flags;
> +
> +	current->flags |= PF_MEMALLOC;
> +
> +	while (1) {
> +		int ret = 0;
> +
> +		if (!mmc_cmdq_should_pull_reqs(host, ctx)) {
> +			test_and_set_bit(0, &ctx->req_starved);
> +			schedule();
> +		}
> +
> +		spin_lock_irqsave(q->queue_lock, flags);
> +		req = blk_peek_request(q);
> +		if (req) {
> +			ret = blk_queue_start_tag(q, req);
> +			spin_unlock_irqrestore(q->queue_lock, flags);
> +			if (ret) {
> +				test_and_set_bit(0, &ctx->req_starved);
> +				schedule();
> +			} else {
> +				ret = mq->cmdq_issue_fn(mq, req);
> +				if (ret) {
> +					pr_err("%s: failed (%d) to issue req, requeue\n",
> +					       mmc_hostname(host), ret);
> +					spin_lock_irqsave(q->queue_lock, flags);
> +					blk_requeue_request(q, req);
> +					spin_unlock_irqrestore(q->queue_lock,
> +							       flags);
> +				}
> +			}
> +		} else {
> +			spin_unlock_irqrestore(q->queue_lock, flags);
> +			if (kthread_should_stop()) {
> +				set_current_state(TASK_RUNNING);
> +				break;
> +			}
> +			schedule();
> +		}
> +	} /* loop */
> +	return 0;
> +}
> +
>  static int mmc_queue_thread(void *d)
>  {
>  	struct mmc_queue *mq = d;
> @@ -102,6 +166,13 @@ static int mmc_queue_thread(void *d)
>  	return 0;
>  }
>
> +static void mmc_cmdq_dispatch_req(struct request_queue *q)
> +{
> +	struct mmc_queue *mq = q->queuedata;
> +
> +	wake_up_process(mq->thread);
> +}
> +
>  /*
>   * Generic MMC request handler.  This is called for any queue on a
>   * particular host.  When the host is not busy, we look for a request
> @@ -177,6 +248,29 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  }
>
>  /**
> + * mmc_blk_cmdq_setup_queue
> + * @mq: mmc queue
> + * @card: card to attach to this queue
> + *
> + * Setup queue for CMDQ supporting MMC card
> + */
> +void mmc_cmdq_setup_queue(struct mmc_queue *mq, struct mmc_card *card)

Should be static

> +{
> +	u64 limit = BLK_BOUNCE_HIGH;
> +	struct mmc_host *host = card->host;
> +
> +	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
> +	if (mmc_can_erase(card))
> +		mmc_queue_setup_discard(mq->queue, card);
> +
> +	blk_queue_bounce_limit(mq->queue, limit);
> +	blk_queue_max_hw_sectors(mq->queue, min(host->max_blk_count,
> +						host->max_req_size / 512));
> +	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
> +	blk_queue_max_segments(mq->queue, host->max_segs);
> +}
> +
> +/**
>   * mmc_init_queue - initialise a queue structure.
>   * @mq: mmc queue
>   * @card: mmc card to attach this queue
> @@ -186,7 +280,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>   * Initialise a MMC card request queue.
>   */
>  int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,

Ditto.

> -		   spinlock_t *lock, const char *subname)
> +		   spinlock_t *lock, const char *subname, int area_type)
>  {
>  	struct mmc_host *host = card->host;
>  	u64 limit = BLK_BOUNCE_HIGH;
> @@ -198,6 +292,28 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>
>  	mq->card = card;
> +	if (card->ext_csd.cmdq_support &&
> +	    (area_type == MMC_BLK_DATA_AREA_MAIN)) {

It seems you don't disable cmdq when switching to RPMB somewhere.
Do I miss sth. ?

> +		mq->queue = blk_init_queue(mmc_cmdq_dispatch_req, lock);
> +		if (!mq->queue)
> +			return -ENOMEM;
> +		mmc_cmdq_setup_queue(mq, card);
> +		ret = mmc_cmdq_init(mq, card);
> +		if (ret) {
> +			pr_err("%s: %d: cmdq: unable to set-up\n",
> +			       mmc_hostname(card->host), ret);
> +			blk_cleanup_queue(mq->queue);
> +		} else {
> +			mq->queue->queuedata = mq;
> +			mq->thread = kthread_run(mmc_cmdq_thread, mq,
> +						 "mmc-cmdqd/%d%s",
> +						 host->index,
> +						 subname ? subname : "");
> +
> +			return ret;
> +		}
> +	}
> +
>  	mq->queue = blk_init_queue(mmc_request_fn, lock);
>  	if (!mq->queue)
>  		return -ENOMEM;
> @@ -402,6 +518,77 @@ void mmc_packed_clean(struct mmc_queue *mq)
>  	mqrq_prev->packed = NULL;
>  }
>
> +static void mmc_cmdq_softirq_done(struct request *rq)
> +{
> +	struct mmc_queue *mq = rq->q->queuedata;
> +	mq->cmdq_complete_fn(rq);
> +}
> +
> +int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
> +{
> +	int i, ret = 0;
> +	/* one slot is reserved for dcmd requests */
> +	int q_depth = card->ext_csd.cmdq_depth - 1;
> +
> +	if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE)) {

I notice you just cleanup the queue if failing to support cmdq

So, should we go on and fall back to create mmc_queue_thread?

> +		ret = -ENOTSUPP;
> +		goto out;
> +	}
> +
> +	mq->mqrq_cmdq = kzalloc(
> +			sizeof(struct mmc_queue_req) * q_depth, GFP_KERNEL);
> +	if (!mq->mqrq_cmdq) {
> +		pr_warn("%s: unable to allocate mqrq's for q_depth %d\n",
> +			mmc_card_name(card), q_depth);

could remove the pr_warn.

> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* sg is allocated for data request slots only */
> +	for (i = 0; i < q_depth; i++) {
> +		mq->mqrq_cmdq[i].sg = mmc_alloc_sg(card->host->max_segs, &ret);
> +		if (ret) {
> +			pr_warn("%s: unable to allocate cmdq sg of size %d\n",
> +				mmc_card_name(card),
> +				card->host->max_segs);
> +			goto free_mqrq_sg;
> +		}
> +	}
> +
> +	ret = blk_queue_init_tags(mq->queue, q_depth, NULL, BLK_TAG_ALLOC_FIFO);
> +	if (ret) {
> +		pr_warn("%s: unable to allocate cmdq tags %d\n",
> +				mmc_card_name(card), q_depth);
> +		goto free_mqrq_sg;
> +	}
> +
> +	blk_queue_softirq_done(mq->queue, mmc_cmdq_softirq_done);
> +	goto out;
> +
> +free_mqrq_sg:
> +	for (i = 0; i < q_depth; i++)
> +		kfree(mq->mqrq_cmdq[i].sg);
> +	kfree(mq->mqrq_cmdq);
> +	mq->mqrq_cmdq = NULL;
> +out:
> +	return ret;
> +}
> +
> +void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card)
> +{
> +	int i;
> +	int q_depth = card->ext_csd.cmdq_depth - 1;
> +
> +	blk_free_tags(mq->queue->queue_tags);
> +	mq->queue->queue_tags = NULL;
> +	blk_queue_free_tags(mq->queue);
> +
> +	for (i = 0; i < q_depth; i++)
> +		kfree(mq->mqrq_cmdq[i].sg);
> +	kfree(mq->mqrq_cmdq);
> +	mq->mqrq_cmdq = NULL;
> +}
> +
>  /**
>   * mmc_queue_suspend - suspend a MMC request queue
>   * @mq: MMC queue to suspend
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 36cddab..4c7e39d2 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -52,16 +52,20 @@ struct mmc_queue {
>  #define MMC_QUEUE_SUSPENDED	(1 << 0)
>  #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
>
> -	int			(*issue_fn)(struct mmc_queue *, struct request *);
> +	int (*issue_fn)(struct mmc_queue *, struct request *);
> +	int (*cmdq_issue_fn)(struct mmc_queue *,
> +			     struct request *);
> +	void (*cmdq_complete_fn)(struct request *);
>  	void			*data;
>  	struct request_queue	*queue;
>  	struct mmc_queue_req	mqrq[2];
>  	struct mmc_queue_req	*mqrq_cur;
>  	struct mmc_queue_req	*mqrq_prev;
> +	struct mmc_queue_req	*mqrq_cmdq;
>  };
>
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> -			  const char *);
> +			  const char *, int);
>  extern void mmc_cleanup_queue(struct mmc_queue *);
>  extern void mmc_queue_suspend(struct mmc_queue *);
>  extern void mmc_queue_resume(struct mmc_queue *);
> @@ -76,4 +80,6 @@ extern void mmc_packed_clean(struct mmc_queue *);
>
>  extern int mmc_access_rpmb(struct mmc_queue *);
>
> +extern int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card);
> +extern void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card);
>  #endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8dd4d29..23accc3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -175,6 +175,23 @@ struct mmc_slot {
>  	void *handler_priv;
>  };
>
> +

remove this new line

> +/**
> + * mmc_cmdq_context_info - describes the contexts of cmdq
> + * @active_reqs		requests being processed
> + * @curr_state		state of cmdq engine
> + * @req_starved		completion should invoke the request_fn since
> + *			no tags were available
> + * @cmdq_ctx_lock	acquire this before accessing this structure

where is it?

> + */
> +struct mmc_cmdq_context_info {
> +	unsigned long	active_reqs; /* in-flight requests */
> +	unsigned long	curr_state;
> +#define	CMDQ_STATE_ERR 0
> +	/* no free tag available */
> +	unsigned long	req_starved;
> +};
> +
>  /**
>   * mmc_context_info - synchronization details for mmc context
>   * @is_done_rcv		wake up reason was done request
> @@ -291,6 +308,7 @@ struct mmc_host {
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
>  #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
> +#define MMC_CAP2_CMD_QUEUE	(1 << 20)	/* support eMMC command queue */

Should rebase agian against Ulf's next :)

git://git.linaro.org/people/ulf.hansson/mmc

>
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>
> @@ -372,6 +390,7 @@ struct mmc_host {
>  	int			dsr_req;	/* DSR value is valid */
>  	u32			dsr;	/* optional driver stage (DSR) value */
>
> +	struct mmc_cmdq_context_info	cmdq_ctx;
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>
>


-- 
Best Regards
Shawn Lin

