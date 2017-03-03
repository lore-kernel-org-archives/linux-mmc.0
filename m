From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mmc: tegra: Add Tegra186 support
Date: Fri, 3 Mar 2017 09:44:06 +0200
Message-ID: <7893a54f-08fd-a8e6-308d-a388bb183434@intel.com>
References: <20170223162342.15911-1-thierry.reding@gmail.com>
 <20170223162342.15911-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170223162342.15911-2-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 23/02/17 18:23, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> The SDHCI controller found on NVIDIA Tegra186 SoCs is very similar to
> the one on prior generations of Tegra and can be supported by the same
> driver.
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 9ae5895678e8..9ef4afcf312c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -434,7 +434,23 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  	.pdata = &sdhci_tegra210_pdata,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
> +	.pdata = &sdhci_tegra186_pdata,
> +};
> +
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> +	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>  	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
>  	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
>  	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
> 
