From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-omap: Add platform specific reset callback
Date: Tue, 20 Nov 2018 10:30:23 +0530
Message-ID: <04c28877-7705-ce7e-cb73-67d202174741@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-4-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org



On 19/11/18 4:46 PM, Faiz Abbas wrote:
> The TRM (SPRUIC2C - January 2017 - Revised May 2018 [1]) forbids
> assertion of data reset while tuning is happening. Implement a
> platform specific callback that takes care of this condition.
> 
> [1] http://www.ti.com/lit/pdf/spruic2 Section 25.5.1.2.4
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Once patch 2 is merged with this patch, you can add
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/mmc/host/sdhci-omap.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index cfffcf58be3f..bf268b38ddc8 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -688,6 +688,18 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
>   	sdhci_omap_start_clock(omap_host);
>   }
>   
> +void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	/* Don't reset data lines during tuning operation */
> +	if (omap_host->is_tuning)
> +		mask &= ~SDHCI_RESET_DATA;
> +
> +	sdhci_reset(host, mask);
> +}
> +
>   static struct sdhci_ops sdhci_omap_ops = {
>   	.set_clock = sdhci_omap_set_clock,
>   	.set_power = sdhci_omap_set_power,
> @@ -696,7 +708,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>   	.get_min_clock = sdhci_omap_get_min_clock,
>   	.set_bus_width = sdhci_omap_set_bus_width,
>   	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_omap_reset,
>   	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
>   };
>   
> 
