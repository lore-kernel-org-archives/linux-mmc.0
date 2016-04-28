From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-at91: add presets setup
Date: Thu, 28 Apr 2016 16:20:02 +0300
Message-ID: <57220E02.7020001@intel.com>
References: <1461848366-32562-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461848366-32562-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com
List-Id: linux-mmc@vger.kernel.org

On 28/04/16 15:59, Ludovic Desroches wrote:
> The controller claims to support SDR104. In fact, it only supports a
> degraded SDR104 since the maximum frequency of the SD clock is 120 MHz
> instead of 208 MHz.
> The sdhci core is unaware of it and will compute a wrong clock divider.
> We can deal with this specific case by using presets.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes:
> - v2:
>   - use a define for preset_common since it's a constant
> 
>  drivers/mmc/host/sdhci-of-at91.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index c1923c0..25f779e 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> @@ -32,6 +33,8 @@
>  #define		SDMMC_CACR_CAPWREN	BIT(0)
>  #define		SDMMC_CACR_KEY		(0x46 << 8)
>  
> +#define SDHCI_AT91_PRESET_COMMON_CONF	0x400 /* drv type B, programmable clock mode */
> +
>  struct sdhci_at91_priv {
>  	struct clk *hclock;
>  	struct clk *gck;
> @@ -163,6 +166,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	unsigned int			clk_base, clk_mul;
>  	unsigned int			gck_rate, real_gck_rate;
>  	int				ret;
> +	unsigned int			preset_div;
>  
>  	match = of_match_device(sdhci_at91_dt_match, &pdev->dev);
>  	if (!match)
> @@ -230,6 +234,28 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  			 clk_mul, real_gck_rate);
>  	}
>  
> +	/*
> +	 * We have to set preset values because it depends on the clk_mul
> +	 * value. Moreover, SDR104 is supported in a degraded mode since the
> +	 * maximum sd clock value is 120 MHz instead of 208 MHz. For that
> +	 * reason, we need to use presets to support SDR104.
> +	 */
> +	preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR12);
> +	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR25);
> +	preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR50);
> +	preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR104);
> +	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
> +
>  	clk_prepare_enable(priv->mainck);
>  	clk_prepare_enable(priv->gck);
>  
> 
