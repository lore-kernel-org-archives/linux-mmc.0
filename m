From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 01/10] mmc: tegra: Poll for calibration completion
Date: Wed, 25 Jul 2018 10:04:25 +0300
Message-ID: <02139ade-23f4-8133-321e-8dd06a7011ea@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442591-5640-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532442591-5640-2-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24.07.2018 17:29, Aapo Vienamo wrote:
> Implement polling with 10 ms timeout for automatic pad drive strength
> calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f108c48..e40ca43 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -49,6 +49,9 @@
>   #define SDHCI_AUTO_CAL_START			BIT(31)
>   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
>   
> +#define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
> +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)

Please align the definition value with tabs. Also it looks like the 
alignments for the defines here are all over the place, would be nice to 
fix those up so they line up.

> +
>   #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
>   #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
>   #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> @@ -198,13 +201,24 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
> -	u32 val;
> +	unsigned timeout = 10;

I prefer "unsigned int" instead of just "unsigned", but I guess that's 
just a personal preference..

> +	u32 reg;
>   
> -	mdelay(1);
> +	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	udelay(1);
> +
> +	do {
> +		reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_STATUS);
> +		if (!(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE))
> +			break;
> +		mdelay(1);
> +		timeout--;
> +	} while (timeout);

Can we use readl_poll_timeout here? We'll need to calculate the address 
directly but it'd still look nicer.

Cheers,
Mikko

>   
> -	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> -	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> -	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	if (timeout == 0)
> +		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>   }
>   
>   static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> 
