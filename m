From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Fri, 27 Aug 2010 08:09:55 +0100
Message-ID: <20100827070955.GA2418@console-pimps.org>
References: <4C775C8E.7040903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:33858 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752331Ab0H0HJ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 03:09:57 -0400
Content-Disposition: inline
In-Reply-To: <4C775C8E.7040903@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, matt@console-pimps.org, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>

On Fri, Aug 27, 2010 at 03:34:54PM +0900, Jaehoon Chung wrote:
> If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk, 
> controller need always polling detect
> 
> In this case, always generated interrupt.Because controller checked card status.
> I think that is not efficiently.
> 
> But if card is nonremovable, we need not always polling.
> So i added the check-point which is nonremovable or not
> 
>  Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 401527d..4bc5d3c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1826,8 +1826,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps & SDHCI_CAN_DO_HISPD)
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
>  
> -	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> -		mmc->caps |= MMC_CAP_NEEDS_POLL;
> +	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> +		!(host->mmc->caps & MMC_CAP_NONREMOVABLE))
> +			mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
>  	mmc->ocr_avail = 0;
>  	if (caps & SDHCI_CAN_VDD_330)
> -- 
> 1.6.0.4
> --

I don't have any non-removable hardware so I can't test this patch but I
think it makes sense. The indentation looks a bit weird, but Andrew may
fix that up if he thinks it's a problem.

I'm assuming that you're testing this change with the sdhci-s3c.c
driver? Is it a good idea that the driver is using
SDHCI_QUIRK_BROKEN_CARD_DETECTION when it has a nonremovable card?
Currently we seem to be using SDHCI_QUIRK_BROKEN_CARD_DETECTION and
MMC_CAP_NONREMOVABLE to mean that same thing in some places which is
really confusing.

Like in drivers/mmc/host/sdhci.c we can enable card detection irqs for
cards that are nonremovable which is a bit pointless (though obviously
not harmful).

But your patch seems fine unless anyone else has an issue with it, I'm
just trying to see if we could clean this up ontop of your patch.

Adding Andrew Morton to the CC list.
