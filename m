From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Add cache control for eMMC4.5 device
Date: Wed, 05 Oct 2011 14:47:01 +0300
Message-ID: <4E8C43B5.7020704@intel.com>
References: <1315466950-28973-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315466950-28973-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 08/09/11 10:29, Seungwon Jeon wrote:
> This patch adds cache feature of eMMC4.5 Spec.
> If device supports cache capability, host can utilize some specific
> operations.
>
> Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>
> ---
> This patch is base on [PATCH v3] mmc: core: Add default timeout value for CMD6
>
>   drivers/mmc/card/block.c |   14 ++++++----
>   drivers/mmc/core/core.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/mmc/core/mmc.c   |   23 +++++++++++++++++
>   include/linux/mmc/card.h |    2 +
>   include/linux/mmc/core.h |    2 +
>   include/linux/mmc/host.h |    3 ++
>   include/linux/mmc/mmc.h  |    3 ++
>   7 files changed, 103 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index e702c61..84fa4bb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -779,16 +779,18 @@ out:
>   static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
>   {
>   	struct mmc_blk_data *md = mq->data;
> +	struct mmc_card *card = md->queue.card;
> +	int ret = 0;
> +
> +	ret = mmc_flush_cache(card);
> +	if (ret)
> +		ret = -EIO;
>
> -	/*
> -	 * No-op, only service this because we need REQ_FUA for reliable
> -	 * writes.
> -	 */
>   	spin_lock_irq(&md->lock);
> -	__blk_end_request_all(req, 0);
> +	__blk_end_request_all(req, ret);
>   	spin_unlock_irq(&md->lock);
>
> -	return 1;
> +	return ret ? 0 : 1;
>   }
>
>   /*
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 557856b..14c2431 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1987,6 +1987,64 @@ int mmc_card_can_sleep(struct mmc_host *host)
>   }
>   EXPORT_SYMBOL(mmc_card_can_sleep);
>
> +/*
> + * Flush the cache to the non-volatile storage.
> + */
> +int mmc_flush_cache(struct mmc_card *card)
> +{
> +	struct mmc_host *host = card->host;
> +	int err = 0;
> +
> +	if (!(host->caps&  MMC_CAP_CACHE_CTRL))
> +		return err;
> +
> +	if (mmc_card_mmc(card)&&
> +			(card->ext_csd.cache_size>  0)&&
> +			(card->ext_csd.cache_ctrl&  1)) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				EXT_CSD_FLUSH_CACHE, 1, 0);
> +		if (err)
> +			pr_err("%s: cache flush error %d\n",
> +					mmc_hostname(card->host), err);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_flush_cache);
> +
> +/*
> + * Turn the cache ON/OFF.
> + * Turning the cache OFF shall trigger flushing of the data
> + * to the non-volatile storage.
> + */
> +int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
> +{
> +	struct mmc_card *card = host->card;
> +	int err = 0;
> +
> +	if (!(host->caps&  MMC_CAP_CACHE_CTRL))
> +		return err;
> +

This patch does not cover code paths for removable cards.
For clarity and in case a platform does not set non-removable
flags for eMMC, a check is needed here e.g.

	if (mmc_card_is_removable(host))
		return 0;

> +	if (card&&  mmc_card_mmc(card)&&
> +			(card->ext_csd.cache_size>  0)) {
> +		enable = !!enable;
> +
> +		if (card->ext_csd.cache_ctrl ^ enable)
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					EXT_CSD_CACHE_CTRL, enable, 0);
> +		if (err)
> +			pr_err("%s: cache %s error %d\n",
> +					mmc_hostname(card->host),
> +					enable ? "on" : "off",
> +					err);
> +		else
> +			card->ext_csd.cache_ctrl = enable;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_cache_ctrl);
> +
>   #ifdef CONFIG_PM
>
>   /**
> @@ -2001,6 +2059,9 @@ int mmc_suspend_host(struct mmc_host *host)
>   		cancel_delayed_work(&host->disable);
>   	cancel_delayed_work(&host->detect);
>   	mmc_flush_scheduled_work();
> +	err = mmc_cache_ctrl(host, 0);
> +	if (err)
> +		goto out;
>
>   	mmc_bus_get(host);
>   	if (host->bus_ops&&  !host->bus_dead) {
> @@ -2025,6 +2086,7 @@ int mmc_suspend_host(struct mmc_host *host)
>   	if (!err&&  !mmc_card_keep_power(host))
>   		mmc_power_off(host);
>
> +out:
>   	return err;
>   }
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ea58a0c..035112b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -419,6 +419,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		 */
>   		card->ext_csd.generic_cmd6_time = 0;
>
> +	card->ext_csd.cache_size =
> +		ext_csd[EXT_CSD_CACHE_SIZE + 0]<<  0 |
> +		ext_csd[EXT_CSD_CACHE_SIZE + 1]<<  8 |
> +		ext_csd[EXT_CSD_CACHE_SIZE + 2]<<  16 |
> +		ext_csd[EXT_CSD_CACHE_SIZE + 3]<<  24;
> +
>   out:
>   	return err;
>   }
> @@ -851,6 +857,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   		}
>   	}
>
> +	/*
> +	 * If cache size is higher than 0, this indicates
> +	 * the the existence of cache and it can be turned on.
> +	 */
> +	if ((host->caps&  MMC_CAP_CACHE_CTRL)&&
> +			card->ext_csd.cache_size>  0) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				EXT_CSD_CACHE_CTRL, 1, 0);
> +		if (err&&  err != -EBADMSG)
> +			goto free_card;
> +
> +		/*
> +		 * Only if no error, cache is turned on successfully.
> +		 */
> +		card->ext_csd.cache_ctrl = err ? 0 : 1;
> +	}
> +
>   	if (!oldcard)
>   		host->card = card;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b713abf..519660b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -50,6 +50,7 @@ struct mmc_ext_csd {
>   	u8			rel_sectors;
>   	u8			rel_param;
>   	u8			part_config;
> +	u8			cache_ctrl;
>   	unsigned int		part_time;		/* Units: ms */
>   	unsigned int		sa_timeout;		/* Units: 100ns */
>   	unsigned int		generic_cmd6_time;	/* Units: 10ms */
> @@ -65,6 +66,7 @@ struct mmc_ext_csd {
>   	unsigned long long	enhanced_area_offset;	/* Units: Byte */
>   	unsigned int		enhanced_area_size;	/* Units: KB */
>   	unsigned int		boot_size;		/* in bytes */
> +	unsigned int		cache_size;		/* Units: KB */
>   	u8			raw_partition_support;	/* 160 */
>   	u8			raw_erased_mem_count;	/* 181 */
>   	u8			raw_ext_csd_structure;	/* 194 */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b8b1b7a..45b4acf 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -171,6 +171,8 @@ extern void mmc_release_host(struct mmc_host *host);
>   extern void mmc_do_release_host(struct mmc_host *host);
>   extern int mmc_try_claim_host(struct mmc_host *host);
>
> +extern int mmc_flush_cache(struct mmc_card *);
> +
>   /**
>    *	mmc_claim_host - exclusively claim a host
>    *	@host: mmc host to claim
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4c4bddf..6d0006d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -230,6 +230,7 @@ struct mmc_host {
>   #define MMC_CAP_MAX_CURRENT_600	(1<<  28)	/* Host max current limit is 600mA */
>   #define MMC_CAP_MAX_CURRENT_800	(1<<  29)	/* Host max current limit is 800mA */
>   #define MMC_CAP_CMD23		(1<<  30)	/* CMD23 supported. */
> +#define MMC_CAP_CACHE_CTRL		(1<<  31)	/* Allow cache control. */
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>
> @@ -335,6 +336,8 @@ extern int mmc_power_restore_host(struct mmc_host *host);
>   extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
>   extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
>
> +extern int mmc_cache_ctrl(struct mmc_host *, u8);
> +
>   static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>   {
>   	host->ops->enable_sdio_irq(host, 0);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index e869f00..b7fa9f7 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -270,6 +270,8 @@ struct _mmc_csd {
>    * EXT_CSD fields
>    */
>
> +#define EXT_CSD_FLUSH_CACHE		32	/* W */
> +#define EXT_CSD_CACHE_CTRL		33	/* R/W */
>   #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
>   #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>   #define EXT_CSD_WR_REL_PARAM		166	/* RO */
> @@ -294,6 +296,7 @@ struct _mmc_csd {
>   #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
>   #define EXT_CSD_TRIM_MULT		232	/* RO */
>   #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
> +#define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
>
>   /*
>    * EXT_CSD field definitions
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
