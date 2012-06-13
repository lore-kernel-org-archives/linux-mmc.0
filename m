From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Wed, 13 Jun 2012 12:40:18 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FEA11E5@SHSMSX102.ccr.corp.intel.com>
References: <4FD1821D.4070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60909 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab2FMMkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 08:40:22 -0400
In-Reply-To: <4FD1821D.4070603@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Jaehoon,

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 0b6141d..9adb004 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -41,6 +41,12 @@
>  #include "sd_ops.h"
>  #include "sdio_ops.h"
> 
> +/*
> + * The Background operation can take a long time, depends on the house
> +keeping
> + * operations the card has to peform
> + */
> +#define MMC_BKOPS_MAX_TIMEOUT	(4 * 80 * 1000) /* max time to wait in
> ms */
> +
Just go through the eMMC specification, didn't find any clue about the max timeout value for background operations. So, could you please tell why you choose 320s?
This value will used to calculate TIMEOUT_CONTROL registers for SDHC host controller. And as far as I know, this value is too large for some host.

>  static struct workqueue_struct *workqueue;  static const unsigned freqs[] =
> { 400000, 300000, 200000, 100000 };
> 
> @@ -175,6 +181,16 @@ void mmc_request_done(struct mmc_host *host, struct
> mmc_request *mrq)
>  		if (mrq->done)
>  			mrq->done(mrq);
> 
> +		/*
> +		 * Check BKOPS urgency from each R1 response
> +		 */
> +		if (host->card && mmc_card_mmc(host->card) &&
> +			((mmc_resp_type(cmd) == MMC_RSP_R1) ||
> +			 (mmc_resp_type(cmd) == MMC_RSP_R1B)) &&
> +			(cmd->resp[0] & R1_EXCEPTION_EVENT)) {
> +			mmc_card_set_check_bkops(host->card);
> +		}
> +
>  		mmc_host_clk_release(host);
>  	}
>  }
> @@ -245,6 +261,74 @@ mmc_start_request(struct mmc_host *host, struct
> mmc_request *mrq)
>  	host->ops->request(host, mrq);
>  }
> 
> +/**
> + *	mmc_start_bkops - start BKOPS for supported cards
> + *	@card: MMC card to start BKOPS
> + *
> + *	Start background operations whenever requested.
> + *	when the urgent BKOPS bit is set in a R1 command response
> + *	then background operations should be started immediately.
> +*/
> +void mmc_start_bkops(struct mmc_card *card) {
> +	int err;
> +	int timeout;
> +	u8 wait_for_prog_done;
> +
> +	BUG_ON(!card);
> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
> +		return;
> +
> +	if (mmc_card_check_bkops(card)) {
> +		mmc_card_clr_check_bkops(card);
> +		if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
eMMC4.5 specification has said that "EXCEPTION_EVENTS_STATUS is set whenever the levels is either 2 or 3." To my understanding, EXCEPTION_EVENTS_STATUS will be set only when level-2 or level-3. For level-0 and level-1, EXCEPTION_EVENTS_STATUS won't be set. Regarding this, checking EXCEPTION_EVENTS_CTRL register during mmc card initialization phase can help to save the ext_csd reading commands.

I don't have eMMC4.5 chip on hand, not sure how the real device is implemented. It is better if you can provide a testing result with your EXCEPTION_EVENTS_STATUS register and BKOPS_STATUS register.

> +			if (card->ext_csd.raw_bkops_status)
> +				mmc_card_set_need_bkops(card);
> +	}
> +
> +	/*
> +	 * If card is already doing bkops or need for
> +	 * bkops flag is not set, then do nothing just
> +	 * return
> +	 */
> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
> +		return;
> +
> +	mmc_claim_host(card->host);
> +	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
> +		timeout = MMC_BKOPS_MAX_TIMEOUT;
> +		wait_for_prog_done = 1;
> +	} else {
> +		timeout = 0;
> +		wait_for_prog_done = 0;
> +	}
As specification, CMD6 needs R1B response. Is it really good to use R1 response for it?
To my understanding, the BUSY signal is indicate whether the CMD6 switching is done, but not whether the background operation is done. After CMD6, card will stay in PRG state which means card is still not ready for data transferring. Once the card state change to transfer state, background operation is really finished. So the signal for whether background operations finished is not the BUSY signal but the card state. Please correct me if I am wrong on this point. Of cause, you can have a test with your device.

Thanks
Chuanxiao

> +
> +	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_BKOPS_START, 1, timeout, wait_for_prog_done);
> +	if (err) {
> +		pr_warn("%s: error %d starting bkops\n",
> +			   mmc_hostname(card->host), err);
> +		mmc_card_clr_need_bkops(card);
> +		goto out;
> +	}
> +
> +	mmc_card_clr_need_bkops(card);
> +
> +	/*
> +	 * For urgent bkops status (LEVEL_2 and more)
> +	 * bkops executed synchronously, otherwise
> +	 * the operation is in progress
> +	 */
> +	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2)
> +		mmc_card_set_check_bkops(card);
> +	else
> +		mmc_card_set_doing_bkops(card);
> +
> +out:
> +	mmc_release_host(card->host);
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
>  static void mmc_wait_done(struct mmc_request *mrq)  {
>  	complete(&mrq->completion);
> @@ -359,12 +443,15 @@ struct mmc_async_req *mmc_start_req(struct
> mmc_host *host,
>  	if (!err && areq)
>  		start_err = __mmc_start_req(host, areq->mrq);
> 
> -	if (host->areq)
> +	if (host->areq) {
> +		if (!areq && host->areq && mmc_card_mmc(host->card))
> +			mmc_start_bkops(host->card);
>  		mmc_post_req(host, host->areq->mrq, 0);
> +	}
> 
>  	 /* Cancel a prepared request if it was not started. */
>  	if ((err || start_err) && areq)
> -			mmc_post_req(host, areq->mrq, -EINVAL);
> +		mmc_post_req(host, areq->mrq, -EINVAL);
> 
>  	if (err)
>  		host->areq = NULL;
> @@ -480,6 +567,66 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct
> mmc_command *cmd, int retries  EXPORT_SYMBOL(mmc_wait_for_cmd);
> 
>  /**
> + *	mmc_stop_bkops - stop ongoing BKOPS
> + *	@card: MMC card to check BKOPS
> + *
> + *	Send HPI command to stop ongoing background operations,
> + *	to allow rapid servicing of foreground operations,e.g. read/
> + *	writes. Wait until the card comes out of the programming state
> + *	to avoid errors in servicing read/write requests.
> + */
> +int mmc_stop_bkops(struct mmc_card *card) {
> +	int err = 0;
> +
> +	BUG_ON(!card);
> +
> +	err = mmc_interrupt_hpi(card);
> +
> +	mmc_card_clr_doing_bkops(card);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_stop_bkops);
> +
> +int mmc_read_bkops_status(struct mmc_card *card) {
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
> +	card->ext_csd.raw_exception_status =
> +ext_csd[EXT_CSD_EXCEPTION_STATUS];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mmc_read_bkops_status);
> +
> +int mmc_is_exception_event(struct mmc_card *card, unsigned int value) {
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
> +	return (card->ext_csd.raw_exception_status & value) ? 1 : 0; }
> +EXPORT_SYMBOL(mmc_is_exception_event);
> +
> +/**
>   *	mmc_set_data_timeout - set the timeout for a data command
>   *	@data: data phase for command
>   *	@card: the MMC card associated with the data transfer
> @@ -2294,8 +2441,11 @@ int mmc_suspend_host(struct mmc_host *host)
>  	mmc_bus_get(host);
>  	if (host->bus_ops && !host->bus_dead) {
> 
> -		if (host->bus_ops->suspend)
> +		if (host->bus_ops->suspend) {
> +			if (mmc_card_doing_bkops(host->card))
> +				mmc_stop_bkops(host->card);
>  			err = host->bus_ops->suspend(host);
> +		}
> 
>  		if (err == -ENOSYS || !host->bus_ops->resume) {
>  			/*
> @@ -2382,6 +2532,11 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  	switch (mode) {
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
> +		if (host->card && mmc_card_mmc(host->card) &&
> +				mmc_card_doing_bkops(host->card)) {
> +			mmc_interrupt_hpi(host->card);
> +			mmc_card_clr_doing_bkops(host->card);
> +		}
> 
>  		spin_lock_irqsave(&host->lock, flags);
>  		host->rescan_disable = 1;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 258b203..9e036e5 100644
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
> +					pr_warn("%s: Enabling BKOPS failed\n",
> +						mmc_hostname(card->host));
> +				else
> +					card->ext_csd.bkops_en = 1;
> +			}
> +		}
> +
>  		/* check whether the eMMC card supports HPI */
>  		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
>  			card->ext_csd.hpi = 1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c index
> 69370f4..f0bebd9 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -367,18 +367,20 @@ int mmc_spi_set_crc(struct mmc_host *host, int
> use_crc)  }
> 
>  /**
> - *	mmc_switch - modify EXT_CSD register
> + *	__mmc_switch - modify EXT_CSD register
>   *	@card: the MMC card associated with the data transfer
>   *	@set: cmd set values
>   *	@index: EXT_CSD register index
>   *	@value: value to program into EXT_CSD register
>   *	@timeout_ms: timeout (ms) for operation performed by register write,
>   *                   timeout of zero implies maximum possible timeout
> + *      @wait_for_prod_done: is waiting for program done
>   *
>   *	Modifies the EXT_CSD register for selected card.
>   */
> -int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> -	       unsigned int timeout_ms)
> +int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> +	       unsigned int timeout_ms, u8 wait_for_prog_done)
> +
>  {
>  	int err;
>  	struct mmc_command cmd = {0};
> @@ -392,13 +394,23 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>  		  (index << 16) |
>  		  (value << 8) |
>  		  set;
> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +
> +	cmd.flags = MMC_CMD_AC;
> +	if (wait_for_prog_done)
> +		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +	else
> +		cmd.flags |= MMC_RSP_R1 | MMC_RSP_R1;
> +
>  	cmd.cmd_timeout_ms = timeout_ms;
> 
>  	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>  	if (err)
>  		return err;
> 
> +	/* No need to check card status in case of BKOPS switch*/
> +	if (index == EXT_CSD_BKOPS_START)
> +		return 0;
> +
>  	/* Must check status to be sure of no errors */
>  	do {
>  		err = mmc_send_status(card, &status); @@ -423,6 +435,13 @@ int
> mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> 
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(__mmc_switch);
> +
> +int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> +		unsigned int timeout_ms)
> +{
> +	return __mmc_switch(card, set, index, value, timeout_ms, 1); }
>  EXPORT_SYMBOL_GPL(mmc_switch);
> 
>  int mmc_send_status(struct mmc_card *card, u32 *status) diff --git
> a/include/linux/mmc/card.h b/include/linux/mmc/card.h index d76513b..50b3539
> 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -76,10 +76,13 @@ struct mmc_ext_csd {
>  	bool			hpi_en;			/* HPI enablebit */
>  	bool			hpi;			/* HPI support bit */
>  	unsigned int		hpi_cmd;		/* cmd used as HPI */
> +	bool			bkops;		/* background support bit */
> +	bool			bkops_en;	/* background enable bit */
>  	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>  	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>  	unsigned int		boot_ro_lock;		/* ro lock support */
>  	bool			boot_ro_lockable;
> +	u8			raw_exception_status;	/* 53 */
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_erased_mem_count;	/* 181 */
>  	u8			raw_ext_csd_structure;	/* 194 */
> @@ -93,6 +96,7 @@ struct mmc_ext_csd {
>  	u8			raw_sec_erase_mult;	/* 230 */
>  	u8			raw_sec_feature_support;/* 231 */
>  	u8			raw_trim_mult;		/* 232 */
> +	u8			raw_bkops_status;	/* 246 */
>  	u8			raw_sectors[4];		/* 212 - 4 bytes */
> 
>  	unsigned int            feature_support;
> @@ -225,6 +229,9 @@ struct mmc_card {
>  #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
>  #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200
> mode */
>  #define MMC_STATE_SLEEP		(1<<9)		/* card is in sleep state */
> +#define MMC_STATE_NEED_BKOPS	(1<<10)		/* card need to do BKOPS */
> +#define MMC_STATE_DOING_BKOPS	(1<<11)		/* card is doing BKOPS */
> +#define MMC_STATE_CHECK_BKOPS	(1<<12)		/* card need to check BKOPS
> */
>  	unsigned int		quirks; 	/* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes
> outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize
> */
> @@ -391,6 +398,9 @@ static inline void __maybe_unused remove_quirk(struct
> mmc_card *card, int data)  #define mmc_card_ext_capacity(c) ((c)->state &
> MMC_CARD_SDXC)
>  #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
>  #define mmc_card_is_sleep(c)	((c)->state & MMC_STATE_SLEEP)
> +#define mmc_card_need_bkops(c)	((c)->state & MMC_STATE_NEED_BKOPS)
> +#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
> +#define mmc_card_check_bkops(c) ((c)->state & MMC_STATE_CHECK_BKOPS)
> 
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY) @@
> -403,7 +413,13 @@ static inline void __maybe_unused remove_quirk(struct
> mmc_card *card, int data)  #define mmc_card_set_ext_capacity(c) ((c)->state |=
> MMC_CARD_SDXC)  #define mmc_card_set_removed(c) ((c)->state |=
> MMC_CARD_REMOVED)
>  #define mmc_card_set_sleep(c)	((c)->state |= MMC_STATE_SLEEP)
> +#define mmc_card_set_need_bkops(c)	((c)->state |=
> MMC_STATE_NEED_BKOPS)
> +#define mmc_card_set_doing_bkops(c)	((c)->state |=
> MMC_STATE_DOING_BKOPS)
> +#define mmc_card_set_check_bkops(c) ((c)->state |=
> +MMC_STATE_CHECK_BKOPS)
> 
> +#define mmc_card_clr_need_bkops(c)	((c)->state &= ~MMC_STATE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c)	((c)->state &=
> ~MMC_STATE_DOING_BKOPS)
> +#define mmc_card_clr_check_bkops(c) ((c)->state &=
> +~MMC_STATE_CHECK_BKOPS)
>  #define mmc_card_clr_sleep(c)	((c)->state &= ~MMC_STATE_SLEEP)
>  /*
>   * Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
> 1b431c7..bda3d86 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -134,6 +134,9 @@ struct mmc_host;
>  struct mmc_card;
>  struct mmc_async_req;
> 
> +extern int mmc_stop_bkops(struct mmc_card *); extern int
> +mmc_read_bkops_status(struct mmc_card *); extern int
> +mmc_is_exception_event(struct mmc_card *, unsigned int);
>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  					   struct mmc_async_req *, int *);  extern int
> mmc_interrupt_hpi(struct mmc_card *); @@ -142,6 +145,8 @@ extern int
> mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);  extern int
> mmc_app_cmd(struct mmc_host *, struct mmc_card *);  extern int
> mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
>  	struct mmc_command *, int);
> +extern void mmc_start_bkops(struct mmc_card *card); extern int
> +__mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, u8);
>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
> 
>  #define MMC_ERASE_ARG		0x00000000
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> 0707d22..d23caf2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,8 @@ struct mmc_host {
>  #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
>  #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card
> removal */
>  #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
> +#define MMC_CAP2_INIT_BKOPS	(1 << 10)	/* To enable BKOPS */
> +#define MMC_CAP2_BKOPS		(1 << 11)	/* BKOPS supported */
> 
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  	unsigned int        power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> d425cab..80cfbf1 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
>  #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
>  #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
>  #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
> +#define R1_EXCEPTION_EVENT	(1 << 6)	/* sx, a */
>  #define R1_APP_CMD		(1 << 5)	/* sr, c */
> 
>  #define R1_STATE_IDLE	0
> @@ -274,12 +275,15 @@ struct _mmc_csd {
>  #define EXT_CSD_FLUSH_CACHE		32      /* W */
>  #define EXT_CSD_CACHE_CTRL		33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
> +#define EXT_CSD_EXCEPTION_STATUS	54	/* RO */
>  #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
>  #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
>  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>  #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>  #define EXT_CSD_HPI_MGMT		161	/* R/W */
>  #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
> +#define EXT_CSD_BKOPS_EN		163	/* R/W */
> +#define EXT_CSD_BKOPS_START		164	/* W */
>  #define EXT_CSD_SANITIZE_START		165     /* W */
>  #define EXT_CSD_WR_REL_PARAM		166	/* RO */
>  #define EXT_CSD_BOOT_WP			173	/* R/W */
> @@ -313,11 +317,13 @@ struct _mmc_csd {
>  #define EXT_CSD_PWR_CL_200_360		237	/* RO */
>  #define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
>  #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
> +#define EXT_CSD_BKOPS_STATUS		246	/* RO */
>  #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
>  #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
>  #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
>  #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
>  #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
> +#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
>  #define EXT_CSD_HPI_FEATURES		503	/* RO */
> 
>  /*
> @@ -386,4 +392,17 @@ struct _mmc_csd {
>  #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1
> in value */
>  #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
> 
> +/*
> + * BKOPS status level
> + */
> +#define EXT_CSD_BKOPS_LEVEL_2		0x2
> +
> +/*
> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)  */
> +#define EXT_CSD_URGENT_BKOPS		BIT(0)
> +#define EXT_CSD_DYNCAP_NEEDED		BIT(1)
> +#define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
> +#define EXT_CSD_PACKED_FAILURE		BIT(3)
> +
>  #endif /* LINUX_MMC_MMC_H */
> --
> 1.7.4.1
