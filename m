From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: Support external regulators
Date: Fri, 10 Mar 2017 14:29:48 +0100
Message-ID: <95e69d5f-29c6-5283-7bd7-831a92081d7b@microchip.com>
References: <20170309151820.7510-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170309151820.7510-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Romain,

On 03/09/2017 04:18 PM, Romain Izard wrote:
> The SDHCI controller in the SAMA5D2 chip requires a valid voltage set
> in the power control register, otherwise commands will fail with a
> timeout error.
>
> When using the regulator framework to specify the regulator used by the
> mmc device, the voltage is not configured, and it is not possible to use
> the connected device.
>

It's true, I proposed some patches long time ago to change a bit the 
behavior of the sdhci_set_power function but we didn't agree and so I 
didn't declare the regulator.

> Implement a custom 'set_power' function for this specific hardware, that
> configures the voltage in the register in all cases.
>

I don't remember if the set_power ops was available at that time. If 
yes, I would have thought about it. IMO it's a nice solution.

> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 2f9ad213377a..291a74955a4c 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -85,11 +85,30 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  }
>
> +/*
> + * In this specific implementation of the SDHCI contoller, the power register
controller

Regards

Ludovic

> + * needs to have a valid voltage set even when the power supply is managed by
> + * an external regulator.
> + */
> +static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
> +		     unsigned short vdd)
> +{
> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
> +		struct mmc_host *mmc = host->mmc;
> +
> +		spin_unlock_irq(&host->lock);
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		spin_lock_irq(&host->lock);
> +	}
> +	sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
>  static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>  	.set_clock		= sdhci_at91_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.reset			= sdhci_reset,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.set_power		= sdhci_at91_set_power,
>  };
>
>  static const struct sdhci_pltfm_data soc_data_sama5d2 = {
>
