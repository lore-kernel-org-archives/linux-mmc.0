From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
Date: Wed, 11 Dec 2013 09:56:43 +0800
Message-ID: <20131211015640.GA18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:51709
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829Ab3LKB4W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 20:56:22 -0500
Content-Disposition: inline
In-Reply-To: <1386680168-5227-2-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

On Tue, Dec 10, 2013 at 08:56:03PM +0800, Dong Aisheng wrote:
> Currently the max_discard_to is simply got by (1 << 27) / host->timeout_clk
> which is assumed to be the maximum timeout value, however, some platforms
> maximum timeout counter may not be 1 << 27, e.g. i.MX uSDHC is 1 << 28.
> Thus 1 << 27 may not be correct for such platforms.
> 
> It is also possible that other platforms may have different problems.
> To be flexible, we add a get_max_timeout hook to get the correct
> maximum timeout value for these platforms.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Reported-by: Ed Sutter <ed.sutter@alcatel-lucent.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 ++++-
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..464d42c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2930,7 +2930,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>  		host->timeout_clk = mmc->f_max / 1000;
>  
> -	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	if (host->ops->get_max_timeout)
> +		mmc->max_discard_to = host->ops->get_max_timeout(host);

Does "timeout" conceptually equals to "discard_to"?  If not, we might
want to write it in the either form below to avoid messing these two
concepts.

	mmc->max_discard_to = host->ops->get_max_timeout(host) / host->timeout_clk;

or

	mmc->max_discard_to = host->ops->get_max_discard_to(host);

I guess you may want to go for the second one.

Shawn

> +	else
> +		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>  
>  	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0a3ed01..1591cbb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -281,6 +281,7 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	unsigned int	(*get_max_timeout)(struct sdhci_host *host);
>  	int		(*platform_bus_width)(struct sdhci_host *host,
>  					       int width);
>  	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> -- 
> 1.7.2.rc3
> 
> 

