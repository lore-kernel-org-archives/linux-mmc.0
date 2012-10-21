From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read scenarios
Date: Mon, 22 Oct 2012 01:02:59 +0200
Message-ID: <CAFEEs1mE9XfVM9=Nh7hD9pHZMpLbwAcofjUgZUGUMFKBjofJ-w@mail.gmail.com>
References: <1350315412-5595-1-git-send-email-kdorfman@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40345 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575Ab2JUXDB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Oct 2012 19:03:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1303576lbo.19
        for <linux-mmc@vger.kernel.org>; Sun, 21 Oct 2012 16:02:59 -0700 (PDT)
In-Reply-To: <1350315412-5595-1-git-send-email-kdorfman@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Mon, Oct 15, 2012 at 5:36 PM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> The main assumption of the async request design is that the file
> system adds block requests to the block device queue asynchronously
> without waiting for completion (see the Rationale section of
> https://wiki.linaro.org/WorkingGroups/Kernel/Specs
> /StoragePerfMMC-async-req).
>
> We found out that in case of sequential read operations this is not
> the case, due to the read ahead mechanism.
> When mmcqt reports on completion of a request there should be
> a context switch to allow the insertion of the next read ahead BIOs
> to the block layer. Since the mmcqd tries to fetch another request
> immediately after the completion of the previous request it gets NULL
> and starts waiting for the completion of the previous request.
> This wait on completion gives the FS the opportunity to insert the next
> request but the MMC layer is already blocked on the previous request
> completion and is not aware of the new request waiting to be fetched.
I thought that I could trigger a context switch in order to give
execution time for FS to add the new request to the MMC queue.
I made a simple hack to call yield() in case the request gets NULL. I
thought it may give the FS layer enough time to add a new request to
the MMC queue. This would not delay the MMC transfer since the yield()
is done in parallel with an ongoing transfer. Anyway it was just meant
to be a simple test.

One yield was not enough. Just for sanity check I added a msleep as
well and that was enough to let FS add a new request,
Would it be possible to gain throughput by delaying the fetch of new
request? Too avoid unnecessary NULL requests

If (ongoing request is read AND size is max read ahead AND new request
is NULL) yield();

BR
Per

>
> This patch fixes the above behavior and allows the async request mechanism
> to work in case of sequential read scenarios.
> The main idea is to replace the blocking wait for a completion with an
> event driven mechanism and add a new event of new_request.
> When the block layer notifies the MMC layer on a new request, we check
> for the above case where MMC layer is waiting on a previous request
> completion and the current request is NULL.
> In such a case the new_request event will be triggered to wakeup
> the waiting thread. MMC layer will then fetch the new request
> and after its preparation will go back to waiting on the completion.
>
> Our tests showed that this fix improves the read sequential throughput
> by 16%.
>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 172a768..4d6431b 100644
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
> @@ -1224,6 +1213,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>         }
>
>         mqrq->mmc_active.mrq = &brq->mrq;
> +       mqrq->mmc_active.mrq->sync_data = &mq->sync_data;
>         mqrq->mmc_active.err_check = mmc_blk_err_check;
>
>         mmc_queue_bounce_pre(mqrq);
> @@ -1284,9 +1274,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                         areq = &mq->mqrq_cur->mmc_active;
>                 } else
>                         areq = NULL;
> -               areq = mmc_start_req(card->host, areq, (int *) &status);
> -               if (!areq)
> +               areq = mmc_start_data_req(card->host, areq, (int *)&status);
> +               if (!areq) {
> +                       if (status == MMC_BLK_NEW_REQUEST)
> +                               return status;
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
> @@ -1367,7 +1362,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                          * prepare it again and resend.
>                          */
>                         mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
> -                       mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
> +                       mmc_start_data_req(card->host, &mq_rq->mmc_active,
> +                               (int *)&status);
>                 }
>         } while (ret);
>
> @@ -1382,7 +1378,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>   start_new_req:
>         if (rqc) {
>                 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> -               mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
> +               mmc_start_data_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
>         }
>
>         return 0;
> @@ -1426,9 +1422,10 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>         }
>
>  out:
> -       if (!req)
> +       if (!req && (ret != MMC_BLK_NEW_REQUEST))
>                 /* release host only when there are no more requests */
>                 mmc_release_host(card->host);
> +
>         return ret;
>  }
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..65cecf2 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -67,7 +67,8 @@ static int mmc_queue_thread(void *d)
>
>                 if (req || mq->mqrq_prev->req) {
>                         set_current_state(TASK_RUNNING);
> -                       mq->issue_fn(mq, req);
> +                       if (mq->issue_fn(mq, req) == MMC_BLK_NEW_REQUEST)
> +                               continue; /* fetch again */
>                 } else {
>                         if (kthread_should_stop()) {
>                                 set_current_state(TASK_RUNNING);
> @@ -98,6 +99,7 @@ static int mmc_queue_thread(void *d)
>   */
>  static void mmc_request_fn(struct request_queue *q)
>  {
> +       unsigned long flags;
>         struct mmc_queue *mq = q->queuedata;
>         struct request *req;
>
> @@ -108,9 +110,25 @@ static void mmc_request_fn(struct request_queue *q)
>                 }
>                 return;
>         }
> -
> -       if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
> -               wake_up_process(mq->thread);
> +       if (!mq->mqrq_cur->req && mq->mqrq_prev->req) {
> +               /*
> +                * New MMC request arrived when MMC thread may be
> +                * blocked on the previous request to be complete
> +                * with no current request fetched
> +                */
> +               mq->sync_data.should_skip_awake = false;
> +               /* critical section with mmc_wait_data_req_done() */
> +               spin_lock_irqsave(&mq->sync_data.lock, flags);
> +               /* do stop flow only when mmc thread is waiting for done */
> +               if (mq->sync_data.is_waiting &&
> +                               !mq->sync_data.is_new_req &&
> +                               !mq->sync_data.should_skip_awake) {
> +                       mq->sync_data.is_new_req = true;
> +                       wake_up_interruptible(&mq->sync_data.wait);
> +               }
> +               spin_unlock_irqrestore(&mq->sync_data.lock, flags);
> +       } else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
> +                       wake_up_process(mq->thread);
>  }
>
>  static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
> @@ -259,6 +277,12 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         }
>
>         sema_init(&mq->thread_sem, 1);
> +       spin_lock_init(&mq->sync_data.lock);
> +       mq->sync_data.should_skip_awake = false;
> +       mq->sync_data.is_new_req = false;
> +       mq->sync_data.is_done_rcv = false;
> +       mq->sync_data.is_waiting = false;
> +       init_waitqueue_head(&mq->sync_data.wait);
>
>         mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
>                 host->index, subname ? subname : "");
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d2a1eb4..bcccfd6 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -33,6 +33,7 @@ struct mmc_queue {
>         struct mmc_queue_req    mqrq[2];
>         struct mmc_queue_req    *mqrq_cur;
>         struct mmc_queue_req    *mqrq_prev;
> +       struct mmc_sync_data    sync_data;
>  };
>
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06c42cf..b93ea31 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -316,11 +316,49 @@ out:
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
> +       unsigned long flags;
> +
> +       /* critical section with  blk layer notifications */
> +       spin_lock_irqsave(&mrq->sync_data->lock, flags);
> +       mrq->sync_data->should_skip_awake = true;
> +       mrq->sync_data->is_done_rcv = true;
> +       wake_up_interruptible(&mrq->sync_data->wait);
> +       spin_unlock_irqrestore(&mrq->sync_data->lock, flags);
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
> @@ -334,6 +372,64 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
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
> +       struct mmc_sync_data *sync_data = mrq->sync_data;
> +       bool is_done_rcv = false;
> +       bool is_new_req = false;
> +       int err;
> +
> +       while (1) {
> +               sync_data->is_waiting = true;
> +               sync_data->is_new_req = false;
> +               wait_event_interruptible(sync_data->wait,
> +                               (sync_data->is_done_rcv ||
> +                                sync_data->is_new_req));
> +               sync_data->is_waiting = false;
> +               is_done_rcv = sync_data->is_done_rcv;
> +               is_new_req = sync_data->is_new_req;
> +               if (is_done_rcv) {
> +                       sync_data->is_done_rcv = false;
> +                       sync_data->is_new_req = false;
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
> +                               sync_data->is_done_rcv = false;
> +                               continue; /* wait for done/new event again */
> +                       }
> +               } else if (is_new_req) {
> +                       sync_data->is_new_req = false;
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
> @@ -396,6 +492,64 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
>  }
>
>  /**
> + * mmc_start_data_req - start a non-blocking data request
> + * @host: MMC host to start the command
> + * @areq: async request to start
> + * @error: out parameter; returns 0 for success, otherwise non zero
> + *
> + * Wait for the ongoing request (previoulsy started) to complete and
> + * return the completed request. If there is no ongoing request, NULL
> + * is returned without waiting. NULL is not an error condition.
> + */
> +struct mmc_async_req *mmc_start_data_req(struct mmc_host *host,
> +                                        struct mmc_async_req *areq, int *error)
> +{
> +       int err = 0;
> +       int start_err = 0;
> +       struct mmc_async_req *data = host->areq;
> +
> +       /* Prepare a new request */
> +       if (areq)
> +               mmc_pre_req(host, areq->mrq, !host->areq);
> +
> +       if (host->areq) {
> +               err = mmc_wait_for_data_req_done(host, host->areq->mrq);
> +               if (err == MMC_BLK_NEW_REQUEST) {
> +                       if (areq)
> +                               pr_err("%s: new request while areq = %p",
> +                                               mmc_hostname(host), areq);
> +                       *error = err;
> +                       /*
> +                        * The previous request was not completed,
> +                        * nothing to return
> +                        */
> +                       return NULL;
> +               }
> +       }
> +
> +       if (!err && areq)
> +               start_err = __mmc_start_data_req(host, areq->mrq);
> +
> +       if (host->areq)
> +               mmc_post_req(host, host->areq->mrq, 0);
> +
> +       /* Cancel a prepared request if it was not started. */
> +       if ((err || start_err) && areq)
> +               mmc_post_req(host, areq->mrq, -EINVAL);
> +
> +       if (err)
> +               host->areq = NULL;
> +       else
> +               host->areq = areq;
> +
> +       if (error)
> +               *error = err;
> +
> +       return data;
> +}
> +EXPORT_SYMBOL(mmc_start_data_req);
> +
> +/**
>   *     mmc_start_req - start a non-blocking request
>   *     @host: MMC host to start command
>   *     @areq: async request to start
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
> index 9b9cdaf..fdf4dac 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -120,6 +120,24 @@ struct mmc_data {
>         s32                     host_cookie;    /* host private data */
>  };
>
> +/**
> + * mmc_sync_data - synchronization details for mmc context
> + * @is_done_rcv                wake up reason was done request
> + * @is_new_req wake up reason was new request
> + * @should_skip_awake  done arrived, no need in wake up flag
> + * @is_waiting mmc context in waiting state flag
> + * @wait               wait queue
> + * @lock               spinlock to protect this struct
> + */
> +struct mmc_sync_data {
> +       bool                    is_done_rcv;
> +       bool                    is_new_req;
> +       bool                    should_skip_awake;
> +       bool                    is_waiting;
> +       wait_queue_head_t       wait;
> +       spinlock_t              lock;
> +};
> +
>  struct mmc_request {
>         struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
>         struct mmc_command      *cmd;
> @@ -128,6 +146,7 @@ struct mmc_request {
>
>         struct completion       completion;
>         void                    (*done)(struct mmc_request *);/* completion function */
> +       struct mmc_sync_data    *sync_data;
>  };
>
>  struct mmc_host;
> @@ -138,6 +157,8 @@ extern int mmc_stop_bkops(struct mmc_card *);
>  extern int mmc_read_bkops_status(struct mmc_card *);
>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>                                            struct mmc_async_req *, int *);
> +extern struct mmc_async_req *mmc_start_data_req(struct mmc_host *,
> +                                          struct mmc_async_req *, int *);
>  extern int mmc_interrupt_hpi(struct mmc_card *);
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
> --
> 1.7.6
> --
> Konstantin Dorfman,
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
