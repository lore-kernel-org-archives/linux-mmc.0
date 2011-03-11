From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] Exynos4: Add HSMMC channel 4 support
Date: Fri, 11 Mar 2011 11:30:48 +0900
Message-ID: <00d601cbdf94$59254640$0b6fd2c0$%kim@samsung.com>
References: <20110308025340.GA25712@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43618 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab1CKCa5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 21:30:57 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHV0017KGBJKYB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 Mar 2011 11:30:55 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHV00MVBGBJOQ@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 Mar 2011 11:30:55 +0900 (KST)
In-reply-to: <20110308025340.GA25712@july>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>, jh80.chung@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Exynos4 has the DesignWare Host controller at channel 4.
> 
Yeah, Exynos4210 has it but it can be happened problem when used your
approach later.
Because, we can't assume hsmmc4 to be used for dw_mmc on other SoCs.

I mean, other file, eg., dev-dwmmc.c or dev-dwmci.c should be added for its
platform devices.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
> exynos4/include/mach/irqs.h
> index 2dc5900..aa32679 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -104,6 +104,7 @@
>  #define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
>  #define IRQ_HSMMC2		COMBINER_IRQ(29, 2)
>  #define IRQ_HSMMC3		COMBINER_IRQ(29, 3)
> +#define IRQ_HSMMC4		COMBINER_IRQ(29, 4)
> 
>  #define IRQ_MIPI_CSIS0		COMBINER_IRQ(30, 0)
>  #define IRQ_MIPI_CSIS1		COMBINER_IRQ(30, 1)
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-
> exynos4/include/mach/map.h
> index 80a41e0..ea79962 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -107,6 +107,7 @@
>  #define S3C_PA_HSMMC1			EXYNOS4_PA_HSMMC(1)
>  #define S3C_PA_HSMMC2			EXYNOS4_PA_HSMMC(2)
>  #define S3C_PA_HSMMC3			EXYNOS4_PA_HSMMC(3)
> +#define S3C_PA_HSMMC4			EXYNOS4_PA_HSMMC(4)
>  #define S3C_PA_IIC			EXYNOS4_PA_IIC(0)
>  #define S3C_PA_IIC1			EXYNOS4_PA_IIC(1)
>  #define S3C_PA_IIC2			EXYNOS4_PA_IIC(2)
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index be72100..f816985 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -171,6 +171,11 @@ config S3C_DEV_HSMMC3
>  	help
>  	  Compile in platform device definitions for HSMMC channel 3
> 
> +config S3C_DEV_HSMMC4
> +	bool
> +	help
> +	  Compile in platform device definitions for HSMMC channel 4
> +
>  config S3C_DEV_HWMON
>  	bool
>  	help
> diff --git a/arch/arm/plat-samsung/Makefile
b/arch/arm/plat-samsung/Makefile
> index e9de58a..7ddba03 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
>  obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
>  obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
>  obj-$(CONFIG_S3C_DEV_HSMMC3)	+= dev-hsmmc3.o
> +obj-$(CONFIG_S3C_DEV_HSMMC4)	+= dev-hsmmc4.o
>  obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
>  obj-y				+= dev-i2c0.o
>  obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
> diff --git a/arch/arm/plat-samsung/dev-hsmmc4.c
b/arch/arm/plat-samsung/dev-
> hsmmc4.c
> new file mode 100644
> index 0000000..c69a78f
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-hsmmc4.c
> @@ -0,0 +1,54 @@
> +/* linux/arch/arm/plat-samsung/dev-hsmmc4.c
> + *
> + * Copyright (C) 2011 Samsung Electronics Co., Ltd.
> + *
> + * Samsung device definition for hsmmc device 4
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/dw_mmc.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <mach/map.h>
> +#include <plat/sdhci.h>
> +#include <plat/devs.h>
> +
> +#define S3C_SZ_HSMMC		0x1000
> +
> +static struct resource s3c_hsmmc4_resource[] = {
> +	[0] = {
> +		.start	= S3C_PA_HSMMC4,
> +		.end	= S3C_PA_HSMMC4 + S3C_SZ_HSMMC - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_HSMMC4,
> +		.end	= IRQ_HSMMC4,
> +		.flags	= IORESOURCE_IRQ,
> +	}
> +};
> +
> +static u64 s3c_device_hsmmc4_dmamask = DMA_BIT_MASK(32);
> +
> +struct platform_device s3c_device_hsmmc4 = {
> +	.name			= "dw_mmc",
> +	.id			= -1,
> +	.num_resources		= ARRAY_SIZE(s3c_hsmmc4_resource),
> +	.resource		= s3c_hsmmc4_resource,
> +	.dev			= {
> +		.dma_mask		= &s3c_device_hsmmc4_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +};
> +
> +void s3c_hsmmc4_set_platdata(struct dw_mci_board *pdata)
> +{
> +	s3c_set_platdata(pdata, sizeof(struct dw_mci_board),
> +			 &s3c_device_hsmmc4);
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index e2b3ab9..4e198ba 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -65,6 +65,7 @@ extern struct platform_device s3c_device_hsmmc0;
>  extern struct platform_device s3c_device_hsmmc1;
>  extern struct platform_device s3c_device_hsmmc2;
>  extern struct platform_device s3c_device_hsmmc3;
> +extern struct platform_device s3c_device_hsmmc4;
>  extern struct platform_device s3c_device_cfcon;
> 
>  extern struct platform_device s3c_device_spi0;

