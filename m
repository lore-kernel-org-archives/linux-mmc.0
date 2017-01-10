From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC 2/3] mmc: host: tmio: SDIO_STATUS_QUIRK is rather
 SDIO_STATUS_SETBITS
Date: Tue, 10 Jan 2017 09:07:40 +0100
Message-ID: <20170110080740.GD25239@verge.net.au>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
 <20170105114326.12426-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105114326.12426-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 05, 2017 at 12:43:25PM +0100, Wolfram Sang wrote:
> QUIRK sounds like there is something wrong, but actually there are just
> some bits which need to be 1. Rename it to be more clear.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 6 ++----
>  drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
>  include/linux/mfd/tmio.h          | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 59db14b4827c33..1600fefc2c3e2c 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -641,10 +641,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	 */
>  	mmc_data->flags |= TMIO_MMC_HAVE_CMD12_CTRL;
>  
> -	/*
> -	 * All SDHI need SDIO_INFO1 reserved bit
> -	 */
> -	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
> +	/* All SDHI have reserved bits */
> +	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
>  
>  	ret = tmio_mmc_host_probe(host, mmc_data);
>  	if (ret < 0)
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 60dc43b4574117..d6033620a45c12 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -723,7 +723,7 @@ static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
>  	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
>  
>  	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
> -	if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
> +	if (pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
>  		sdio_status |= 6;
>  
>  	sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index fba44abd05ba1a..5a05a34cc1a292 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -97,7 +97,7 @@
>  /*
>   * Some controllers needs to set 1 on SDIO status reserved bits
>   */

Is the following update to the above appropriate?
In particular, is it some or all?

    * Controllers need to set 1 on SDIO status reserved bits

> -#define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
> +#define TMIO_MMC_SDIO_STATUS_SETBITS	(1 << 8)
>  
>  /*
>   * Some controllers have a 32-bit wide data port register
> -- 
> 2.11.0
> 
