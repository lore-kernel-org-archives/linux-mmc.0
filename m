From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v5] mmc: fix async request mechanism for sequential read
 scenarios
Date: Fri, 28 Dec 2012 19:16:30 +0900
Message-ID: <001501cde4e4$67adc410$37094c30$%jun@samsung.com>
References: <n@samsung.com>
 <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27816 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab2L1KQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Dec 2012 05:16:32 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFQ0046QKJ72E60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Dec 2012 19:16:31 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFQ00JYVKJIYU00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Dec 2012 19:16:30 +0900 (KST)
In-reply-to: <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Konstantin Dorfman' <kdorfman@codeaurora.org>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, per.lkml@gmail.com

I checked the changes. Thanks for your work.

Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>

On Wednesday, December 26, 2012, Konstantin Dorfman wrote:
> When current request is running on the bus and if next request fetched
> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
> current request completes. This means that if new request comes in while
> the mmcqd thread is blocked, this new request can not be prepared in
> parallel to current ongoing request. This may result in delaying the new
> request execution and increase it's latency.
> 
> This change allows to wake up the MMC thread on new request arrival.
> Now once the MMC thread is woken up, a new request can be fetched and
> prepared in parallel to the current running request which means this new
> request can be started immediately after the current running request
> completes.
> 
> With this change read throughput is improved by 16%.
> 
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> ---
> v5: 	- Removed BUG() and BUG_ON() with proper error handling
> 	- Turn on of is_waiting_last_req flag moved from queue.c into
> 	  block.c (mmc_blk_issue_req())
>   	- mmc_init_context_info() called from mmc_add_card(). It is
> 	  common point for MMC, SD, SDIO.
> 
> v4:     keeps new synchronization mechanism within mmc/core
> 	layer, so mmc/core external API's are not changed.
> 	- context_info moved into mmc_host struct
> 	- context_info initialized in mmc_attach_mmc()
> 
> v3:
> 	- new MMC_QUEUE_NEW_REQUEST flag to mark new request case
> 	- lock added to update is_new_req flag
> 	- condition for sending new req notification changed
> 	- Moved start waiting for new req notification
> 	  after fetching NULL
> v2:
> 	- Removed synchronization flags
> 	- removed lock from done()
> 	- flags names changed
> v1:
> 	- Initial submit
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 21056b9..f79b468 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -113,17 +113,6 @@ struct mmc_blk_data {
> 
>  static DEFINE_MUTEX(open_lock);
> 
> -enum mmc_blk_status {
> -	MMC_BLK_SUCCESS = 0,
> -	MMC_BLK_PARTIAL,
> -	MMC_BLK_CMD_ERR,
> -	MMC_BLK_RETRY,
> -	MMC_BLK_ABORT,
> -	MMC_BLK_DATA_ERR,
> -	MMC_BLK_ECC_ERR,
> -	MMC_BLK_NOMEDIUM,
> -};
> -
>  module_param(perdev_minors, int, 0444);
>  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
> 
> @@ -1364,8 +1353,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  		} else
>  			areq = NULL;
>  		areq = mmc_start_req(card->host, areq, (int *) &status);
> -		if (!areq)
> +		if (!areq) {
> +			if (status == MMC_BLK_NEW_REQUEST)
> +				mq->flags |= MMC_QUEUE_NEW_REQUEST;
>  			return 0;
> +		}
> 
>  		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
>  		brq = &mq_rq->brq;
> @@ -1438,6 +1430,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			break;
>  		case MMC_BLK_NOMEDIUM:
>  			goto cmd_abort;
> +		default:
> +			pr_err("%s: Unhandled return value (%d)",
> +					req->rq_disk->disk_name, status);
> +			goto cmd_abort;
>  		}
> 
>  		if (ret) {
> @@ -1472,6 +1468,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  	int ret;
>  	struct mmc_blk_data *md = mq->data;
>  	struct mmc_card *card = md->queue.card;
> +	struct mmc_host *host = card->host;
> +	unsigned long flags;
> 
>  	if (req && !mq->mqrq_prev->req)
>  		/* claim host only for the first request */
> @@ -1486,6 +1484,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  		goto out;
>  	}
> 
> +	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
>  	if (req && req->cmd_flags & REQ_DISCARD) {
>  		/* complete ongoing async transfer before issuing discard */
>  		if (card->host->areq)
> @@ -1501,11 +1500,16 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  			mmc_blk_issue_rw_rq(mq, NULL);
>  		ret = mmc_blk_issue_flush(mq, req);
>  	} else {
> +		if (!req && host->areq) {
> +			spin_lock_irqsave(&host->context_info.lock, flags);
> +			host->context_info.is_waiting_last_req = true;
> +			spin_unlock_irqrestore(&host->context_info.lock, flags);
> +		}
>  		ret = mmc_blk_issue_rw_rq(mq, req);
>  	}
> 
>  out:
> -	if (!req)
> +	if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
>  		/* release host only when there are no more requests */
>  		mmc_release_host(card->host);
>  	return ret;
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index fadf52e..2ab21a0 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -22,7 +22,6 @@
> 
>  #define MMC_QUEUE_BOUNCESZ	65536
> 
> -#define MMC_QUEUE_SUSPENDED	(1 << 0)
> 
>  /*
>   * Prepare a MMC request. This just filters out odd stuff.
> @@ -68,6 +67,10 @@ static int mmc_queue_thread(void *d)
>  		if (req || mq->mqrq_prev->req) {
>  			set_current_state(TASK_RUNNING);
>  			mq->issue_fn(mq, req);
> +			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
> +				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> +				continue; /* fetch again */
> +			}
> 
>  			/*
>  			 * Current request becomes previous request
> @@ -103,6 +106,8 @@ static void mmc_request_fn(struct request_queue *q)
>  {
>  	struct mmc_queue *mq = q->queuedata;
>  	struct request *req;
> +	unsigned long flags;
> +	struct mmc_context_info *cntx;
> 
>  	if (!mq) {
>  		while ((req = blk_fetch_request(q)) != NULL) {
> @@ -112,7 +117,20 @@ static void mmc_request_fn(struct request_queue *q)
>  		return;
>  	}
> 
> -	if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
> +	cntx = &mq->card->host->context_info;
> +	if (!mq->mqrq_cur->req && mq->mqrq_prev->req) {
> +		/*
> +		 * New MMC request arrived when MMC thread may be
> +		 * blocked on the previous request to be complete
> +		 * with no current request fetched
> +		 */
> +		spin_lock_irqsave(&cntx->lock, flags);
> +		if (cntx->is_waiting_last_req) {
> +			cntx->is_new_req = true;
> +			wake_up_interruptible(&cntx->wait);
> +		}
> +		spin_unlock_irqrestore(&cntx->lock, flags);
> +	} else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
>  		wake_up_process(mq->thread);
>  }
> 
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d2a1eb4..e20c27b 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -27,6 +27,9 @@ struct mmc_queue {
>  	struct task_struct	*thread;
>  	struct semaphore	thread_sem;
>  	unsigned int		flags;
> +#define MMC_QUEUE_SUSPENDED	(1 << 0)
> +#define MMC_QUEUE_NEW_REQUEST	(1 << 1)
> +
>  	int			(*issue_fn)(struct mmc_queue *, struct request *);
>  	void			*data;
>  	struct request_queue	*queue;
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 420cb67..e219c97 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -321,6 +321,7 @@ int mmc_add_card(struct mmc_card *card)
>  #ifdef CONFIG_DEBUG_FS
>  	mmc_add_card_debugfs(card);
>  #endif
> +	mmc_init_context_info(card->host);
> 
>  	ret = device_add(&card->dev);
>  	if (ret)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index aaed768..614e4d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -319,11 +319,44 @@ out:
>  }
>  EXPORT_SYMBOL(mmc_start_bkops);
> 
> +/*
> + * mmc_wait_data_done() - done callback for data request
> + * @mrq: done data request
> + *
> + * Wakes up mmc context, passed as a callback to host controller driver
> + */
> +static void mmc_wait_data_done(struct mmc_request *mrq)
> +{
> +	mrq->host->context_info.is_done_rcv = true;
> +	wake_up_interruptible(&mrq->host->context_info.wait);
> +}
> +
>  static void mmc_wait_done(struct mmc_request *mrq)
>  {
>  	complete(&mrq->completion);
>  }
> 
> +/*
> + *__mmc_start_data_req() - starts data request
> + * @host: MMC host to start the request
> + * @mrq: data request to start
> + *
> + * Sets the done callback to be called when request is completed by the card.
> + * Starts data mmc request execution
> + */
> +static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +	mrq->done = mmc_wait_data_done;
> +	mrq->host = host;
> +	if (mmc_card_removed(host->card)) {
> +		mrq->cmd->error = -ENOMEDIUM;
> +		return -ENOMEDIUM;
> +	}
> +	mmc_start_request(host, mrq);
> +
> +	return 0;
> +}
> +
>  static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
>  	init_completion(&mrq->completion);
> @@ -337,6 +370,62 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  	return 0;
>  }
> 
> +/*
> + * mmc_wait_for_data_req_done() - wait for request completed
> + * @host: MMC host to prepare the command.
> + * @mrq: MMC request to wait for
> + *
> + * Blocks MMC context till host controller will ack end of data request
> + * execution or new request notification arrives from the block layer.
> + * Handles command retries.
> + *
> + * Returns enum mmc_blk_status after checking errors.
> + */
> +static int mmc_wait_for_data_req_done(struct mmc_host *host,
> +				      struct mmc_request *mrq,
> +				      struct mmc_async_req *next_req)
> +{
> +	struct mmc_command *cmd;
> +	struct mmc_context_info *context_info = &host->context_info;
> +	int err;
> +	unsigned long flags;
> +
> +	while (1) {
> +		wait_event_interruptible(context_info->wait,
> +				(context_info->is_done_rcv ||
> +				 context_info->is_new_req));
> +		spin_lock_irqsave(&context_info->lock, flags);
> +		context_info->is_waiting_last_req = false;
> +		spin_unlock_irqrestore(&context_info->lock, flags);
> +		if (context_info->is_done_rcv) {
> +			context_info->is_done_rcv = false;
> +			context_info->is_new_req = false;
> +			cmd = mrq->cmd;
> +			if (!cmd->error || !cmd->retries ||
> +					mmc_card_removed(host->card)) {
> +				err = host->areq->err_check(host->card,
> +						host->areq);
> +				break; /* return err */
> +			} else {
> +				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
> +						mmc_hostname(host),
> +						cmd->opcode, cmd->error);
> +				cmd->retries--;
> +				cmd->error = 0;
> +				host->ops->request(host, mrq);
> +				continue; /* wait for done/new event again */
> +			}
> +		} else if (context_info->is_new_req) {
> +			context_info->is_new_req = false;
> +			if (!next_req) {
> +				err = MMC_BLK_NEW_REQUEST;
> +				break; /* return err */
> +			}
> +		}
> +	} /* while */
> +	return err;
> +}
> +
>  static void mmc_wait_for_req_done(struct mmc_host *host,
>  				  struct mmc_request *mrq)
>  {
> @@ -426,8 +515,17 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  		mmc_pre_req(host, areq->mrq, !host->areq);
> 
>  	if (host->areq) {
> -		mmc_wait_for_req_done(host, host->areq->mrq);
> -		err = host->areq->err_check(host->card, host->areq);
> +			err = mmc_wait_for_data_req_done(host, host->areq->mrq,
> +					areq);
> +			if (err == MMC_BLK_NEW_REQUEST) {
> +				if (error)
> +					*error = err;
> +				/*
> +				 * The previous request was not completed,
> +				 * nothing to return
> +				 */
> +				return NULL;
> +			}
>  		/*
>  		 * Check BKOPS urgency for each R1 response
>  		 */
> @@ -439,7 +537,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  	}
> 
>  	if (!err && areq)
> -		start_err = __mmc_start_req(host, areq->mrq);
> +		start_err = __mmc_start_data_req(host, areq->mrq);
> 
>  	if (host->areq)
>  		mmc_post_req(host, host->areq->mrq, 0);
> @@ -2581,6 +2679,23 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  }
>  #endif
> 
> +/**
> + * mmc_init_context_info() - init synchronization context
> + * @host: mmc host
> + *
> + * Init struct context_info needed to implement asynchronous
> + * request mechanism, used by mmc core, host driver and mmc requests
> + * supplier.
> + */
> +void mmc_init_context_info(struct mmc_host *host)
> +{
> +	spin_lock_init(&host->context_info.lock);
> +	host->context_info.is_new_req = false;
> +	host->context_info.is_done_rcv = false;
> +	host->context_info.is_waiting_last_req = false;
> +	init_waitqueue_head(&host->context_info.wait);
> +}
> +
>  static int __init mmc_init(void)
>  {
>  	int ret;
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..0272b32 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -76,5 +76,6 @@ void mmc_remove_host_debugfs(struct mmc_host *host);
>  void mmc_add_card_debugfs(struct mmc_card *card);
>  void mmc_remove_card_debugfs(struct mmc_card *card);
> 
> +void mmc_init_context_info(struct mmc_host *host);
>  #endif
> 
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 5c69315..be2500a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -187,6 +187,18 @@ struct sdio_func_tuple;
> 
>  #define SDIO_MAX_FUNCS		7
> 
> +enum mmc_blk_status {
> +	MMC_BLK_SUCCESS = 0,
> +	MMC_BLK_PARTIAL,
> +	MMC_BLK_CMD_ERR,
> +	MMC_BLK_RETRY,
> +	MMC_BLK_ABORT,
> +	MMC_BLK_DATA_ERR,
> +	MMC_BLK_ECC_ERR,
> +	MMC_BLK_NOMEDIUM,
> +	MMC_BLK_NEW_REQUEST,
> +};
> +
>  /* The number of MMC physical partitions.  These consist of:
>   * boot partitions (2), general purpose partitions (4) in MMC v4.4.
>   */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 5bf7c22..495d133 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -120,6 +120,7 @@ struct mmc_data {
>  	s32			host_cookie;	/* host private data */
>  };
> 
> +struct mmc_host;
>  struct mmc_request {
>  	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
>  	struct mmc_command	*cmd;
> @@ -128,9 +129,9 @@ struct mmc_request {
> 
>  	struct completion	completion;
>  	void			(*done)(struct mmc_request *);/* completion function */
> +	struct mmc_host		*host;
>  };
> 
> -struct mmc_host;
>  struct mmc_card;
>  struct mmc_async_req;
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 61a10c1..82bf1a8 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -170,6 +170,22 @@ struct mmc_slot {
>  	void *handler_priv;
>  };
> 
> +/**
> + * mmc_context_info - synchronization details for mmc context
> + * @is_done_rcv		wake up reason was done request
> + * @is_new_req		wake up reason was new request
> + * @is_waiting_last_req	mmc context waiting for single running request
> + * @wait		wait queue
> + * @lock		lock to protect data fields
> + */
> +struct mmc_context_info {
> +	bool			is_done_rcv;
> +	bool			is_new_req;
> +	bool			is_waiting_last_req;
> +	wait_queue_head_t	wait;
> +	spinlock_t		lock;
> +};
> +
>  struct regulator;
> 
>  struct mmc_supply {
> @@ -331,6 +347,7 @@ struct mmc_host {
>  	struct dentry		*debugfs_root;
> 
>  	struct mmc_async_req	*areq;		/* active async req */
> +	struct mmc_context_info	context_info;	/* async synchronization info */
> 
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>  	struct fault_attr	fail_mmc_request;
> --
> 1.7.6
> --
> Konstantin Dorfman,
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
> Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

