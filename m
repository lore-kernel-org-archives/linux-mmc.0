From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V4] mmc: core: Detect card removal on I/O error
Date: Mon, 5 Mar 2012 16:10:19 +0100
Message-ID: <4F54D75B.1070408@stericsson.com>
References: <1328521359-31962-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:43548 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964981Ab2CEPKq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 10:10:46 -0500
In-Reply-To: <1328521359-31962-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Chris,

Just wondering if you see any issues with proceeding with this patch?

Thanks!

Br
Ulf Hansson


On 02/06/2012 10:42 AM, Ulf HANSSON wrote:
> To prevent I/O as soon as possible at card removal, a new
> detect work is re-scheduled without a delay to let a rescan
> remove the card device as soon a possible.
>
> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
> "slowly" removed cards that a scheduled detect work did not
> detect as removed. To prevent further I/O requests for these
> lingering removed cards, check if card has been removed and then
> schedule a detect work to properly remove it.
>
> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
> ---
>
> Changes in v4:
> 	- Rebased on latest mmc-next branch.
> 	- Prevent scheduling a second not needed detect work.
>
> Changes in v3:
> 	- Check for card is NULL and minor code simplifications.
>
> Changes in v2:
> 	- Updated according to review comments.
> 	- Merging two patches for this feature into one.
>
> ---
>   drivers/mmc/core/core.c  |   24 +++++++++++++++++++++---
>   include/linux/mmc/host.h |    1 +
>   2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8a19143..a8f7efe 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2112,18 +2112,36 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>   int mmc_detect_card_removed(struct mmc_host *host)
>   {
>   	struct mmc_card *card = host->card;
> +	int ret;
>
>   	WARN_ON(!host->claimed);
> +
> +	if (!card)
> +		return 1;
> +
> +	ret = mmc_card_removed(card);
>   	/*
>   	 * The card will be considered unchanged unless we have been asked to
>   	 * detect a change or host requires polling to provide card detection.
>   	 */
> -	if (card&&  !host->detect_change&&  !(host->caps&  MMC_CAP_NEEDS_POLL))
> -		return mmc_card_removed(card);
> +	if (!host->detect_change&&  !(host->caps&  MMC_CAP_NEEDS_POLL)&&
> +	    !(host->caps2&  MMC_CAP2_DETECT_ON_ERR))
> +		return ret;
>
>   	host->detect_change = 0;
> +	if (!ret) {
> +		ret = _mmc_detect_card_removed(host);
> +		if (ret&&  (host->caps2&  MMC_CAP2_DETECT_ON_ERR)) {
> +			/*
> +			 * Schedule a detect work as soon as possible to let a
> +			 * rescan handle the card removal.
> +			 */
> +			cancel_delayed_work(&host->detect);
> +			mmc_detect_change(host, 0);
> +		}
> +	}
>
> -	return _mmc_detect_card_removed(host);
> +	return ret;
>   }
>   EXPORT_SYMBOL(mmc_detect_card_removed);
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 20d7c82..e9f9e88 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -258,6 +258,7 @@ struct mmc_host {
>   #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>   				 MMC_CAP2_HS200_1_2V_SDR)
>   #define MMC_CAP2_BROKEN_VOLTAGE	(1<<  7)	/* Use the broken voltage */
> +#define MMC_CAP2_DETECT_ON_ERR	(1<<  8)	/* On I/O err check card removal */
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>   	unsigned int        power_notify_type;

