From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V1] mmc: core: Add host capability check for power class
Date: Wed, 14 Dec 2011 20:46:28 +0530
Message-ID: <000001ccba73$5c36ea90$14a4bfb0$@org>
References: <1323864059-26966-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1323864059-26966-1-git-send-email-girish.shivananjappa@linaro.org>
Content-Language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> Sent: Wednesday, December 14, 2011 5:31 PM
> To: linux-mmc@vger.kernel.org
> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org;
> subhashj@codeaurora.org; Girish K S; Chris Ball
> Subject: [PATCH V1] mmc: core: Add host capability check for power
> class
> 
> This patch adds a check whether the host supports maximum current value
> obtained from the device's extended csd register for a selected
> interface
> voltage and frequency.
> 
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in v1:
> 	reduced the number of comparisons as per Hein's suggestion
> 
>  drivers/mmc/core/mmc.c   |   21 +++++++++++++++++++++
>  include/linux/mmc/card.h |    4 ++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 006e932..e7f1902 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -688,6 +688,27 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>  		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
>  				EXT_CSD_PWR_CL_4BIT_SHIFT;
> 
> +	if (pwrclass_val >= MMC_MAX_CURRENT_800)
> +		pwrclass_val = MMC_MAX_CURRENT_800;
> +	else if (pwrclass_val >= MMC_MAX_CURRENT_600)
> +		pwrclass_val = MMC_MAX_CURRENT_600;
> +	else if (pwrclass_val >= MMC_MAX_CURRENT_400)
> +		pwrclass_val = MMC_MAX_CURRENT_400;
> +	else if (pwrclass_val >= MMC_MAX_CURRENT_200)
> +		pwrclass_val = MMC_MAX_CURRENT_200;
> +	else
> +		pwrclass_val = MMC_MAX_CURRENT_200;

Last else if and else can be combined as they are assigning the same value
to pwrclass_val.

> +
> +	if ((pwrclass_val == MMC_MAX_CURRENT_800) &&
> +	    !(card->host->caps & MMC_CAP_MAX_CURRENT_800))
> +		pwrclass_val = MMC_MAX_CURRENT_600;
> +	if ((pwrclass_val == MMC_MAX_CURRENT_600) &&
> +	    !(card->host->caps & MMC_CAP_MAX_CURRENT_600))
> +		pwrclass_val = MMC_MAX_CURRENT_400;
> +	if ((pwrclass_val == MMC_MAX_CURRENT_400) &&
> +	    !(card->host->caps & MMC_CAP_MAX_CURRENT_400))
> +		pwrclass_val = MMC_MAX_CURRENT_200;
> +
>  	/* If the power class is different from the default value */
>  	if (pwrclass_val > 0) {
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9478a6b..c5e031a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -195,6 +195,10 @@ struct mmc_part {
>  #define MMC_BLK_DATA_AREA_GP	(1<<2)
>  };
> 
> +#define MMC_MAX_CURRENT_200	(0)
> +#define MMC_MAX_CURRENT_400	(7)
> +#define MMC_MAX_CURRENT_600	(11)
> +#define MMC_MAX_CURRENT_800	(13)
>  /*
>   * MMC device
>   */
> --
> 1.7.1
