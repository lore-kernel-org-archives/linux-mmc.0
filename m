From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH v12] mmc: support BKOPS feature for eMMC
Date: Tue, 18 Sep 2012 08:36:00 +0900
Message-ID: <5057B3E0.9050203@samsung.com>
References: <5056E25A.6070207@samsung.com> <m3wqztx7op.fsf@pullcord.laptop.org>
 <5056FD8E.5090200@samsung.com> <5056FEF8.6040700@samsung.com>
 <m3obl4yh4d.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59251 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab2IQXgT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 19:36:19 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAI00GA0PKGVP70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Sep 2012 08:36:17 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAI00ERDPKGG2B0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Sep 2012 08:36:16 +0900 (KST)
In-reply-to: <m3obl4yh4d.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Minchan Kim <minchan@kernel.org>

On 09/17/2012 09:21 PM, Chris Ball wrote:
> Hi Jaehoon,
> 
> On Mon, Sep 17 2012, Jaehoon Chung wrote:
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. Immediately run BKOPS if required.
>> read/write operations should be requested during BKOPS(LEVEL-1),
>> then issue HPI to interrupt the ongoing BKOPS 
>> and service the foreground operation.
>> (This patch is only control the LEVEL2/3.)
>>
>> When repeating the writing 1GB data, at a certain time, performance is decreased.
>> At that time, card is also triggered the Level-3 or Level-2.
>> After running bkops, performance is recovered.
>>
>> Future considerations
>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>  * Interrupt ongoing BKOPS before powering off the card.
>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>>  * If use periodic bkops, also consider runtime_pm control.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> Reviewed-by: Maya Erez <merez@codeaurora.org>
> 
> Thanks, looks good now.  Is it okay if I apply this stylistic patch
> before pushing to mmc-next?
Sure, Thanks Chris.

Best Regards,
Jaehoon Chung
> 
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4749557..044cd01 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -43,8 +43,8 @@
>  #include "sdio_ops.h"
>  
>  /*
> - * The Background operation can take a long time, depends on the house keeping
> - * operations the card has to peform
> + * Background operations can take a long time, depending on the housekeeping
> + * operations the card has to perform.
>   */
>  #define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
>  
> @@ -255,11 +255,11 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  /**
>   *	mmc_start_bkops - start BKOPS for supported cards
>   *	@card: MMC card to start BKOPS
> - *	@form_exception: A flags to indicate if this function was
> - *			called due to an exception raised by the card
> + *	@form_exception: A flag to indicate if this function was
> + *			 called due to an exception raised by the card
>   *
>   *	Start background operations whenever requested.
> - *	when the urgent BKOPS bit is set in a R1 command response
> + *	When the urgent BKOPS bit is set in a R1 command response
>   *	then background operations should be started immediately.
>  */
>  void mmc_start_bkops(struct mmc_card *card, bool from_exception)
> @@ -275,7 +275,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  
>  	err = mmc_read_bkops_status(card);
>  	if (err) {
> -		pr_err("%s: Didn't read bkops status : %d\n",
> +		pr_err("%s: Failed to read bkops status: %d\n",
>  		       mmc_hostname(card->host), err);
>  		return;
>  	}
> @@ -283,8 +283,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  	if (!card->ext_csd.raw_bkops_status)
>  		return;
>  
> -	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2
> -	    && (from_exception))
> +	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2 &&
> +	    from_exception)
>  		return;
>  
>  	mmc_claim_host(card->host);
> @@ -299,8 +299,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal);
>  	if (err) {
> -		pr_warn("%s: error %d starting bkops\n",
> -			   mmc_hostname(card->host), err);
> +		pr_warn("%s: Error %d starting bkops\n",
> +			mmc_hostname(card->host), err);
>  		goto out;
>  	}
>  
> @@ -429,9 +429,9 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  		 * Check BKOPS urgency for each R1 response
>  		 */
>  		if (host->card && mmc_card_mmc(host->card) &&
> -		((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
> -		 (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
> -		(host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
> +		    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
> +		     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
> +		    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
>  			mmc_start_bkops(host->card, true);
>  	}
>  
> @@ -477,7 +477,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
>   *	@card: the MMC card associated with the HPI transfer
>   *
>   *	Issued High Priority Interrupt, and check for card status
> - *	util out-of prg-state.
> + *	until out-of prg-state.
>   */
>  int mmc_interrupt_hpi(struct mmc_card *card)
>  {
> @@ -572,8 +572,8 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
>   *	mmc_stop_bkops - stop ongoing BKOPS
>   *	@card: MMC card to check BKOPS
>   *
> - *	Send HPI command to stop ongoing background operations,
> - *	to allow rapid servicing of foreground operations,e.g. read/
> + *	Send HPI command to stop ongoing background operations to
> + *	allow rapid servicing of foreground operations, e.g. read/
>   *	writes. Wait until the card comes out of the programming state
>   *	to avoid errors in servicing read/write requests.
>   */
> @@ -585,8 +585,8 @@ int mmc_stop_bkops(struct mmc_card *card)
>  	err = mmc_interrupt_hpi(card);
>  
>  	/*
> -	 * if err is EINVAL, it's status that can't issue HPI.
> -	 * it should complete the BKOPS.
> +	 * If err is EINVAL, we can't issue an HPI.
> +	 * It should complete the BKOPS.
>  	 */
>  	if (!err || (err == -EINVAL)) {
>  		mmc_card_clr_doing_bkops(card);
> @@ -603,12 +603,12 @@ int mmc_read_bkops_status(struct mmc_card *card)
>  	u8 *ext_csd;
>  
>  	/*
> -	 * In future work, we should be consider storing the entire ext_csd.
> +	 * In future work, we should consider storing the entire ext_csd.
>  	 */
>  	ext_csd = kmalloc(512, GFP_KERNEL);
>  	if (!ext_csd) {
> -		pr_err("%s: could not allocate a buffer to "
> -			"receive the ext_csd.\n", mmc_hostname(card->host));
> +		pr_err("%s: could not allocate buffer to receive the ext_csd.\n",
> +		       mmc_hostname(card->host));
>  		return -ENOMEM;
>  	}
>  
> @@ -2470,15 +2470,14 @@ int mmc_suspend_host(struct mmc_host *host)
>  
>  	mmc_bus_get(host);
>  	if (host->bus_ops && !host->bus_dead) {
> -
>  		if (host->bus_ops->suspend) {
>  			if (mmc_card_doing_bkops(host->card)) {
>  				err = mmc_stop_bkops(host->card);
>  				if (err)
>  					goto out;
>  			}
> -		}
>  			err = host->bus_ops->suspend(host);
> +		}
>  
>  		if (err == -ENOSYS || !host->bus_ops->resume) {
>  			/*
> @@ -2566,10 +2565,10 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
>  		if (host->card && mmc_card_mmc(host->card) &&
> -				mmc_card_doing_bkops(host->card)) {
> +		    mmc_card_doing_bkops(host->card)) {
>  			err = mmc_stop_bkops(host->card);
>  			if (err) {
> -				pr_err("%s didn't stop bkops\n",
> +				pr_err("%s: didn't stop bkops\n",
>  					mmc_hostname(host));
>  				return err;
>  			}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9c5caa6..7509de1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -463,15 +463,15 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	}
>  
>  	if (card->ext_csd.rev >= 5) {
> -		/* check whether the eMMC card support BKOPS */
> +		/* check whether the eMMC card supports BKOPS */
>  		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>  			card->ext_csd.bkops = 1;
>  			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
>  			card->ext_csd.raw_bkops_status =
>  				ext_csd[EXT_CSD_BKOPS_STATUS];
>  			if (!card->ext_csd.bkops_en)
> -				pr_info("%s: Didn't set BKOPS_EN bit!\n",
> -						mmc_hostname(card->host));
> +				pr_info("%s: BKOPS_EN bit is not set\n",
> +					mmc_hostname(card->host));
>  		}
>  
>  		/* check whether the eMMC card supports HPI */
> 

