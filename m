From: merez@codeaurora.org
Subject: Re: [PATCH v10] mmc: support BKOPS feature for eMMC
Date: Tue, 17 Jul 2012 12:34:59 -0700 (PDT)
Message-ID: <c6e6e1f03f528666c9080b92a8e15317.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:32137 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2GQTfA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 15:35:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

See my comments below.

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
> +	int err;
> +	int timeout;
> +	u8 use_busy_signal;
> +
> +	BUG_ON(!card);
> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))

Can you please explain why we need to have MMC_CAP2_BKOPS in addition to
card->ext_csd.bkops_en?

+		return;
> +
> +	if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
> +		if (card->ext_csd.raw_bkops_status)
> +			mmc_card_set_need_bkops(card);

I think we can remove the bkops need flag. You can just return here in
case it is not needed instead of updating the flag and checking it in the
next line.


> @@ -354,6 +422,20 @@ struct mmc_async_req *mmc_start_req(struct mmc_host
*host,
>  	if (host->areq) {
>  		mmc_wait_for_req_done(host, host->areq->mrq);
>  		err = host->areq->err_check(host->card, host->areq);
> +		/*
> +		 * Check BKOPS urgency from each R1 response
> +		 */
> +		if (host->card && mmc_card_mmc(host->card) &&
> +		((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
> +		 (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
> +		(host->areq->mrq->cmd->resp[0] & R1_EXP_EVENT))
> +			mmc_start_bkops(host->card);
> +		/*
> +		 * If areq exsit,
> +		 * we stop the bkops for foreground operation
> +		 */
> +		if (areq && mmc_card_doing_bkops(host->card))
> +			err = mmc_stop_bkops(host->card);

I think that mmc_start_bkops should handle only level 2 and 3 for now.
Since it is not likely to have an exception with level 1 on, the best way
to deal with it is inside mmc_start_bkops (starting the BKOPs for levels 2
and 3).
When the periodiv BKOPs will be added, then level 1 will be fully
supported. In such a case mmc_start_bkops should know to start BKOPs on
level 1 only if it is called due to the periodic delayed work (for
example, by adding a flag to mmc_start_bkops)

> +int mmc_stop_bkops(struct mmc_card *card)
> +{
> +	int err = 0;
> +
> +	BUG_ON(!card);
> +	err = mmc_interrupt_hpi(card);
> +
> +	/*
> +	 * if err is EINVAL, it's status that can't issue HPI.
> +	 * Maybe it should be completed the BKOPS.

should complete

> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4ad994a..baf90e0 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -368,18 +368,19 @@ int mmc_spi_set_crc(struct mmc_host *host, int
use_crc)
>  }
>
>  /**
> - *	mmc_switch - modify EXT_CSD register
> + *	__mmc_switch - modify EXT_CSD register
>   *	@card: the MMC card associated with the data transfer
>   *	@set: cmd set values
>   *	@index: EXT_CSD register index
>   *	@value: value to program into EXT_CSD register
>   *	@timeout_ms: timeout (ms) for operation performed by register write,
*                   timeout of zero implies maximum possible timeout
> + *                   @wait_for_prod_done: is waiting for program done

Change the comment for the new parameter: use_busy_signal

>   *
>   *	Modifies the EXT_CSD register for selected card.
>   */
> -int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value, -
   unsigned int timeout_ms)
> +int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value, +
     unsigned int timeout_ms, u8 use_busy_signal)

Use bool instead of u8

>  {
>  	int err;
>  	struct mmc_command cmd = {0};
> @@ -393,13 +394,24 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
index, u8 value,
>  		  (index << 16) |
>  		  (value << 8) |
>  		  set;
> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +
> +	cmd.flags = MMC_CMD_AC;
> +	if (use_busy_signal)
> +		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +	else
> +		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> +
>  	cmd.cmd_timeout_ms = timeout_ms;
>
>  	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>  	if (err)
>  		return err;
>
> +	/* No need to check card status in case of BKOPS LEVEL2 switch*/

have a space before the */

> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
cdfbc3c..b9e11aa 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -79,10 +79,13 @@ struct mmc_ext_csd {
>  	bool			hpi_en;			/* HPI enablebit */
>  	bool			hpi;			/* HPI support bit */
>  	unsigned int		hpi_cmd;		/* cmd used as HPI */
> +	bool			bkops;		/* background support bit */
> +	bool			bkops_en;	/* background enable bit */
>  	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>  	unsigned int		boot_ro_lock;		/* ro lock support */
>  	bool			boot_ro_lockable;
> +	u8			raw_exception_status;	/* 53 */
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_erased_mem_count;	/* 181 */
>  	u8			raw_ext_csd_structure;	/* 194 */
> @@ -96,6 +99,7 @@ struct mmc_ext_csd {
>  	u8			raw_sec_erase_mult;	/* 230 */
>  	u8			raw_sec_feature_support;/* 231 */
>  	u8			raw_trim_mult;		/* 232 */
> +	u8			raw_bkops_status;	/* 246 */
>  	u8			raw_sectors[4];		/* 212 - 4 bytes */
>
>  	unsigned int            feature_support;
> @@ -229,6 +233,9 @@ struct mmc_card {
>  #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
>  #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
#define MMC_STATE_SLEEP		(1<<9)		/* card is in sleep state */
> +#define MMC_STATE_NEED_BKOPS	(1<<10)		/* card need to do BKOPS */
+#define MMC_STATE_DOING_BKOPS	(1<<11)		/* card is doing BKOPS */
+#define MMC_STATE_CHECK_BKOPS	(1<<12)		/* card need to check BKOPS */

MMC_STATE_CHECK_BKOPS is not used, can be removed

> @@ -400,6 +407,9 @@ static inline void __maybe_unused
remove_quirk(struct
> mmc_card *card, int data)
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
#define mmc_card_is_sleep(c)	((c)->state & MMC_STATE_SLEEP)
> +#define mmc_card_need_bkops(c)	((c)->state & MMC_STATE_NEED_BKOPS)
This flag can also be removed
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_check_bkops(c) ((c)->state & MMC_STATE_CHECK_BKOPS)

mmc_card_check_bkops is not used, can be removed

>
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
> @@ -412,7 +422,13 @@ static inline void __maybe_unused
remove_quirk(struct
> mmc_card *card, int data)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
#define mmc_card_set_sleep(c)	((c)->state |= MMC_STATE_SLEEP)
> +#define mmc_card_set_need_bkops(c)	((c)->state |= MMC_STATE_NEED_BKOPS)
+#define mmc_card_set_doing_bkops(c)	((c)->state |=
MMC_STATE_DOING_BKOPS)
> +#define mmc_card_set_check_bkops(c) ((c)->state |=
MMC_STATE_CHECK_BKOPS)

mmc_card_set_check_bkops can be removed

>
> +#define mmc_card_clr_need_bkops(c)	((c)->state &=
~MMC_STATE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c)	((c)->state &=
> ~MMC_STATE_DOING_BKOPS)
> +#define mmc_card_clr_check_bkops(c) ((c)->state &=
> ~MMC_STATE_CHECK_BKOPS)

mmc_card_clr_check_bkops can be removed

Thanks,
Maya
-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum








