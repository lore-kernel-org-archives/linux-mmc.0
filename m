From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pxav3: Fix tabbing issue
Date: Tue, 01 Sep 2015 13:31:26 -0700
Message-ID: <1441139486.12163.3.camel@perches.com>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
	 <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
> There were some coding style issues where spaces have been used instead
> of tabs, for example, in macro definitions, alignment of function
> declarations/definitions, etc...
> 
> This patch fixes all such occurrences in the code.
> And also use BIT for bit definitions.

Please send 2 patches instead.

> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
[]
> @@ -128,7 +133,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>  }
>  
>  static int armada_38x_quirks(struct platform_device *pdev,
> -			     struct sdhci_host *host)
> +			struct sdhci_host *host)

This is not an improvement.

The old code is aligned to the open parenthesis
and is fine.

> @@ -284,10 +288,10 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  	 * FE-2946959
>  	 */
>  	if (pxa->sdio3_conf_reg) {
> -		u8 reg_val  = readb(pxa->sdio3_conf_reg);
> +		u8 reg_val = readb(pxa->sdio3_conf_reg);
>  
>  		if (uhs == MMC_TIMING_UHS_SDR50 ||
> -		    uhs == MMC_TIMING_UHS_DDR50) {
> +				uhs == MMC_TIMING_UHS_DDR50) {

Also not an improvement.

> @@ -304,20 +308,20 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  }
>  
>  static const struct sdhci_ops pxav3_sdhci_ops = {
> -	.set_clock = sdhci_set_clock,
> -	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> -	.set_bus_width = sdhci_set_bus_width,
> -	.reset = pxav3_reset,
> -	.set_uhs_signaling = pxav3_set_uhs_signaling,
> +	.set_clock			= sdhci_set_clock,
> +	.platform_send_init_74_clocks	= pxav3_gen_init_74_clocks,
> +	.get_max_clock			= sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width			= sdhci_set_bus_width,
> +	.reset				= pxav3_reset,
> +	.set_uhs_signaling		= pxav3_set_uhs_signaling,

<shrug>  If you want.
>  };
>  
>  static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
> -	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
> +	.quirks	= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK

Also not an improvement.  Why change the space to a tab here?

> @@ -343,7 +347,7 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
>  		return NULL;
>  
>  	if (!of_property_read_u32(np, "mrvl,clk-delay-cycles",
> -				  &clk_delay_cycles))
> +				&clk_delay_cycles))

Not an improvement, etc...
