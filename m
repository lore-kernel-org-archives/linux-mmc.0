From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH V3] mmc: core: Detect card removal on I/O error
Date: Fri, 03 Feb 2012 19:34:19 +0900
Message-ID: <4F2BB82B.7000400@samsung.com>
References: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55497 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab2BCKef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 05:34:35 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYT00J57C1LM4I0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Feb 2012 19:34:34 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYT001OPC1LKZ30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Feb 2012 19:34:33 +0900 (KST)
In-reply-to: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 02/03/2012 06:33 PM, Ulf Hansson wrote:

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
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
> 
> Changes in v3:
> 	- Check for card is NULL and minor code simplifications.
> 
> Changes in v2:
> 	- Updated according to review comments.
> 	- Merging two patches for this feature into one.
> 
> ---
>  drivers/mmc/core/core.c  |   24 +++++++++++++++++++++---
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bec0bf2..9645e8c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2077,18 +2077,36 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>  int mmc_detect_card_removed(struct mmc_host *host)
>  {
>  	struct mmc_card *card = host->card;
> +	int ret;
>  
>  	WARN_ON(!host->claimed);
> +
> +	if (!card)
> +		return 1;
> +
> +	ret = mmc_card_removed(card);

this function called mmc_detect_card_removed(card->host) in block.c.
then card isn't NULL..isn't? 
Just wondering... :)

Best Regards,
Jaehoon Chung

>  	/*
>  	 * The card will be considered unchanged unless we have been asked to
>  	 * detect a change or host requires polling to provide card detection.
>  	 */
> -	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
> -		return mmc_card_removed(card);
> +	if (!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL) &&
> +	    !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
> +		return ret;
>  
>  	host->detect_change = 0;
> +	if (!ret) {
> +		ret = _mmc_detect_card_removed(host);
> +		if (ret) {
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
>  }
>  EXPORT_SYMBOL(mmc_detect_card_removed);
>  
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index dd13e05..368a2b9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -257,6 +257,7 @@ struct mmc_host {
>  #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
>  #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>  				 MMC_CAP2_HS200_1_2V_SDR)
> +#define MMC_CAP2_DETECT_ON_ERR	(1 << 7)	/* On I/O err check card removal */
>  
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  	unsigned int        power_notify_type;


