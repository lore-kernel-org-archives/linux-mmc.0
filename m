From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH v2] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 5 Nov 2012 07:20:24 +0100
Message-ID: <50975AA8.8030304@stericsson.com>
References: <n> <1351780852-1293-1-git-send-email-kdorfman@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:55745 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab2KEGU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Nov 2012 01:20:58 -0500
In-Reply-To: <1351780852-1293-1-git-send-email-kdorfman@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "per.lkml@gmail.com" <per.lkml@gmail.com>

Hi Konstantin,

On 11/01/2012 03:40 PM, Konstantin Dorfman wrote:
> When current request is running on the bus and if next request fetched
> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
> current request completes. This means if new request comes in while
> the mmcqd thread is blocked, this new request can not be prepared in
> parallel to current ongoing request. This may result in latency to
> start new request.
> 
> This change allows to wake up the MMC thread (which
> is waiting for the current running request to complete). Now once the
> MMC thread is woken up, new request can be fetched and prepared in
> parallel to current running request which means this new request can
> be started immediately after the current running request completes.
> 
> With this change read throughput is improved by 16%.
What HW and what test cases have you been running?

> 
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> ---
Please add a change log here with a brief description of the changes since last version

>  drivers/mmc/card/block.c |   26 +++++-------
>  drivers/mmc/card/queue.c |   26 ++++++++++-
>  drivers/mmc/card/queue.h |    3 +
>  drivers/mmc/core/core.c  |  102 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h |   12 +++++
>  include/linux/mmc/core.h |   15 +++++++
>  6 files changed, 163 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 172a768..0e9bedb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -112,17 +112,6 @@ struct mmc_blk_data {
> 
>  static DEFINE_MUTEX(open_lock);
> 
> -enum mmc_blk_status {
> -       MMC_BLK_SUCCESS = 0,
> -       MMC_BLK_PARTIAL,
> -       MMC_BLK_CMD_ERR,
> -       MMC_BLK_RETRY,
> -       MMC_BLK_ABORT,
> -       MMC_BLK_DATA_ERR,
> -       MMC_BLK_ECC_ERR,
> -       MMC_BLK_NOMEDIUM,
> -};
> -
>  module_param(perdev_minors, int, 0444);
>  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
> 
> @@ -1225,6 +1214,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> 
>         mqrq->mmc_active.mrq = &brq->mrq;
>         mqrq->mmc_active.err_check = mmc_blk_err_check;
> +       mqrq->mmc_active.mrq->context_info = &mq->context_info;
> 
>         mmc_queue_bounce_pre(mqrq);
>  }
> @@ -1284,9 +1274,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                         areq = &mq->mqrq_cur->mmc_active;
>                 } else
>                         areq = NULL;
> -               areq = mmc_start_req(card->host, areq, (int *) &status);
> -               if (!areq)
> +               areq = mmc_start_req(card->host, areq, (int *)&status);
> +               if (!areq) {
> +                       if (status == MMC_BLK_NEW_REQUEST)
> +                               mq->flags |= MMC_QUEUE_NEW_REQUEST;
>                         return 0;
> +               }
> 
>                 mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
>                 brq = &mq_rq->brq;
> @@ -1295,6 +1288,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                 mmc_queue_bounce_post(mq_rq);
> 
>                 switch (status) {
> +               case MMC_BLK_NEW_REQUEST:
> +                       BUG_ON(1); /* should never get here */
>                 case MMC_BLK_SUCCESS:
>                 case MMC_BLK_PARTIAL:
>                         /*
> @@ -1367,7 +1362,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                          * prepare it again and resend.
>                          */
>                         mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
> -                       mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
> +                       mmc_start_req(card->host, &mq_rq->mmc_active, (int *)&status);
>                 }
>         } while (ret);
> 
> @@ -1406,6 +1401,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>                 ret = 0;
>                 goto out;
>         }
> +       mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> 
>         if (req && req->cmd_flags & REQ_DISCARD) {
>                 /* complete ongoing async transfer before issuing discard */
> @@ -1426,7 +1422,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>         }
> 
>  out:
> -       if (!req)
> +       if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
>                 /* release host only when there are no more requests */
>                 mmc_release_host(card->host);
>         return ret;
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index fadf52e..7375476 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -22,7 +22,6 @@
> 
>  #define MMC_QUEUE_BOUNCESZ     65536
> 
> -#define MMC_QUEUE_SUSPENDED    (1 << 0)
> 
>  /*
>   * Prepare a MMC request. This just filters out odd stuff.
> @@ -63,11 +62,17 @@ static int mmc_queue_thread(void *d)
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 req = blk_fetch_request(q);
>                 mq->mqrq_cur->req = req;
> +               if (!req && mq->mqrq_prev->req)
> +                       mq->context_info.is_waiting_last_req = true;
>                 spin_unlock_irq(q->queue_lock);
> 
>                 if (req || mq->mqrq_prev->req) {
>                         set_current_state(TASK_RUNNING);
>                         mq->issue_fn(mq, req);
> +                       if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
> +                               mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> +                               continue; /* fetch again */
> +                       }
> 
>                         /*
>                          * Current request becomes previous request
> @@ -111,8 +116,19 @@ static void mmc_request_fn(struct request_queue *q)
>                 }
>                 return;
>         }
> -
> -       if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
> +       if (!mq->mqrq_cur->req && mq->mqrq_prev->req &&
> +           !(mq->mqrq_prev->req->cmd_flags & REQ_FLUSH) &&
> +           !(mq->mqrq_prev->req->cmd_flags & REQ_DISCARD)) {
> +               /*
> +                * New MMC request arrived when MMC thread may be
> +                * blocked on the previous request to be complete
> +                * with no current request fetched
> +                */
> +               if (mq->context_info.is_waiting_last_req) {
> +                       mq->context_info.is_new_req = true;
> +                       wake_up_interruptible(&mq->context_info.wait);
> +               }
> +       } else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
>                 wake_up_process(mq->thread);
>  }
> 
> @@ -262,6 +278,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         }
> 
>         sema_init(&mq->thread_sem, 1);
> +       mq->context_info.is_new_req = false;
> +       mq->context_info.is_done_rcv = false;
> +       mq->context_info.is_waiting_last_req = false;
> +       init_waitqueue_head(&mq->context_info.wait);
> 
>         mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
>                 host->index, subname ? subname : "");
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d2a1eb4..f5885e9 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -26,6 +26,8 @@ struct mmc_queue {
>         struct mmc_card         *card;
>         struct task_struct      *thread;
>         struct semaphore        thread_sem;
> +#define MMC_QUEUE_SUSPENDED    (1 << 0)
> +#define MMC_QUEUE_NEW_REQUEST  (1 << 1)
>         unsigned int            flags;
>         int                     (*issue_fn)(struct mmc_queue *, struct request *);
>         void                    *data;
> @@ -33,6 +35,7 @@ struct mmc_queue {
>         struct mmc_queue_req    mqrq[2];
>         struct mmc_queue_req    *mqrq_cur;
>         struct mmc_queue_req    *mqrq_prev;
> +       struct mmc_context_info context_info;
>  };
> 
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06c42cf..a24d298 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -316,11 +316,43 @@ out:
>  }
>  EXPORT_SYMBOL(mmc_start_bkops);
> 
> +/*
> + * mmc_wait_data_done() - done callback for data request
> + * @mrq: done data request
> + *
> + * Wakes up mmc context, passed as callback to host controller driver
> + */
> +static void mmc_wait_data_done(struct mmc_request *mrq)
> +{
> +       mrq->context_info->is_done_rcv = true;
> +       wake_up_interruptible(&mrq->context_info->wait);
> +}
> +
>  static void mmc_wait_done(struct mmc_request *mrq)
>  {
>         complete(&mrq->completion);
>  }
> 
> +/*
> + *__mmc_start_data_req() - starts data request
> + * @host: MMC host to start the request
> + * @mrq: data request to start
> + *
> + * Fills done callback that will be used when request are done by card.
> + * Starts data mmc request execution
> + */
> +static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       mrq->done = mmc_wait_data_done;
> +       if (mmc_card_removed(host->card)) {
> +               mrq->cmd->error = -ENOMEDIUM;
> +               return -ENOMEDIUM;
> +       }
> +       mmc_start_request(host, mrq);
> +
> +       return 0;
> +}
> +
>  static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
>         init_completion(&mrq->completion);
> @@ -334,6 +366,57 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>         return 0;
>  }
> 
> +/*
> + * mmc_wait_for_data_req_done() - wait for request completed or new
> + *                               request notification arrives
> + * @host: MMC host to prepare the command.
> + * @mrq: MMC request to wait for
> + *
> + * Blocks MMC context till host controller will ack end of data request
> + * execution or new request arrives from block layer. Handles
> + * command retries.
> + *
> + * Returns enum mmc_blk_status after checking errors.
> + */
> +static int mmc_wait_for_data_req_done(struct mmc_host *host,
> +                                     struct mmc_request *mrq)
> +{
> +       struct mmc_command *cmd;
> +       struct mmc_context_info *context_info = mrq->context_info;
> +       int err;
> +
> +       while (1) {
> +               wait_event_interruptible(context_info->wait,
> +                               (context_info->is_done_rcv ||
> +                                context_info->is_new_req));
> +               context_info->is_waiting_last_req = false;
> +               if (context_info->is_done_rcv) {
> +                       context_info->is_done_rcv = false;
> +                       context_info->is_new_req = false;
> +                       cmd = mrq->cmd;
> +                       if (!cmd->error || !cmd->retries ||
> +                                       mmc_card_removed(host->card)) {
> +                               err = host->areq->err_check(host->card,
> +                                               host->areq);
> +                               break; /* return err */
> +                       } else {
> +                               pr_info("%s: req failed (CMD%u): %d, retrying...\n",
> +                                               mmc_hostname(host),
> +                                               cmd->opcode, cmd->error);
> +                               cmd->retries--;
> +                               cmd->error = 0;
> +                               host->ops->request(host, mrq);
> +                               continue; /* wait for done/new event again */
> +                       }
> +               } else if (context_info->is_new_req) {
> +                       context_info->is_new_req = false;
> +                       err = MMC_BLK_NEW_REQUEST;
> +                       break; /* return err */
> +               }
> +       } /* while */
> +       return err;
> +}
> +
>  static void mmc_wait_for_req_done(struct mmc_host *host,
>                                   struct mmc_request *mrq)
>  {
> @@ -423,8 +506,20 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>                 mmc_pre_req(host, areq->mrq, !host->areq);
> 
>         if (host->areq) {
> -               mmc_wait_for_req_done(host, host->areq->mrq);
> -               err = host->areq->err_check(host->card, host->areq);
> +               err = mmc_wait_for_data_req_done(host, host->areq->mrq);
> +               if (err == MMC_BLK_NEW_REQUEST) {
> +                       if (areq) {
> +                               pr_err("%s: new request while areq = %p",
> +                                               mmc_hostname(host), areq);
> +                               BUG_ON(1);
> +                       }
> +                       *error = err;
> +                       /*
> +                        * The previous request was not completed,
> +                        * nothing to return
> +                        */
> +                       return NULL;
> +               }
>                 /*
>                  * Check BKOPS urgency for each R1 response
>                  */
> @@ -436,7 +531,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>         }
> 
>         if (!err && areq)
> -               start_err = __mmc_start_req(host, areq->mrq);
> +               start_err = __mmc_start_data_req(host, areq->mrq);
> 
>         if (host->areq)
>                 mmc_post_req(host, host->areq->mrq, 0);
> @@ -452,6 +547,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> 
>         if (error)
>                 *error = err;
> +
>         return data;
>  }
>  EXPORT_SYMBOL(mmc_start_req);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 943550d..9681d8f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -186,6 +186,18 @@ struct sdio_func_tuple;
> 
>  #define SDIO_MAX_FUNCS         7
> 
> +enum mmc_blk_status {
> +       MMC_BLK_SUCCESS = 0,
> +       MMC_BLK_PARTIAL,
> +       MMC_BLK_CMD_ERR,
> +       MMC_BLK_RETRY,
> +       MMC_BLK_ABORT,
> +       MMC_BLK_DATA_ERR,
> +       MMC_BLK_ECC_ERR,
> +       MMC_BLK_NOMEDIUM,
> +       MMC_BLK_NEW_REQUEST,
> +};
> +
>  /* The number of MMC physical partitions.  These consist of:
>   * boot partitions (2), general purpose partitions (4) in MMC v4.4.
>   */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 9b9cdaf..fc2d095 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -120,6 +120,20 @@ struct mmc_data {
>         s32                     host_cookie;    /* host private data */
>  };
> 
> +/**
> + * mmc_context_info - synchronization details for mmc context
> + * @is_done_rcv                wake up reason was done request
> + * @is_new_req wake up reason was new request
> + * @is_waiting_last_req        mmc context waiting for single running request
> + * @wait               wait queue
> + */
> +struct mmc_context_info {
> +       bool                    is_done_rcv;
> +       bool                    is_new_req;
> +       bool                    is_waiting_last_req;
> +       wait_queue_head_t       wait;
> +};
> +
>  struct mmc_request {
>         struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
>         struct mmc_command      *cmd;
> @@ -128,6 +142,7 @@ struct mmc_request {
> 
>         struct completion       completion;
>         void                    (*done)(struct mmc_request *);/* completion function */
> +       struct mmc_context_info    *context_info;
>  };
> 
>  struct mmc_host;
> --
> 1.7.6
> 

