From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 04/10] mmc: tegra: Disable card clock during pad
 calibration
Date: Wed, 25 Jul 2018 10:14:54 +0300
Message-ID: <1f70fd07-f952-63c9-8727-e6dacf52da73@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532442865-6391-3-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24.07.2018 17:34, Aapo Vienamo wrote:
> Disable the card clock during automatic pad drive strength calibration
> and re-enable it aftewards.

s/aftewards/afterwards/.

> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 61067b7..0de74f4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -52,6 +52,7 @@
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD		BIT(31)

Looks like this should be in the previous patch.

>   
>   #define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
>   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
> @@ -226,11 +227,35 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
>   	udelay(1);
>   }
>   
> +static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
> +{
> +	bool orig_enabled;
> +	u32 reg;
> +
> +	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	orig_enabled = reg & SDHCI_CLOCK_CARD_EN;

I would do !!(reg & SDHCI_CLOCK_CARD_EN) here.

> +
> +	if (orig_enabled == enable)
> +		return orig_enabled;
> +
> +	if (enable)
> +		reg |= SDHCI_CLOCK_CARD_EN;
> +	else
> +		reg &= ~SDHCI_CLOCK_CARD_EN;
> +
> +	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +	return orig_enabled;
> +}
> +
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
>   	unsigned timeout = 10;
> +	bool card_clk_enabled;
>   	u32 reg;
>   
> +	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
> +
>   	tegra_sdhci_configure_cal_pad(host, true);
>   
>   	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -248,6 +273,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   
>   	tegra_sdhci_configure_cal_pad(host, false);
>   
> +	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +
>   	if (timeout == 0)
>   		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>   }
> 
