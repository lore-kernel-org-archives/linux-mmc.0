From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Thu, 1 Sep 2016 09:44:56 +0300
Message-ID: <c120f682-4a2d-7ca0-9095-3705c0d0c12f@intel.com>
References: <20160831162324.15480-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:64350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752968AbcIAGtc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 02:49:32 -0400
In-Reply-To: <20160831162324.15480-1-thierry.reding@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Kocialkowski <contact@paulk.fr>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On 31/08/16 19:23, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
> addressing, but testing shows that this doesn't work. On a device which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
> addresses above the 32-bit boundary.
> 
> One way to work around this would be to enable IOMMU physical to virtual
> address translations for the SD/MMC controllers, but that's not easy to
> implement without breaking existing use-cases. It's also not obvious why
> 34-bit addressing doesn't work as advertised. In order to fix this for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.
> 
> Reported-by: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Doesn't apply cleanly, but otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index d89200ee017e..a3d045630d0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -394,6 +394,22 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
>  	.pdata = &sdhci_tegra114_pdata,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> +	.pdata = &sdhci_tegra124_pdata,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>  		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -427,7 +443,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>  	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>  	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
> -	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
> +	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
>  	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
>  	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
>  	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
> 

