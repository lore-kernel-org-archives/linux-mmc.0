From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Wed, 31 Aug 2016 21:24:03 +0200
Message-ID: <1472671443.2407.1.camel@lynxeye.de>
References: <20160831162324.15480-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831162324.15480-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, den 31.08.2016, 18:23 +0200 schrieb Thierry Reding:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-
> bit
> addressing, but testing shows that this doesn't work. On a device
> which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can
> use
> addresses above the 32-bit boundary.
> 
> One way to work around this would be to enable IOMMU physical to
> virtual
> address translations for the SD/MMC controllers, but that's not easy
> to
> implement without breaking existing use-cases. It's also not obvious
> why
> 34-bit addressing doesn't work as advertised. In order to fix this
> for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.
> 
> Reported-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-
> tegra.c
> index d89200ee017e..a3d045630d0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -394,6 +394,22 @@ static const struct sdhci_tegra_soc_data
> soc_data_tegra114 = {
>  	.pdata = &sdhci_tegra114_pdata,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |

IMHO it would be good to have a short comment in the code saying why
this flag is necessary. Not everyone checks the git log before trying
to change those things...

Regards,
Lucas

> +		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> +	.pdata = &sdhci_tegra124_pdata,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>  		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -427,7 +443,7 @@ static const struct sdhci_tegra_soc_data
> soc_data_tegra186 = {
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>  	{ .compatible = "nvidia,tegra186-sdhci", .data =
> &soc_data_tegra186 },
>  	{ .compatible = "nvidia,tegra210-sdhci", .data =
> &soc_data_tegra210 },
> -	{ .compatible = "nvidia,tegra124-sdhci", .data =
> &soc_data_tegra114 },
> +	{ .compatible = "nvidia,tegra124-sdhci", .data =
> &soc_data_tegra124 },
>  	{ .compatible = "nvidia,tegra114-sdhci", .data =
> &soc_data_tegra114 },
>  	{ .compatible = "nvidia,tegra30-sdhci", .data =
> &soc_data_tegra30 },
>  	{ .compatible = "nvidia,tegra20-sdhci", .data =
> &soc_data_tegra20 },
