From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 08/19] mmc: sdhi: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 10:07:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1310290919120.8404@axis700.grange>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383004027-25036-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Laurent

On Tue, 29 Oct 2013, Laurent Pinchart wrote:

> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/mmc/host/Kconfig        | 2 +-
>  drivers/mmc/host/tmio_mmc_dma.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..51957d4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -479,7 +479,7 @@ config MMC_TMIO
>  
>  config MMC_SDHI
>  	tristate "SH-Mobile SDHI SD/SDIO controller support"
> -	depends on SUPERH || ARCH_SHMOBILE
> +	depends on SUPERH || ARM
>  	select MMC_TMIO_CORE
>  	help
>  	  This provides support for the SDHI SD/SDIO controller found in
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 65edb4a..535bc35 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -28,7 +28,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
>  	if (!host->chan_tx || !host->chan_rx)
>  		return;
>  
> -#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARM)

I'm not sure about this one. In principle DMA so far is only used on SDHI 
with TMIO. But this #if was for a theoretical case, when a TMIO MMC IP 
inside an MFD is also used with DMA. Bus since I had no indormation about 
whether the CTL_DMA_ENABLE register was SDHI specific or not, I put it 
under an #if for the time being. In any case, I don't think making it 
#ifdef CONFIG_ARM makes much sense. We can either remove the #if 
completely, or keep it to limit the scope of this write to sh-mobile 
arches.

Thanks
Guennadi

>  	/* Switch DMA mode on or off - SuperH specific? */
>  	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
>  #endif
> -- 
> 1.8.1.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
