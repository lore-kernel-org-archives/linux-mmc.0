From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Remove platform data
Date: Wed, 31 Oct 2012 23:45:00 +0800
Message-ID: <20121031154458.GB8358@S2100-06.ap.freescale.net>
References: <1351682578-12922-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:29050
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932178Ab2JaPTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 11:19:42 -0400
Content-Disposition: inline
In-Reply-To: <1351682578-12922-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, marex@denx.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Oct 31, 2012 at 09:22:58AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> All MXS users have been converted to device tree and the board files have been
> removed.
> 
> No need to keep platform data in the driver.
> 
> Also move bus_width declaration in the beggining of mxs_mmc_probe() to avoid:
> 'warning: ISO C90 forbids mixed declarations and code'.
>   
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ----
> Changes since v1:
> - Also remove mxs_mmc_platform_data and linux/mmc/mxs-mmc.h, which was used only
> to include mxs_mmc_platform_data definition.
> 
>  drivers/mmc/host/mxs-mmc.c  |   31 ++++++++++---------------------
>  include/linux/mmc/mxs-mmc.h |   19 -------------------
>  2 files changed, 10 insertions(+), 40 deletions(-)
>  delete mode 100644 include/linux/mmc/mxs-mmc.h
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 80d1e6d..206fe49 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -43,7 +43,6 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/stmp_device.h>
> -#include <linux/mmc/mxs-mmc.h>
>  #include <linux/spi/mxs-spi.h>
>  
>  #define DRIVER_NAME	"mxs-mmc"
> @@ -593,13 +592,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	struct mxs_mmc_host *host;
>  	struct mmc_host *mmc;
>  	struct resource *iores, *dmares;
> -	struct mxs_mmc_platform_data *pdata;
>  	struct pinctrl *pinctrl;
>  	int ret = 0, irq_err, irq_dma;
>  	dma_cap_mask_t mask;
>  	struct regulator *reg_vmmc;
>  	enum of_gpio_flags flags;
>  	struct mxs_ssp *ssp;
> +	u32 bus_width = 0;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> @@ -682,25 +681,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
>  		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
>  
> -	pdata =	mmc_dev(host->mmc)->platform_data;
> -	if (!pdata) {
> -		u32 bus_width = 0;
> -		of_property_read_u32(np, "bus-width", &bus_width);
> -		if (bus_width == 4)
> -			mmc->caps |= MMC_CAP_4_BIT_DATA;
> -		else if (bus_width == 8)
> -			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -		host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0,
> -							&flags);
> -		if (flags & OF_GPIO_ACTIVE_LOW)
> -			host->wp_inverted = 1;
> -	} else {
> -		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
> -			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -		if (pdata->flags & SLOTF_4_BIT_CAPABLE)
> -			mmc->caps |= MMC_CAP_4_BIT_DATA;
> -		host->wp_gpio = pdata->wp_gpio;
> -	}

Since you are here, you may also want to remove the "if (np)" check for
non-dt probe case getting devid and dma_channel.  As the result,
mxs_ssp_ids can be removed as well.

It could be another patch though, so for this one:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> +	of_property_read_u32(np, "bus-width", &bus_width);
> +	if (bus_width == 4)
> +		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +	else if (bus_width == 8)
> +		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> +	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
> +
> +	if (flags & OF_GPIO_ACTIVE_LOW)
> +		host->wp_inverted = 1;
>  
>  	mmc->f_min = 400000;
>  	mmc->f_max = 288000000;
> diff --git a/include/linux/mmc/mxs-mmc.h b/include/linux/mmc/mxs-mmc.h
> deleted file mode 100644
> index 7c2ad3a..0000000
> -- 
> 1.7.9.5
> 

