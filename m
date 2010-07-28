From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCHv2 1/4] sdhci-s3c: add support for the non standard minimal
 clock value
Date: Wed, 28 Jul 2010 17:48:04 +0100
Message-ID: <4C505F44.20100@simtec.co.uk>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com> <1280326797-15792-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1280326797-15792-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

On 28/07/10 15:19, Marek Szyprowski wrote:
> S3C SDHCI host controller can change the source for generating mmc clock.
> By default host bus clock is used, what causes some problems on machines
> with 133MHz bus, because the SDHCI divider cannot be as high get proper
> clock value for identification mode. This is not a problem for the
> controller, because it can generate lower frequencies from other clock
> sources. This patch adds a new quirk to SDHCI driver to calculate the
> minimal supported clock frequency.
> 
> This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
> mmc0: Minimum clock frequency too high for identification mode
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> Changes since V1:
> - rebased onto latest -mm kernel tree
> 
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |    1 +
>  drivers/mmc/host/sdhci-s3c.c      |   29 +++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c          |    2 +-
>  drivers/mmc/host/sdhci.h          |    2 ++
>  4 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index e9f99fe..763b364 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -124,6 +124,7 @@ struct sdhci_of_data sdhci_esdhc = {
>  		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>  		  SDHCI_QUIRK_NO_BUSY_IRQ |
>  		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
> +		  SDHCI_QUIRK_NONSTANDARD_MINCLOCK |
>  		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>  		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
>  		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index d7058ee..5218f2b 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -203,9 +203,36 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  }
>  
> +/**
> + * sdhci_s3c_get_min_clock - callback to get minimal supported clock value
> + * @host: The SDHCI host being queried
> + *
> + * To init mmc host properly a minimal clock value is needed. For high system
> + * bus clock's values the standard formula gives values out of allowed range.
> + * The clock still can be set to lower values, if clock source other then
> + * system bus is selected.
> +*/
> +static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	unsigned int delta, min = UINT_MAX;
> +	int src;
> +
> +	for (src = 0; src < MAX_BUS_CLK; src++) {
> +		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
> +		if (delta == UINT_MAX)
> +			continue;
> +		/* delta is a negative value in this case */
> +		if (-delta < min)
> +			min = -delta;
> +	}
> +	return min;
> +}
> +
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
> +	.get_min_clock		= sdhci_s3c_get_min_clock,
>  };
>  
>  static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> @@ -309,6 +336,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	host->quirks = 0;
>  	host->irq = irq;
>  
> +	host->quirks |= SDHCI_QUIRK_NONSTANDARD_MINCLOCK;
> +
>  	/* Setup quirks for the controller */
>  	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 07b2695..682b285 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1776,7 +1776,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	 * Set host parameters.
>  	 */
>  	mmc->ops = &sdhci_ops;
> -	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_MINCLOCK &&
>  			host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);

We're begining to run out of quirk space, given these fields will
be initialised to NULL if not used, then why not just check for
the op being present?
