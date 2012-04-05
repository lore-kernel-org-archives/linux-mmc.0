From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap4: hsmmc: fix module re-insertion
Date: Thu, 5 Apr 2012 15:11:37 -0700
Message-ID: <20120405221136.GG3785@atomide.com>
References: <1331222320-31370-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331222320-31370-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Chris,

* Balaji T K <balajitk@ti.com> [120308 07:27]:
> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
> Addng the offset to platform_device resource structure
> increments the start address for every insmod operation.
> MMC command fails on re-insertion as module due to incorrect register base.
> Fix this by updating the ioremap base address only.

Any news on getting this fix merged during the -rc cycle?

This is pretty important fix for anybody wanting to reload
the omap_hsmmc.ko module..

Regards,

Tony
 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e550170..102425c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1741,8 +1741,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	if (res == NULL || irq < 0)
>  		return -ENXIO;
>  
> -	res->start += pdata->reg_offset;
> -	res->end += pdata->reg_offset;
>  	res = request_mem_region(res->start, resource_size(res), pdev->name);
>  	if (res == NULL)
>  		return -EBUSY;
> @@ -1766,7 +1764,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	host->dma_ch	= -1;
>  	host->irq	= irq;
>  	host->slot_id	= 0;
> -	host->mapbase	= res->start;
> +	host->mapbase	= res->start + pdata->reg_offset;
>  	host->base	= ioremap(host->mapbase, SZ_4K);
>  	host->power_mode = MMC_POWER_OFF;
>  	host->next_data.cookie = 1;
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
