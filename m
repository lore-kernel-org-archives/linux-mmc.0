From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: core: add driver strength selection when
 selecting hs400es
Date: Wed, 27 Sep 2017 09:28:22 +0800
Message-ID: <9ac955f6-2657-c9d5-a515-105ca33ec62d@rock-chips.com>
References: <1506384220-5108-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1506384220-5108-1-git-send-email-chanho.min@lge.com>
Sender: stable-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>, Adrian Hunter <adrian.hunter@intel.com>, Uri Yanai <uri.yanai@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hankyung Yu <hankyung.yu@lge.com>, Gunho Lee <gunho.lee@lge.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 2017/9/26 8:03, Chanho Min wrote:
> The driver strength selection is missed and required when selecting
> hs400es. So, It is added here.
> 
> v2: add stable tag.
> 
> Fixes: 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Should move changelog out of commit msg and use 12bit SHA-1 ID.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>   drivers/mmc/core/mmc.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a7eb623..36217ad 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1286,6 +1286,23 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>   	return err;
>   }
>   
> +static void mmc_select_driver_type(struct mmc_card *card)
> +{
> +	int card_drv_type, drive_strength, drv_type;
> +
> +	card_drv_type = card->ext_csd.raw_driver_strength |
> +			mmc_driver_type_mask(0);
> +
> +	drive_strength = mmc_select_drive_strength(card,
> +						   card->ext_csd.hs200_max_dtr,
> +						   card_drv_type, &drv_type);
> +
> +	card->drive_strength = drive_strength;
> +
> +	if (drv_type)
> +		mmc_set_driver_type(card->host, drv_type);
> +}
> +
>   static int mmc_select_hs400es(struct mmc_card *card)
>   {
>   	struct mmc_host *host = card->host;
> @@ -1341,6 +1358,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
>   		goto out_err;
>   	}
>   
> +	mmc_select_driver_type(card);
> +
>   	/* Switch card to HS400 */
>   	val = EXT_CSD_TIMING_HS400 |
>   	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> @@ -1374,23 +1393,6 @@ static int mmc_select_hs400es(struct mmc_card *card)
>   	return err;
>   }
>   
> -static void mmc_select_driver_type(struct mmc_card *card)
> -{
> -	int card_drv_type, drive_strength, drv_type;
> -
> -	card_drv_type = card->ext_csd.raw_driver_strength |
> -			mmc_driver_type_mask(0);
> -
> -	drive_strength = mmc_select_drive_strength(card,
> -						   card->ext_csd.hs200_max_dtr,
> -						   card_drv_type, &drv_type);
> -
> -	card->drive_strength = drive_strength;
> -
> -	if (drv_type)
> -		mmc_set_driver_type(card->host, drv_type);
> -}
> -
>   /*
>    * For device supporting HS200 mode, the following sequence
>    * should be done before executing the tuning process.
> 
