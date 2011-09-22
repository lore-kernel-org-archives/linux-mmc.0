From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] mmc: support HPI send command
Date: Thu, 22 Sep 2011 16:05:17 +0900
Message-ID: <4E7ADE2D.4010007@samsung.com>
References: <4E532DB1.4070301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64388 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1IVHFm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2011 03:05:42 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LRW00DNBX1E95Q0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 16:05:40 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LRW00IISX1G4N20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 16:05:40 +0900 (KST)
In-reply-to: <4E532DB1.4070301@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Hi Chris.

This feature is also used in eMMC4.41. So i want to know your opinion.
(In eMMC4.5, i known this feature is important)
If need more modification, i will do. if not, i want to merge this feature.

Regards,
Jaehoon Chung

Jaehoon Chung wrote:

> This patch is added sending function for HPI command.
> 
> HPI command is defined in eMMC4.41.
> We didn't use this feature..but maybe we need to use HPI command for eMMC4.5 feature.
> (If we use HPI command, it's useful for increasing performance and decreasing latency.)
> 
> This patch is based on Chuanxiao's patch which one of many patches related with HPI sent to mailing..
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
> ---
> v4 :
> - change pr_info/pr_debug instead of printk()
> - remove unnecessary parameter.
> v3 :
> - Change response type R1 instead of R1b.(using STOP_TRANSMMISION)
> - Check card status with SEND_STATUS after sending HPI
> 
> v2 : add error checking (when send hpi, card is out of prg-state)
> ---
>  drivers/mmc/core/core.c    |   58 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c     |   37 +++++++++++++++++++++++++++-
>  drivers/mmc/core/mmc_ops.c |   31 +++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.h |    1 +
>  include/linux/mmc/card.h   |    4 +++
>  include/linux/mmc/core.h   |    1 +
>  include/linux/mmc/mmc.h    |    3 ++
>  7 files changed, 134 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index eb3069d..06fd77c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -360,6 +360,64 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>  EXPORT_SYMBOL(mmc_wait_for_req);
>  
>  /**
> + *	mmc_interrupt_hpi - Issue for High priority Interrupt
> + *	@card: the MMC card associated with the HPI transfer
> + *
> + *	Issued High Priority Interrupt, and check for card status
> + *	util out-of prg-state.
> + */
> +int mmc_interrupt_hpi(struct mmc_card *card)
> +{
> +	int err;
> +	u32 status;
> +
> +	BUG_ON(!card);
> +
> +	if (!card->ext_csd.hpi_en) {
> +		pr_info("Didn't set HPI enable bit!\n");
> +		return 1;
> +	}
> +
> +	mmc_claim_host(card->host);
> +	err = mmc_send_status(card, &status);
> +	if (err) {
> +		pr_err("Didn't get card status!\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * If Card status is prg-state, can send HPI command
> +	 */
> +	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> +		do {
> +			/*
> +			 * Actually, didn't be ensure that
> +			 * HPI command is running exactly.
> +			 * So, need to resend HPI until out of prg-state.
> +			 * then check the card status with SEND_STATUS.
> +			 * If timeout error is occured(when send hpi command),
> +			 * that means already out of prg-state.
> +			 */
> +			err = mmc_send_hpi_cmd(card, &status);
> +			if (err)
> +				pr_debug("abort HPI (%d error)", err);
> +			else
> +				pr_debug("HPI success!!!\n");
> +
> +			err = mmc_send_status(card, &status);
> +			if (err)
> +				break;
> +		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> +	} else
> +		pr_debug("Already out of prg-state!!\n");
> +
> +out:
> +	mmc_release_host(card->host);
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_interrupt_hpi);
> +
> +/**
>   *	mmc_wait_for_cmd - start a command and wait for completion
>   *	@host: MMC host to start command
>   *	@cmd: MMC command to start
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5700b1c..ef312c9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -402,8 +402,26 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			ext_csd[EXT_CSD_TRIM_MULT];
>  	}
>  
> -	if (card->ext_csd.rev >= 5)
> +	if (card->ext_csd.rev >= 5) {
> +		/* check whether the eMMC card support HPI */
> +		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
> +			card->ext_csd.hpi = 1;
> +			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
> +				card->ext_csd.hpi_cmd =
> +						MMC_STOP_TRANSMISSION;
> +			else
> +				card->ext_csd.hpi_cmd =
> +						MMC_SEND_STATUS;
> +
> +			/*
> +			 * Indicate the maximum timeout to close
> +			 * a command interrupted by HPI
> +			 */
> +			card->ext_csd.out_of_int_time =
> +				ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] * 10;
> +		}
>  		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
> +	}
>  
>  	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>  		card->erased_byte = 0xFF;
> @@ -726,6 +744,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	}
>  
>  	/*
> +	 * Enable HPI feature (if supported)
> +	 */
> +	if (card->ext_csd.hpi) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_HPI_MGMT, 1, 0);
> +		if (err && err != -EBADMSG)
> +			goto free_card;
> +
> +		if (err) {
> +			printk(KERN_WARNING "%s: Enabling HPI failed\n",
> +				mmc_hostname(card->host));
> +			err = 0;
> +		} else
> +			card->ext_csd.hpi_en = 1;
> +	}
> +
> +	/*
>  	 * Compute bus speed.
>  	 */
>  	max_dtr = (unsigned int)-1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 770c3d0..4706400 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -547,3 +547,34 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
>  	err = mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
>  	return err;
>  }
> +
> +int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
> +{
> +	struct mmc_command cmd;
> +	unsigned int opcode;
> +	unsigned int flags;
> +	int err;
> +
> +	opcode = card->ext_csd.hpi_cmd;
> +	if (opcode == MMC_STOP_TRANSMISSION)
> +		flags = MMC_RSP_R1 | MMC_CMD_AC;
> +	else if (opcode == MMC_SEND_STATUS)
> +		flags = MMC_RSP_R1 | MMC_CMD_AC;
> +
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +	cmd.opcode = opcode;
> +	cmd.arg = card->rca << 16 | 1;
> +	cmd.flags = flags;
> +	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
> +
> +	err = mmc_wait_for_cmd(card->host, &cmd, 0);
> +	if (err) {
> +		printk(KERN_DEBUG "error %d interrupting operation"
> +			"HPI command response  %#x\n",
> +				err, cmd.resp[0]);
> +		return err;
> +	}
> +	if (status)
> +		*status = cmd.resp[0];
> +	return 0;
> +}
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 9276946..2a6e0db 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -17,6 +17,7 @@ int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_go_idle(struct mmc_host *host);
>  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
>  int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
> +int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
>  int mmc_set_relative_addr(struct mmc_card *card);
>  int mmc_send_csd(struct mmc_card *card, u32 *csd);
>  int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b460fc2..411054d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -64,10 +64,14 @@ struct mmc_ext_csd {
>  	unsigned long long	enhanced_area_offset;	/* Units: Byte */
>  	unsigned int		enhanced_area_size;	/* Units: KB */
>  	unsigned int		boot_size;		/* in bytes */
> +	bool			hpi_en;			/* HPI enablebit */
> +	bool			hpi;			/* HPI support bit */
> +	unsigned int		hpi_cmd;		/* cmd used as HPI */
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_erased_mem_count;	/* 181 */
>  	u8			raw_ext_csd_structure;	/* 194 */
>  	u8			raw_card_type;		/* 196 */
> +	u8			out_of_int_time;	/* 198 */
>  	u8			raw_s_a_timeout;		/* 217 */
>  	u8			raw_hc_erase_gap_size;	/* 221 */
>  	u8			raw_erase_timeout_mult;	/* 223 */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b8b1b7a..dca3c08 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -136,6 +136,7 @@ struct mmc_async_req;
>  
>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  					   struct mmc_async_req *, int *);
> +extern int mmc_interrupt_hpi(struct mmc_card *);
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
>  extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 5a794cb..e16c776 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -272,6 +272,7 @@ struct _mmc_csd {
>  
>  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>  #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
> +#define EXT_CSD_HPI_MGMT		161	/* R/W */
>  #define EXT_CSD_WR_REL_PARAM		166	/* RO */
>  #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
>  #define EXT_CSD_PART_CONFIG		179	/* R/W */
> @@ -281,6 +282,7 @@ struct _mmc_csd {
>  #define EXT_CSD_REV			192	/* RO */
>  #define EXT_CSD_STRUCTURE		194	/* RO */
>  #define EXT_CSD_CARD_TYPE		196	/* RO */
> +#define EXT_CSD_OUT_OF_INTERRUPT_TIME	198	/* RO */
>  #define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
>  #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
>  #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
> @@ -293,6 +295,7 @@ struct _mmc_csd {
>  #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
>  #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
>  #define EXT_CSD_TRIM_MULT		232	/* RO */
> +#define EXT_CSD_HPI_FEATURES		503	/* RO */
>  
>  /*
>   * EXT_CSD field definitions
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


