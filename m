From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Sat, 23 Oct 2010 16:24:03 +0200
Message-ID: <201010231624.03293.marek.vasut@gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101022110457.GA14136@void.printf.net> <AANLkTikg3-5whd65aZmK4sJSg+vvNke0fSkqSQJ1B5vf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47572 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096Ab0JWOYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Oct 2010 10:24:10 -0400
Received: by fxm16 with SMTP id 16so1513985fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 23 Oct 2010 07:24:08 -0700 (PDT)
In-Reply-To: <AANLkTikg3-5whd65aZmK4sJSg+vvNke0fSkqSQJ1B5vf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, "eric.y.miao" <eric.y.miao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

Dne P=C3=A1 22. =C5=99=C3=ADjna 2010 16:09:03 zhangfei gao napsal(a):
> On Fri, Oct 22, 2010 at 7:04 AM, Chris Ball <cjb@laptop.org> wrote:
> > Hi,
> >=20
> > On Fri, Oct 22, 2010 at 10:58:14AM +0100, Chris Ball wrote:
> > [...]
> >=20
> >> +#ifdef CONFIG_PM
> >> +static int sdhci_pxa_suspend(struct platform_device *dev)
> >> +{
> >> +     struct sdhci_host *host =3D
> >> platform_get_drvdata(to_platform_device(dev)); +
> >> +     return sdhci_suspend_host(host, state);
> >> +}
> >> +
> >> +static int sdhci_pxa_resume(struct platform_device *dev)
> >> +{
> >=20
> > These prototypes are not correct, leading to:
> >=20
> >  CC [M]  drivers/mmc/host/sdhci-pxa.o
> > drivers/mmc/host/sdhci-pxa.c: In function =E2=80=98sdhci_pxa_suspen=
d=E2=80=99:
> > drivers/mmc/host/sdhci-pxa.c:205: warning: initialization from
> > incompatible pointer type drivers/mmc/host/sdhci-pxa.c:207: error:
> > =E2=80=98state=E2=80=99 undeclared (first use in this function)
> > drivers/mmc/host/sdhci-pxa.c:207: error: (Each undeclared identifie=
r is
> > reported only once drivers/mmc/host/sdhci-pxa.c:207: error: for eac=
h
> > function it appears in.) drivers/mmc/host/sdhci-pxa.c: In function
> > =E2=80=98sdhci_pxa_resume=E2=80=99:
> > drivers/mmc/host/sdhci-pxa.c:212: warning: initialization from
> > incompatible pointer type drivers/mmc/host/sdhci-pxa.c: At top leve=
l:
> > drivers/mmc/host/sdhci-pxa.c:222: warning: initialization from
> > incompatible pointer type drivers/mmc/host/sdhci-pxa.c:223: warning=
:
> > initialization from incompatible pointer type
> >=20
> > when compiled with CONFIG_PM=3Dy.
> >=20
> > --
> > Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> > One Laptop Per Child
>=20
> Sorry, forgot open CONFIG_PM.
> Updated patch, thanks
>=20
> From 88e7f028433fe87b211bf3d75b54261979d0d176 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 10:51:28 -0400
> Subject: [PATCH] mmc: add support of sdhci-pxa driver
>=20
> 	Support Marvell PXA168/PXA910/MMP2 SD Host Controller
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Acked-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
>  drivers/mmc/host/Kconfig               |   12 ++
>  drivers/mmc/host/Makefile              |    1 +
>  drivers/mmc/host/sdhci-pxa.c           |  254
> ++++++++++++++++++++++++++++++++ 4 files changed, 299 insertions(+), =
0
> deletions(-)
>  create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>  create mode 100644 drivers/mmc/host/sdhci-pxa.c
>=20
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> new file mode 100644
> index 0000000..38e86ad
> --- /dev/null
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -0,0 +1,32 @@
> +/* linux/arch/arm/plat-pxa/include/plat/sdhci.h
> + *
> + * Copyright 2010 Marvell
> + *	Zhangfei Gao <zhangfei.gao@marvell.com>
> + *
> + * PXA Platform - SDHCI platform data definitions
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __PLAT_PXA_SDHCI_H
> +#define __PLAT_PXA_SDHCI_H
> +
> +/* pxa specific flag */
> +/* Require clock free running */
> +#define	PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +
> +/**
> + * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> + * @max_speed: The maximum speed supported.
> + * @quirks: quirks of specific device
> + * @flags: flags for platfrom requirement
> +*/
> +struct sdhci_pxa_platdata {
> +	unsigned int	max_speed;
> +	unsigned int	quirks;
> +	unsigned int	flags;
> +};
> +
> +#endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index c9c2520..c387402 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -155,6 +155,18 @@ config MMC_SDHCI_S3C
>=20
>  	  If unsure, say N.
>=20
> +config MMC_SDHCI_PXA
> +	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
> +	depends on ARCH_PXA || ARCH_MMP
> +	select MMC_SDHCI
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller=
=2E
> +	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller=
 and a
> +	  card slot,say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_SPEAR
>  	tristate "SDHCI support on ST SPEAr platform"
>  	depends on MMC_SDHCI && PLAT_SPEAR
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6c4ac67..7b645ff 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_MMC_IMX)		+=3D imxmmc.o
>  obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
> +obj-$(CONFIG_MMC_SDHCI_PXA)	+=3D sdhci-pxa.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> new file mode 100644
> index 0000000..abf208c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -0,0 +1,254 @@
> +/* linux/drivers/mmc/host/sdhci-pxa.c
> + *
> + * Copyright (C) 2010 Marvell International Ltd.
> + *		Zhangfei Gao <zhangfei.gao@marvell.com>
> + *		Kevin Wang <dwang4@marvell.com>
> + *		Mingwei Wang <mwwang@marvell.com>
> + *		Philip Rakity <prakity@marvell.com>
> + *		Mark Brown <markb@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* Supports:
> + * SDHCI support for MMP2/PXA910/PXA168
> + *
> + * Refer sdhci-s3c.c
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/mmc/host.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <plat/sdhci.h>
> +#include "sdhci.h"
> +
> +#define DRIVER_NAME	"sdhci-pxa"
> +
> +#define SD_FIFO_PARAM		0x104
> +#define DIS_PAD_SD_CLK_GATE	0x400
> +
> +struct sdhci_pxa {
> +	struct sdhci_host		*host;
> +	struct sdhci_pxa_platdata	*pdata;
> +	struct clk			*clk;
> +	struct resource			*res;
> +
> +	u8 clk_enable;
> +};
> +
> +/*******************************************************************=
******
> ****\ + *                                                            =
     =20
>         * + * SDHCI core callbacks                                   =
    =20
>              * + *                                                   =
    =20
>                   *
> +\*******************************************************************=
*****
> *****/ +static void set_clock(struct sdhci_host *host, unsigned int c=
lock)
> +{
> +	struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +	u32 tmp =3D 0;
> +
> +	if (clock =3D=3D 0) {
> +		if (pxa->clk_enable) {
> +			clk_disable(pxa->clk);
> +			pxa->clk_enable =3D 0;
> +		}
> +	} else {
> +		if (0 =3D=3D pxa->clk_enable) {
> +			if (pxa->pdata->flags
> +					& PXA_FLAG_DISABLE_CLOCK_GATING) {
> +				tmp =3D readl(host->ioaddr + SD_FIFO_PARAM);
> +				tmp |=3D DIS_PAD_SD_CLK_GATE;
> +				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
> +			}
> +			clk_enable(pxa->clk);
> +			pxa->clk_enable =3D 1;
> +		}
> +	}
> +}

Doesn't the clock framework have something like clk_is_already_enabled(=
)=20
function ?
> +
> +static struct sdhci_ops sdhci_pxa_ops =3D {
> +	.set_clock =3D set_clock,
> +};
> +
> +/*******************************************************************=
******
> ****\ + *                                                            =
     =20
>         * + * Device probing/removal                                 =
    =20
>              * + *                                                   =
    =20
>                   *
> +\*******************************************************************=
*****
> *****/ +
> +static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data;
> +	struct device *dev =3D &pdev->dev;
> +	struct sdhci_host *host =3D NULL;
> +	struct resource *iomem =3D NULL;
> +	struct sdhci_pxa *pxa =3D NULL;
> +	int ret, irq;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no irq specified\n");
> +		return irq;
> +	}
> +
> +	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iomem) {
> +		dev_err(dev, "no memory specified\n");
> +		return -ENOENT;
> +	}
> +
> +	host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
> +	if (IS_ERR(host)) {
> +		dev_err(dev, "failed to alloc host\n");
> +		return PTR_ERR(host);
> +	}
> +
> +	pxa =3D sdhci_priv(host);
> +	pxa->host =3D host;
> +	pxa->pdata =3D pdata;
> +	pxa->clk_enable =3D 0;
> +
> +	pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
> +	if (IS_ERR(pxa->clk)) {
> +		dev_err(dev, "failed to get io clock\n");
> +		ret =3D PTR_ERR(pxa->clk);
> +		goto out;
> +	}
> +
> +	pxa->res =3D request_mem_region(iomem->start, resource_size(iomem),
> +		mmc_hostname(host->mmc));
> +	if (!pxa->res) {
> +		dev_err(&pdev->dev, "cannot request region\n");
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	host->ioaddr =3D ioremap(iomem->start, resource_size(iomem));
> +	if (!host->ioaddr) {
> +		dev_err(&pdev->dev, "failed to remap registers\n");
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	host->hw_name =3D "MMC";
> +	host->ops =3D &sdhci_pxa_ops;
> +	host->irq =3D irq;
> +	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEO=
UT_VAL;
> +

Maybe check if these aren't already set in pdata and warn user ?

> +	if (pdata->quirks)
> +		host->quirks |=3D pdata->quirks;
> +
> +	ret =3D sdhci_add_host(host);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add host\n");
> +		goto out;
> +	}
> +
> +	if (pxa->pdata->max_speed)
> +		host->mmc->f_max =3D pxa->pdata->max_speed;

What happens otherwise ?

> +
> +	platform_set_drvdata(pdev, host);
> +
> +	return 0;
> +out:
> +	if (host) {
> +		clk_put(pxa->clk);
> +		if (host->ioaddr)
> +			iounmap(host->ioaddr);
> +		if (pxa->res)
> +			release_mem_region(pxa->res->start,
> +					resource_size(pxa->res));
> +		sdhci_free_host(host);
> +	}
> +
> +	return ret;
> +}
> +
> +static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +	int dead =3D 0;
> +	u32 scratch;
> +
> +	if (host) {
> +		scratch =3D readl(host->ioaddr + SDHCI_INT_STATUS);
> +		if (scratch =3D=3D (u32)-1)
> +			dead =3D 1;
> +
> +		sdhci_remove_host(host, dead);
> +
> +		if (host->ioaddr)
> +			iounmap(host->ioaddr);
> +		if (pxa->res)
> +			release_mem_region(pxa->res->start,
> +					resource_size(pxa->res));
> +		if (pxa->clk_enable) {
> +			clk_disable(pxa->clk);
> +			pxa->clk_enable =3D 0;
> +		}
> +		clk_put(pxa->clk);
> +
> +		sdhci_free_host(host);
> +		platform_set_drvdata(pdev, NULL);
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int sdhci_pxa_suspend(struct platform_device *dev, pm_message=
_t
> state) +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	return sdhci_suspend_host(host, state);
> +}
> +
> +static int sdhci_pxa_resume(struct platform_device *dev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	return sdhci_resume_host(host);
> +}
> +#else
> +#define sdhci_pxa_suspend	NULL
> +#define sdhci_pxa_resume	NULL
> +#endif
> +
> +static struct platform_driver sdhci_pxa_driver =3D {
> +	.probe		=3D sdhci_pxa_probe,
> +	.remove		=3D __devexit_p(sdhci_pxa_remove),
> +	.suspend	=3D sdhci_pxa_suspend,
> +	.resume		=3D sdhci_pxa_resume,
> +	.driver		=3D {
> +		.name	=3D DRIVER_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +/*******************************************************************=
******
> ****\ + *                                                            =
     =20
>         * + * Driver init/exit                                       =
    =20
>              * + *                                                   =
    =20
>                   *
> +\*******************************************************************=
*****
> *****/ +
> +static int __init sdhci_pxa_init(void)
> +{
> +	return platform_driver_register(&sdhci_pxa_driver);
> +}
> +
> +static void __exit sdhci_pxa_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_pxa_driver);
> +}
> +
> +module_init(sdhci_pxa_init);
> +module_exit(sdhci_pxa_exit);
> +
> +MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
> +MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
> +MODULE_LICENSE("GPL v2");

Thanks!

Cheers
