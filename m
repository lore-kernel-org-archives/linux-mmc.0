From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 03/10] mmc: tegra: Power on the calibration pad
Date: Tue, 31 Jul 2018 11:41:57 +0200
Message-ID: <e4319add2110282f8ddc4c3016512516@agner.ch>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
 <1532608016-14319-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532608016-14319-4-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26.07.2018 14:26, Aapo Vienamo wrote:
> Automatic pad drive strength calibration is performed on a separate pad
> identical to the ones used for driving the actual bus. Power on the
> calibration pad during the calibration procedure and power it off
> afterwards to save power.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 51eda20..363490e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -53,6 +53,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
>  
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> @@ -241,11 +242,30 @@ static void tegra_sdhci_reset(struct sdhci_host
> *host, u8 mask)
>  	tegra_host->ddr_signaling = false;
>  }
>  
> +static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable the additional I/O pad used by the drive strength
> +	 * calibration process.
> +	 */
> +	reg = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	if (enable)
> +		reg |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +	else
> +		reg &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	udelay(1);

Is this necessary on enable and disable?

If it only necessary on enable, I suggest to move it after the call to:
tegra_sdhci_configure_cal_pad(host, true);

--
Stefan

> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
>  	u32 reg;
>  	int ret;
>  
> +	tegra_sdhci_configure_cal_pad(host, true);
> +
>  	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>  	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
>  	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -255,6 +275,8 @@ static void tegra_sdhci_pad_autocalib(struct
> sdhci_host *host)
>  				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
>  				 1, 10000);
>  
> +	tegra_sdhci_configure_cal_pad(host, false);
> +
>  	if (ret)
>  		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
