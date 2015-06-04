From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 2/2] mmc: core.c: Add comment to clarify special cases
 of ERASE/TRIM
Date: Thu, 04 Jun 2015 14:16:23 +0300
Message-ID: <55703387.8060509@intel.com>
References: <CAPDyKFocxYD+q_CQQ4Kz6ZZ88P+DwWcwfrEGEJJEEgkFT5r+MA@mail.gmail.com> <1433413214-21614-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38996 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbbFDLSw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Jun 2015 07:18:52 -0400
In-Reply-To: <1433413214-21614-1-git-send-email-david@protonic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/06/15 13:20, David Jander wrote:
> Signed-off-by: David Jander <david@protonic.nl>

Please never send delta patches.  Always send a new version of the whole patch.

> ---
>  drivers/mmc/core/core.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6c9611b..b6aa9ad 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2109,11 +2109,20 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * Sanity check: If we do not erase aligned, whole erase-groups, return
> +	 * an error, since we intended a "secure" erase, silently not erasing
> +	 * something would be unacceptable.
> +	 */

I am not sure the value of a comment that can anyway be inferred from the code.

>  	if (arg == MMC_SECURE_ERASE_ARG) {
>  		if (from % card->erase_size || nr % card->erase_size)
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * Make sure only erase-groups that are fully contained in the erase
> +	 * region are erased. Silently ignore the rest.
> +	 */

Ditto

>  	if (arg == MMC_ERASE_ARG) {
>  		rem = from % card->erase_size;
>  		if (rem) {
> @@ -2140,6 +2149,14 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  	/* 'from' and 'to' are inclusive */
>  	to -= 1;
>  
> +	/*
> +	 * Special case where only one erase-group fits in the timout budget:

timout -> timeout

> +	 * If the region crosses an erase-group boundary on this particular
> +	 * case, we will be trimming more than one erase-group which, does not
> +	 * fit in the timeout budget of the controller, so we need to split it
> +	 * and call mmc_do_erase() twice if necessary. This special case is
> +	 * identified by the card->eg_boundary flag.
> +	 */
>  	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
>  	    (from % card->erase_size)) {
>  		rem = card->erase_size - (from % card->erase_size);
> @@ -2244,7 +2261,16 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>  	if (!qty)
>  		return 0;
>  
> -	/* We can only erase one erase group special case */
> +	/*
> +	 * When specifying a sector range to trim, chances are we might cross
> +	 * an erase-group boundary even if the amount of sectors is less than
> +	 * one erase-group.
> +	 * If we can only fit one erase-group in the controller timeout budget,
> +	 * we have to care that erase-group boundaries are not crossed by a
> +	 * single trim operation. We flag that special case with "eg_boundary".
> +	 * In all other cases we can just decrement qty and pretend that we
> +	 * always touch (qty + 1) erase-groups as a simple optimization.

The language seems a little odd here. We are setting the max_discard limit
which does not involve "pretending" or "optimization", it is just a
calculation.  The important point is that the calculation has to count the
maximum number of erase blocks affected not the size in erase blocks.  You
could give an example e.g. if a 2 sector trim crosses an erase block
boundary then that counts as 2 erase blocks affected.

> +	 */
>  	if (qty == 1)
>  		card->eg_boundary = 1;
>  	else
> 

