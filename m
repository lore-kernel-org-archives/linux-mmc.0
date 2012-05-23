From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Wed, 23 May 2012 13:30:23 +0530
Message-ID: <4FBC9917.8090108@codeaurora.org>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:1458 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab2EWIA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 May 2012 04:00:29 -0400
In-Reply-To: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, ulf.hansson@stericsson.com, saugata.das@linaro.org


Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

On 5/22/2012 5:15 PM, Girish K S wrote:
> From: Saugata Das<saugata.das@linaro.org>
>
> This is a rework of the existing POWER OFF NOTIFY patch. The current problem
> with the patch comes from the ambiguity on the usage of POWER OFF NOTIFY
> together with SLEEP and misunderstanding on the usage of MMC_POWER_OFF
> power_mode from mmc_set_ios in different host controller drivers.
>
> This new patch works around this problem by adding a new host CAP,
> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected that host
> controller drivers will set this CAP, if they switch off both Vcc and Vccq
> from MMC_POWER_OFF condition within mmc_set_ios. However, note that there
> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched off.
>
> This patch also sends POWER OFF NOTIFY from power management routines (e.g.
> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host), which
> does reinitialization of the eMMC on the return path of the power management
> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE,
> mmc_start_host).
>
> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is sent from
> the suspend sequence. If it is sent from shutdown sequence then it is set to
> POWER_OFF_LONG.
>
> Earlier implementation of PowerOff Notify as a core function is replaced as
> a device's bus operation.
>
> Signed-off-by: Saugata Das<saugata.das@linaro.org>
> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>
> changes in v5:
> 	modified the the handling of return value in mmc_poweroff_notify.
> changes in v4:
> 	As suggested in review,
> 	- Moved mmc_can_poweroff_notify to core.c
> 	- Moved mmc_claim_host, mmc_release_host outside mmc_poweroff_notify
> 	- Added check for wrong initialization for poweroff_notify_type
> 	- mmc_poweroff_notify is modified to take as 2nd parameter
> changes in v3:
> 	This version addresses the review comments given by Subhash and Ulf
> changes in v2:
> 	This version addresses the changes suggested by Ulf
> ---
>   drivers/mmc/core/core.c   |  108 ++++++++++++++++++--------------------------
>   drivers/mmc/core/core.h   |    1 +
>   drivers/mmc/core/mmc.c    |   56 ++++++++++++++++++++---
>   drivers/mmc/host/dw_mmc.c |    5 --
>   drivers/mmc/host/sdhci.c  |    9 ----
>   include/linux/mmc/card.h  |    5 +-
>   include/linux/mmc/core.h  |    1 +
>   include/linux/mmc/host.h  |    5 +--
>   include/linux/mmc/mmc.h   |    7 +++
>   9 files changed, 104 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..fe616b9 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1101,48 +1101,6 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>   	mmc_host_clk_release(host);
>   }
>
> -static void mmc_poweroff_notify(struct mmc_host *host)
> -{
> -	struct mmc_card *card;
> -	unsigned int timeout;
> -	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
> -	int err = 0;
> -
> -	card = host->card;
> -	mmc_claim_host(host);
> -
> -	/*
> -	 * Send power notify command only if card
> -	 * is mmc and notify state is powered ON
> -	 */
> -	if (card&&  mmc_card_mmc(card)&&
> -	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
> -
> -		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
> -			notify_type = EXT_CSD_POWER_OFF_SHORT;
> -			timeout = card->ext_csd.generic_cmd6_time;
> -			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
> -		} else {
> -			notify_type = EXT_CSD_POWER_OFF_LONG;
> -			timeout = card->ext_csd.power_off_longtime;
> -			card->poweroff_notify_state = MMC_POWEROFF_LONG;
> -		}
> -
> -		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -				 EXT_CSD_POWER_OFF_NOTIFICATION,
> -				 notify_type, timeout);
> -
> -		if (err&&  err != -EBADMSG)
> -			pr_err("Device failed to respond within %d poweroff "
> -			       "time. Forcefully powering down the device\n",
> -			       timeout);
> -
> -		/* Set the card state to no notification after the poweroff */
> -		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
> -	}
> -	mmc_release_host(host);
> -}
> -
>   /*
>    * Apply power to the MMC stack.  This is a two-stage process.
>    * First, we enable power to the card without the clock running.
> @@ -1202,8 +1160,6 @@ static void mmc_power_up(struct mmc_host *host)
>
>   void mmc_power_off(struct mmc_host *host)
>   {
> -	int err = 0;
> -
>   	if (host->ios.power_mode == MMC_POWER_OFF)
>   		return;
>
> @@ -1212,22 +1168,6 @@ void mmc_power_off(struct mmc_host *host)
>   	host->ios.clock = 0;
>   	host->ios.vdd = 0;
>
> -	/*
> -	 * For eMMC 4.5 device send AWAKE command before
> -	 * POWER_OFF_NOTIFY command, because in sleep state
> -	 * eMMC 4.5 devices respond to only RESET and AWAKE cmd
> -	 */
> -	if (host->card&&  mmc_card_is_sleep(host->card)&&
> -	    host->bus_ops->resume) {
> -		err = host->bus_ops->resume(host);
> -
> -		if (!err)
> -			mmc_poweroff_notify(host);
> -		else
> -			pr_warning("%s: error %d during resume "
> -				   "(continue with poweroff sequence)\n",
> -				   mmc_hostname(host), err);
> -	}
>
>   	/*
>   	 * Reset ocr mask to be the highest possible voltage supported for
> @@ -1726,6 +1666,15 @@ int mmc_can_secure_erase_trim(struct mmc_card *card)
>   }
>   EXPORT_SYMBOL(mmc_can_secure_erase_trim);
>
> +int mmc_can_poweroff_notify(const struct mmc_card *card)
> +{
> +	return card&&
> +		mmc_card_mmc(card)&&
> +		card->host->bus_ops->poweroff_notify&&
> +		(card->poweroff_notify_state == MMC_POWERED_ON);
> +}
> +EXPORT_SYMBOL(mmc_can_poweroff_notify);
> +
>   int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
>   			    unsigned int nr)
>   {
> @@ -2096,6 +2045,15 @@ void mmc_stop_host(struct mmc_host *host)
>
>   	mmc_bus_get(host);
>   	if (host->bus_ops&&  !host->bus_dead) {
> +		mmc_claim_host(host);
> +		if (mmc_can_poweroff_notify(host->card)) {
> +			int err = host->bus_ops->poweroff_notify(host,
> +						MMC_PW_OFF_NOTIFY_LONG);
> +			if (err)
> +				pr_info("%s: error [%d] in poweroff notify\n",
> +					mmc_hostname(host), err);
> +		}
> +		mmc_release_host(host);
>   		/* Calling bus_ops->remove() with a claimed host can deadlock */
>   		if (host->bus_ops->remove)
>   			host->bus_ops->remove(host);
> @@ -2131,6 +2089,15 @@ int mmc_power_save_host(struct mmc_host *host)
>
>   	if (host->bus_ops->power_save)
>   		ret = host->bus_ops->power_save(host);
> +	mmc_claim_host(host);
> +	if (mmc_can_poweroff_notify(host->card)) {
> +		int err = host->bus_ops->poweroff_notify(host,
> +					MMC_PW_OFF_NOTIFY_SHORT);
> +		if (err)
> +			pr_info("%s: error [%d] in poweroff notify\n",
> +				mmc_hostname(host), err);
> +	}
> +	mmc_release_host(host);
>
>   	mmc_bus_put(host);
>
> @@ -2173,8 +2140,11 @@ int mmc_card_awake(struct mmc_host *host)
>
>   	mmc_bus_get(host);
>
> -	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->awake)
> +	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->awake) {
>   		err = host->bus_ops->awake(host);
> +		if (!err)
> +			mmc_card_clr_sleep(host->card);
> +	}
>
>   	mmc_bus_put(host);
>
> @@ -2191,8 +2161,11 @@ int mmc_card_sleep(struct mmc_host *host)
>
>   	mmc_bus_get(host);
>
> -	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->sleep)
> +	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->sleep) {
>   		err = host->bus_ops->sleep(host);
> +		if (!err)
> +			mmc_card_set_sleep(host->card);
> +	}
>
>   	mmc_bus_put(host);
>
> @@ -2385,12 +2358,20 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>
>   		spin_lock_irqsave(&host->lock, flags);
>   		host->rescan_disable = 1;
> -		host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
>   		spin_unlock_irqrestore(&host->lock, flags);
>   		cancel_delayed_work_sync(&host->detect);
>
>   		if (!host->bus_ops || host->bus_ops->suspend)
>   			break;
> +		mmc_claim_host(host);
> +		if (mmc_can_poweroff_notify(host->card)) {
> +			int err = host->bus_ops->poweroff_notify(host,
> +						MMC_PW_OFF_NOTIFY_SHORT);
> +			if (err)
> +				pr_info("%s: error [%d] in poweroff notify\n",
> +					mmc_hostname(host), err);
> +		}
> +		mmc_release_host(host);
>
>   		/* Calling bus_ops->remove() with a claimed host can deadlock */
>   		if (host->bus_ops->remove)
> @@ -2409,7 +2390,6 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>
>   		spin_lock_irqsave(&host->lock, flags);
>   		host->rescan_disable = 0;
> -		host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
>   		spin_unlock_irqrestore(&host->lock, flags);
>   		mmc_detect_change(host, 0);
>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..15b918d 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
>   	int (*power_save)(struct mmc_host *);
>   	int (*power_restore)(struct mmc_host *);
>   	int (*alive)(struct mmc_host *);
> +	int (*poweroff_notify)(struct mmc_host *, int notify);
>   };
>
>   void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2f0e11c..042dbdc 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1259,6 +1259,40 @@ err:
>   	return err;
>   }
>
> +static int mmc_poweroff_notify(struct mmc_host *host, int notify)
> +{
> +	struct mmc_card *card;
> +	unsigned int timeout;
> +	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
> +	int err;
> +
> +	card = host->card;
> +
> +	if (notify == MMC_PW_OFF_NOTIFY_SHORT) {
> +		notify_type = EXT_CSD_POWER_OFF_SHORT;
> +		timeout = card->ext_csd.generic_cmd6_time;
> +	} else if (notify == MMC_PW_OFF_NOTIFY_LONG) {
> +		notify_type = EXT_CSD_POWER_OFF_LONG;
> +		timeout = card->ext_csd.power_off_longtime;
> +	} else {
> +		pr_info("%s: mmc_poweroff_notify called "
> +		        "with notify type %d\n", mmc_hostname(host), notify);
> +		return -EINVAL;
> +	}
> +
> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			 EXT_CSD_POWER_OFF_NOTIFICATION,
> +			 notify_type, timeout);
> +
> +	if (err)
> +		pr_err("%s: Device failed to respond within %d "
> +		       "poweroff timeout.\n", mmc_hostname(host), timeout);
> +	else
> +		card->poweroff_notify_state =
> +					MMC_NO_POWER_NOTIFICATION;
> +
> +	return err;
> +}
>   /*
>    * Host is being removed. Free up the current card.
>    */
> @@ -1319,13 +1353,18 @@ static int mmc_suspend(struct mmc_host *host)
>   	BUG_ON(!host->card);
>
>   	mmc_claim_host(host);
> -	if (mmc_card_can_sleep(host)) {
> -		err = mmc_card_sleep(host);
> -		if (!err)
> -			mmc_card_set_sleep(host->card);
> -	} else if (!mmc_host_is_spi(host))
> -		mmc_deselect_cards(host);
> -	host->card->state&= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
> +	if (mmc_can_poweroff_notify(host->card)&&
> +		(host->caps2&  MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND)) {
> +		err = mmc_poweroff_notify(host, MMC_PW_OFF_NOTIFY_SHORT);
> +	} else {
> +		if (mmc_card_can_sleep(host))
> +			err = mmc_card_sleep(host);
> +		else if (!mmc_host_is_spi(host))
> +			mmc_deselect_cards(host);
> +	}
> +	if (!err)
> +		host->card->state&=
> +			~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
>   	mmc_release_host(host);
>
>   	return err;
> @@ -1347,7 +1386,6 @@ static int mmc_resume(struct mmc_host *host)
>   	mmc_claim_host(host);
>   	if (mmc_card_is_sleep(host->card)) {
>   		err = mmc_card_awake(host);
> -		mmc_card_clr_sleep(host->card);
>   	} else
>   		err = mmc_init_card(host, host->ocr, host->card);
>   	mmc_release_host(host);
> @@ -1407,6 +1445,7 @@ static const struct mmc_bus_ops mmc_ops = {
>   	.resume = NULL,
>   	.power_restore = mmc_power_restore,
>   	.alive = mmc_alive,
> +	.poweroff_notify = mmc_poweroff_notify,
>   };
>
>   static const struct mmc_bus_ops mmc_ops_unsafe = {
> @@ -1418,6 +1457,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
>   	.resume = mmc_resume,
>   	.power_restore = mmc_power_restore,
>   	.alive = mmc_alive,
> +	.poweroff_notify = mmc_poweroff_notify,
>   };
>
>   static void mmc_attach_bus_ops(struct mmc_host *host)
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1532357..463130f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1788,11 +1788,6 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>   	if (host->pdata->quirks&  DW_MCI_QUIRK_HIGHSPEED)
>   		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>
> -	if (mmc->caps2&  MMC_CAP2_POWEROFF_NOTIFY)
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> -	else
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
> -
>   	if (host->pdata->blk_settings) {
>   		mmc->max_segs = host->pdata->blk_settings->max_segs;
>   		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e626732..c0a5a91 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2812,15 +2812,6 @@ int sdhci_add_host(struct sdhci_host *host)
>   	if (caps[1]&  SDHCI_DRIVER_TYPE_D)
>   		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
>
> -	/*
> -	 * If Power Off Notify capability is enabled by the host,
> -	 * set notify to short power off notify timeout value.
> -	 */
> -	if (mmc->caps2&  MMC_CAP2_POWEROFF_NOTIFY)
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> -	else
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
> -
>   	/* Initial value for re-tuning timer count */
>   	host->tuning_count = (caps[1]&  SDHCI_RETUNING_TIMER_COUNT_MASK)>>
>   			SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d76513b..040eec4 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -239,11 +239,10 @@ struct mmc_card {
>   #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
>   #define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time>  CSD says */
>   						/* byte mode */
> -	unsigned int    poweroff_notify_state;	/* eMMC4.5 notify feature */
> +	unsigned int		poweroff_notify_state; /* MMC-4.5 poweroff
> +							notify feature */
>   #define MMC_NO_POWER_NOTIFICATION	0
>   #define MMC_POWERED_ON			1
> -#define MMC_POWEROFF_SHORT		2
> -#define MMC_POWEROFF_LONG		3
>
>   	unsigned int		erase_size;	/* erase size in sectors */
>    	unsigned int		erase_shift;	/* if erase unit is power 2 */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 1b431c7..54894d6 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -161,6 +161,7 @@ extern int mmc_can_trim(struct mmc_card *card);
>   extern int mmc_can_discard(struct mmc_card *card);
>   extern int mmc_can_sanitize(struct mmc_card *card);
>   extern int mmc_can_secure_erase_trim(struct mmc_card *card);
> +extern int mmc_can_poweroff_notify(const struct mmc_card *card);
>   extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
>   				   unsigned int nr);
>   extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..0e9adac 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,12 +238,9 @@ struct mmc_host {
>   #define MMC_CAP2_BROKEN_VOLTAGE	(1<<  7)	/* Use the broken voltage */
>   #define MMC_CAP2_DETECT_ON_ERR	(1<<  8)	/* On I/O err check card removal */
>   #define MMC_CAP2_HC_ERASE_SZ	(1<<  9)	/* High-capacity erase size */
> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND	(1<<  10)
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
> -	unsigned int        power_notify_type;
> -#define MMC_HOST_PW_NOTIFY_NONE		0
> -#define MMC_HOST_PW_NOTIFY_SHORT	1
> -#define MMC_HOST_PW_NOTIFY_LONG		2
>
>   #ifdef CONFIG_MMC_CLKGATE
>   	int			clk_requests;	/* internal reference counter */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d425cab..b11876b 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -386,4 +386,11 @@ struct _mmc_csd {
>   #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
>   #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
>
> +/*
> + * MMC Poweroff Notify types
> + */
> +#define MMC_PW_OFF_NOTIFY_NONE		0
> +#define MMC_PW_OFF_NOTIFY_SHORT		1
> +#define MMC_PW_OFF_NOTIFY_LONG		2
> +
>   #endif /* LINUX_MMC_MMC_H */

