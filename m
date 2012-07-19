From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: OMAP: make MMC_OMAP* depend on DMA_OMAP
Date: Thu, 19 Jul 2012 01:05:20 -0400
Message-ID: <87pq7s9w8f.fsf@octavius.laptop.org>
References: <1341450721-20993-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57202 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756231Ab2GSFF0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 01:05:26 -0400
In-Reply-To: <1341450721-20993-1-git-send-email-ming.lei@canonical.com> (Ming
	Lei's message of "Thu, 5 Jul 2012 09:12:01 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, Ming Lei <ming.lei@canonical.com>
Cc: linux-mmc@vger.kernel.org

Hi Venkat -- please could you ACK/review this patch?

On Wed, Jul 04 2012, Ming Lei wrote:
> Recent commits on omap mmc/hsmmc in -next tree switch to
> DMA_ENGINE entirely, so make MMC_OMAP* depend on DMA_OMAP
> and DMA_ENGINE, otherwise OMAP MMC/HSMMC won't work without
> enabling DMA_ENGINE and DMA_OMAP.
>
> The patch simply make them depend on DMA_OMAP since DMA_OMAP
> will select DMA_ENGINE automatically.
>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  drivers/mmc/host/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index aa131b3..ef72c50 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA
>  
>  config MMC_OMAP
>  	tristate "TI OMAP Multimedia Card Interface support"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP && DMA_OMAP
>  	select TPS65010 if MACH_OMAP_H2
>  	help
>  	  This selects the TI OMAP Multimedia card Interface.
> @@ -242,7 +242,7 @@ config MMC_OMAP
>  
>  config MMC_OMAP_HS
>  	tristate "TI OMAP High Speed Multimedia Card Interface support"
> -	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
> +	depends on (SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4) && DMA_OMAP
>  	help
>  	  This selects the TI OMAP High Speed Multimedia card Interface.
>  	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
