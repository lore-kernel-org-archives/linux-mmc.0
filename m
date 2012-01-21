From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 09/31] ARM: amba: samsung: get rid of NO_IRQ initializers
Date: Sat, 21 Jan 2012 09:28:58 +0900
Message-ID: <00fe01ccd7d3$aa88b8e0$ff9a2aa0$%kim@samsung.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAit-0005Er-2s@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <E1RoAit-0005Er-2s@rmk-PC.arm.linux.org.uk>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'STEricsson' <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

Russell King wrote:
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-exynos/dma.c  |    4 ++--
>  arch/arm/mach-s5p64x0/dma.c |    2 +-
>  arch/arm/mach-s5pc100/dma.c |    4 ++--
>  arch/arm/mach-s5pv210/dma.c |    4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
> index b10fcd2..8d681bf 100644
> --- a/arch/arm/mach-exynos/dma.c
> +++ b/arch/arm/mach-exynos/dma.c
> @@ -86,7 +86,7 @@ struct amba_device exynos4_device_pdma0 = {
>  		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA0, NO_IRQ},
> +	.irq = {IRQ_PDMA0},
>  	.periphid = 0x00041330,
>  };
> 
> @@ -135,7 +135,7 @@ struct amba_device exynos4_device_pdma1 = {
>  		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA1, NO_IRQ},
> +	.irq = {IRQ_PDMA1},
>  	.periphid = 0x00041330,
>  };
> 
> diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
> index f820c07..99049aa 100644
> --- a/arch/arm/mach-s5p64x0/dma.c
> +++ b/arch/arm/mach-s5p64x0/dma.c
> @@ -119,7 +119,7 @@ struct amba_device s5p64x0_device_pdma = {
>  		.end = S5P64X0_PA_PDMA + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_DMA0, NO_IRQ},
> +	.irq = {IRQ_DMA0},
>  	.periphid = 0x00041330,
>  };
> 
> diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
> index c841f4d3..ac08d7e 100644
> --- a/arch/arm/mach-s5pc100/dma.c
> +++ b/arch/arm/mach-s5pc100/dma.c
> @@ -85,7 +85,7 @@ struct amba_device s5pc100_device_pdma0 = {
>  		.end = S5PC100_PA_PDMA0 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA0, NO_IRQ},
> +	.irq = {IRQ_PDMA0},
>  	.periphid = 0x00041330,
>  };
> 
> @@ -139,7 +139,7 @@ struct amba_device s5pc100_device_pdma1 = {
>  		.end = S5PC100_PA_PDMA1 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA1, NO_IRQ},
> +	.irq = {IRQ_PDMA1},
>  	.periphid = 0x00041330,
>  };
> 
> diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
> index a6113e0..8602fa5 100644
> --- a/arch/arm/mach-s5pv210/dma.c
> +++ b/arch/arm/mach-s5pv210/dma.c
> @@ -83,7 +83,7 @@ struct amba_device s5pv210_device_pdma0 = {
>  		.end = S5PV210_PA_PDMA0 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA0, NO_IRQ},
> +	.irq = {IRQ_PDMA0},
>  	.periphid = 0x00041330,
>  };
> 
> @@ -139,7 +139,7 @@ struct amba_device s5pv210_device_pdma1 = {
>  		.end = S5PV210_PA_PDMA1 + SZ_4K,
>  		.flags = IORESOURCE_MEM,
>  	},
> -	.irq = {IRQ_PDMA1, NO_IRQ},
> +	.irq = {IRQ_PDMA1},
>  	.periphid = 0x00041330,
>  };
> 
> --
> 1.7.4.4
