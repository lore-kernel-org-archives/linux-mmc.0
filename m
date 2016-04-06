From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: introduce sdhci_compute_clock_config
Date: Wed, 6 Apr 2016 15:37:28 +0300
Message-ID: <57050308.2070006@intel.com>
References: <1459783675-7798-1-git-send-email-ludovic.desroches@atmel.com>
 <1459783675-7798-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48663 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbcDFMm3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Apr 2016 08:42:29 -0400
In-Reply-To: <1459783675-7798-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com

On 04/04/16 18:27, Ludovic Desroches wrote:
> In order to remove the SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST and to
> reduce code duplication, put the code relative to the SD clock
> configuration in a function which can be used by hosts for the
> implementation of the set_clock() callback.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++++++++-----------
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6bd3d17..2c3dede 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1091,23 +1091,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	return preset;
>  }
>  
> -void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +u16 sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock)

The function name 'sdhci_compute_clock_config' seems a bit long.  How about
just sdhci_calc_clk.

Also it needs to calculate 'actual_clock' too, so it needs to do that and
return the value.

>  {
>  	int div = 0; /* Initialized for compiler warning */
>  	int real_div = div, clk_mul = 1;
>  	u16 clk = 0;
> -	unsigned long timeout;
>  	bool switch_base_clk = false;
>  
> -	host->mmc->actual_clock = 0;
> -
> -	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> -	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> -		mdelay(1);
> -
> -	if (clock == 0)
> -		return;
> -
>  	if (host->version >= SDHCI_SPEC_300) {
>  		if (host->preset_enabled) {
>  			u16 pre_val;
> @@ -1188,6 +1178,27 @@ clock_set:
>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>  		<< SDHCI_DIVIDER_HI_SHIFT;
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_compute_clock_config);
> +
> +void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +	unsigned long timeout;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> +		mdelay(1);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_compute_clock_config(host, clock);
> +
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0f39f4f..23ddd6e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -661,6 +661,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
>  	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
>  }
>  
> +u16 sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		     unsigned short vdd);
> 

