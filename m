From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: core: Prevent I/O as soon as possible at card
 removal
Date: Fri, 20 Jan 2012 13:55:27 +0200
Message-ID: <4F19562F.6010907@intel.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com> <1326991191-12472-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2898 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2ATLz1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Jan 2012 06:55:27 -0500
In-Reply-To: <1326991191-12472-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 19/01/12 18:39, Ulf Hansson wrote:
> Once the card has been detected to be removed by the
> mmc_detect_card_removed function, schedule a new detect work
> immediately and without a delay to let a rescan remove the
> card device as soon a possible. This will sooner prevent
> further I/O requests.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/core/core.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bec0bf2..265dfd8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2077,6 +2077,7 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>  int mmc_detect_card_removed(struct mmc_host *host)
>  {
>  	struct mmc_card *card = host->card;
> +	int ret;
>  
>  	WARN_ON(!host->claimed);
>  	/*
> @@ -2086,9 +2087,20 @@ int mmc_detect_card_removed(struct mmc_host *host)
>  	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
>  		return mmc_card_removed(card);
>  
> -	host->detect_change = 0;

That line should not be removed.  It is not related to your change.

> +	ret = mmc_card_removed(card);

Calling mmc_card_removed() is not needed here since
_mmc_detect_card_removed() does it anyway.

> +	if (!ret) {
> +		ret = _mmc_detect_card_removed(host);
> +		if (ret) {
> +			/*
> +			 * Schedule a detect work as soon as possible to let a
> +			 * rescan handle the card removal.
> +			 */
> +			cancel_delayed_work(&host->detect);

Why cancel the detect work?

> +			mmc_detect_change(host, 0);
> +		}
> +	}
>  
> -	return _mmc_detect_card_removed(host);
> +	return ret;
>  }
>  EXPORT_SYMBOL(mmc_detect_card_removed);
>  

