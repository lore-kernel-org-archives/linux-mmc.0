From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Wed, 4 Apr 2012 13:33:16 +0200
Message-ID: <4F7C317C.1040203@stericsson.com>
References: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:60832 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755251Ab2DDLdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Apr 2012 07:33:23 -0400
In-Reply-To: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>

On 03/30/2012 12:02 PM, Girish K S wrote:
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
> Signed-off-by: Saugata Das<saugata.das@linaro.org>
> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> ---
>   drivers/mmc/core/core.c  |   36 ++++++++++++++----------------------
>   drivers/mmc/core/core.h  |    1 +
>   drivers/mmc/core/mmc.c   |   20 +++++++++++++-------
>   include/linux/mmc/host.h |    1 +
>   4 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 14f262e..dc85ee1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1096,12 +1096,12 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>   	mmc_host_clk_release(host);
>   }
>
> -static void mmc_poweroff_notify(struct mmc_host *host)
> +int mmc_poweroff_notify(struct mmc_host *host)

A more generic comment; why is not this function implemented as a 
bus_ops function, similar how sleep for mmc is done? That would be more 
preferred I think.

>   {
>   	struct mmc_card *card;
>   	unsigned int timeout;
>   	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
> -	int err = 0;
> +	int err = -EINVAL;
>
>   	card = host->card;
>   	mmc_claim_host(host);
> @@ -1136,6 +1136,7 @@ static void mmc_poweroff_notify(struct mmc_host *host)
>   		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
>   	}
>   	mmc_release_host(host);
> +	return err;
>   }
>
>   /*
> @@ -1194,30 +1195,12 @@ static void mmc_power_up(struct mmc_host *host)
>
>   void mmc_power_off(struct mmc_host *host)
>   {
> -	int err = 0;
>   	mmc_host_clk_hold(host);
>
>   	host->ios.clock = 0;
>   	host->ios.vdd = 0;
>
>   	/*
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
> -
> -	/*
>   	 * Reset ocr mask to be the highest possible voltage supported for
>   	 * this mmc host. This value will be used at next power up.
>   	 */
> @@ -2076,6 +2059,7 @@ void mmc_stop_host(struct mmc_host *host)
>   	host->pm_flags = 0;
>
>   	mmc_bus_get(host);
> +	mmc_poweroff_notify(host);

We must not do mmc_poweroff_notify, without knowing we have a card 
attached through the bus_ops.

>   	if (host->bus_ops&&  !host->bus_dead) {
>   		/* Calling bus_ops->remove() with a claimed host can deadlock */
>   		if (host->bus_ops->remove)
> @@ -2112,7 +2096,8 @@ int mmc_power_save_host(struct mmc_host *host)
>
>   	if (host->bus_ops->power_save)
>   		ret = host->bus_ops->power_save(host);
> -
> +	host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> +	mmc_poweroff_notify(host);

Same comment as above.

Moreover, mmc_power_save_host is not working for eMMC cards supporting 
the SLEEP command (violating the eMMC spec for how VCC is cut). So, I am 
not sure we should introduce the poweroff_notify for the 
mmc_power_save_host right now. Better to fix SLEEP first, if needed at all.

Additionally, this function is only used for SDIO if runtime PM is 
enabled at the moment.

>   	mmc_bus_put(host);
>
>   	mmc_power_off(host);
> @@ -2135,7 +2120,7 @@ int mmc_power_restore_host(struct mmc_host *host)
>   		mmc_bus_put(host);
>   		return -EINVAL;
>   	}
> -
> +	host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;

Similar comments as for mmc_power_save_host

>   	mmc_power_up(host);
>   	ret = host->bus_ops->power_restore(host);
>
> @@ -2157,6 +2142,9 @@ int mmc_card_awake(struct mmc_host *host)
>   	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->awake)
>   		err = host->bus_ops->awake(host);
>
> +	if (!err)
> +		mmc_card_clr_sleep(host->card);
> +

This code must be handled from withing the bus_ops function instead, or 
you need to move it inside the "if" above, since the awake bus_ops only 
exist for (e)MMC. Moreover, you do not want to set the sleep state 
unless the sleep cmd really has been executed.

>   	mmc_bus_put(host);
>
>   	return err;
> @@ -2175,6 +2163,9 @@ int mmc_card_sleep(struct mmc_host *host)
>   	if (host->bus_ops&&  !host->bus_dead&&  host->bus_ops->sleep)
>   		err = host->bus_ops->sleep(host);
>
> +	if (!err)
> +		mmc_card_set_sleep(host->card);
> +

I think this code should be handled from withing the bus_ops function 
instead, or you need to move it inside the "if" above, since the awake 
bus_ops only exist for (e)MMC.

>   	mmc_bus_put(host);
>
>   	return err;
> @@ -2393,6 +2384,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>   			host->bus_ops->remove(host);
>
>   		mmc_claim_host(host);
> +		mmc_poweroff_notify(host);

This wont work if the card has been removed from the bus_ops->remove above.

>   		mmc_detach_bus(host);
>   		mmc_power_off(host);
>   		mmc_release_host(host);
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..0bdc0fd 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>   void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>   void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>   void mmc_power_off(struct mmc_host *host);
> +int mmc_poweroff_notify(struct mmc_host *host);
>
>   static inline void mmc_delay(unsigned int ms)
>   {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02914d6..885ad61 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,12 +1338,18 @@ static int mmc_suspend(struct mmc_host *host)
>   	BUG_ON(!host->card);
>
>   	mmc_claim_host(host);
> -	if (mmc_card_can_sleep(host)) {
> -		err = mmc_card_sleep(host);
> +	if (host->caps2&  MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND) {
1. missing whitespace after caps2
2. Can't we have an mmc_card_can_poweroff_notify to check instead, which 
also considering this new cap together with the card features.
> +		err = mmc_poweroff_notify(host);
>   		if (!err)
> -			mmc_card_set_sleep(host->card);
> -	} else if (!mmc_host_is_spi(host))
> +			goto out;
Suggest to remove the goto and just have another if-else, as we already 
have for sleep.
> +	}
> +
> +	if (mmc_card_can_sleep(host))
> +		err = mmc_card_sleep(host);
> +	else if (!mmc_host_is_spi(host))
>   		mmc_deselect_cards(host);
> +
> +out:	
>   	host->card->state&= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
>   	mmc_release_host(host);
>
> @@ -1364,11 +1370,11 @@ static int mmc_resume(struct mmc_host *host)
>   	BUG_ON(!host->card);
>
>   	mmc_claim_host(host);
> -	if (mmc_card_is_sleep(host->card)) {
> +	if (mmc_card_is_sleep(host->card))
>   		err = mmc_card_awake(host);
> -		mmc_card_clr_sleep(host->card);
> -	} else
> +	else
>   		err = mmc_init_card(host, host->ocr, host->card);
> +
>   	mmc_release_host(host);
>
>   	return err;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 33a4d08..3749a42 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -237,6 +237,7 @@ struct mmc_host {
>   #define MMC_CAP2_BROKEN_VOLTAGE	(1<<  7)	/* Use the broken voltage */
>   #define MMC_CAP2_DETECT_ON_ERR	(1<<  8)	/* On I/O err check card removal */
>   #define MMC_CAP2_HC_ERASE_SZ	(1<<  9)	/* High-capacity erase size */
> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND	(1<<  10)
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>   	unsigned int        power_notify_type;

Kind regards
Ulf Hansson
