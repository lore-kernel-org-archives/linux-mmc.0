From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/4] ARM: SAMSUNG: move the header file to driver directory
Date: Fri, 24 Feb 2012 19:42:22 +0900
Message-ID: <4F47698E.6040509@samsung.com>
References: <4F39EB0B.5030205@samsung.com>
 <CAJuYYwQfSJn4z-1O6WsQf74Cg6heZx1yUSg+EQFJfZi3pubWkA@mail.gmail.com>
 <4F4766A9.3040809@samsung.com>
 <CAJuYYwRhqud-5apKzrymOUbnHm5fgzZ=1XGhR_-8PPWfJFHQWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35641 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab2BXKm3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 05:42:29 -0500
In-reply-to: <CAJuYYwRhqud-5apKzrymOUbnHm5fgzZ=1XGhR_-8PPWfJFHQWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>, heiko@sntech.de

On 02/24/2012 07:36 PM, Thomas Abraham wrote:

> On 24 February 2012 16:00, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> On 02/24/2012 06:10 PM, Thomas Abraham wrote:
>>
>>> Dear Mr. Chung,
>>>
>>> On 14 February 2012 10:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> The header-file is moved to drivers/mmc/host from plat.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>>  arch/arm/mach-exynos/setup-sdhci-gpio.c         |    1 -
>>>>  arch/arm/mach-s5pc100/setup-sdhci-gpio.c        |    1 -
>>>>  arch/arm/mach-s5pv210/setup-sdhci-gpio.c        |    1 -
>>>>  arch/arm/plat-samsung/include/plat/regs-sdhci.h |   87 ----------------------
>>>>  drivers/mmc/host/sdhci-s3c.h                    |   89 +++++++++++++++++++++++
>>>>  5 files changed, 89 insertions(+), 90 deletions(-)
>>>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
>>>>  create mode 100644 drivers/mmc/host/sdhci-s3c.h
>>>>
>>>> diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
>>>> index e8d08bf..cda3714 100644
>>>> --- a/arch/arm/mach-exynos/setup-sdhci-gpio.c
>>>> +++ b/arch/arm/mach-exynos/setup-sdhci-gpio.c
>>>> @@ -20,7 +20,6 @@
>>>>  #include <linux/mmc/card.h>
>>>>
>>>>  #include <plat/gpio-cfg.h>
>>>> -#include <plat/regs-sdhci.h>
>>>>  #include <plat/sdhci.h>
>>>>
>>>>  void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
>>>> diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
>>>> index 03c02d0..6010c03 100644
>>>> --- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
>>>> +++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
>>>> @@ -19,7 +19,6 @@
>>>>  #include <linux/mmc/card.h>
>>>>
>>>>  #include <plat/gpio-cfg.h>
>>>> -#include <plat/regs-sdhci.h>
>>>>  #include <plat/sdhci.h>
>>>>
>>>>  void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
>>>> diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
>>>> index 3e3ac05..0512ada 100644
>>>> --- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
>>>> +++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
>>>> @@ -20,7 +20,6 @@
>>>>  #include <linux/mmc/card.h>
>>>>
>>>>  #include <plat/gpio-cfg.h>
>>>> -#include <plat/regs-sdhci.h>
>>>>  #include <plat/sdhci.h>
>>>>
>>>>  void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
>>>> diff --git a/arch/arm/plat-samsung/include/plat/regs-sdhci.h b/arch/arm/plat-samsung/include/plat/regs-sdhci.h
>>>> deleted file mode 100644
>>>> index e34049a..0000000
>>>> --- a/arch/arm/plat-samsung/include/plat/regs-sdhci.h
>>>> +++ /dev/null
>>>> @@ -1,87 +0,0 @@
>>>> -/* linux/arch/arm/plat-s3c/include/plat/regs-sdhci.h
>>>> - *
>>>> - * Copyright 2008 Openmoko, Inc.
>>>> - * Copyright 2008 Simtec Electronics
>>>> - *     http://armlinux.simtec.co.uk/
>>>> - *     Ben Dooks <ben@simtec.co.uk>
>>>> - *
>>>> - * S3C Platform - SDHCI (HSMMC) register definitions
>>>> - *
>>>> - * This program is free software; you can redistribute it and/or modify
>>>> - * it under the terms of the GNU General Public License version 2 as
>>>> - * published by the Free Software Foundation.
>>>> -*/
>>>> -
>>>> -#ifndef __PLAT_S3C_SDHCI_REGS_H
>>>> -#define __PLAT_S3C_SDHCI_REGS_H __FILE__
>>>> -
>>>> -#define S3C_SDHCI_CONTROL2                     (0x80)
>>>> -#define S3C_SDHCI_CONTROL3                     (0x84)
>>>> -#define S3C64XX_SDHCI_CONTROL4                 (0x8C)
>>>> -
>>>> -#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR      (1 << 31)
>>>> -#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK                (1 << 30)
>>>> -#define S3C_SDHCI_CTRL2_CDINVRXD3              (1 << 29)
>>>> -#define S3C_SDHCI_CTRL2_SLCARDOUT              (1 << 28)
>>>> -
>>>> -#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK         (0xf << 24)
>>>> -#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT                (24)
>>>> -#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)          ((_x) << 24)
>>>> -
>>>> -#define S3C_SDHCI_CTRL2_LVLDAT_MASK            (0xff << 16)
>>>> -#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT           (16)
>>>> -#define S3C_SDHCI_CTRL2_LVLDAT(_x)             ((_x) << 16)
>>>> -
>>>> -#define S3C_SDHCI_CTRL2_ENFBCLKTX              (1 << 15)
>>>> -#define S3C_SDHCI_CTRL2_ENFBCLKRX              (1 << 14)
>>>> -#define S3C_SDHCI_CTRL2_SDCDSEL                        (1 << 13)
>>>> -#define S3C_SDHCI_CTRL2_SDSIGPC                        (1 << 12)
>>>> -#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART       (1 << 11)
>>>> -
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_MASK             (0x3 << 9)
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_SHIFT            (9)
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_NONE             (0x0 << 9)
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK           (0x1 << 9)
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK          (0x2 << 9)
>>>> -#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK          (0x3 << 9)
>>>> -
>>>> -#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD           (1 << 8)
>>>> -#define S3C_SDHCI_CTRL2_RWAITMODE              (1 << 7)
>>>> -#define S3C_SDHCI_CTRL2_DISBUFRD               (1 << 6)
>>>> -#define S3C_SDHCI_CTRL2_SELBASECLK_MASK                (0x3 << 4)
>>>> -#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT       (4)
>>>> -#define S3C_SDHCI_CTRL2_PWRSYNC                        (1 << 3)
>>>> -#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON         (1 << 1)
>>>> -#define S3C_SDHCI_CTRL2_HWINITFIN              (1 << 0)
>>>> -
>>>> -#define S3C_SDHCI_CTRL3_FCSEL3                 (1 << 31)
>>>> -#define S3C_SDHCI_CTRL3_FCSEL2                 (1 << 23)
>>>> -#define S3C_SDHCI_CTRL3_FCSEL1                 (1 << 15)
>>>> -#define S3C_SDHCI_CTRL3_FCSEL0                 (1 << 7)
>>>> -
>>>> -#define S3C_SDHCI_CTRL3_FIA3_MASK              (0x7f << 24)
>>>> -#define S3C_SDHCI_CTRL3_FIA3_SHIFT             (24)
>>>> -#define S3C_SDHCI_CTRL3_FIA3(_x)               ((_x) << 24)
>>>> -
>>>> -#define S3C_SDHCI_CTRL3_FIA2_MASK              (0x7f << 16)
>>>> -#define S3C_SDHCI_CTRL3_FIA2_SHIFT             (16)
>>>> -#define S3C_SDHCI_CTRL3_FIA2(_x)               ((_x) << 16)
>>>> -
>>>> -#define S3C_SDHCI_CTRL3_FIA1_MASK              (0x7f << 8)
>>>> -#define S3C_SDHCI_CTRL3_FIA1_SHIFT             (8)
>>>> -#define S3C_SDHCI_CTRL3_FIA1(_x)               ((_x) << 8)
>>>> -
>>>> -#define S3C_SDHCI_CTRL3_FIA0_MASK              (0x7f << 0)
>>>> -#define S3C_SDHCI_CTRL3_FIA0_SHIFT             (0)
>>>> -#define S3C_SDHCI_CTRL3_FIA0(_x)               ((_x) << 0)
>>>> -
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK      (0x3 << 16)
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT     (16)
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA       (0x0 << 16)
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA       (0x1 << 16)
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA       (0x2 << 16)
>>>> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA       (0x3 << 16)
>>>> -
>>>> -#define S3C64XX_SDHCI_CONTROL4_BUSY            (1)
>>>> -
>>>> -#endif /* __PLAT_S3C_SDHCI_REGS_H */
>>>> diff --git a/drivers/mmc/host/sdhci-s3c.h b/drivers/mmc/host/sdhci-s3c.h
>>>> new file mode 100644
>>>> index 0000000..e233b15
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/sdhci-s3c.h
>>>> @@ -0,0 +1,89 @@
>>>> +/*
>>>> + * SDHCI Samsung controller driver generics for OF and pltfm.
>>>> + *
>>>> + * Copyright 2008 Openmoko, Inc.
>>>> + * Copyright 2008 Simtec Electronics
>>>> + *     http://armlinux.simtec.co.uk/
>>>> + *     Ben Dooks <ben@simtec.co.uk>
>>>> + *
>>>> + * S3C Platform - SDHCI (HSMMC) register definitions
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License.
>>>> + */
>>>> +
>>>> +#ifndef __DRIVERS_MMC_S3C_SDHCI_H
>>>> +#define __DRIVERS_MMC_S3C_SDHCI_H
>>>> +
>>>> +#define S3C_SDHCI_CONTROL2                     (0x80)
>>>> +#define S3C_SDHCI_CONTROL3                     (0x84)
>>>> +#define S3C_SDHCI_CONTROL4                     (0x8C)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_ENSTAASYNCCLR          (1 << 31)
>>>> +#define S3C_SDHCI_CTRL2_ENCMDCNFMSK            (1 << 30)
>>>> +#define S3C_SDHCI_CTRL2_CDINVRXD3              (1 << 29)
>>>> +#define S3C_SDHCI_CTRL2_SLCARDOUT              (1 << 28)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK         (0xf << 24)
>>>> +#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT                (24)
>>>> +#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)          ((_x) << 24)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_LVLDAT_MASK            (0xff << 16)
>>>> +#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT           (16)
>>>> +#define S3C_SDHCI_CTRL2_LVLDAT(_x)             ((_x) << 16)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_ENFBCLKTX              (1 << 15)
>>>> +#define S3C_SDHCI_CTRL2_ENFBCLKRX              (1 << 14)
>>>> +#define S3C_SDHCI_CTRL2_SDCDSEL                        (1 << 13)
>>>> +#define S3C_SDHCI_CTRL2_SDSIGPC                        (1 << 12)
>>>> +#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART       (1 << 11)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_MASK             (0x3 << 9)
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_SHIFT            (9)
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_NONE             (0x0 << 9)
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK           (0x1 << 9)
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK          (0x2 << 9)
>>>> +#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK          (0x3 << 9)
>>>> +
>>>> +#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD           (1 << 8)
>>>> +#define S3C_SDHCI_CTRL2_RWAITMODE              (1 << 7)
>>>> +#define S3C_SDHCI_CTRL2_DISBUFRD               (1 << 6)
>>>> +#define S3C_SDHCI_CTRL2_SELBASECLK_MASK                (0x3 << 4)
>>>> +#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT       (4)
>>>> +#define S3C_SDHCI_CTRL2_PWRSYNC                        (1 << 3)
>>>> +#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON         (1 << 1)
>>>> +#define S3C_SDHCI_CTRL2_HWINITFIN              (1 << 0)
>>>> +
>>>> +#define S3C_SDHCI_CTRL3_FCSEL3                 (1 << 31)
>>>> +#define S3C_SDHCI_CTRL3_FCSEL2                 (1 << 23)
>>>> +#define S3C_SDHCI_CTRL3_FCSEL1                 (1 << 15)
>>>> +#define S3C_SDHCI_CTRL3_FCSEL0                 (1 << 7)
>>>> +
>>>> +#define S3C_SDHCI_CTRL3_FIA3_MASK              (0x7f << 24)
>>>> +#define S3C_SDHCI_CTRL3_FIA3_SHIFT             (24)
>>>> +#define S3C_SDHCI_CTRL3_FIA3(_x)               ((_x) << 24)
>>>> +
>>>> +#define S3C_SDHCI_CTRL3_FIA2_MASK              (0x7f << 16)
>>>> +#define S3C_SDHCI_CTRL3_FIA2_SHIFT             (16)
>>>> +#define S3C_SDHCI_CTRL3_FIA2(_x)               ((_x) << 16)
>>>> +
>>>> +#define S3C_SDHCI_CTRL3_FIA1_MASK              (0x7f << 8)
>>>> +#define S3C_SDHCI_CTRL3_FIA1_SHIFT             (8)
>>>> +#define S3C_SDHCI_CTRL3_FIA1(_x)               ((_x) << 8)
>>>> +
>>>> +#define S3C_SDHCI_CTRL3_FIA0_MASK              (0x7f << 0)
>>>> +#define S3C_SDHCI_CTRL3_FIA0_SHIFT             (0)
>>>> +#define S3C_SDHCI_CTRL3_FIA0(_x)               ((_x) << 0)
>>>> +
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_MASK          (0x3 << 16)
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_SHIFT         (16)
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_2mA           (0x0 << 16)
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_4mA           (0x1 << 16)
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_7mA           (0x2 << 16)
>>>> +#define S3C_SDHCI_CONTROL4_DRIVE_9mA           (0x3 << 16)
>>>
>>> The CONTROL4 register is available from s3c6410 onwards. The sdhci
>>> controller in s3c24xx (such as s3c2416) do not have the CONTROL4
>>> register. I understand that renaming S3C64XX... to S3C should be fine
>>> but the information that it is applicable from S3C64XX onwards only is
>>> lost. Is this rename mandatory? I do not have any preference here, but
>>> I guess we could just leave it as S3C64XX.
>>
>> Right..But CONTROL4 register didn't present only in s3c24xx.
>> (just reserved).
>> I think that can control in device driver whether s3c24xx or not.
>> And also in CONTROL2 register, SELBASECLK bit didn't be used up to exynos4.
>> But everything used S3C_SDHCI_XXX. so i have changed them.
>> I didn't prefer anything, too.

Hi Thomas.

> 
> Ok. In this case, we can do as Heiko suggested - Add comments in the
> header file that CONTROL4 is used in s3c64xx onwards.

That's no problem. Heiko's suggestion is also good.
As Heiko suggested, i will change.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Thomas.
> 
>> Are there any reason that leave that information?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Thanks,
>>> Thomas.
>>>
>>>> +
>>>> +#define S3C_SDHCI_CONTROL4_BUSY                        (1)
>>>> +
>>>> +#endif /* __DRIVERS_MMC_S3C_SDHCI_H */
>>>> +
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


