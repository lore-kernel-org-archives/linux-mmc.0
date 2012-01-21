From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 31/31] ARM: amba: samsung: use common amba device
 initializers
Date: Sat, 21 Jan 2012 09:45:23 +0900
Message-ID: <010201ccd7d5$f5ceabf0$e16c03d0$%kim@samsung.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAq3-0005GM-LI@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <E1RoAq3-0005GM-LI-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'STEricsson' <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Russell King wrote:
> 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

Acked-by: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-exynos/dma.c  |   38 ++++++--------------------------------
>  arch/arm/mach-s5p64x0/dma.c |   22 +++++-----------------
>  arch/arm/mach-s5pc100/dma.c |   38 ++++++--------------------------------
>  arch/arm/mach-s5pv210/dma.c |   38 ++++++--------------------------------
>  4 files changed, 23 insertions(+), 113 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
> index 8d681bf..91370de 100644
> --- a/arch/arm/mach-exynos/dma.c
> +++ b/arch/arm/mach-exynos/dma.c
> @@ -74,21 +74,8 @@ struct dma_pl330_platdata exynos4_pdma0_pdata = {
>  	.peri_id = pdma0_peri,
>  };
> 
> -struct amba_device exynos4_device_pdma0 = {
> -	.dev = {
> -		.init_name = "dma-pl330.0",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &exynos4_pdma0_pdata,
> -	},
> -	.res = {
> -		.start = EXYNOS4_PA_PDMA0,
> -		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA0},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330, EXYNOS4_PA_PDMA0,
> +	{IRQ_PDMA0}, &exynos4_pdma0_pdata);
> 
>  u8 pdma1_peri[] = {
>  	DMACH_PCM0_RX,
> @@ -123,21 +110,8 @@ struct dma_pl330_platdata exynos4_pdma1_pdata = {
>  	.peri_id = pdma1_peri,
>  };
> 
> -struct amba_device exynos4_device_pdma1 = {
> -	.dev = {
> -		.init_name = "dma-pl330.1",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &exynos4_pdma1_pdata,
> -	},
> -	.res = {
> -		.start = EXYNOS4_PA_PDMA1,
> -		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA1},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330, EXYNOS4_PA_PDMA1,
> +	{IRQ_PDMA1}, &exynos4_pdma1_pdata);
> 
>  static int __init exynos4_dma_init(void)
>  {
> @@ -146,11 +120,11 @@ static int __init exynos4_dma_init(void)
> 
>  	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
> -	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
> +	amba_device_register(&exynos4_pdma0_device, &iomem_resource);
> 
>  	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
> -	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
> +	amba_device_register(&exynos4_pdma1_device, &iomem_resource);
> 
>  	return 0;
>  }
> diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
> index 99049aa..f7f68ad 100644
> --- a/arch/arm/mach-s5p64x0/dma.c
> +++ b/arch/arm/mach-s5p64x0/dma.c
> @@ -108,34 +108,22 @@ struct dma_pl330_platdata s5p6450_pdma_pdata = {
>  	.peri_id = s5p6450_pdma_peri,
>  };
> 
> -struct amba_device s5p64x0_device_pdma = {
> -	.dev = {
> -		.init_name = "dma-pl330",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.res = {
> -		.start = S5P64X0_PA_PDMA,
> -		.end = S5P64X0_PA_PDMA + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_DMA0},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(s5p64x0_pdma, "dma-pl330", 0x00041330, S5P64X0_PA_PDMA,
> +	{IRQ_DMA0}, NULL);
> 
>  static int __init s5p64x0_dma_init(void)
>  {
>  	if (soc_is_s5p6450()) {
>  		dma_cap_set(DMA_SLAVE, s5p6450_pdma_pdata.cap_mask);
>  		dma_cap_set(DMA_CYCLIC, s5p6450_pdma_pdata.cap_mask);
> -		s5p64x0_device_pdma.dev.platform_data = &s5p6450_pdma_pdata;
> +		s5p64x0_pdma_device.dev.platform_data = &s5p6450_pdma_pdata;
>  	} else {
>  		dma_cap_set(DMA_SLAVE, s5p6440_pdma_pdata.cap_mask);
>  		dma_cap_set(DMA_CYCLIC, s5p6440_pdma_pdata.cap_mask);
> -		s5p64x0_device_pdma.dev.platform_data = &s5p6440_pdma_pdata;
> +		s5p64x0_pdma_device.dev.platform_data = &s5p6440_pdma_pdata;
>  	}
> 
> -	amba_device_register(&s5p64x0_device_pdma, &iomem_resource);
> +	amba_device_register(&s5p64x0_pdma_device, &iomem_resource);
> 
>  	return 0;
>  }
> diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
> index ac08d7e..96b1ab3 100644
> --- a/arch/arm/mach-s5pc100/dma.c
> +++ b/arch/arm/mach-s5pc100/dma.c
> @@ -73,21 +73,8 @@ struct dma_pl330_platdata s5pc100_pdma0_pdata = {
>  	.peri_id = pdma0_peri,
>  };
> 
> -struct amba_device s5pc100_device_pdma0 = {
> -	.dev = {
> -		.init_name = "dma-pl330.0",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &s5pc100_pdma0_pdata,
> -	},
> -	.res = {
> -		.start = S5PC100_PA_PDMA0,
> -		.end = S5PC100_PA_PDMA0 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA0},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(s5pc100_pdma0,  "dma-pl330.0", 0x00041330, S5PC100_PA_PDMA0,
> +	{IRQ_PDMA0}, &s5pc100_pdma0_pdata);
> 
>  u8 pdma1_peri[] = {
>  	DMACH_UART0_RX,
> @@ -127,31 +114,18 @@ struct dma_pl330_platdata s5pc100_pdma1_pdata = {
>  	.peri_id = pdma1_peri,
>  };
> 
> -struct amba_device s5pc100_device_pdma1 = {
> -	.dev = {
> -		.init_name = "dma-pl330.1",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &s5pc100_pdma1_pdata,
> -	},
> -	.res = {
> -		.start = S5PC100_PA_PDMA1,
> -		.end = S5PC100_PA_PDMA1 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA1},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(s5pc100_pdma1, "dma-pl330.1", 0x00041330, S5PC100_PA_PDMA1,
> +	{IRQ_PDMA1}, &s5pc100_pdma1_pdata);
> 
>  static int __init s5pc100_dma_init(void)
>  {
>  	dma_cap_set(DMA_SLAVE, s5pc100_pdma0_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, s5pc100_pdma0_pdata.cap_mask);
> -	amba_device_register(&s5pc100_device_pdma0, &iomem_resource);
> +	amba_device_register(&s5pc100_pdma0_device, &iomem_resource);
> 
>  	dma_cap_set(DMA_SLAVE, s5pc100_pdma1_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, s5pc100_pdma1_pdata.cap_mask);
> -	amba_device_register(&s5pc100_device_pdma1, &iomem_resource);
> +	amba_device_register(&s5pc100_pdma1_device, &iomem_resource);
> 
>  	return 0;
>  }
> diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
> index 8602fa5..f6885d2 100644
> --- a/arch/arm/mach-s5pv210/dma.c
> +++ b/arch/arm/mach-s5pv210/dma.c
> @@ -71,21 +71,8 @@ struct dma_pl330_platdata s5pv210_pdma0_pdata = {
>  	.peri_id = pdma0_peri,
>  };
> 
> -struct amba_device s5pv210_device_pdma0 = {
> -	.dev = {
> -		.init_name = "dma-pl330.0",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &s5pv210_pdma0_pdata,
> -	},
> -	.res = {
> -		.start = S5PV210_PA_PDMA0,
> -		.end = S5PV210_PA_PDMA0 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA0},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(s5pv210_pdma0, "dma-pl330.0", 0x00041330, S5PV210_PA_PDMA0,
> +	{IRQ_PDMA0}, &s5pv210_pdma0_pdata);
> 
>  u8 pdma1_peri[] = {
>  	DMACH_UART0_RX,
> @@ -127,31 +114,18 @@ struct dma_pl330_platdata s5pv210_pdma1_pdata = {
>  	.peri_id = pdma1_peri,
>  };
> 
> -struct amba_device s5pv210_device_pdma1 = {
> -	.dev = {
> -		.init_name = "dma-pl330.1",
> -		.dma_mask = &dma_dmamask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -		.platform_data = &s5pv210_pdma1_pdata,
> -	},
> -	.res = {
> -		.start = S5PV210_PA_PDMA1,
> -		.end = S5PV210_PA_PDMA1 + SZ_4K,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	.irq = {IRQ_PDMA1},
> -	.periphid = 0x00041330,
> -};
> +AMBA_AHB_DEVICE(s5pv210_pdma1, "dma-pl330.1", 0x00041330, S5PV210_PA_PDMA1,
> +	{IRQ_PDMA1}, &s5pv210_pdma1_pdata);
> 
>  static int __init s5pv210_dma_init(void)
>  {
>  	dma_cap_set(DMA_SLAVE, s5pv210_pdma0_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, s5pv210_pdma0_pdata.cap_mask);
> -	amba_device_register(&s5pv210_device_pdma0, &iomem_resource);
> +	amba_device_register(&s5pv210_pdma0_device, &iomem_resource);
> 
>  	dma_cap_set(DMA_SLAVE, s5pv210_pdma1_pdata.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, s5pv210_pdma1_pdata.cap_mask);
> -	amba_device_register(&s5pv210_device_pdma1, &iomem_resource);
> +	amba_device_register(&s5pv210_pdma1_device, &iomem_resource);
> 
>  	return 0;
>  }
> --
> 1.7.4.4
