From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: core: Add default timeout value for CMD6.
Date: Tue, 04 Oct 2011 16:11:04 +0300
Message-ID: <4E8B05E8.2030206@intel.com>
References: <1316657541-9221-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1316657541-9221-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 22/09/11 05:12, Seungwon Jeon wrote:
> EXT_CSD[248] includes the default maximum timeout for CMD6.
> This field is added at eMMC4.5 Spec. And it can be used for default
> timeout except for some operations which don't define the timeout(i.e.
> background operation, sanitize, flush cache) in eMMC4.5 Spec.
>
> Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>

What about the mmc_switch() in mmc_select_powerclass()?

> ---
>   drivers/mmc/core/mmc.c   |   16 ++++++++++++----
>   include/linux/mmc/card.h |    1 +
>   include/linux/mmc/mmc.h  |    1 +
>   3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5700b1c..b2ee14a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -410,6 +410,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   	else
>   		card->erased_byte = 0x0;
>
> +	if (card->ext_csd.rev>= 6)
> +		card->ext_csd.generic_cmd6_time = 10 *
> +			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
> +	else
> +		card->ext_csd.generic_cmd6_time = 0;
> +
>   out:
>   	return err;
>   }
> @@ -668,7 +674,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   	 */
>   	if (card->ext_csd.enhanced_area_en) {
>   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -				 EXT_CSD_ERASE_GROUP_DEF, 1, 0);
> +				 EXT_CSD_ERASE_GROUP_DEF, 1,
> +				 card->ext_csd.generic_cmd6_time);
>
>   		if (err&&  err != -EBADMSG)
>   			goto free_card;
> @@ -711,7 +718,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   	if ((card->ext_csd.hs_max_dtr != 0)&&
>   		(host->caps&  MMC_CAP_MMC_HIGHSPEED)) {
>   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -				 EXT_CSD_HS_TIMING, 1, 0);
> +				 EXT_CSD_HS_TIMING, 1,
> +				 card->ext_csd.generic_cmd6_time);
>   		if (err&&  err != -EBADMSG)
>   			goto free_card;
>
> @@ -783,7 +791,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   					 EXT_CSD_BUS_WIDTH,
>   					 ext_csd_bits[idx][0],
> -					 0);
> +					 card->ext_csd.generic_cmd6_time);
>   			if (!err) {
>   				mmc_set_bus_width(card->host, bus_width);
>
> @@ -806,7 +814,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   					 EXT_CSD_BUS_WIDTH,
>   					 ext_csd_bits[idx][1],
> -					 0);
> +					 card->ext_csd.generic_cmd6_time);
>   		}
>   		if (err) {
>   			printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b460fc2..b713abf 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -52,6 +52,7 @@ struct mmc_ext_csd {
>   	u8			part_config;
>   	unsigned int		part_time;		/* Units: ms */
>   	unsigned int		sa_timeout;		/* Units: 100ns */
> +	unsigned int		generic_cmd6_time;	/* Units: 10ms */


Units are "ms" not "10ms" because you multiply by 10 in mmc_read_ext_csd


>   	unsigned int		hs_max_dtr;
>   	unsigned int		sectors;
>   	unsigned int		card_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 5a794cb..e869f00 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -293,6 +293,7 @@ struct _mmc_csd {
>   #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
>   #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
>   #define EXT_CSD_TRIM_MULT		232	/* RO */
> +#define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
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
