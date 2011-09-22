From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH v2] mmc: support background operation
Date: Thu, 22 Sep 2011 16:06:34 +0900
Message-ID: <4E7ADE7A.1080705@samsung.com>
References: <4E532DB3.2070303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23622 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1IVHG7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2011 03:06:59 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LRW005V2X3KYJL0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 16:06:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LRW009T1X3LCF@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 16:06:57 +0900 (KST)
In-reply-to: <4E532DB3.2070303@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, J Freyensee <james_p_freyensee@linux.intel.com>

Hi Chris.

how about this feature..? didn't you have any comment?

Regards,
Jaehoon Chung

Jaehoon Chung wrote:

> Hi mailing.
> 
> This RFC patch is supported background operation(BKOPS).
> And if you want to test this patch, must apply "[PATCH v3] mmc: support HPI send command"
> 
> This patch is based on Hanumath Prasad's patch "mmc: enable background operations for emmc4.41 with HPI support"
> Hanumath's patch is implemented before applied per forlin's patch "use nonblock mmc request...".
> This patch is based on 3.1.0-rc1 in mmc-next.
> 
> Background operations is run when set the URGENT_BKOPS in response.
> 
> if set the URGENT_BKOPS in response, we can notify that card need the BKOPS.
> (URGENT_BKOPS is used in eMMC4.41 spec, but in eMMC4.5 changed to EXCEPTION_EVENT bit.
>  maybe, we need to change this point).
> 
> And all request is done, then run background operation.
> if request read/write operation when running BKOPS, issue HPI interrupt
> 
> This patch is just RFC patch (not to merge).
> 
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
> ---
> v2:
> - change pr_debug/pr_info instead of printk()
> - add check BKOPS_EN bit (if BKOPS support)
> ---
>  drivers/mmc/card/block.c   |    4 ++++
>  drivers/mmc/card/queue.c   |   10 ++++++++++
>  drivers/mmc/core/core.c    |   38 ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c     |   34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.c |    3 +++
>  include/linux/mmc/card.h   |   11 +++++++++++
>  include/linux/mmc/core.h   |    1 +
>  include/linux/mmc/mmc.h    |    4 ++++
>  8 files changed, 105 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1ff5486..83379ff 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1078,6 +1078,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  		switch (status) {
>  		case MMC_BLK_SUCCESS:
>  		case MMC_BLK_PARTIAL:
> +			if (mmc_card_mmc(card) &&
> +				(brq->cmd.resp[0] & R1_URGENT_BKOPS))
> +				mmc_card_set_need_bkops(card);
> +
>  			/*
>  			 * A block was successfully transferred.
>  			 */
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 45fb362..52b1293 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -46,6 +46,8 @@ static int mmc_queue_thread(void *d)
>  {
>  	struct mmc_queue *mq = d;
>  	struct request_queue *q = mq->queue;
> +	struct mmc_card *card = mq->card;
> +	unsigned long flags;
>  
>  	current->flags |= PF_MEMALLOC;
>  
> @@ -61,6 +63,13 @@ static int mmc_queue_thread(void *d)
>  		spin_unlock_irq(q->queue_lock);
>  
>  		if (req || mq->mqrq_prev->req) {
> +			if (mmc_card_doing_bkops(card)) {
> +				mmc_interrupt_hpi(card);
> +				spin_lock_irqsave(&card->host->lock, flags);
> +				mmc_card_clr_doing_bkops(card);
> +				spin_unlock_irqrestore(&card->host->lock,
> +						flags);
> +			}
>  			set_current_state(TASK_RUNNING);
>  			mq->issue_fn(mq, req);
>  		} else {
> @@ -68,6 +77,7 @@ static int mmc_queue_thread(void *d)
>  				set_current_state(TASK_RUNNING);
>  				break;
>  			}
> +			mmc_start_bkops(mq->card);
>  			up(&mq->thread_sem);
>  			schedule();
>  			down(&mq->thread_sem);
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06fd77c..b5a92af 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -360,6 +360,44 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>  EXPORT_SYMBOL(mmc_wait_for_req);
>  
>  /**
> + *	mmc_start_bkops - start a background operation
> + *	@card: the MMC card associated with the HPI transfer
> + *
> + *	When need a background operation, card start a background operation.
> + */
> +void mmc_start_bkops(struct mmc_card *card)
> +{
> +	int err;
> +	unsigned long flags;
> +
> +	BUG_ON(!card);
> +
> +	if (!card->ext_csd.bkops_en) {
> +		pr_info("Didn't set BKOPS enable bit!\n");
> +		return;
> +	}
> +
> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
> +		return;
> +
> +	mmc_claim_host(card->host);
> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +		EXT_CSD_BKOPS_START, 1, 0);
> +	if (err) {
> +		mmc_card_clr_need_bkops(card);
> +		goto out;
> +	}
> +
> +	spin_lock_irqsave(&card->host->lock, flags);
> +	mmc_card_clr_need_bkops(card);
> +	mmc_card_set_doing_bkops(card);
> +	spin_unlock_irqrestore(&card->host->lock, flags);
> +out:
> +	mmc_release_host(card->host);
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
> +/**
>   *	mmc_interrupt_hpi - Issue for High priority Interrupt
>   *	@card: the MMC card associated with the HPI transfer
>   *
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ef312c9..4ae02d2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -420,6 +420,18 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			card->ext_csd.out_of_int_time =
>  				ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] * 10;
>  		}
> +
> +		/*
> +		 * check whether the eMMC card support BKOPS.
> +		 * if set BKOPS_SUPPORT bit,
> +		 * BKOPS_STATUS, BKOPS_EN,,BKOPS_START and
> +		 * URGENT_BKOPS are supported.(default)
> +		 */
> +		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
> +			card->ext_csd.bkops = 1;
> +			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
> +		}
> +
>  		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
>  	}
>  
> @@ -744,6 +756,28 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	}
>  
>  	/*
> +	 * Enable BKOPS feature (if supported)
> +	 */
> +	if (card->ext_csd.bkops) {
> +		/*
> +		 * If card supported BKOPS, default set BKOPS_EN bit.
> +		 * But ensure to enable bkops, need to check enable bit
> +		*/
> +		if (!card->ext_csd.bkops_en) {
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					EXT_CSD_BKOPS_EN, 1, 0);
> +			if (err && err != -EBADMSG)
> +				goto free_card;
> +			if (err) {
> +				printk(KERN_ERR "%s: Enabling BKOPS failed\n",
> +						mmc_hostname(card->host));
> +				err = 0;
> +			} else
> +				card->ext_csd.bkops_en = 1;
> +		}
> +	}
> +
> +	/*
>  	 * Enable HPI feature (if supported)
>  	 */
>  	if (card->ext_csd.hpi) {
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 4706400..2a54221 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -398,6 +398,9 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  	if (err)
>  		return err;
>  
> +	if (index == EXT_CSD_BKOPS_START)
> +		return 0;
> +
>  	/* Must check status to be sure of no errors */
>  	do {
>  		err = mmc_send_status(card, &status);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 411054d..c41b91b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -67,6 +67,8 @@ struct mmc_ext_csd {
>  	bool			hpi_en;			/* HPI enablebit */
>  	bool			hpi;			/* HPI support bit */
>  	unsigned int		hpi_cmd;		/* cmd used as HPI */
> +	bool			bkops;			/* BKOPS support bit */
> +	bool			bkops_en;		/* BKOPS enable bit */
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_erased_mem_count;	/* 181 */
>  	u8			raw_ext_csd_structure;	/* 194 */
> @@ -181,6 +183,8 @@ struct mmc_card {
>  #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
>  #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
>  #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
> +#define MMC_STATE_NEED_BKOPS	(1<<7)		/* Need background operation */
> +#define MMC_STATE_DOING_BKOPS	(1<<8)		/* Do running background operation */
>  	unsigned int		quirks; 	/* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
> @@ -318,6 +322,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS)
> +#define mmc_card_doing_bkops(c) ((c)->state & MMC_STATE_DOING_BKOPS)
>  
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
> @@ -326,6 +332,11 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> +#define mmc_card_set_need_bkops(c) ((c)->state |= MMC_STATE_NEED_BKOPS)
> +#define mmc_card_set_doing_bkops(c) ((c)->state |= MMC_STATE_DOING_BKOPS)
> +
> +#define mmc_card_clr_need_bkops(c) ((c)->state &= ~MMC_STATE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c) ((c)->state &= ~MMC_STATE_DOING_BKOPS)
>  
>  /*
>   * Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index dca3c08..90f2e1c 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -162,6 +162,7 @@ extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
>  				   unsigned int nr);
>  extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>  
> +extern void mmc_start_bkops(struct mmc_card *card);
>  extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
>  
>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index e16c776..419a48e 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
>  #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
>  #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
>  #define R1_APP_CMD		(1 << 5)	/* sr, c */
> +#define R1_URGENT_BKOPS		(1 << 6)	/* sr, a */
>  
>  #define R1_STATE_IDLE	0
>  #define R1_STATE_READY	1
> @@ -273,6 +274,8 @@ struct _mmc_csd {
>  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>  #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>  #define EXT_CSD_HPI_MGMT		161	/* R/W */
> +#define EXT_CSD_BKOPS_EN		163	/* R/W */
> +#define EXT_CSD_BKOPS_START		164	/* R/W */
>  #define EXT_CSD_WR_REL_PARAM		166	/* RO */
>  #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
>  #define EXT_CSD_PART_CONFIG		179	/* R/W */
> @@ -295,6 +298,7 @@ struct _mmc_csd {
>  #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
>  #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
>  #define EXT_CSD_TRIM_MULT		232	/* RO */
> +#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
>  #define EXT_CSD_HPI_FEATURES		503	/* RO */
>  
>  /*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


