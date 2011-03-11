From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Exynos4: Add HSMMC channel 4 support
Date: Fri, 11 Mar 2011 12:18:18 +0900
Message-ID: <AANLkTimk+GPkxrDx0zG3rMam9OCz9sCL+2n4_c8KwLye@mail.gmail.com>
References: <20110308025340.GA25712@july>
	<00d601cbdf94$59254640$0b6fd2c0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57113 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1CKDST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 22:18:19 -0500
Received: by ywj3 with SMTP id 3so981711ywj.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 19:18:18 -0800 (PST)
In-Reply-To: <00d601cbdf94$59254640$0b6fd2c0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: jh80.chung@samsung.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Fri, Mar 11, 2011 at 11:30 AM, Kukjin Kim <kgene.kim@samsung.com> wr=
ote:
> Kyungmin Park wrote:
>>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Exynos4 has the DesignWare Host controller at channel 4.
>>
> Yeah, Exynos4210 has it but it can be happened problem when used your
> approach later.
> Because, we can't assume hsmmc4 to be used for dw_mmc on other SoCs.
>
> I mean, other file, eg., dev-dwmmc.c or dev-dwmci.c should be added f=
or its
> platform devices.

Who's opinions? Please Cc the proper person at LSI. I want to listen
his opinions.

Thank you,
Kyungmin Park
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/ma=
ch-
>> exynos4/include/mach/irqs.h
>> index 2dc5900..aa32679 100644
>> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
>> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
>> @@ -104,6 +104,7 @@
>> =A0#define IRQ_HSMMC1 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(29, 1)
>> =A0#define IRQ_HSMMC2 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(29, 2)
>> =A0#define IRQ_HSMMC3 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(29, 3)
>> +#define IRQ_HSMMC4 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(29, 4)
>>
>> =A0#define IRQ_MIPI_CSIS0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(3=
0, 0)
>> =A0#define IRQ_MIPI_CSIS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 COMBINER_IRQ(3=
0, 1)
>> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mac=
h-
>> exynos4/include/mach/map.h
>> index 80a41e0..ea79962 100644
>> --- a/arch/arm/mach-exynos4/include/mach/map.h
>> +++ b/arch/arm/mach-exynos4/include/mach/map.h
>> @@ -107,6 +107,7 @@
>> =A0#define S3C_PA_HSMMC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0EXYNOS4_PA_HSMMC(1)
>> =A0#define S3C_PA_HSMMC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0EXYNOS4_PA_HSMMC(2)
>> =A0#define S3C_PA_HSMMC3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0EXYNOS4_PA_HSMMC(3)
>> +#define S3C_PA_HSMMC4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
EXYNOS4_PA_HSMMC(4)
>> =A0#define S3C_PA_IIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXYNOS4_PA=
_IIC(0)
>> =A0#define S3C_PA_IIC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXYNOS4_PA=
_IIC(1)
>> =A0#define S3C_PA_IIC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXYNOS4_PA=
_IIC(2)
>> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/K=
config
>> index be72100..f816985 100644
>> --- a/arch/arm/plat-samsung/Kconfig
>> +++ b/arch/arm/plat-samsung/Kconfig
>> @@ -171,6 +171,11 @@ config S3C_DEV_HSMMC3
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Compile in platform device definitions for HSMMC cha=
nnel 3
>>
>> +config S3C_DEV_HSMMC4
>> + =A0 =A0 bool
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Compile in platform device definitions for HSMMC chann=
el 4
>> +
>> =A0config S3C_DEV_HWMON
>> =A0 =A0 =A0 bool
>> =A0 =A0 =A0 help
>> diff --git a/arch/arm/plat-samsung/Makefile
> b/arch/arm/plat-samsung/Makefile
>> index e9de58a..7ddba03 100644
>> --- a/arch/arm/plat-samsung/Makefile
>> +++ b/arch/arm/plat-samsung/Makefile
>> @@ -37,6 +37,7 @@ obj-$(CONFIG_S3C_DEV_HSMMC) +=3D dev-hsmmc.o
>> =A0obj-$(CONFIG_S3C_DEV_HSMMC1) +=3D dev-hsmmc1.o
>> =A0obj-$(CONFIG_S3C_DEV_HSMMC2) +=3D dev-hsmmc2.o
>> =A0obj-$(CONFIG_S3C_DEV_HSMMC3) +=3D dev-hsmmc3.o
>> +obj-$(CONFIG_S3C_DEV_HSMMC4) +=3D dev-hsmmc4.o
>> =A0obj-$(CONFIG_S3C_DEV_HWMON) =A0+=3D dev-hwmon.o
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D dev-i2c0.o
>> =A0obj-$(CONFIG_S3C_DEV_I2C1) =A0 +=3D dev-i2c1.o
>> diff --git a/arch/arm/plat-samsung/dev-hsmmc4.c
> b/arch/arm/plat-samsung/dev-
>> hsmmc4.c
>> new file mode 100644
>> index 0000000..c69a78f
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/dev-hsmmc4.c
>> @@ -0,0 +1,54 @@
>> +/* linux/arch/arm/plat-samsung/dev-hsmmc4.c
>> + *
>> + * Copyright (C) 2011 Samsung Electronics Co., Ltd.
>> + *
>> + * Samsung device definition for hsmmc device 4
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/dw_mmc.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <mach/map.h>
>> +#include <plat/sdhci.h>
>> +#include <plat/devs.h>
>> +
>> +#define S3C_SZ_HSMMC =A0 =A0 =A0 =A0 0x1000
>> +
>> +static struct resource s3c_hsmmc4_resource[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D S3C_PA_HSMMC4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D S3C_PA_HSMMC4 + S3C_SZ_HSM=
MC - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> + =A0 =A0 },
>> + =A0 =A0 [1] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D IRQ_HSMMC4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D IRQ_HSMMC4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> + =A0 =A0 }
>> +};
>> +
>> +static u64 s3c_device_hsmmc4_dmamask =3D DMA_BIT_MASK(32);
>> +
>> +struct platform_device s3c_device_hsmmc4 =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "dw_mmc",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>> + =A0 =A0 .num_resources =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(s3c_hsmmc=
4_resource),
>> + =A0 =A0 .resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D s3c_hsmmc4_resou=
rce,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =
&s3c_device_hsmmc4_dmamask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =A0 =A0 =A0=3D DMA_BIT_=
MASK(32),
>> + =A0 =A0 },
>> +};
>> +
>> +void s3c_hsmmc4_set_platdata(struct dw_mci_board *pdata)
>> +{
>> + =A0 =A0 s3c_set_platdata(pdata, sizeof(struct dw_mci_board),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&s3c_device_hsmmc4);
>> +}
>> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/pl=
at-
>> samsung/include/plat/devs.h
>> index e2b3ab9..4e198ba 100644
>> --- a/arch/arm/plat-samsung/include/plat/devs.h
>> +++ b/arch/arm/plat-samsung/include/plat/devs.h
>> @@ -65,6 +65,7 @@ extern struct platform_device s3c_device_hsmmc0;
>> =A0extern struct platform_device s3c_device_hsmmc1;
>> =A0extern struct platform_device s3c_device_hsmmc2;
>> =A0extern struct platform_device s3c_device_hsmmc3;
>> +extern struct platform_device s3c_device_hsmmc4;
>> =A0extern struct platform_device s3c_device_cfcon;
>>
>> =A0extern struct platform_device s3c_device_spi0;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
