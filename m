From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: core: optimize mmc_calc_max_discard
Date: Fri, 9 Feb 2018 15:38:40 +0800
Message-ID: <1ab2c955-b6ef-bbb6-f395-16b06e390318@rock-chips.com>
References: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com>
 <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:48809 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBIHiy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Feb 2018 02:38:54 -0500
In-Reply-To: <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergio Valverde <vlvrdv@gmail.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mmc@vger.kernel.org


On 2018/2/9 1:41, Sergio Valverde wrote:
> If the max_discard value is zero, the conditional branch that checks the
> trim capabilities will never update this value with max_trim.
> 
> Change the condition statement to also check the max_discard value in order
> to avoid an unnecessary call to mmc_do_calc_max_discard.
> 

Given it's not in the hot call patch and it's rare to return zero from
mmc_do_calc_max_discard if you read the code instead of doing sanity
check by tools. So I doubt there is no gain in practice. But FWIW,

Reviewed-by: Shawn Lin <shawn.lin@rock-chip.com>

> Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>
> ---
> Changes in v2:
> - Evaluate max_discard to avoid unnecessary calls to mmc_can_trim.
> 
>   drivers/mmc/core/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1f0f44f..c32c0f4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2567,7 +2567,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>   		return card->pref_erase;
>   
>   	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
> -	if (mmc_can_trim(card)) {
> +	if (max_discard && mmc_can_trim(card)) {
>   		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>   		if (max_trim < max_discard)
>   			max_discard = max_trim;
> 

