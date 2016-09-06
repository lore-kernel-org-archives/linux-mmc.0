From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: Use a default maximum erase timeout
Date: Tue, 6 Sep 2016 09:59:24 +0800
Message-ID: <8962af00-8735-a419-5de8-50d5f3eda72d@rock-chips.com>
References: <1472815801-24932-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57877 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbcIFCAD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2016 22:00:03 -0400
In-Reply-To: <1472815801-24932-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Baolin Wang <baolin.wang@linaro.org>

Hi Ulf,

On 2016/9/2 19:30, Ulf Hansson wrote:
> In cases when the host->max_busy_timeout isn't specified, the calculated
> number of maximum discard sectors defaults to UINT_MAX. This may cause a
> too long timeout for a discard request.


There is a android specific case(aka recovery stage) which may stuck IO
routine for a very long time (I saw 7 mins for the wrost case) . After
flashing ROM or factory reset, it will wipe a large number of sectors
with secure tag[0]. We can image that we may do secdiscard for a 100GB
free disk and unfortunately the max_busy_timeout isn't specified. It's
probably ok as on recovery stage there are no other tasks competing for
the IO and we hope the wipe action could finish ASAP. But if this case
happens for normal runing time, the system/user-space will be broken
anyway for waiting for such a long time. So this patch looks sane.


[0]: 
https://android.googlesource.com/platform/system/extras/+/61d6591/ext4_utils/wipe.c

>
> Avoid this by using a default maximum erase timeout of 60s, used when we
> calculate the maximum number of sectors that are allowed to be discarded
> per request.
>
> Do note that the minimum number of sectors to be discarded is still at
> least one "preferred erase size".
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..59b452d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -58,6 +58,9 @@
>   */
>  #define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
>
> +/* The max erase timeout, used when host->max_busy_timeout isn't specified */
> +#define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
> +
>  static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>
>  /*
> @@ -2352,6 +2355,8 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>  	struct mmc_host *host = card->host;
>  	unsigned int max_discard, x, y, qty = 0, max_qty, min_qty, timeout;
>  	unsigned int last_timeout = 0;
> +	unsigned int max_busy_timeout = host->max_busy_timeout ?
> +			host->max_busy_timeout : MMC_ERASE_TIMEOUT_MS;
>
>  	if (card->erase_shift) {
>  		max_qty = UINT_MAX >> card->erase_shift;
> @@ -2374,15 +2379,15 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>  	 * matter what size of 'host->max_busy_timeout', but if the
>  	 * 'host->max_busy_timeout' is large enough for more discard sectors,
>  	 * then we can continue to increase the max discard sectors until we
> -	 * get a balance value.
> +	 * get a balance value. In cases when the 'host->max_busy_timeout'
> +	 * isn't specified, use the default max erase timeout.
>  	 */
>  	do {
>  		y = 0;
>  		for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
>  			timeout = mmc_erase_timeout(card, arg, qty + x);
>
> -			if (qty + x > min_qty &&
> -			    timeout > host->max_busy_timeout)
> +			if (qty + x > min_qty && timeout > max_busy_timeout)
>  				break;
>
>  			if (timeout < last_timeout)
> @@ -2427,9 +2432,6 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>  	struct mmc_host *host = card->host;
>  	unsigned int max_discard, max_trim;
>
> -	if (!host->max_busy_timeout)
> -		return UINT_MAX;
> -
>  	/*
>  	 * Without erase_group_def set, MMC erase timeout depends on clock
>  	 * frequence which can change.  In that case, the best choice is
> @@ -2447,7 +2449,8 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>  		max_discard = 0;
>  	}
>  	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
> -		 mmc_hostname(host), max_discard, host->max_busy_timeout);
> +		mmc_hostname(host), max_discard, host->max_busy_timeout ?
> +		host->max_busy_timeout : MMC_ERASE_TIMEOUT_MS);
>  	return max_discard;
>  }
>  EXPORT_SYMBOL(mmc_calc_max_discard);
>


-- 
Best Regards
Shawn Lin

