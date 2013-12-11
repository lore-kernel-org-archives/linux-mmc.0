From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] mmc: sdhci: calculate max_discard_to dynamically for
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Wed, 11 Dec 2013 12:05:12 +0800
Message-ID: <20131211040511.GJ18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-6-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:11556
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751424Ab3LKEE4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 23:04:56 -0500
Content-Disposition: inline
In-Reply-To: <1386680168-5227-6-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

On Tue, Dec 10, 2013 at 08:56:07PM +0800, Dong Aisheng wrote:
>  static inline void sdhci_update_clock(struct sdhci_host *host)
> @@ -2939,10 +2952,12 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>  		host->timeout_clk = mmc->f_max / 1000;

Since max_discard_to calculation below will not happen for
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK case, does it still make sense to
keep the above code?

Or put it in the other way, if we keep the above code and do not make
the change below, will there be any problem besides the max_discard_to
initialization plays for nothing?

All in all, I'm just confused why we keep the above code and make the
change below at the same time.

Shawn

>  
> -	if (host->ops->get_max_timeout)
> -		mmc->max_discard_to = host->ops->get_max_timeout(host);
> -	else
> -		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +		if (host->ops->get_max_timeout)
> +			mmc->max_discard_to = host->ops->get_max_timeout(host);
> +		else
> +			mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	}
>  
>  	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>  
> -- 
> 1.7.2.rc3
> 
> 

