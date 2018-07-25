From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 02/10] mmc: tegra: Set calibration pad voltage reference
Date: Wed, 25 Jul 2018 10:08:46 +0300
Message-ID: <d5018027-f333-8432-f8ed-81a2cdfedea8@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24.07.2018 17:34, Aapo Vienamo wrote:
> Configure the voltage reference used by the automatic pad drive strength
> calibration procedure. The value is a magic number from the TRM.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e40ca43..6008e2f 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -49,6 +49,10 @@
>   #define SDHCI_AUTO_CAL_START			BIT(31)
>   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
>   
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +
>   #define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
>   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
>   
> @@ -152,7 +156,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>   	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> -	u32 misc_ctrl, clk_ctrl;
> +	u32 misc_ctrl, clk_ctrl, pad_ctrl;
>   
>   	sdhci_reset(host, mask);
>   
> @@ -193,8 +197,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>   	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>   
> -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> +	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB) {
> +		pad_ctrl = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +		pad_ctrl &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK;
> +		pad_ctrl |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL;
> +		sdhci_writel(host, pad_ctrl, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +

Will this happen to only eMMC controllers or for all controllers? My 
docs are saying this should be set to 0x7 for SDMMC2/4 and 0x1 or 0x2 
for SDMMC1/3 depending on voltage. Not sure how downstream is 
programming it, though.

>   		tegra_host->pad_calib_required = true;
> +	}
>   
>   	tegra_host->ddr_signaling = false;
>   }
> 
