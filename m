From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Force a "detect" to handle non-properly removed
 cards
Date: Wed, 04 Jan 2012 23:26:42 +0200
Message-ID: <4F04C412.1030604@intel.com>
References: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1455 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971Ab2ADV0r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jan 2012 16:26:47 -0500
In-Reply-To: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 3/01/2012 12:33 p.m., Ulf Hansson wrote:
> Removing a card "slowly" can trigger a GPIO irq to be raised far
> before the card is actually removed. This means the scheduled
> detect work will not find out that the card were removed and thus
> the card and the block device will not be unregistered.

One way around that problem is to error out requests after the GPIO
indicates the card is "removed".  sdhci effectively does that but with
a "present" bit.  Perhaps even simpler - set the card-removed flag.

> Let the mmc_detect_card_removed function trigger a new detect
> work immediately when it discovers that a card has been removed.

This is changing some long-standing functionality i.e. the card is not 
removed
without a card detect event.  It is difficult to know whether that will 
be very
bad for poor quality cards,

> This will solve the described issue above. Moreover we make sure
> the detect work is executed as soon as possible, since there is
> no reason for waiting for a "delayed" detect to happen.
>
> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
> ---
>   drivers/mmc/core/core.c  |   24 +++++++++++++-----------
>   include/linux/mmc/host.h |    1 -
>   2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4770807..7bc02f4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1462,7 +1462,6 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>   	WARN_ON(host->removed);
>   	spin_unlock_irqrestore(&host->lock, flags);
>   #endif
> -	host->detect_change = 1;
>   	mmc_schedule_delayed_work(&host->detect, delay);
>   }
>
> @@ -2077,18 +2076,23 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>   int mmc_detect_card_removed(struct mmc_host *host)
>   {
>   	struct mmc_card *card = host->card;
> +	int ret = 1;
>
>   	WARN_ON(!host->claimed);
> -	/*
> -	 * The card will be considered unchanged unless we have been asked to
> -	 * detect a change or host requires polling to provide card detection.
> -	 */
> -	if (card&&  !host->detect_change&&  !(host->caps&  MMC_CAP_NEEDS_POLL))
> -		return mmc_card_removed(card);
>
> -	host->detect_change = 0;
> +	if (card&&  !mmc_card_removed(card)) {
> +		if (_mmc_detect_card_removed(host)) {
> +			/*
> +			 * Make sure a detect work is always executed and also
> +			 * do it as soon as possible.
> +			 */
> +			cancel_delayed_work(&host->detect);
> +			mmc_detect_change(host, 0);
> +		}
> +		ret = mmc_card_removed(card);
> +	}
>
> -	return _mmc_detect_card_removed(host);
> +	return ret;
>   }
>   EXPORT_SYMBOL(mmc_detect_card_removed);
>
> @@ -2112,8 +2116,6 @@ void mmc_rescan(struct work_struct *work)
>   	&&  !(host->caps&  MMC_CAP_NONREMOVABLE))
>   		host->bus_ops->detect(host);
>
> -	host->detect_change = 0;
> -
>   	/*
>   	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
>   	 * the card is no longer present.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 031d865..09fa5e6 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -305,7 +305,6 @@ struct mmc_host {
>   	int			claim_cnt;	/* "claim" nesting count */
>
>   	struct delayed_work	detect;
> -	int			detect_change;	/* card detect flag */
>   	struct mmc_hotplug	hotplug;
>
>   	const struct mmc_bus_ops *bus_ops;	/* current bus driver */

