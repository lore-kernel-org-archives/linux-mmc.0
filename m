From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Tue, 9 Nov 2010 14:31:40 +0000
Message-ID: <20101109143140.GA7977@void.printf.net>
References: <AANLkTinyu5j0KpZ5AWuE0yOvAaFNBkM+bSfiLqpNcS+_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40503 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab0KIObl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 09:31:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinyu5j0KpZ5AWuE0yOvAaFNBkM+bSfiLqpNcS+_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

Hi,

Here are some obvious changes:

On Tue, Nov 09, 2010 at 09:17:21AM -0500, zhangfei gao wrote:
> Haojian,
> 
> Would you help review, since arch/arm/plat-pxa/include/plat/sdhci.h is
> updated, thanks
> 
> >From 6619812b749aa12ebf0efbe057366c2f99051bfe Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Tue, 2 Nov 2010 07:37:44 -0400
> Subject: [PATCH] sdhci-pxa: support tune_timming for various cards
> 
> 	1. Add pdata check, in case pdata is NULL
> 	2. Add tune_timming to adjust read data/command timming without
> performance impact when crc error, as a result
> 		a, sd could work at 50M
> 		b, emmc could work at ddr50 mode

timming -> timing, throughout the patch

> 	3. Remove clock_enable checking, since clock gating is still on-going
> in core stack.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |    2 +
>  drivers/mmc/host/sdhci-pxa.c           |   51 +++++++++++++++++++++++--------
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index fc5ceab..8c340b1 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -24,11 +24,13 @@
>   * @max_speed: the maximum speed supported
>   * @quirks: quirks of specific device
>   * @flags: flags for platform requirement
> + * @clk_delay: clk_delay vlaue to tunning various cards

vlaue -> value
tunning -> tuning

>   */
>  struct sdhci_pxa_platdata {
>  	unsigned int	max_speed;
>  	unsigned int	quirks;
>  	unsigned int	flags;
> +	unsigned int	clk_delay;
>  };
> 
>  #endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index 8455c46..cf514f8 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -32,6 +32,11 @@
>  #define SD_FIFO_PARAM		0x104
>  #define DIS_PAD_SD_CLK_GATE	0x400
> 
> +#define SD_CLOCK_AND_BURST_SIZE_SETUP		0x10A
> +#define SDCLK_SEL	0x100
> +#define SDCLK_DELAY_SHIFT	9
> +#define SDCLK_DELAY_MASK	0x1f
> +
>  struct sdhci_pxa {
>  	struct sdhci_host		*host;
>  	struct sdhci_pxa_platdata	*pdata;
> @@ -46,6 +51,26 @@ struct sdhci_pxa {
>   * SDHCI core callbacks                                                      *
>   *                                                                           *
>  \*****************************************************************************/
> +static void tune_timming(struct sdhci_host *host)
> +{
> +	struct sdhci_pxa *pxa = sdhci_priv(host);
> +
> +	/*
> +	 * tune timming of read data/command when crc error happen
> +	 * No perfermance impact

perfermance -> performance

> +	 */
> +	if (pxa->pdata && 0 != pxa->pdata->clk_delay) {
> +		u16 tmp;
> +
> +		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> +		tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK)
> +					<< SDCLK_DELAY_SHIFT;
> +		tmp |= SDCLK_SEL;
> +		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> +	}
> +
> +}
> +
>  static void set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pxa *pxa = sdhci_priv(host);
> @@ -57,15 +82,16 @@ static void set_clock(struct sdhci_host *host,
> unsigned int clock)
>  			pxa->clk_enable = 0;
>  		}
>  	} else {
> -		if (0 == pxa->clk_enable) {
> -			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
> -				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
> -				tmp |= DIS_PAD_SD_CLK_GATE;
> -				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
> -			}
> -			clk_enable(pxa->clk);
> -			pxa->clk_enable = 1;
> +		tune_timming(host);

It looks like tune_timing() is a void function that only gets called
once.  Perhaps it should just happen inline here instead?

> +		if (pxa->pdata &&
> +			pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
> +
> +			tmp = readl(host->ioaddr + SD_FIFO_PARAM);
> +			tmp |= DIS_PAD_SD_CLK_GATE;
> +			writel(tmp, host->ioaddr + SD_FIFO_PARAM);
>  		}
> +		clk_enable(pxa->clk);
> +		pxa->clk_enable = 1;
>  	}
>  }
> 
> @@ -138,13 +164,13 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
>  	host->irq = irq;
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> -	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> +	if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
>  		/* on-chip device */
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
>  	}
> 
> -	if (pdata->quirks)
> +	if (pdata && pdata->quirks)
>  		host->quirks |= pdata->quirks;
> 
>  	ret = sdhci_add_host(host);
> @@ -153,9 +179,8 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
>  		goto out;
>  	}
> 
> -	if (pxa->pdata->max_speed)
> -		host->mmc->f_max = pxa->pdata->max_speed;
> -
> +	if (pdata && pdata->max_speed)
> +		host->mmc->f_max = pdata->max_speed;
>  	platform_set_drvdata(pdev, host);

No reason to remove the newline here.

> 
>  	return 0;
> -- 

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
