From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing
 frequency
Date: Wed, 11 Jul 2018 15:29:14 +0300
Message-ID: <baf7647f-47e7-dfe0-102c-9f7f48b3a363@intel.com>
References: <20180705113937.16414-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705113937.16414-1-stefan@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 05/07/18 14:39, Stefan Agner wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
> 
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
> 
> Make sure to disable card clock before chainging frequency for uSDHC

chainging -> changing

> IP variants too. Also fix indent to make disable/enable clock look
> alike.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..aa48f4b2541a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  	int div = 1;
>  	u32 temp, val;
>  
> +	if (esdhc_is_usdhc(imx_data)) {
> +		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
> +	}
> +
>  	if (clock == 0) {
>  		host->mmc->actual_clock = 0;
> -
> -		if (esdhc_is_usdhc(imx_data)) {
> -			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -					host->ioaddr + ESDHC_VENDOR_SPEC);
> -		}
>  		return;
>  	}
>  
> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  	if (esdhc_is_usdhc(imx_data)) {
>  		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>  		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -		host->ioaddr + ESDHC_VENDOR_SPEC);
> +			host->ioaddr + ESDHC_VENDOR_SPEC);

Ideally each patch does only 1 thing.  Please make white-space fix-up a
separate patch.

>  	}
>  
>  	mdelay(1);
> 
