From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date: Wed, 16 Jan 2019 14:59:32 +0200
Message-ID: <d92a5588-ffdd-5198-b985-04d9b8dae601@intel.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
List-Id: linux-mmc@vger.kernel.org

On 15/01/19 6:28 PM, Thomas Petazzoni wrote:
> Even though SDHCI controllers may have a dedicated WP pin that can be
> queried using the SDHCI_PRESENT_STATE register, some platforms may
> chose to use a separate regular GPIO to route the WP signal. Such a
> GPIO is typically represented using the wp-gpios property in the
> Device Tree.
> 
> Unfortunately, the current sdhci_check_ro() function does not make use
> of such GPIO when available: it either uses a host controller specific
> ->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
> controller specific ->get_ro() functions are implemented just to use
> check a WP GPIO state.
> 
> Instead of pushing this to more controller-specific implementations,
> let's handle this in the core SDHCI code, just like it is already done
> for the CD GPIO in sdhci_get_cd().
> 
> The below patch simply changes sdhci_check_ro() to use the value of
> the WP GPIO if available. We need to adjust the prototype of the
> function to use a mmc_host* as argument instead of sdhci_host*, since
> the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.

Why not just use host->mmc

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index df05352b6a4a..63cc4bd033b9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2022,8 +2022,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
>  
> -static int sdhci_check_ro(struct sdhci_host *host)
> +static int sdhci_check_ro(struct mmc_host *mmc)
>  {
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  	int is_readonly;
>  
> @@ -2031,6 +2032,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
>  
>  	if (host->flags & SDHCI_DEVICE_DEAD)
>  		is_readonly = 0;
> +	else if (mmc_can_gpio_ro(mmc))
> +		is_readonly = mmc_gpio_get_ro(mmc);

Perhaps host->ops->get_ro should be checked before mmc_can_gpio_ro()?

>  	else if (host->ops->get_ro)
>  		is_readonly = host->ops->get_ro(host);
>  	else
> @@ -2052,11 +2055,11 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  	int i, ro_count;
>  
>  	if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
> -		return sdhci_check_ro(host);
> +		return sdhci_check_ro(mmc);
>  
>  	ro_count = 0;
>  	for (i = 0; i < SAMPLE_COUNT; i++) {
> -		if (sdhci_check_ro(host)) {
> +		if (sdhci_check_ro(mmc)) {
>  			if (++ro_count > SAMPLE_COUNT / 2)
>  				return 1;
>  		}
> 
