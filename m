From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/2 V2] Powerpc/eSDHC: Add limit to data and erase
 timeout value calculation
Date: Sun, 18 Nov 2012 16:46:18 -0800
Message-ID: <20121119004618.GL29066@lizard.sbx05977.paloaca.wayport.net>
References: <1352797762-30526-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55436 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab2KSAt2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 19:49:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3064935pbc.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 16:49:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352797762-30526-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Tue, Nov 13, 2012 at 05:09:21PM +0800, Haijun Zhang wrote:
> Some cards apply too larg timeout value for host to response,
> So limit the maximum data transfer timeout value and maximum erase
> timeout value to aviod timeout issue.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for v2:
>         - Add limit to data and erase timeout value calculation
>         - split the V1 patch into two V2 patchs.
> 
>  drivers/mmc/core/core.c |   27 ++++++++++++++++-----------
>  1 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c241fc1..c90b791 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -721,6 +721,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  				data->timeout_ns =  100000000;	/* 100ms */
>  		}
>  	}
> +
> +	if (card->host->max_discard_to &&
> +		card->host->max_discard_to < div_u64(data->timeout_ns, 1000000))

Incorrect indentation, please add one more tab.

Otherwise, the patch looks OK to me.

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

> +		data->timeout_ns = (u64)card->host->max_discard_to * 1000000;
>  }
>  EXPORT_SYMBOL(mmc_set_data_timeout);
>  
> @@ -1880,7 +1884,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>  		return 0;
>  
>  	if (qty == 1)
> -		return 1;
> +		return 1 << card->erase_shift;
>  
>  	/* Convert qty to sectors */
>  	if (card->erase_shift)
> @@ -1898,16 +1902,17 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>  	struct mmc_host *host = card->host;
>  	unsigned int max_discard, max_trim;
>  
> -	if (!host->max_discard_to)
> -		return UINT_MAX;
> -
> -	/*
> -	 * Without erase_group_def set, MMC erase timeout depends on clock
> -	 * frequence which can change.  In that case, the best choice is
> -	 * just the preferred erase size.
> -	 */
> -	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> -		return card->pref_erase;
> +	if (!host->max_discard_to) {
> +		if (mmc_card_sd(card))
> +			return UINT_MAX;
> +		/*
> +		 * Without erase_group_def set, MMC erase timeout depends on
> +		 * clock frequence which can change.  In that case, the best
> +		 * choice is just the preferred erase size.
> +		 */
> +		if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> +			return card->pref_erase;
> +	}
>  
>  	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
>  	if (mmc_can_trim(card)) {
> -- 
> 1.7.0.4
