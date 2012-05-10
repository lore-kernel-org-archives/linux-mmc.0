From: kdorfman@codeaurora.org
Subject: Re: [PATCH v8] mmc: support BKOPS feature for eMMC
Date: Thu, 10 May 2012 07:46:40 -0700 (PDT)
Message-ID: <aa38953dd272014cd1c4d014ce9d15bd.squirrel@www.codeaurora.org>
References: <4FABC495.8060708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:52307 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab2EJOqm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 10:46:42 -0400
In-Reply-To: <4FABC495.8060708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi Jaehoon,
I see 2 issues with new patch:
1. New code starts BKOPS always with waiting for BUSY. (see comment below
in the code)
2. Runtime suspend (mmc_suspend_host) do not checks that BKOPS is in
progress,
this means, that CMD5 (slee) will fail.

> Enable eMMC background operations (BKOPS) feature.
>
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
> the BKOPS-STATUS vaule.
>
> If you want to enable this feature, set MMC_CAP2_BKOPS.
> And if you want to set the BKOPS_EN bit in ext_csd register,
> use the MMC_CAP2_INIT_BKOPS.
>
> When BKOPS_STATUS is Level-3, if we're waiting for done, it spent
> 60~80sec.
> So Added timeout value. if timeout value is set to 0, send hpi command.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog V8:
> 	- Remove host->lock spin lock reviewed by Adrian
> 	- Support periodic start bkops
> 	- when bkops_status is level-3, if timeout is set to 0, send hpi.
> 	- Move the start-bkops point
> Changelog V7:
> 	- Use HPI command when issued URGENT_BKOPS
> 	- Recheck until clearing the bkops-status bit.
> Changelog V6:
> 	- Add the flag of check-bkops-status.
> 	  (For fixing async_req problem)
> 	- Add the capability for MMC_CAP2_INIT_BKOPS.
> 	  (When unset the bkops_en bit in ext_csd register)
> 	- modify the wrong condition.
> Changelog V5:
> 	- Rebase based on the latest mmc-next.
> 	- modify codes based-on Chris's comment
> Changelog V4:
> 	- Add mmc_read_bkops_status
> 	- When URGENT_BKOPS(level2-3), didn't use HPI command.
> 	- In mmc_switch(), use R1B/R1 according to level.
> Changelog V3:
> 	- move the bkops setting's location in mmc_blk_issue_rw_rq
> 	- modify condition checking
> 	- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
> 	- remove the unused code
> 	- change pr_debug instead of pr_warn in mmc_send_hpi_cmd
> 	- Add the Future consideration suggested by Per
> Changelog V2:
> 	- Use EXCEPTION_STATUS instead of URGENT_BKOPS
> 	- Add function to check Exception_status(for eMMC4.5)
> ---
>  drivers/mmc/card/queue.c   |    2 +
>  drivers/mmc/core/core.c    |  170
> +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/host.c    |    1 +
>  drivers/mmc/core/mmc.c     |   18 +++++
>  drivers/mmc/core/mmc_ops.c |    4 +
>  include/linux/mmc/card.h   |   16 ++++
>  include/linux/mmc/core.h   |    5 ++
>  include/linux/mmc/host.h   |    4 +
>  include/linux/mmc/mmc.h    |   20 +++++
>  9 files changed, 238 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..e4a2cde 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
>  		spin_unlock_irq(q->queue_lock);
>
>  		if (req || mq->mqrq_prev->req) {
> +			if (mmc_card_doing_bkops(mq->card))
> +				mmc_stop_bkops(mq->card);
>  			set_current_state(TASK_RUNNING);
>  			mq->issue_fn(mq, req);
>  		} else {
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..91a03d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -175,6 +175,13 @@ void mmc_request_done(struct mmc_host *host, struct
> mmc_request *mrq)
>  		if (mrq->done)
>  			mrq->done(mrq);
>
> +		/*
> +		 * Check BKOPS urgency from each R1 response
> +		 */
> +		if (host->card && mmc_card_mmc(host->card) &&
> +			(cmd->resp[0] & R1_EXCEPTION_EVENT))
> +			mmc_card_set_check_bkops(host->card);
> +
>  		mmc_host_clk_release(host);
>  	}
>  }
> @@ -245,6 +252,76 @@ mmc_start_request(struct mmc_host *host, struct
> mmc_request *mrq)
>  	host->ops->request(host, mrq);
>  }
>
> +static void mmc_send_bkops_cmd(struct mmc_card *card)
> +{
> +	int err;
> +
> +	BUG_ON(!card);
> +
> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_BKOPS_START, 1, 0);
> +	if (err) {
> +		pr_warning("%s: error %d starting bkops\n",
> +			   mmc_hostname(card->host), err);
> +		mmc_card_clr_need_bkops(card);
> +		return;
> +	}
> +
> +	mmc_card_clr_need_bkops(card);
> +	mmc_card_set_doing_bkops(card);
> +
> +}
> +
> +void mmc_start_periodic_bkops(struct work_struct *work)
> +{
> +	struct mmc_host *host = container_of(work, struct mmc_host,
> +			start_bkops.work);
> +
> +	mmc_card_set_check_bkops(host->card);
> +
> +	mmc_claim_host(host);
> +	mmc_start_bkops(host->card);
> +	mmc_release_host(host);
> +}
> +EXPORT_SYMBOL(mmc_start_periodic_bkops);
> +
> +/**
> + *	mmc_start_bkops - start BKOPS for supported cards
> + *	@card: MMC card to start BKOPS
> + *
> + *	Start background operations whenever requested.
> + *	when the urgent BKOPS bit is set in a R1 command response
> + *	then background operations should be started immediately.
> +*/
> +void mmc_start_bkops(struct mmc_card *card)
> +{
> +	BUG_ON(!card);
> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
> +		return;
> +
> +	if (mmc_card_check_bkops(card)) {
> +		mmc_card_clr_check_bkops(card);
> +		if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS)) {
> +			if (card->ext_csd.raw_bkops_status)
> +				mmc_card_set_need_bkops(card);
> +		} else
> +			mmc_card_clr_need_bkops(card);
> +	}
> +
> +	/*
> +	 * If card_need_bkops_flag didn't set, then do nothing just
> +	 * return
> +	 */
> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
> +		goto check_bkops;
> +
> +	mmc_send_bkops_cmd(card);
> +
> +check_bkops:
> +	queue_delayed_work(system_nrt_wq, &card->host->start_bkops, 5 * HZ);
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
>  static void mmc_wait_done(struct mmc_request *mrq)
>  {
>  	complete(&mrq->completion);
> @@ -348,8 +425,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host
> *host,
>  	struct mmc_async_req *data = host->areq;
>
>  	/* Prepare a new request */
> -	if (areq)
> +	if (areq) {
> +		cancel_delayed_work_sync(&host->start_bkops);
>  		mmc_pre_req(host, areq->mrq, !host->areq);
> +	}
>
>  	if (host->areq) {
>  		mmc_wait_for_req_done(host, host->areq->mrq);
> @@ -359,8 +438,11 @@ struct mmc_async_req *mmc_start_req(struct mmc_host
> *host,
>  	if (!err && areq)
>  		start_err = __mmc_start_req(host, areq->mrq);
>
> -	if (host->areq)
> +	if (host->areq) {
>  		mmc_post_req(host, host->areq->mrq, 0);
> +		if (!areq && host->areq && mmc_card_mmc(host->card))
> +			mmc_start_bkops(host->card);
> +	}
>
>  	 /* Cancel a prepared request if it was not started. */
>  	if ((err || start_err) && areq)
> @@ -480,6 +562,84 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct
> mmc_command *cmd, int retries
>  EXPORT_SYMBOL(mmc_wait_for_cmd);
>
>  /**
> + *	mmc_stop_bkops - stop ongoing BKOPS
> + *	@card: MMC card to check BKOPS
> + *
> + *	Send HPI command to interrupt ongoing background operations,
> + *	to allow rapid servicing of foreground operations,e.g. read/
> + *	writes. Wait until the card comes out of the programming state
> + *	to avoid errors in servicing read/write requests.
> + */
> +int mmc_stop_bkops(struct mmc_card *card)
> +{
> +	int err = 0;
> +	unsigned int timeout = 0x10000;
> +	u32 status;
> +
> +	BUG_ON(!card);
> +	cancel_delayed_work_sync(&card->host->start_bkops);
> +
> +	if (card->ext_csd.raw_bkops_status == EXT_CSD_BKOPS_LEVEL_3) {
> +		do {
> +			if (timeout == 0)
> +				break;
> +			mmc_claim_host(card->host);
> +			mmc_send_status(card, &status);
> +			mmc_release_host(card->host);
> +
> +			timeout--;
> +		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> +		if (timeout != 0)
> +			goto done;
> +	}
> +
> +	err = mmc_interrupt_hpi(card);
> +
> +done:
> +	mmc_card_clr_doing_bkops(card);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_stop_bkops);
> +
> +int mmc_read_bkops_status(struct mmc_card *card)
> +{
> +	int err;
> +	u8 ext_csd[512];
> +
> +	mmc_claim_host(card->host);
> +	err = mmc_send_ext_csd(card, ext_csd);
> +	mmc_release_host(card->host);
> +	if (err)
> +		return err;
> +
> +	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
> +	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXCEPTION_STATUS];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mmc_read_bkops_status);
> +
> +int mmc_is_exception_event(struct mmc_card *card, unsigned int value)
> +{
> +	int err;
> +
> +	err = mmc_read_bkops_status(card);
> +	if (err) {
> +		pr_err("%s: Didn't read bkops status : %d\n",
> +		       mmc_hostname(card->host), err);
> +		return 0;
> +	}
> +
> +	/* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
> +	if (card->ext_csd.rev == 5)
> +		return 1;
> +
> +	return (card->ext_csd.raw_exception_status & value) ? 1 : 0;
> +}
> +EXPORT_SYMBOL(mmc_is_exception_event);
> +
> +/**
>   *	mmc_set_data_timeout - set the timeout for a data command
>   *	@data: data phase for command
>   *	@card: the MMC card associated with the data transfer
> @@ -2382,6 +2542,12 @@ int mmc_pm_notify(struct notifier_block
> *notify_block,
>  	switch (mode) {
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
> +		if (host->card && mmc_card_mmc(host->card) &&
> +				mmc_card_doing_bkops(host->card)) {
> +			mmc_interrupt_hpi(host->card);
> +			mmc_card_clr_doing_bkops(host->card);
> +		}
> +		cancel_delayed_work_sync(&host->start_bkops);
>
>  		spin_lock_irqsave(&host->lock, flags);
>  		host->rescan_disable = 1;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 91c84c7..3b6a8e4 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -330,6 +330,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct
> device *dev)
>  	spin_lock_init(&host->lock);
>  	init_waitqueue_head(&host->wq);
>  	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> +	INIT_DELAYED_WORK(&host->start_bkops, mmc_start_periodic_bkops);
>  #ifdef CONFIG_PM
>  	host->pm_notify.notifier_call = mmc_pm_notify;
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2f0e11c..275555a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -463,6 +463,24 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
> *ext_csd)
>  	}
>
>  	if (card->ext_csd.rev >= 5) {
> +		/* check whether the eMMC card support BKOPS */
> +		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
> +			card->ext_csd.bkops = 1;
> +			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
> +			card->ext_csd.raw_bkops_status =
> +				ext_csd[EXT_CSD_BKOPS_STATUS];
> +			if (!card->ext_csd.bkops_en &&
> +				card->host->caps2 & MMC_CAP2_INIT_BKOPS) {
> +				err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					EXT_CSD_BKOPS_EN, 1, 0);
> +				if (err)
> +					pr_warning("%s: Enabling BKOPS failed\n",
> +						mmc_hostname(card->host));
> +				else
> +					card->ext_csd.bkops_en = 1;
> +			}
> +		}
> +
>  		/* check whether the eMMC card supports HPI */
>  		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
>  			card->ext_csd.hpi = 1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..bc8da17 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -399,6 +399,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>  	if (err)
>  		return err;
>

In your previous patch (v7) was code:

-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_CMD_AC;
+	if (index == EXT_CSD_BKOPS_START &&
+	    card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
+		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
+	else
+		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;

When level of raw_bkops_status is not critical, the host controller flags
used
without waiting for BUSY line release. This means, that mmc queue thread
will continue
to fetch requests while BKOPS still running on the card.
Without this code, BKOPS will always be blocking till BKOPS done and using
HPI for interrupt BKOPS on
new request is not need.
Why you removed this code?


