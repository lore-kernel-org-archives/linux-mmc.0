From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH v8] mmc: support BKOPS feature for eMMC
Date: Fri, 11 May 2012 18:09:57 +0530
Message-ID: <4FAD089D.2080302@codeaurora.org>
References: <4FABC495.8060708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:59268 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758403Ab2EKMkL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 May 2012 08:40:11 -0400
In-Reply-To: <4FABC495.8060708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi Jaehoon,

Please find comments inline below.

On 5/10/2012 7:07 PM, Jaehoon Chung wrote:
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
> When BKOPS_STATUS is Level-3, if we're waiting for done, it spent 60~80sec.
> So Added timeout value. if timeout value is set to 0, send hpi command.
>
> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
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
>   drivers/mmc/card/queue.c   |    2 +
>   drivers/mmc/core/core.c    |  170 +++++++++++++++++++++++++++++++++++++++++++-
>   drivers/mmc/core/host.c    |    1 +
>   drivers/mmc/core/mmc.c     |   18 +++++
>   drivers/mmc/core/mmc_ops.c |    4 +
>   include/linux/mmc/card.h   |   16 ++++
>   include/linux/mmc/core.h   |    5 ++
>   include/linux/mmc/host.h   |    4 +
>   include/linux/mmc/mmc.h    |   20 +++++
>   9 files changed, 238 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..e4a2cde 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
>   		spin_unlock_irq(q->queue_lock);
>
>   		if (req || mq->mqrq_prev->req) {
> +			if (mmc_card_doing_bkops(mq->card))
> +				mmc_stop_bkops(mq->card);
mmc_stop_bkops() may fail and can return an error but we are ignoring it 
here. What if this function has returned error which means BKOPS may 
still be running in card and if you go ahead and issue another 
read/write request?
>   			set_current_state(TASK_RUNNING);
>   			mq->issue_fn(mq, req);
>   		} else {
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..91a03d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -175,6 +175,13 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>   		if (mrq->done)
>   			mrq->done(mrq);
>
> +		/*
> +		 * Check BKOPS urgency from each R1 response
> +		 */
> +		if (host->card&&  mmc_card_mmc(host->card)&&
> +			(cmd->resp[0]&  R1_EXCEPTION_EVENT))
Shouldn't you make sure that response expected for this commands is 
R1/R1b? Only in that case cmd->resp[0] will have the device status.
> +			mmc_card_set_check_bkops(host->card);
> +
>   		mmc_host_clk_release(host);
>   	}
>   }
> @@ -245,6 +252,76 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>   	host->ops->request(host, mrq);
>   }
>
> +static void mmc_send_bkops_cmd(struct mmc_card *card)
I guess name should be mmc_send_bkops_start_cmd().
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
In case of failure, why are we clearing the NEED_BKOPS flag? You still 
need the BKOPS, correct?
> +		return;
> +	}
> +
> +	mmc_card_clr_need_bkops(card);
> +	mmc_card_set_doing_bkops(card);
> +
You can remove this extra line here.
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
> +	if (!card->ext_csd.bkops_en || !(card->host->caps2&  MMC_CAP2_BKOPS))
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
> +	queue_delayed_work(system_nrt_wq,&card->host->start_bkops, 5 * HZ);
Can we use the deferrable timer for this delayed work? If it's not 
deferrable and if CPU is some low power state, it has to wakeup and 
serve this timer on it's expiration. Better make it deferrable so it 
won't wakeup the system when timer expires.

Also, just wondering, how came to this 5 sec timeout?
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
>   static void mmc_wait_done(struct mmc_request *mrq)
>   {
>   	complete(&mrq->completion);
> @@ -348,8 +425,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>   	struct mmc_async_req *data = host->areq;
>
>   	/* Prepare a new request */
> -	if (areq)
> +	if (areq) {
> +		cancel_delayed_work_sync(&host->start_bkops);
>   		mmc_pre_req(host, areq->mrq, !host->areq);
> +	}
>
>   	if (host->areq) {
>   		mmc_wait_for_req_done(host, host->areq->mrq);
> @@ -359,8 +438,11 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>   	if (!err&&  areq)
>   		start_err = __mmc_start_req(host, areq->mrq);
>
> -	if (host->areq)
> +	if (host->areq) {
>   		mmc_post_req(host, host->areq->mrq, 0);
> +		if (!areq&&  host->areq&&  mmc_card_mmc(host->card))
> +			mmc_start_bkops(host->card);
> +	}
>
>   	 /* Cancel a prepared request if it was not started. */
>   	if ((err || start_err)&&  areq)
> @@ -480,6 +562,84 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
>   EXPORT_SYMBOL(mmc_wait_for_cmd);
>
>   /**
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
How this 0x10000 value is calculated? Is there any defined timeout value 
for card to come out of programming after starting the BKOPS? if not, 
then let's wait indefinitely for it to come out of the programming 
state? Don't we wait indefinitely for write request?
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
> +			mmc_send_status(card,&status);
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
Here even if mmc_interrupt_hpi() fails, you are clearing the DOING_BKOPS 
flag which is not correct. Which should clear this flag if HPI issued 
successfully.
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
> +	return (card->ext_csd.raw_exception_status&  value) ? 1 : 0;
> +}
> +EXPORT_SYMBOL(mmc_is_exception_event);
> +
> +/**
>    *	mmc_set_data_timeout - set the timeout for a data command
>    *	@data: data phase for command
>    *	@card: the MMC card associated with the data transfer
> @@ -2382,6 +2542,12 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>   	switch (mode) {
>   	case PM_HIBERNATION_PREPARE:
>   	case PM_SUSPEND_PREPARE:
> +		if (host->card&&  mmc_card_mmc(host->card)&&
> +				mmc_card_doing_bkops(host->card)) {
> +			mmc_interrupt_hpi(host->card);
> +			mmc_card_clr_doing_bkops(host->card);
> +		}
> +		cancel_delayed_work_sync(&host->start_bkops);
>
>   		spin_lock_irqsave(&host->lock, flags);
>   		host->rescan_disable = 1;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 91c84c7..3b6a8e4 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -330,6 +330,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>   	spin_lock_init(&host->lock);
>   	init_waitqueue_head(&host->wq);
>   	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> +	INIT_DELAYED_WORK(&host->start_bkops, mmc_start_periodic_bkops);
>   #ifdef CONFIG_PM
>   	host->pm_notify.notifier_call = mmc_pm_notify;
>   #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2f0e11c..275555a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -463,6 +463,24 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   	}
>
>   	if (card->ext_csd.rev>= 5) {
> +		/* check whether the eMMC card support BKOPS */
> +		if (ext_csd[EXT_CSD_BKOPS_SUPPORT]&  0x1) {
> +			card->ext_csd.bkops = 1;
> +			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
> +			card->ext_csd.raw_bkops_status =
> +				ext_csd[EXT_CSD_BKOPS_STATUS];
> +			if (!card->ext_csd.bkops_en&&
> +				card->host->caps2&  MMC_CAP2_INIT_BKOPS) {
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
>   		/* check whether the eMMC card supports HPI */
>   		if (ext_csd[EXT_CSD_HPI_FEATURES]&  0x1) {
>   			card->ext_csd.hpi = 1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..bc8da17 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -399,6 +399,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   	if (err)
>   		return err;
>
> +	/* No need to check card status in case of BKOPS switch*/
> +	if (index == EXT_CSD_BKOPS_START)
> +		return 0;
> +
>   	/* Must check status to be sure of no errors */
>   	do {
>   		err = mmc_send_status(card,&status);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d76513b..52b507d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -76,6 +76,9 @@ struct mmc_ext_csd {
>   	bool			hpi_en;			/* HPI enablebit */
>   	bool			hpi;			/* HPI support bit */
>   	unsigned int		hpi_cmd;		/* cmd used as HPI */
> +	bool			bkops;		/* background support bit */
> +	bool			bkops_en;	/* background enable bit */
> +	u8			raw_exception_status;	/* 53 */
>   	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>   	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>   	unsigned int		boot_ro_lock;		/* ro lock support */
> @@ -93,6 +96,7 @@ struct mmc_ext_csd {
>   	u8			raw_sec_erase_mult;	/* 230 */
>   	u8			raw_sec_feature_support;/* 231 */
>   	u8			raw_trim_mult;		/* 232 */
> +	u8			raw_bkops_status;	/* 246 */
>   	u8			raw_sectors[4];		/* 212 - 4 bytes */
>
>   	unsigned int            feature_support;
> @@ -225,6 +229,9 @@ struct mmc_card {
>   #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
>   #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
>   #define MMC_STATE_SLEEP		(1<<9)		/* card is in sleep state */
> +#define MMC_STATE_NEED_BKOPS	(1<<10)		/* card need to do BKOPS */
> +#define MMC_STATE_DOING_BKOPS	(1<<11)		/* card is doing BKOPS */
> +#define MMC_STATE_CHECK_BKOPS	(1<<12)		/* card need to check BKOPS */
>   	unsigned int		quirks; 	/* card quirks */
>   #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
>   #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
> @@ -391,6 +398,9 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>   #define mmc_card_ext_capacity(c) ((c)->state&  MMC_CARD_SDXC)
>   #define mmc_card_removed(c)	((c)&&  ((c)->state&  MMC_CARD_REMOVED))
>   #define mmc_card_is_sleep(c)	((c)->state&  MMC_STATE_SLEEP)
> +#define mmc_card_need_bkops(c)	((c)->state&  MMC_STATE_NEED_BKOPS)
> +#define mmc_card_doing_bkops(c)	((c)->state&  MMC_STATE_DOING_BKOPS)
> +#define mmc_card_check_bkops(c) ((c)->state&  MMC_STATE_CHECK_BKOPS)
>
>   #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>   #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
> @@ -403,7 +413,13 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>   #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>   #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>   #define mmc_card_set_sleep(c)	((c)->state |= MMC_STATE_SLEEP)
> +#define mmc_card_set_need_bkops(c)	((c)->state |= MMC_STATE_NEED_BKOPS)
> +#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
> +#define mmc_card_set_check_bkops(c) ((c)->state |= MMC_STATE_CHECK_BKOPS)
>
> +#define mmc_card_clr_need_bkops(c)	((c)->state&= ~MMC_STATE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c)	((c)->state&= ~MMC_STATE_DOING_BKOPS)
> +#define mmc_card_clr_check_bkops(c) ((c)->state&= ~MMC_STATE_CHECK_BKOPS)
>   #define mmc_card_clr_sleep(c)	((c)->state&= ~MMC_STATE_SLEEP)
>   /*
>    * Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 1b431c7..c920250 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -134,6 +134,9 @@ struct mmc_host;
>   struct mmc_card;
>   struct mmc_async_req;
>
> +extern int mmc_stop_bkops(struct mmc_card *);
> +extern int mmc_read_bkops_status(struct mmc_card *);
> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int);
>   extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>   					   struct mmc_async_req *, int *);
>   extern int mmc_interrupt_hpi(struct mmc_card *);
> @@ -163,6 +166,8 @@ extern int mmc_can_sanitize(struct mmc_card *card);
>   extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>   extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
>   				   unsigned int nr);
> +extern void mmc_start_periodic_bkops(struct work_struct *work);
> +extern void mmc_start_bkops(struct mmc_card *card);
>   extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>
>   extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..186d146 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,8 @@ struct mmc_host {
>   #define MMC_CAP2_BROKEN_VOLTAGE	(1<<  7)	/* Use the broken voltage */
>   #define MMC_CAP2_DETECT_ON_ERR	(1<<  8)	/* On I/O err check card removal */
>   #define MMC_CAP2_HC_ERASE_SZ	(1<<  9)	/* High-capacity erase size */
> +#define MMC_CAP2_INIT_BKOPS	(1<<  10)	/* To enable BKOPS */
> +#define MMC_CAP2_BKOPS		(1<<  11)	/* BKOPS supported */
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>   	unsigned int        power_notify_type;
> @@ -320,6 +322,8 @@ struct mmc_host {
>
>   	unsigned int		actual_clock;	/* Actual HC clock rate */
>
> +	struct delayed_work	start_bkops;	/* Periodic bkops start */
> +
>   	unsigned long		private[0] ____cacheline_aligned;
>   };
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d425cab..06afeb4 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
>   #define R1_CURRENT_STATE(x)	((x&  0x00001E00)>>  9)	/* sx, b (4 bits) */
>   #define R1_READY_FOR_DATA	(1<<  8)	/* sx, a */
>   #define R1_SWITCH_ERROR		(1<<  7)	/* sx, c */
> +#define R1_EXCEPTION_EVENT	(1<<  6)	/* sx, a */
>   #define R1_APP_CMD		(1<<  5)	/* sr, c */
>
>   #define R1_STATE_IDLE	0
> @@ -274,12 +275,15 @@ struct _mmc_csd {
>   #define EXT_CSD_FLUSH_CACHE		32      /* W */
>   #define EXT_CSD_CACHE_CTRL		33      /* R/W */
>   #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
> +#define EXT_CSD_EXCEPTION_STATUS	54	/* RO */
>   #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
>   #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
>   #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>   #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>   #define EXT_CSD_HPI_MGMT		161	/* R/W */
>   #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
> +#define EXT_CSD_BKOPS_EN		163	/* R/W */
> +#define EXT_CSD_BKOPS_START		164	/* W */
>   #define EXT_CSD_SANITIZE_START		165     /* W */
>   #define EXT_CSD_WR_REL_PARAM		166	/* RO */
>   #define EXT_CSD_BOOT_WP			173	/* R/W */
> @@ -313,11 +317,13 @@ struct _mmc_csd {
>   #define EXT_CSD_PWR_CL_200_360		237	/* RO */
>   #define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
>   #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
> +#define EXT_CSD_BKOPS_STATUS		246	/* RO */
>   #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
>   #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
>   #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
>   #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
>   #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
> +#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
>   #define EXT_CSD_HPI_FEATURES		503	/* RO */
>
>   /*
> @@ -386,4 +392,18 @@ struct _mmc_csd {
>   #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
>   #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
>
> +/*
> + * BKOPS status level
> + */
> +#define EXT_CSD_BKOPS_LEVEL_2		0x2
> +#define EXT_CSD_BKOPS_LEVEL_3		0x3
> +
> +/*
> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
> + */
> +#define EXT_CSD_URGENT_BKOPS		BIT(0)
> +#define EXT_CSD_DYNCAP_NEEDED		BIT(1)
> +#define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
> +#define EXT_CSD_PACKED_FAILURE		BIT(3)
> +
>   #endif /* LINUX_MMC_MMC_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

