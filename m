From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: Support external regulators
Date: Tue, 14 Mar 2017 14:06:40 +0100
Message-ID: <20170314130640.wz2wnebphaluvsjw@rfolt0960.corp.atmel.com>
References: <20170309151820.7510-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exsmtp01.microchip.com ([198.175.253.37]:41449 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbdCNNHL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 09:07:11 -0400
Content-Disposition: inline
In-Reply-To: <20170309151820.7510-1-romain.izard.pro@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Mar 09, 2017 at 04:18:20PM +0100, Romain Izard wrote:
> The SDHCI controller in the SAMA5D2 chip requires a valid voltage set
> in the power control register, otherwise commands will fail with a
> timeout error.
> 
> When using the regulator framework to specify the regulator used by the
> mmc device, the voltage is not configured, and it is not possible to use
> the connected device.
> 
> Implement a custom 'set_power' function for this specific hardware, that
> configures the voltage in the register in all cases.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Cc: stable@vger.kernel.org #4.9+

Can be added since sdhci_set_power_noreg was introduced in 4.9.

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
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
