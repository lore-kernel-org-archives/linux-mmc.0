From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH] mmc: core: disable the cache before suspend only after
 stopping BKOPS
Date: Sat, 12 Jan 2013 12:36:46 +0530
Message-ID: <50F10B86.6020905@codeaurora.org>
References: <n> <1357936936-25977-1-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1357936936-25977-1-git-send-email-merez@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1/12/2013 2:12 AM, Maya Erez wrote:
> mmc_cache_ctrl was called in runtime suspend before MMC interrupted
> BKOPS in case it is still running on the card. This caused the cache
> disable to timeout.
I guess even if the idle time bkops polling is not implemented, this 
patch is good to have. cache control is the eMMC feature and in that 
sense, it should have been part of MMC's bus resume (mmc_resume) rather 
than generic mmc_suspend_host().

Patch as such is fine and if you agree, you may want to remove the 
mentioning of bkops as part of commit text and may just want to mention 
above reason as the main motivation for this patch.

> Therefore, mmc_cache_ctrl has to move to mmc_suspend where we are sure
> that the card can go into suspend and there is no pending activity.
>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> ---
>   drivers/mmc/core/core.c |    7 +------
>   drivers/mmc/core/mmc.c  |    8 +++++++-
>   2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index aaed768..b438bb2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2388,6 +2388,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
>    * Turn the cache ON/OFF.
>    * Turning the cache OFF shall trigger flushing of the data
>    * to the non-volatile storage.
> + * This function should be called with host claimed
>    */
>   int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
>   {
> @@ -2399,7 +2400,6 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
>   			mmc_card_is_removable(host))
>   		return err;
>   
> -	mmc_claim_host(host);
>   	if (card && mmc_card_mmc(card) &&
>   			(card->ext_csd.cache_size > 0)) {
>   		enable = !!enable;
> @@ -2417,7 +2417,6 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
>   				card->ext_csd.cache_ctrl = enable;
>   		}
>   	}
> -	mmc_release_host(host);
>   
>   	return err;
>   }
> @@ -2436,10 +2435,6 @@ int mmc_suspend_host(struct mmc_host *host)
>   	cancel_delayed_work(&host->detect);
>   	mmc_flush_scheduled_work();
>   
> -	err = mmc_cache_ctrl(host, 0);
> -	if (err)
> -		goto out;
> -
>   	mmc_bus_get(host);
>   	if (host->bus_ops && !host->bus_dead) {
>   		if (host->bus_ops->suspend) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e6e3911..dc17d40 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1379,6 +1379,11 @@ static int mmc_suspend(struct mmc_host *host)
>   	BUG_ON(!host->card);
>   
>   	mmc_claim_host(host);
> +
> +	err = mmc_cache_ctrl(host, 0);
> +	if (err)
> +		goto out;
> +
>   	if (mmc_can_poweroff_notify(host->card))
>   		err = mmc_poweroff_notify(host->card, EXT_CSD_POWER_OFF_SHORT);
>   	else if (mmc_card_can_sleep(host))
> @@ -1386,8 +1391,9 @@ static int mmc_suspend(struct mmc_host *host)
>   	else if (!mmc_host_is_spi(host))
>   		err = mmc_deselect_cards(host);
>   	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
> -	mmc_release_host(host);
>   
> +out:
> +	mmc_release_host(host);
>   	return err;
>   }
>   
