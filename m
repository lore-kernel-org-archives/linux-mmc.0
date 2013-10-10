From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: Get rid of MMC_BLOCK dependency
Date: Thu, 10 Oct 2013 16:24:33 +0900
Message-ID: <20131010072431.GA24126@verge.net.au>
References: <20131009224545.23119.45781.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131009224545.23119.45781.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, cjb@laptop.org, linux-mmc@vger.kernel.org, g.liakhovetski@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 10, 2013 at 07:45:45AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> It seems like sh_mmcif.c now is the only MMC driver depending on MMC_BLOCK,
> the hardware is not special in any way so rework the Kconfig dependency to
> be less special.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/drivers/mmc/host/Kconfig
> +++ work/drivers/mmc/host/Kconfig	2013-10-08 18:03:17.000000000 +0900
> @@ -588,7 +588,7 @@ config MMC_DW_PCI
>  
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
> -	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> +	depends on SUPERH || ARCH_SHMOBILE
>  	help
>  	  This selects the MMC Host Interface controller (MMCIF).
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
