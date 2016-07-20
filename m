From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 1/2] mmc: sdhci: Request regulators before reading
 capabilities
Date: Wed, 20 Jul 2016 16:02:03 +0300
Message-ID: <578F764B.2070403@intel.com>
References: <1468331617-22265-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468331617-22265-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 12/07/16 16:53, Jon Hunter wrote:
> The capabilities of the SDHCI host controller are read early during the
> SDHCI host initialisation in sdhci_setup_host() and before any
> regulators for the host have been requested. This means that if the host
> supports some high-speed modes (according to its capabilities register),
> but the board cannot because the appropriate voltage regulator is not
> available, then the host cannot easily override the capabilities that
> are supported.
> 
> To allow a SDHCI host controller to determine if it can support high
> speed modes via the presense of the MMC regulators, request the

Try not to confuse High Speed mode with UHS modes.

presense -> presence

> regulators before reading the capabilites of the host controller. This

capabilites -> capabilities

> will allow the SDHCI host to use the 'reset' callback to take the
> appropriate action (set flags, configure registers, etc) before the
> capabilities register(s) are read.
> 
> Please note that some SDHCI hosts, such as the Tegra SDHCI host, has
> the ability to mask bits in the capabilities register to prevent
> certain capabilities from being advertised.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> 
> Although this is described as a "V2" this patch has been added since
> the original patch was posted.
> 
> If the below is deemed not appropriate, then another solution I was
> thinking of is to allow the SDHCI host to call 'mmc_regulator_get_supply'
> before calling sdhci_setup_host() and then in sdhci_setup_host() check
> if any regulators are already present before calling
> mmc_regulator_get_supply().

And we can still do that later if we need to.

> 
>  drivers/mmc/host/sdhci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ee8bfa77116..628c4b3558c0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3021,6 +3021,17 @@ int sdhci_setup_host(struct sdhci_host *host)
>  
>  	mmc = host->mmc;
>  
> +	/*
> +	 * If there are external regulators, get them. Note
> +	 * this must be done early before resetting the host
> +	 * and reading the capabilities so that the host can
> +	 * take the appropriate action if regulators are not
> +	 * available.
> +	 */
> +	ret = mmc_regulator_get_supply(mmc);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +
>  	sdhci_read_caps(host);
>  
>  	override_timeout_clk = host->timeout_clk;
> @@ -3253,11 +3264,6 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	    mmc_gpio_get_cd(host->mmc) < 0)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
> -	/* If there are external regulators, get them */
> -	ret = mmc_regulator_get_supply(mmc);
> -	if (ret == -EPROBE_DEFER)
> -		goto undma;

All goto's before this now need to goto unreg.

> -
>  	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
>  		ret = regulator_enable(mmc->supply.vqmmc);
> 
