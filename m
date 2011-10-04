From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V7] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 04 Oct 2011 19:52:10 +0900
Message-ID: <4E8AE55A.2030808@samsung.com>
References: <1317293169-16677-1-git-send-email-girish.shivananjappa@linaro.org>
 <1317293169-16677-2-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317293169-16677-2-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish..

i think this patch didn't base on latest for mmc-next..
i commented the below.

Regards,
Jaehoon Chung

On 09/29/2011 07:46 PM, Girish K S wrote:

> This patch adds the support for power off notify feature
> available in eMMC 4.5 devices.
>         If the the host has support for this feature, then the
> mmc core will notify it to the device by setting the
> POWER_OFF_NOTIFICATION byte in the extended csd register
> with a value 1(POWER_ON).
> 	For suspend mode short timeout is used, whereas for the 
> normal poweroff long timeout is used.
>         This patch is dependent on Seungwon Jeon's patch for
> CMD6 timeout.
> 
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in V2:
> 	Adds poweroff notification handling in suspend/normal
> Changes in V4:
> 	Updated with review comments of Jeon
> Changes in V5:
> 	This patch version fixes the problem with power off
> 	notify function, when called for the first time and
> 	card is not yet initialised.
> Changes in V6:
> 	Fixes checkpatch errors. The patches are generated after
> 	rebasing to chris's mmc-next branch.
> Changes in V7:
> 	Rebased to chris-mmc/mmc-next branch. merged to patches 
> 	to single patch.
>  drivers/mmc/core/core.c  |   37 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c   |   22 ++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c |   10 ++++++++++
>  include/linux/mmc/card.h |   21 +++++++++++++++++++++
>  include/linux/mmc/host.h |    5 +++++
>  include/linux/mmc/mmc.h  |    6 ++++++
>  6 files changed, 101 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9698d8a..5fb2120 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1198,11 +1198,46 @@ static void mmc_power_up(struct mmc_host *host)
>  
>  void mmc_power_off(struct mmc_host *host)
>  {
> +	struct mmc_card *card;
> +	unsigned int notify_type;
> +	unsigned int timeout;
> +	int err;
> +
> +	BUG_ON(!host);
> +
>  	mmc_host_clk_hold(host);
>  
> +	card = host->card;
>  	host->ios.clock = 0;
>  	host->ios.vdd = 0;
>  
> +	if (card != NULL && mmc_card_mmc(card) &&
> +	    (mmc_card_powernotify_on(card))) {
> +
> +		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
> +			notify_type = EXT_CSD_POWER_OFF_SHORT;
> +			timeout = card->ext_csd.generic_cmd6_time;
> +			mmc_card_set_powernotify_short(card);
> +		} else {
> +			notify_type = EXT_CSD_POWER_OFF_LONG;
> +			timeout = card->ext_csd.power_off_longtime;
> +			mmc_card_set_powernotify_long(card);
> +		}
> +
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 EXT_CSD_POWER_OFF_NOTIFICATION,
> +				 notify_type, timeout);
> +
> +		if (err && err != -EBADMSG)
> +			pr_err("Device failed to respond "
> +			       "within %d poweroff time."
> +			       "forcefully powering down"
> +			       "the device\n", timeout);
> +
> +		/* Set the card state to no notification after the poweroff */
> +		mmc_card_set_powernotify_off(card);
> +	}
> +
>  	/*
>  	 * Reset ocr mask to be the highest possible voltage supported for
>  	 * this mmc host. This value will be used at next power up.
> @@ -2194,6 +2230,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  
>  		spin_lock_irqsave(&host->lock, flags);
>  		host->rescan_disable = 1;
> +		host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		cancel_delayed_work_sync(&host->detect);
>  
> @@ -2217,6 +2254,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  
>  		spin_lock_irqsave(&host->lock, flags);
>  		host->rescan_disable = 0;
> +		host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		mmc_detect_change(host, 0);
>  
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f28aa4f..25ba7f5 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -447,6 +447,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	else
>  		card->erased_byte = 0x0;
>  
> +	if (card->ext_csd.rev >= 6) {
> +		card->ext_csd.power_off_longtime = 10 *
> +			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
> +	}
> +
>  out:
>  	return err;
>  }
> @@ -829,6 +834,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	}
>  
>  	/*
> +	 * If the host supports the power_off_notify capability then
> +	 * set the notification byte in the ext_csd register of device
> +	 */
> +	if (host->caps2 & MMC_CAP_POWEROFF_NOTIFY &&
> +	    (mmc_card_powernotify_off(card))) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 EXT_CSD_POWER_OFF_NOTIFICATION,
> +				 EXT_CSD_POWER_ON,
> +				 card->ext_csd.generic_cmd6_time);
> +		if (err && err != -EBADMSG)
> +			goto free_card;
> +	}
> +


you used host->caps2, i think right that should be use
MMC_CAP2_POWEROFF_NOTIFY.

> +	if (!err)
> +		mmc_card_set_powernotify_on(card);
> +
> +	/*
>  	 * Activate high speed (if supported)
>  	 */
>  	if (card->ext_csd.hs_max_dtr != 0) {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4220133..2818238 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2599,6 +2599,16 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps[1] & SDHCI_DRIVER_TYPE_D)
>  		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
>  
> +	/*
> +	 * If Notify capability is enabled and
> +	 * notify type is not initialised by host, set default to
> +	 * long power off notify timeout value
> +	 */
> +	if (mmc->caps2 & MMC_CAP_POWEROFF_NOTIFY)
> +		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> +	else
> +		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
> +


also here...

>  	/* Initial value for re-tuning timer count */
>  	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>  			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 15e5ce2..d6f8c85 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -53,6 +53,8 @@ struct mmc_ext_csd {
>  	u8			rst_n_function;
>  	unsigned int		part_time;		/* Units: ms */
>  	unsigned int		sa_timeout;		/* Units: 100ns */
> +	unsigned int            generic_cmd6_time;      /* Units: ms */
> +	unsigned int            power_off_longtime;     /* Units: ms */
>  	unsigned int		hs_max_dtr;
>  	unsigned int		sectors;
>  	unsigned int		card_type;
> @@ -192,6 +194,11 @@ struct mmc_card {
>  #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
>  #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
>  						/* byte mode */
> +	unsigned int    poweroff_notify_state;	/* eMMC4.5 notify feature */
> +#define MMC_NO_POWER_NOTIFICATION	0
> +#define MMC_POWERED_ON			1
> +#define MMC_POWEROFF_SHORT		2
> +#define MMC_POWEROFF_LONG		3
>  
>  	unsigned int		erase_size;	/* erase size in sectors */
>   	unsigned int		erase_shift;	/* if erase unit is power 2 */
> @@ -329,6 +336,20 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>  
> +#define mmc_card_powernotify_on(c)     \
> +		 ((c)->poweroff_notify_state == MMC_POWERED_ON)
> +#define mmc_card_powernotify_off(c)    \
> +		 ((c)->poweroff_notify_state == MMC_NO_POWER_NOTIFICATION)
> +
> +#define mmc_card_set_powernotify_off(c)    \
> +		 ((c)->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION)
> +#define mmc_card_set_powernotify_on(c) \
> +		 ((c)->poweroff_notify_state = MMC_POWERED_ON)
> +#define mmc_card_set_powernotify_short(c)  \
> +		 ((c)->poweroff_notify_state = MMC_POWEROFF_SHORT)
> +#define mmc_card_set_powernotify_long(c)   \
> +		 ((c)->poweroff_notify_state = MMC_POWEROFF_LONG)
> +
>  /*
>   * Quirk add/remove for MMC products.
>   */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f62ffa2..b711a00 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -245,8 +245,13 @@ struct mmc_host {
>  #define MMC_CAP_HS200_1_8V_SDR	(1 << 2)	/* can support */
>  #define MMC_CAP_HS200_1_2V_SDR	(1 << 3)	/* can support */
>  #define MMC_CAP_HIGHSPEED_200	(1 << 4)	/* Can do MMC HS200 timing */
> +#define MMC_CAP_POWEROFF_NOTIFY	(1 << 31)	/* Notify poweroff supported */
>  
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
> +	unsigned int        power_notify_type;
> +#define MMC_HOST_PW_NOTIFY_NONE		0
> +#define MMC_HOST_PW_NOTIFY_SHORT	1
> +#define MMC_HOST_PW_NOTIFY_LONG		2
>  
>  #ifdef CONFIG_MMC_CLKGATE
>  	int			clk_requests;	/* internal reference counter */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 3f2e210..944c99b 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -271,6 +271,7 @@ struct _mmc_csd {
>   * EXT_CSD fields
>   */
>  
> +#define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
>  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>  #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>  #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
> @@ -348,6 +349,11 @@ struct _mmc_csd {
>  #define EXT_CSD_RST_N_EN_MASK	0x3
>  #define EXT_CSD_RST_N_ENABLED	1	/* RST_n is enabled on card */
>  
> +#define EXT_CSD_NO_POWER_NOTIFICATION	0
> +#define EXT_CSD_POWER_ON		1
> +#define EXT_CSD_POWER_OFF_SHORT		2
> +#define EXT_CSD_POWER_OFF_LONG		3
> +
>  #define EXT_CSD_PWR_CL_8BIT_MASK	0xF0	/* 8 bit PWR CLS */
>  #define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
>  #define EXT_CSD_PWR_CL_8BIT_SHIFT	4
