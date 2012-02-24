From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/4] ARM: SAMSUNG: move the header file to driver directory
Date: Fri, 24 Feb 2012 14:40:44 +0530
Message-ID: <CAJuYYwQfSJn4z-1O6WsQf74Cg6heZx1yUSg+EQFJfZi3pubWkA@mail.gmail.com>
References: <4F39EB0B.5030205@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F39EB0B.5030205@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Dear Mr. Chung,

On 14 February 2012 10:33, Jaehoon Chung <jh80.chung@samsung.com> wrote=
:
> The header-file is moved to drivers/mmc/host from plat.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0arch/arm/mach-exynos/setup-sdhci-gpio.c =A0 =A0 =A0 =A0 | =A0 =A01=
 -
> =A0arch/arm/mach-s5pc100/setup-sdhci-gpio.c =A0 =A0 =A0 =A0| =A0 =A01=
 -
> =A0arch/arm/mach-s5pv210/setup-sdhci-gpio.c =A0 =A0 =A0 =A0| =A0 =A01=
 -
> =A0arch/arm/plat-samsung/include/plat/regs-sdhci.h | =A0 87 ---------=
-------------
> =A0drivers/mmc/host/sdhci-s3c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 89 +++++++++++++++++++++++
> =A05 files changed, 89 insertions(+), 90 deletions(-)
> =A0delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
> =A0create mode 100644 drivers/mmc/host/sdhci-s3c.h
>
> diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-=
exynos/setup-sdhci-gpio.c
> index e8d08bf..cda3714 100644
> --- a/arch/arm/mach-exynos/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-exynos/setup-sdhci-gpio.c
> @@ -20,7 +20,6 @@
> =A0#include <linux/mmc/card.h>
>
> =A0#include <plat/gpio-cfg.h>
> -#include <plat/regs-sdhci.h>
> =A0#include <plat/sdhci.h>
>
> =A0void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *dev, in=
t width)
> diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach=
-s5pc100/setup-sdhci-gpio.c
> index 03c02d0..6010c03 100644
> --- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
> @@ -19,7 +19,6 @@
> =A0#include <linux/mmc/card.h>
>
> =A0#include <plat/gpio-cfg.h>
> -#include <plat/regs-sdhci.h>
> =A0#include <plat/sdhci.h>
>
> =A0void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, in=
t width)
> diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach=
-s5pv210/setup-sdhci-gpio.c
> index 3e3ac05..0512ada 100644
> --- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> @@ -20,7 +20,6 @@
> =A0#include <linux/mmc/card.h>
>
> =A0#include <plat/gpio-cfg.h>
> -#include <plat/regs-sdhci.h>
> =A0#include <plat/sdhci.h>
>
> =A0void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, in=
t width)
> diff --git a/arch/arm/plat-samsung/include/plat/regs-sdhci.h b/arch/a=
rm/plat-samsung/include/plat/regs-sdhci.h
> deleted file mode 100644
> index e34049a..0000000
> --- a/arch/arm/plat-samsung/include/plat/regs-sdhci.h
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -/* linux/arch/arm/plat-s3c/include/plat/regs-sdhci.h
> - *
> - * Copyright 2008 Openmoko, Inc.
> - * Copyright 2008 Simtec Electronics
> - * =A0 =A0 http://armlinux.simtec.co.uk/
> - * =A0 =A0 Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C Platform - SDHCI (HSMMC) register definitions
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __PLAT_S3C_SDHCI_REGS_H
> -#define __PLAT_S3C_SDHCI_REGS_H __FILE__
> -
> -#define S3C_SDHCI_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x80)
> -#define S3C_SDHCI_CONTROL3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x84)
> -#define S3C64XX_SDHCI_CONTROL4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x8C=
)
> -
> -#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR =A0 =A0 =A0(1 << 31)
> -#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 30)
> -#define S3C_SDHCI_CTRL2_CDINVRXD3 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2=
9)
> -#define S3C_SDHCI_CTRL2_SLCARDOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2=
8)
> -
> -#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK =A0 =A0 =A0 =A0 (0xf << 24)
> -#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(24)
> -#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x) =A0 =A0 =A0 =A0 =A0((_x) << 24=
)
> -
> -#define S3C_SDHCI_CTRL2_LVLDAT_MASK =A0 =A0 =A0 =A0 =A0 =A0(0xff << =
16)
> -#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT =A0 =A0 =A0 =A0 =A0 (16)
> -#define S3C_SDHCI_CTRL2_LVLDAT(_x) =A0 =A0 =A0 =A0 =A0 =A0 ((_x) << =
16)
> -
> -#define S3C_SDHCI_CTRL2_ENFBCLKTX =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1=
5)
> -#define S3C_SDHCI_CTRL2_ENFBCLKRX =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1=
4)
> -#define S3C_SDHCI_CTRL2_SDCDSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 13)
> -#define S3C_SDHCI_CTRL2_SDSIGPC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 12)
> -#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART =A0 =A0 =A0 (1 << 11)
> -
> -#define S3C_SDHCI_CTRL2_DFCNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 9=
)
> -#define S3C_SDHCI_CTRL2_DFCNT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0(9)
> -#define S3C_SDHCI_CTRL2_DFCNT_NONE =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << 9=
)
> -#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK =A0 =A0 =A0 =A0 =A0 (0x1 << 9)
> -#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK =A0 =A0 =A0 =A0 =A0(0x2 << 9)
> -#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK =A0 =A0 =A0 =A0 =A0(0x3 << 9)
> -
> -#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD =A0 =A0 =A0 =A0 =A0 (1 << 8)
> -#define S3C_SDHCI_CTRL2_RWAITMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7=
)
> -#define S3C_SDHCI_CTRL2_DISBUFRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 6=
)
> -#define S3C_SDHCI_CTRL2_SELBASECLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0x3 << 4)
> -#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT =A0 =A0 =A0 (4)
> -#define S3C_SDHCI_CTRL2_PWRSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 3)
> -#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON =A0 =A0 =A0 =A0 (1 << 1)
> -#define S3C_SDHCI_CTRL2_HWINITFIN =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0=
)
> -
> -#define S3C_SDHCI_CTRL3_FCSEL3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 31)
> -#define S3C_SDHCI_CTRL3_FCSEL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 23)
> -#define S3C_SDHCI_CTRL3_FCSEL1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 15)
> -#define S3C_SDHCI_CTRL3_FCSEL0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 7)
> -
> -#define S3C_SDHCI_CTRL3_FIA3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 24)
> -#define S3C_SDHCI_CTRL3_FIA3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (24)
> -#define S3C_SDHCI_CTRL3_FIA3(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 24)
> -
> -#define S3C_SDHCI_CTRL3_FIA2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 16)
> -#define S3C_SDHCI_CTRL3_FIA2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (16)
> -#define S3C_SDHCI_CTRL3_FIA2(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 16)
> -
> -#define S3C_SDHCI_CTRL3_FIA1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 8)
> -#define S3C_SDHCI_CTRL3_FIA1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (8)
> -#define S3C_SDHCI_CTRL3_FIA1(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 8)
> -
> -#define S3C_SDHCI_CTRL3_FIA0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 0)
> -#define S3C_SDHCI_CTRL3_FIA0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (0)
> -#define S3C_SDHCI_CTRL3_FIA0(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 0)
> -
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK =A0 =A0 =A0(0x3 << 16)
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT =A0 =A0 (16)
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA =A0 =A0 =A0 (0x0 << 16)
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA =A0 =A0 =A0 (0x1 << 16)
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA =A0 =A0 =A0 (0x2 << 16)
> -#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA =A0 =A0 =A0 (0x3 << 16)
> -
> -#define S3C64XX_SDHCI_CONTROL4_BUSY =A0 =A0 =A0 =A0 =A0 =A0(1)
> -
> -#endif /* __PLAT_S3C_SDHCI_REGS_H */
> diff --git a/drivers/mmc/host/sdhci-s3c.h b/drivers/mmc/host/sdhci-s3=
c.h
> new file mode 100644
> index 0000000..e233b15
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-s3c.h
> @@ -0,0 +1,89 @@
> +/*
> + * SDHCI Samsung controller driver generics for OF and pltfm.
> + *
> + * Copyright 2008 Openmoko, Inc.
> + * Copyright 2008 Simtec Electronics
> + * =A0 =A0 http://armlinux.simtec.co.uk/
> + * =A0 =A0 Ben Dooks <ben@simtec.co.uk>
> + *
> + * S3C Platform - SDHCI (HSMMC) register definitions
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License.
> + */
> +
> +#ifndef __DRIVERS_MMC_S3C_SDHCI_H
> +#define __DRIVERS_MMC_S3C_SDHCI_H
> +
> +#define S3C_SDHCI_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x80)
> +#define S3C_SDHCI_CONTROL3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x84)
> +#define S3C_SDHCI_CONTROL4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x8C)
> +
> +#define S3C_SDHCI_CTRL2_ENSTAASYNCCLR =A0 =A0 =A0 =A0 =A0(1 << 31)
> +#define S3C_SDHCI_CTRL2_ENCMDCNFMSK =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
> +#define S3C_SDHCI_CTRL2_CDINVRXD3 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2=
9)
> +#define S3C_SDHCI_CTRL2_SLCARDOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2=
8)
> +
> +#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK =A0 =A0 =A0 =A0 (0xf << 24)
> +#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(24)
> +#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x) =A0 =A0 =A0 =A0 =A0((_x) << 24=
)
> +
> +#define S3C_SDHCI_CTRL2_LVLDAT_MASK =A0 =A0 =A0 =A0 =A0 =A0(0xff << =
16)
> +#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT =A0 =A0 =A0 =A0 =A0 (16)
> +#define S3C_SDHCI_CTRL2_LVLDAT(_x) =A0 =A0 =A0 =A0 =A0 =A0 ((_x) << =
16)
> +
> +#define S3C_SDHCI_CTRL2_ENFBCLKTX =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1=
5)
> +#define S3C_SDHCI_CTRL2_ENFBCLKRX =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1=
4)
> +#define S3C_SDHCI_CTRL2_SDCDSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 13)
> +#define S3C_SDHCI_CTRL2_SDSIGPC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 12)
> +#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART =A0 =A0 =A0 (1 << 11)
> +
> +#define S3C_SDHCI_CTRL2_DFCNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 9=
)
> +#define S3C_SDHCI_CTRL2_DFCNT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0(9)
> +#define S3C_SDHCI_CTRL2_DFCNT_NONE =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << 9=
)
> +#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK =A0 =A0 =A0 =A0 =A0 (0x1 << 9)
> +#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK =A0 =A0 =A0 =A0 =A0(0x2 << 9)
> +#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK =A0 =A0 =A0 =A0 =A0(0x3 << 9)
> +
> +#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD =A0 =A0 =A0 =A0 =A0 (1 << 8)
> +#define S3C_SDHCI_CTRL2_RWAITMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7=
)
> +#define S3C_SDHCI_CTRL2_DISBUFRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 6=
)
> +#define S3C_SDHCI_CTRL2_SELBASECLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0x3 << 4)
> +#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT =A0 =A0 =A0 (4)
> +#define S3C_SDHCI_CTRL2_PWRSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 3)
> +#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON =A0 =A0 =A0 =A0 (1 << 1)
> +#define S3C_SDHCI_CTRL2_HWINITFIN =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0=
)
> +
> +#define S3C_SDHCI_CTRL3_FCSEL3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 31)
> +#define S3C_SDHCI_CTRL3_FCSEL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 23)
> +#define S3C_SDHCI_CTRL3_FCSEL1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 15)
> +#define S3C_SDHCI_CTRL3_FCSEL0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 7)
> +
> +#define S3C_SDHCI_CTRL3_FIA3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 24)
> +#define S3C_SDHCI_CTRL3_FIA3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (24)
> +#define S3C_SDHCI_CTRL3_FIA3(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 24)
> +
> +#define S3C_SDHCI_CTRL3_FIA2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 16)
> +#define S3C_SDHCI_CTRL3_FIA2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (16)
> +#define S3C_SDHCI_CTRL3_FIA2(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 16)
> +
> +#define S3C_SDHCI_CTRL3_FIA1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 8)
> +#define S3C_SDHCI_CTRL3_FIA1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (8)
> +#define S3C_SDHCI_CTRL3_FIA1(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 8)
> +
> +#define S3C_SDHCI_CTRL3_FIA0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f <=
< 0)
> +#define S3C_SDHCI_CTRL3_FIA0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 (0)
> +#define S3C_SDHCI_CTRL3_FIA0(_x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_x) <=
< 0)
> +
> +#define S3C_SDHCI_CONTROL4_DRIVE_MASK =A0 =A0 =A0 =A0 =A0(0x3 << 16)
> +#define S3C_SDHCI_CONTROL4_DRIVE_SHIFT =A0 =A0 =A0 =A0 (16)
> +#define S3C_SDHCI_CONTROL4_DRIVE_2mA =A0 =A0 =A0 =A0 =A0 (0x0 << 16)
> +#define S3C_SDHCI_CONTROL4_DRIVE_4mA =A0 =A0 =A0 =A0 =A0 (0x1 << 16)
> +#define S3C_SDHCI_CONTROL4_DRIVE_7mA =A0 =A0 =A0 =A0 =A0 (0x2 << 16)
> +#define S3C_SDHCI_CONTROL4_DRIVE_9mA =A0 =A0 =A0 =A0 =A0 (0x3 << 16)

The CONTROL4 register is available from s3c6410 onwards. The sdhci
controller in s3c24xx (such as s3c2416) do not have the CONTROL4
register. I understand that renaming S3C64XX... to S3C should be fine
but the information that it is applicable from S3C64XX onwards only is
lost. Is this rename mandatory? I do not have any preference here, but
I guess we could just leave it as S3C64XX.

Thanks,
Thomas.

> +
> +#define S3C_SDHCI_CONTROL4_BUSY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1)
> +
> +#endif /* __DRIVERS_MMC_S3C_SDHCI_H */
> +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
