From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 11 Dec 2013 10:16:48 +0800
Message-ID: <20131211021646.GC18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:30537
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab3LKCQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 21:16:32 -0500
Content-Disposition: inline
In-Reply-To: <1386680168-5227-4-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

On Tue, Dec 10, 2013 at 08:56:05PM +0800, Dong Aisheng wrote:
> Currently the common code assume 0xE is the maximum timeout counter
> value and use it to write into the timeout counter register.
> However, it's fairly possible that the different SoCs may have
> different register layout on the timeout counter register.
> That means 0xE may not be the correct maximum timeout value, then
> the 0xE becomes meaningless.
> 
> To be flexible, this patch provides another approach for platforms
> to set the correct timeout on their way.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c |   19 ++++++++++++++-----
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 464d42c..4cc3bd6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -726,19 +726,28 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
>  		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 count;
> +
> +	if (host->ops->set_timeout) {
> +		host->ops->set_timeout(host, cmd);
> +	} else {
> +		count = sdhci_calc_timeout(host, cmd);
> +		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +	}
> +}
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
>  	u8 ctrl;
>  	struct mmc_data *data = cmd->data;
>  	int ret;
>  
>  	WARN_ON(host->data);
>  
> -	if (data || (cmd->flags & MMC_RSP_BUSY)) {
> -		count = sdhci_calc_timeout(host, cmd);

>From what I read the commit log, I think it might be more appropriate to
patch sdhci_calc_timeout() like the following?

	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
		if (host->ops->get_max_timeout)
			return host->ops->get_max_timeout(host);
		else
			return 0xE;

Shawn

> -		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> -	}
> +	if (data || (cmd->flags & MMC_RSP_BUSY))
> +		sdhci_set_timeout(host, cmd);
>  
>  	if (!data)
>  		return;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 1591cbb..a4851a0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -282,6 +282,8 @@ struct sdhci_ops {
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_max_timeout)(struct sdhci_host *host);
> +	void		(*set_timeout)(struct sdhci_host *host,
> +						struct mmc_command *cmd);
>  	int		(*platform_bus_width)(struct sdhci_host *host,
>  					       int width);
>  	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> -- 
> 1.7.2.rc3
> 
> 

