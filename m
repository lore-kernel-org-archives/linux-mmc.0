From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: use the defined function to check whether card
 is removable
Date: Fri, 29 Jan 2016 08:38:51 +0800
Message-ID: <56AAB49B.401@rock-chips.com>
References: <1454025177-21233-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:57850 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbcA2AjU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 19:39:20 -0500
In-Reply-To: <1454025177-21233-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com

Hi Jaehoon,

On 2016/1/29 7:52, Jaehoon Chung wrote:
> In linux/mmc/host.h, mmc_card_is_removable() is already defined.
> There is no reason that it doesn't use.
>

It's good to use it. But, I find some host drivers also use
"caps & MMC_CAP_NONREMOVABLE". How about respin a patchset to
slove them ?  :)

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>   drivers/mmc/core/core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f95d41f..9da9b60 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2532,7 +2532,7 @@ int mmc_detect_card_removed(struct mmc_host *host)
>   	if (!card)
>   		return 1;
>
> -	if (host->caps & MMC_CAP_NONREMOVABLE)
> +	if (!mmc_card_is_removable(host))
>   		return 0;
>
>   	ret = mmc_card_removed(card);
> @@ -2570,7 +2570,7 @@ void mmc_rescan(struct work_struct *work)
>   		return;
>
>   	/* If there is a non-removable card registered, only scan once */
> -	if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
> +	if (!mmc_card_is_removable(host) && host->rescan_entered)
>   		return;
>   	host->rescan_entered = 1;
>
> @@ -2587,8 +2587,7 @@ void mmc_rescan(struct work_struct *work)
>   	 * if there is a _removable_ card registered, check whether it is
>   	 * still present
>   	 */
> -	if (host->bus_ops && !host->bus_dead
> -	    && !(host->caps & MMC_CAP_NONREMOVABLE))
> +	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
>   		host->bus_ops->detect(host);
>
>   	host->detect_change = 0;
> @@ -2613,7 +2612,7 @@ void mmc_rescan(struct work_struct *work)
>   	mmc_bus_put(host);
>
>   	mmc_claim_host(host);
> -	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
> +	if (mmc_card_is_removable(host) && host->ops->get_cd &&
>   			host->ops->get_cd(host) == 0) {
>   		mmc_power_off(host);
>   		mmc_release_host(host);
>


-- 
Best Regards
Shawn Lin

