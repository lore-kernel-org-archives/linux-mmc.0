From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 01/25] mmc: queue: Fix queue thread wake-up
Date: Mon, 28 Nov 2016 09:02:47 +0530
Message-ID: <5bdc24b0-61ee-b245-0d91-7d8953505d17@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbcK1Dc4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 22:32:56 -0500
In-Reply-To: <1480068442-5169-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:36 PM, Adrian Hunter wrote:
> The only time the driver sleeps expecting to be woken upon the arrival of
> a new request, is when the dispatch queue is empty. The only time that it
> is known whether the dispatch queue is empty is after NULL is returned
> from blk_fetch_request() while under the queue lock.
>
> Recognizing those facts, simplify the synchronization between the queue
> thread and the request function. A couple of flags tell the request
> function what to do, and the queue lock and barriers associated with
> wake-ups ensure synchronization.
>
> The result is simpler and allows the removal of the context_info lock.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good!!
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

> ---
>  drivers/mmc/card/block.c |  7 -------
>  drivers/mmc/card/queue.c | 35 +++++++++++++++++++++--------------
>  drivers/mmc/card/queue.h |  1 +
>  drivers/mmc/core/core.c  |  6 ------
>  include/linux/mmc/host.h |  2 --
>  5 files changed, 22 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 6618126fcb9f..f8e51640596e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2193,8 +2193,6 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  	int ret;
>  	struct mmc_blk_data *md = mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
> -	struct mmc_host *host = card->host;
> -	unsigned long flags;
>  	bool req_is_special = mmc_req_is_special(req);
>
>  	if (req && !mq->mqrq_prev->req)
> @@ -2227,11 +2225,6 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  			mmc_blk_issue_rw_rq(mq, NULL);
>  		ret = mmc_blk_issue_flush(mq, req);
>  	} else {
> -		if (!req && host->areq) {
> -			spin_lock_irqsave(&host->context_info.lock, flags);
> -			host->context_info.is_waiting_last_req = true;
> -			spin_unlock_irqrestore(&host->context_info.lock, flags);
> -		}
>  		ret = mmc_blk_issue_rw_rq(mq, req);
>  	}
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 3f6a2463ab30..c4ac4b8a1a98 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -53,6 +53,7 @@ static int mmc_queue_thread(void *d)
>  {
>  	struct mmc_queue *mq = d;
>  	struct request_queue *q = mq->queue;
> +	struct mmc_context_info *cntx = &mq->card->host->context_info;
>
>  	current->flags |= PF_MEMALLOC;
>
> @@ -63,6 +64,19 @@ static int mmc_queue_thread(void *d)
>  		spin_lock_irq(q->queue_lock);
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		req = blk_fetch_request(q);
> +		mq->asleep = false;
> +		cntx->is_waiting_last_req = false;
> +		cntx->is_new_req = false;
> +		if (!req) {
> +			/*
> +			 * Dispatch queue is empty so set flags for
> +			 * mmc_request_fn() to wake us up.
> +			 */
> +			if (mq->mqrq_prev->req)
> +				cntx->is_waiting_last_req = true;
> +			else
> +				mq->asleep = true;
> +		}
>  		mq->mqrq_cur->req = req;
>  		spin_unlock_irq(q->queue_lock);
>
> @@ -115,7 +129,6 @@ static void mmc_request_fn(struct request_queue *q)
>  {
>  	struct mmc_queue *mq = q->queuedata;
>  	struct request *req;
> -	unsigned long flags;
>  	struct mmc_context_info *cntx;
>
>  	if (!mq) {
> @@ -127,19 +140,13 @@ static void mmc_request_fn(struct request_queue *q)
>  	}
>
>  	cntx = &mq->card->host->context_info;
> -	if (!mq->mqrq_cur->req && mq->mqrq_prev->req) {
> -		/*
> -		 * New MMC request arrived when MMC thread may be
> -		 * blocked on the previous request to be complete
> -		 * with no current request fetched
> -		 */
> -		spin_lock_irqsave(&cntx->lock, flags);
> -		if (cntx->is_waiting_last_req) {
> -			cntx->is_new_req = true;
> -			wake_up_interruptible(&cntx->wait);
> -		}
> -		spin_unlock_irqrestore(&cntx->lock, flags);
> -	} else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
> +
> +	if (cntx->is_waiting_last_req) {
> +		cntx->is_new_req = true;
> +		wake_up_interruptible(&cntx->wait);
> +	}
> +
> +	if (mq->asleep)
>  		wake_up_process(mq->thread);
>  }
>
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 334c9306070f..0e8133c626c9 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -58,6 +58,7 @@ struct mmc_queue {
>  	unsigned int		flags;
>  #define MMC_QUEUE_SUSPENDED	(1 << 0)
>  #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
> +	bool			asleep;
>  	struct mmc_blk_data	*blkdata;
>  	struct request_queue	*queue;
>  	struct mmc_queue_req	mqrq[2];
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f39397f7c8dc..dc1f27ee50b8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -504,18 +504,14 @@ static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
>  	struct mmc_command *cmd;
>  	struct mmc_context_info *context_info = &host->context_info;
>  	enum mmc_blk_status status;
> -	unsigned long flags;
>
>  	while (1) {
>  		wait_event_interruptible(context_info->wait,
>  				(context_info->is_done_rcv ||
>  				 context_info->is_new_req));
> -		spin_lock_irqsave(&context_info->lock, flags);
>  		context_info->is_waiting_last_req = false;
> -		spin_unlock_irqrestore(&context_info->lock, flags);
>  		if (context_info->is_done_rcv) {
>  			context_info->is_done_rcv = false;
> -			context_info->is_new_req = false;
>  			cmd = mrq->cmd;
>
>  			if (!cmd->error || !cmd->retries ||
> @@ -534,7 +530,6 @@ static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
>  				continue; /* wait for done/new event again */
>  			}
>  		} else if (context_info->is_new_req) {
> -			context_info->is_new_req = false;
>  			if (!next_req)
>  				return MMC_BLK_NEW_REQUEST;
>  		}
> @@ -3016,7 +3011,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
>   */
>  void mmc_init_context_info(struct mmc_host *host)
>  {
> -	spin_lock_init(&host->context_info.lock);
>  	host->context_info.is_new_req = false;
>  	host->context_info.is_done_rcv = false;
>  	host->context_info.is_waiting_last_req = false;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2a6418d0c343..bcf6d252ec67 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -197,14 +197,12 @@ struct mmc_slot {
>   * @is_new_req		wake up reason was new request
>   * @is_waiting_last_req	mmc context waiting for single running request
>   * @wait		wait queue
> - * @lock		lock to protect data fields
>   */
>  struct mmc_context_info {
>  	bool			is_done_rcv;
>  	bool			is_new_req;
>  	bool			is_waiting_last_req;
>  	wait_queue_head_t	wait;
> -	spinlock_t		lock;
>  };
>
>  struct regulator;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
