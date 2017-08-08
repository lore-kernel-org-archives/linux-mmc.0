From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH V4 09/11] mmc: block: Add CQE support
Date: Tue, 8 Aug 2017 12:07:38 +0000
Message-ID: <AM4PR0401MB2324BC179C08C1CF2A2013E8908A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0073.outbound.protection.outlook.com ([104.47.1.73]:65353
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752623AbdHHMHm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Aug 2017 08:07:42 -0400
In-Reply-To: <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Friday, July 21, 2017 5:50 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>; Shawn=
 Lin
> <shawn.lin@rock-chips.com>
> Subject: [PATCH V4 09/11] mmc: block: Add CQE support
>=20
> Add CQE support to the block driver, including:
> 	- optionally using DCMD for flush requests
> 	- manually issuing discard requests
> 	- issuing read / write requests to the CQE
> 	- supporting block-layer timeouts
> 	- handling recovery
> 	- supporting re-tuning
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/block.c | 195 ++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/block.h |   7 ++
>  drivers/mmc/core/queue.c | 273
> ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/queue.h |  42 +++++++-
>  4 files changed, 510 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 915290c74363..2d25115637b7 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -109,6 +109,7 @@ struct mmc_blk_data {
>  #define MMC_BLK_WRITE		BIT(1)
>  #define MMC_BLK_DISCARD		BIT(2)
>  #define MMC_BLK_SECDISCARD	BIT(3)
> +#define MMC_BLK_CQE_RECOVERY	BIT(4)
>=20
>  	/*
>  	 * Only set in main mmc_blk_data associated @@ -1612,6 +1613,198
> @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct
> mmc_queue_req *mqrq,
>  		*do_data_tag_p =3D do_data_tag;
>  }
>=20
> +#define MMC_CQE_RETRIES 2
> +
> +void mmc_blk_cqe_complete_rq(struct request *req) {
> +	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq =3D &mqrq->brq.mrq;
> +	struct request_queue *q =3D req->q;
> +	struct mmc_queue *mq =3D q->queuedata;
> +	struct mmc_host *host =3D mq->card->host;
> +	unsigned long flags;
> +	bool put_card;
> +	int err;
> +
> +	mmc_cqe_post_req(host, mrq);
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +
> +	mq->cqe_in_flight[mmc_cqe_issue_type(host, req)] -=3D 1;
> +
> +	put_card =3D mmc_cqe_tot_in_flight(mq) =3D=3D 0;
> +
> +	if (mrq->cmd && mrq->cmd->error)
> +		err =3D mrq->cmd->error;
> +	else if (mrq->data && mrq->data->error)
> +		err =3D mrq->data->error;
> +	else
> +		err =3D 0;
> +
> +	if (err) {
> +		if (mqrq->retries++ < MMC_CQE_RETRIES)
> +			blk_requeue_request(q, req);
> +		else
> +			__blk_end_request_all(req, BLK_STS_IOERR);
> +	} else if (mrq->data) {
> +		if (__blk_end_request(req, BLK_STS_OK, mrq->data-
> >bytes_xfered))
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
> +void mmc_blk_cqe_recovery(struct mmc_queue *mq) {
> +	struct mmc_card *card =3D mq->card;
> +	struct mmc_host *host =3D card->host;
> +	int err;
> +
> +	mmc_get_card(card);
> +
> +	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
> +
> +	mq->cqe_in_recovery =3D true;
> +
> +	err =3D mmc_cqe_recovery(host);
> +	if (err)
> +		mmc_blk_reset(mq->blkdata, host,
> MMC_BLK_CQE_RECOVERY);
> +	else
> +		mmc_blk_reset_success(mq->blkdata,
> MMC_BLK_CQE_RECOVERY);
> +
> +	mq->cqe_in_recovery =3D false;
> +
> +	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
> +
> +	mmc_put_card(card);
> +}
> +
> +static void mmc_blk_cqe_req_done(struct mmc_request *mrq) {
> +	struct mmc_queue_req *mqrq =3D container_of(mrq, struct
> mmc_queue_req,
> +						  brq.mrq);
> +	struct request *req =3D mmc_queue_req_to_req(mqrq);
> +	struct request_queue *q =3D req->q;
> +	struct mmc_queue *mq =3D q->queuedata;
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
> +static int mmc_blk_cqe_start_req(struct mmc_host *host, struct
> +mmc_request *mrq) {
> +	mrq->done =3D mmc_blk_cqe_req_done;
> +	return mmc_cqe_start_req(host, mrq);
> +}
> +
> +static struct mmc_request *mmc_blk_cqe_prep_dcmd(struct
> mmc_queue_req *mqrq,
> +						 struct request *req)
> +{
> +	struct mmc_blk_request *brq =3D &mqrq->brq;
> +
> +	memset(brq, 0, sizeof(*brq));
> +
> +	brq->mrq.cmd =3D &brq->cmd;
> +	brq->mrq.tag =3D req->tag;
> +
> +	return &brq->mrq;
> +}
> +
> +static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request
> +*req) {
> +	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq =3D mmc_blk_cqe_prep_dcmd(mqrq, req);
> +
> +	mrq->cmd->opcode =3D MMC_SWITCH;
> +	mrq->cmd->arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +			(EXT_CSD_FLUSH_CACHE << 16) |
> +			(1 << 8) |
> +			EXT_CSD_CMD_SET_NORMAL;
> +	mrq->cmd->flags =3D MMC_CMD_AC | MMC_RSP_R1B;
> +
> +	return mmc_blk_cqe_start_req(mq->card->host, mrq); }
> +
> +static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request
> +*req) {
> +	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
> +
> +	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
> +
> +	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq); }
> +
> +enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq, struct
> +request *req) {
> +	struct mmc_blk_data *md =3D mq->blkdata;
> +	struct mmc_card *card =3D md->queue.card;
> +	struct mmc_host *host =3D card->host;
> +	int ret;
> +
> +	ret =3D mmc_blk_part_switch(card, md);
> +	if (ret)
> +		return MMC_REQ_FAILED_TO_START;
> +
> +	switch (mmc_cqe_issue_type(host, req)) {
> +	case MMC_ISSUE_SYNC:
> +		ret =3D host->cqe_ops->cqe_wait_for_idle(host);
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
> +			ret =3D mmc_blk_cqe_issue_flush(mq, req);
> +			break;
> +		case REQ_OP_READ:
> +		case REQ_OP_WRITE:
> +			ret =3D mmc_blk_cqe_issue_rw_rq(mq, req);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			ret =3D -EINVAL;
> +		}
> +		if (!ret)
> +			return MMC_REQ_STARTED;
> +		return ret =3D=3D -EBUSY ? MMC_REQ_BUSY :
> MMC_REQ_FAILED_TO_START;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return MMC_REQ_FAILED_TO_START;
> +	}
> +}
> +
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			       struct mmc_card *card,
>  			       int disable_multi,
> @@ -2035,7 +2228,7 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>  	INIT_LIST_HEAD(&md->part);
>  	md->usage =3D 1;
>=20
> -	ret =3D mmc_init_queue(&md->queue, card, &md->lock, subname);
> +	ret =3D mmc_init_queue(&md->queue, card, &md->lock, subname,
> area_type);
>  	if (ret)
>  		goto err_putdisk;
>=20
> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h index
> 860ca7c8df86..d7b3d7008b00 100644
> --- a/drivers/mmc/core/block.h
> +++ b/drivers/mmc/core/block.h
> @@ -6,4 +6,11 @@
>=20
>  void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
>=20
> +enum mmc_issued;
> +
> +enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq,
> +				     struct request *req);
> +void mmc_blk_cqe_complete_rq(struct request *rq); void
> +mmc_blk_cqe_recovery(struct mmc_queue *mq);
> +
>  #endif
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index
> affa7370ba82..0cb7b0e8ee58 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -36,10 +36,254 @@ static int mmc_prep_request(struct request_queue *q,
> struct request *req)
>  		return BLKPREP_KILL;
>=20
>  	req->rq_flags |=3D RQF_DONTPREP;
> +	req_to_mmc_queue_req(req)->retries =3D 0;
>=20
>  	return BLKPREP_OK;
>  }
>=20
> +static void mmc_cqe_request_fn(struct request_queue *q) {
> +	struct mmc_queue *mq =3D q->queuedata;
> +	struct request *req;
> +
> +	if (!mq) {
> +		while ((req =3D blk_fetch_request(q)) !=3D NULL) {
> +			req->rq_flags |=3D RQF_QUIET;
> +			__blk_end_request_all(req, BLK_STS_IOERR);
> +		}
> +		return;
> +	}
> +
> +	if (mq->asleep && !mq->cqe_busy)
> +		wake_up_process(mq->thread);
> +}
> +
> +static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq) {
> +	/* Allow only 1 DCMD at a time */
> +	return mq->cqe_in_flight[MMC_ISSUE_DCMD];
> +}
> +
> +void mmc_cqe_kick_queue(struct mmc_queue *mq) {
> +	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY)
> && !mmc_cqe_dcmd_busy(mq))
> +		mq->cqe_busy &=3D ~MMC_CQE_DCMD_BUSY;
> +
> +	mq->cqe_busy &=3D ~MMC_CQE_QUEUE_FULL;
> +
> +	if (mq->asleep && !mq->cqe_busy)
> +		__blk_run_queue(mq->queue);
> +}
> +
> +static inline bool mmc_cqe_can_dcmd(struct mmc_host *host) {
> +	return host->caps2 & MMC_CAP2_CQE_DCMD; }
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
> +		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD :
> MMC_ISSUE_SYNC;
> +	default:
> +		return MMC_ISSUE_ASYNC;
> +	}
> +}
> +
> +static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq) {
> +	if (!mq->cqe_recovery_needed) {
> +		mq->cqe_recovery_needed =3D true;
> +		wake_up_process(mq->thread);
> +	}
> +}
> +
> +static void mmc_cqe_recovery_notifier(struct mmc_host *host,
> +				      struct mmc_request *mrq)
> +{
> +	struct mmc_queue_req *mqrq =3D container_of(mrq, struct
> mmc_queue_req,
> +						  brq.mrq);
> +	struct request *req =3D mmc_queue_req_to_req(mqrq);
> +	struct request_queue *q =3D req->q;
> +	struct mmc_queue *mq =3D q->queuedata;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	__mmc_cqe_recovery_notifier(mq);
> +	spin_unlock_irqrestore(q->queue_lock, flags); }
> +
> +static int mmc_cqe_thread(void *d)
> +{
> +	struct mmc_queue *mq =3D d;
> +	struct request_queue *q =3D mq->queue;
> +	struct mmc_card *card =3D mq->card;
> +	struct mmc_host *host =3D card->host;
> +	unsigned long flags;
> +	int get_put =3D 0;
> +
> +	current->flags |=3D PF_MEMALLOC;
> +
> +	down(&mq->thread_sem);
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	while (1) {
> +		struct request *req =3D NULL;
> +		enum mmc_issue_type issue_type;
> +		bool retune_ok =3D false;
> +
> +		if (mq->cqe_recovery_needed) {
> +			spin_unlock_irqrestore(q->queue_lock, flags);
> +			mmc_blk_cqe_recovery(mq);
> +			spin_lock_irqsave(q->queue_lock, flags);
> +			mq->cqe_recovery_needed =3D false;
> +		}
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (!kthread_should_stop())
> +			req =3D blk_peek_request(q);
> +
> +		if (req) {
> +			issue_type =3D mmc_cqe_issue_type(host, req);
> +			switch (issue_type) {
> +			case MMC_ISSUE_DCMD:
> +				if (mmc_cqe_dcmd_busy(mq)) {
> +					mq->cqe_busy |=3D
> MMC_CQE_DCMD_BUSY;
> +					req =3D NULL;
> +					break;
> +				}
> +				/* Fall through */
> +			case MMC_ISSUE_ASYNC:
> +				if (blk_queue_start_tag(q, req)) {
> +					mq->cqe_busy |=3D
> MMC_CQE_QUEUE_FULL;
> +					req =3D NULL;
> +				}
> +				break;
> +			default:
> +				/*
> +				 * Timeouts are handled by mmc core, so set a
> +				 * large value to avoid races.
> +				 */
> +				req->timeout =3D 600 * HZ;
> +				blk_start_request(req);
> +				break;
> +			}
> +			if (req) {
> +				mq->cqe_in_flight[issue_type] +=3D 1;
> +				if (mmc_cqe_tot_in_flight(mq) =3D=3D 1)
> +					get_put +=3D 1;
> +				if (mmc_cqe_qcnt(mq) =3D=3D 1)
> +					retune_ok =3D true;
> +			}
> +		}
> +
> +		mq->asleep =3D !req;
> +
> +		spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +		if (req) {
> +			enum mmc_issued issued;
> +
> +			set_current_state(TASK_RUNNING);
> +
> +			if (get_put) {
> +				get_put =3D 0;
> +				mmc_get_card(card);
> +			}
> +
> +			if (host->need_retune && retune_ok &&
> +			    !host->hold_retune)
> +				host->retune_now =3D true;
> +			else
> +				host->retune_now =3D false;
> +
> +			issued =3D mmc_blk_cqe_issue_rq(mq, req);
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
> +				mq->cqe_in_flight[issue_type] -=3D 1;
> +				if (mmc_cqe_tot_in_flight(mq) =3D=3D 0)
> +					get_put =3D -1;
> +			}
> +		} else {
> +			if (get_put < 0) {
> +				get_put =3D 0;
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
> +static enum blk_eh_timer_return __mmc_cqe_timed_out(struct request
> +*req) {
> +	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
> +	struct mmc_request *mrq =3D &mqrq->brq.mrq;
> +	struct mmc_queue *mq =3D req->q->queuedata;
> +	struct mmc_host *host =3D mq->card->host;
> +	enum mmc_issue_type issue_type =3D mmc_cqe_issue_type(host, req);
> +	bool recovery_needed =3D false;
> +
> +	switch (issue_type) {
> +	case MMC_ISSUE_ASYNC:
> +	case MMC_ISSUE_DCMD:
> +		if (host->cqe_ops->cqe_timeout(host, mrq,
> &recovery_needed)) {
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
> +	struct mmc_queue *mq =3D req->q->queuedata;
> +
> +	if (mq->cqe_recovery_needed)
> +		return BLK_EH_RESET_TIMER;
> +
> +	return __mmc_cqe_timed_out(req);
> +}
> +
>  static int mmc_queue_thread(void *d)
>  {
>  	struct mmc_queue *mq =3D d;
> @@ -233,11 +477,12 @@ static void mmc_exit_request(struct request_queue
> *q, struct request *req)
>   * Initialise a MMC card request queue.
>   */
>  int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> -		   spinlock_t *lock, const char *subname)
> +		   spinlock_t *lock, const char *subname, int area_type)
>  {
>  	struct mmc_host *host =3D card->host;
>  	u64 limit =3D BLK_BOUNCE_HIGH;
>  	int ret =3D -ENOMEM;
> +	bool use_cqe =3D host->cqe_enabled && area_type !=3D
> +MMC_BLK_DATA_AREA_RPMB;
>=20
>  	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>  		limit =3D (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> @@ -247,7 +492,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct
> mmc_card *card,
>  	if (!mq->queue)
>  		return -ENOMEM;
>  	mq->queue->queue_lock =3D lock;
> -	mq->queue->request_fn =3D mmc_request_fn;
> +	mq->queue->request_fn =3D use_cqe ? mmc_cqe_request_fn :
> mmc_request_fn;
>  	mq->queue->init_rq_fn =3D mmc_init_request;
>  	mq->queue->exit_rq_fn =3D mmc_exit_request;
>  	mq->queue->cmd_size =3D sizeof(struct mmc_queue_req); @@ -259,6
> +504,24 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card
> *card,
>  		return ret;
>  	}
>=20
> +	if (use_cqe) {
> +		int q_depth =3D card->ext_csd.cmdq_depth;
> +
> +		if (q_depth > host->cqe_qdepth)
> +			q_depth =3D host->cqe_qdepth;
> +
> +		ret =3D blk_queue_init_tags(mq->queue, q_depth, NULL,
> +					  BLK_TAG_ALLOC_FIFO);
> +		if (ret)
> +			goto cleanup_queue;
> +
> +		blk_queue_softirq_done(mq->queue,
> mmc_blk_cqe_complete_rq);
> +		blk_queue_rq_timed_out(mq->queue, mmc_cqe_timed_out);
> +		blk_queue_rq_timeout(mq->queue, 60 * HZ);

Hi Adrian,=20

These days I'm doing CMDQ stress test, and find one issue.
On our i.MX8QXP-ARM2 board, the RAM is 3GB. eMMC is 32GB.=20
I use command 'free -m' get the total memory is 2800M, and the free memory =
is 2500M.

I use 'mkfs.ext4' to format ext4 file system on the eMMC under HS400ES CMDQ=
 mode, works fine.

When I use the following command to stress test CMDQ, it works fine.
bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 2048 -r 1024

But when I change to use a large file size to do the same stress test, usin=
g=20
bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 4096 -r 2048
or
bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 5600

I get the following dump message.  According to the log, mmc_cqe_timed_out(=
) was trigged.
Seems mmc was blocked in somewhere.
Then I try to debug this issue, and open MMC_DEBUG in config, do the same t=
est, print the detail
Command sending information on the console, but finally can't reproduce.

Shawn,
Can you have a try on your side?


[  738.385610] mmc0: cqhci: timeout for tag 1
[  738.389719] mmc0: cqhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CQHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  738.396164] mmc0: cqhci: Caps:      0x0000310a | Version:  0x00000510
[  738.402601] mmc0: cqhci: Config:    0x00001001 | Control:  0x00000000
[  738.409038] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
[  738.415475] mmc0: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
[  738.421913] mmc0: cqhci: TDL base:  0x9007a000 | TDL up32: 0x00000000
[  738.428350] mmc0: cqhci: Doorbell:  0x1fffffff | TCN:      0x00000000
[  738.434788] mmc0: cqhci: Dev queue: 0x1f7fffff | Dev Pend: 0x1fffefff
[  738.441226] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
[  738.447663] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
[  738.454100] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
[  738.460538] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
[  738.466975] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  738.473414] mmc0: sdhci: Sys addr:  0xb6512000 | Version:  0x00000002
[  738.479850] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
[  738.486288] mmc0: sdhci: Argument:  0x000c0400 | Trn mode: 0x00000023
[  738.492725] mmc0: sdhci: Present:   0x01fd858f | Host ctl: 0x00000030
[  738.499162] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  738.505600] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
[  738.512037] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[  738.518475] mmc0: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
[  738.524912] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
[  738.531350] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[  738.537787] mmc0: sdhci: Cmd:       0x00002c1a | Max curr: 0x00ffffff
[  738.544225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[  738.550662] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
[  738.557099] mmc0: sdhci: Host ctl2: 0x00000008
[  738.561540] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x90098400
[  738.567975] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  738.574449] mmc0: running CQE recovery
[  738.593643] mmc0: Unexpected interrupt 0x00004000.
[  738.598436] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  738.604881] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
[  738.611318] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
[  738.617756] mmc0: sdhci: Argument:  0x01af6800 | Trn mode: 0x00000023
[  738.624193] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
[  738.630630] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  738.637068] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
[  738.643505] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00004000
[  738.649943] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
[  738.656380] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
[  738.662818] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[  738.669255] mmc0: sdhci: Cmd:       0x00002d12 | Max curr: 0x00ffffff
[  738.675693] mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0xffffffff
[  738.682130] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
[  738.688566] mmc0: sdhci: Host ctl2: 0x00000008
[  738.693008] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
[  738.699443] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  738.715999] mmc0: Controller never released inhibit bit(s).
[  738.721573] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  738.728018] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
[  738.734455] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
[  738.740892] mmc0: sdhci: Argument:  0x01af6800 | Trn mode: 0x00000023
[  738.747330] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
[  738.753767] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  738.760204] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
[  738.766642] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00004000
[  738.773079] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
[  738.779517] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
[  738.785955] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[  738.792392] mmc0: sdhci: Cmd:       0x00002d12 | Max curr: 0x00ffffff
[  738.798829] mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0xffffffff
[  738.805266] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
[  738.811703] mmc0: sdhci: Host ctl2: 0x00000008
[  738.816144] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
[  738.822579] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  748.881580] mmc0: Timeout waiting for hardware interrupt.
......


> +
> +		host->cqe_recovery_notifier =3D mmc_cqe_recovery_notifier;
> +	}
> +
>  	blk_queue_prep_rq(mq->queue, mmc_prep_request);
>  	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
>  	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq-
> >queue); @@ -280,9 +543,9 @@ int mmc_init_queue(struct mmc_queue *mq,
> struct mmc_card *card,
>=20
>  	sema_init(&mq->thread_sem, 1);
>=20
> -	mq->thread =3D kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
> -		host->index, subname ? subname : "");
> -
> +	mq->thread =3D kthread_run(use_cqe ? mmc_cqe_thread :
> mmc_queue_thread,
> +				 mq, "mmcqd/%d%s", host->index,
> +				 subname ? subname : "");
>  	if (IS_ERR(mq->thread)) {
>  		ret =3D PTR_ERR(mq->thread);
>  		goto cleanup_queue;
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h index
> 361b46408e0f..8e9273d977c0 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -7,6 +7,20 @@
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/host.h>
>=20
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
>  static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request
> *rq)  {
>  	return blk_mq_rq_to_pdu(rq);
> @@ -53,6 +67,7 @@ struct mmc_queue_req {
>  	int			drv_op_result;
>  	struct mmc_blk_ioc_data	**idata;
>  	unsigned int		ioc_count;
> +	int			retries;
>  };
>=20
>  struct mmc_queue {
> @@ -70,10 +85,17 @@ struct mmc_queue {
>  	 * associated mmc_queue_req data.
>  	 */
>  	int			qcnt;
> +	/* Following are defined for a Command Queue Engine */
> +	int			cqe_in_flight[MMC_ISSUE_MAX];
> +	unsigned int		cqe_busy;
> +	bool			cqe_recovery_needed;
> +	bool			cqe_in_recovery;
> +#define MMC_CQE_DCMD_BUSY	BIT(0)
> +#define MMC_CQE_QUEUE_FULL	BIT(1)
>  };
>=20
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *,
> spinlock_t *,
> -			  const char *);
> +			  const char *, int);
>  extern void mmc_cleanup_queue(struct mmc_queue *);  extern void
> mmc_queue_suspend(struct mmc_queue *);  extern void
> mmc_queue_resume(struct mmc_queue *); @@ -85,4 +107,22 @@ extern
> unsigned int mmc_queue_map_sg(struct mmc_queue *,
>=20
>  extern int mmc_access_rpmb(struct mmc_queue *);
>=20
> +void mmc_cqe_kick_queue(struct mmc_queue *mq);
> +
> +enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
> +				       struct request *req);
> +
> +static inline int mmc_cqe_tot_in_flight(struct mmc_queue *mq) {
> +	return mq->cqe_in_flight[MMC_ISSUE_SYNC] +
> +	       mq->cqe_in_flight[MMC_ISSUE_DCMD] +
> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
> +}
> +
> +static inline int mmc_cqe_qcnt(struct mmc_queue *mq) {
> +	return mq->cqe_in_flight[MMC_ISSUE_DCMD] +
> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
> +}
> +
>  #endif
> --
> 1.9.1

