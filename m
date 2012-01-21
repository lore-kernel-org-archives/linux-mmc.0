From: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 03/31] ARM: amba: ux500: convert to use
 amba_device_alloc
Date: Sat, 21 Jan 2012 21:51:58 +0530
Message-ID: <20120121162157.GB26323@bnru02>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAgu-0005EQ-Fo@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1RoAgu-0005EQ-Fo@rmk-PC.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 20, 2012 at 10:23:24 +0100, Russell King - ARM Linux wrote:
> Convert ux500 to use the new amba_device_alloc APIs.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

> ---
>  arch/arm/mach-ux500/devices-common.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
> index c563e54..e8c34fa 100644
> --- a/arch/arm/mach-ux500/devices-common.c
> +++ b/arch/arm/mach-ux500/devices-common.c
> @@ -26,16 +26,10 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
>  	struct amba_device *dev;
>  	int ret;
>  
> -	dev = kzalloc(sizeof *dev, GFP_KERNEL);
> +	dev = amba_device_alloc(name, base, SZ_4K);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
>  
> -	dev->dev.init_name = name;
> -
> -	dev->res.start = base;
> -	dev->res.end = base + SZ_4K - 1;
> -	dev->res.flags = IORESOURCE_MEM;
> -
>  	dev->dma_mask = DMA_BIT_MASK(32);
>  	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  
> @@ -46,9 +40,9 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
>  
>  	dev->dev.platform_data = pdata;
>  
> -	ret = amba_device_register(dev, &iomem_resource);
> +	ret = amba_device_add(dev, &iomem_resource);
>  	if (ret) {
> -		kfree(dev);
> +		amba_device_put(dev);
>  		return ERR_PTR(ret);
>  	}
>  
> -- 
> 1.7.4.4
> 
