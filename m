From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: don't limit discard timeout by data line
 timeout
Date: Fri, 22 Nov 2013 13:38:42 +0200
Message-ID: <528F4242.8040408@intel.com>
References: <1385046445-29711-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41031 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab3KVLbq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Nov 2013 06:31:46 -0500
In-Reply-To: <1385046445-29711-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-mmc@vger.kernel.org, Ed Sutter <ed.sutter@alcatel-lucent.com>, Chris Ball <cjb@laptop.org>

On 21/11/13 17:07, Vladimir Zapolskiy wrote:
> JEDEC specification defines quite high erase timeout value for 300ms
> multiplied by erase group number, and SD Host Controller specification
> data line timeout may be much less, e.g. 2^13 / 52MHz ~ 160us.
> 
>>From block layer and MMC perfromance perspective it is desirable that
> millions of erase groups are discarded at once, so there is no much
> sense to limit maximum erase timeout by data line timeout, if a
> controller handles correctly erase operation without indication of
> data line timeout.

Would you explain that some more.  Do you mean that:
	a) it does not have a timeout
	b) it has a timeout which is less than the timeout specified by the
standard but the operation nevertheless completes

> 
> Potentially the change may break some of the SDHCs on discard of mmc,
> and for backward compatibility a new quirk is introduced, which is NOT
> set by default.

It sounds to me that what you want to do is not standard so the quirk should
be the other way around.

> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Reported-by: Ed Sutter <ed.sutter@alcatel-lucent.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c  |    5 ++++-
>  include/linux/mmc/sdhci.h |    1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..b1fdddb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2930,7 +2930,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>  		host->timeout_clk = mmc->f_max / 1000;
>  
> -	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	if (host->quirks2 & SDHCI_QUIRK2_DATA_TIMEOUT_ON_DISCARD)
> +		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	else
> +		mmc->max_discard_to = 0;
>  
>  	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>  
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 3e781b8..e7f6bd2 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -98,6 +98,7 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
>  /* Controller has a non-standard host control register */
>  #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
> +#define SDHCI_QUIRK2_DATA_TIMEOUT_ON_DISCARD		(1<<6)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

