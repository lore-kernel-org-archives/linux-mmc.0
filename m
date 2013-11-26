From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Tue, 26 Nov 2013 15:39:55 -0800
Message-ID: <9e92f3b2-5434-4fcf-b7f5-3f634175193c@CO1EHSMHS024.ehs.local>
References: <1383151090-13885-1-git-send-email-soren.brinkmann@xilinx.com>
 <87mwkqeojd.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:50440
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755864Ab3KZXkD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 18:40:03 -0500
Content-Disposition: inline
In-Reply-To: <87mwkqeojd.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>

Hi Chris,

On Tue, Nov 26, 2013 at 06:22:46PM -0500, Chris Ball wrote:
> Hi Soren, sorry for the late review, just trivial changes:
No problem. Thanks for looking at it.

>=20
> On Wed, Oct 30 2013, Soren Brinkmann wrote:
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt=
 b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > new file mode 100644
> > index 000000000000..ef4c5ac753e8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -0,0 +1,27 @@
> > +Device Tree Bindings for the Arasan SDCHI Controller
>=20
> SDHCI
Oops. Will be fixed.

>=20
> > +
> > +  The bindings follow the mmc[1], clock[2] and interrupt[3] bindin=
gs. Only
> > +  deviations are documented here.
> > +
> > +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> > +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +  [3] Documentation/devicetree/bindings/interrupt-controller/inter=
rupts.txt
> > +
> > +Required Properties:
> > +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> > +  - reg: From mmc bindings: Register location and length.
>=20
> Actually, reg/interrupts are from the OF core.  There's no need to
> mention them here.
Tomasz complained when I left those parts out so I added them in v2.
Since it's there now, I don't mind either way. Let's just agree on one
way or the other.

>=20
> > +  - clocks: From clock bindings: Handles to clock inputs.
> > +  - clock-names: From clock bindings: Tuple including "clk_xin" an=
d "clk_ahb"
> > +  - interrupts: Interrupt specifier
> > +  - interrupt-parent: Phandle for the interrupt controller that se=
rvices
> > +		      interrupts for this device.
> > +
> > +Example:
> > +	sdhci@e0100000 {
> > +		compatible =3D "arasan,sdhci-8.9a";
> > +		reg =3D <0xe0100000 0x1000>;
> > +		clock-names =3D "clk_xin", "clk_ahb";
> > +		clocks =3D <&clkc 21>, <&clkc 32>;
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 24 4>;
> > +	} ;
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3438384d270c..5ede7f722025 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1357,6 +1357,7 @@ T:	git git://git.xilinx.com/linux-xlnx.git
> >  S:	Supported
> >  F:	arch/arm/mach-zynq/
> >  F:	drivers/cpuidle/cpuidle-zynq.c
> > +F:	drivers/mmc/host/sdhci-of-arasan.c
> > =20
> >  ARM SMMU DRIVER
> >  M:	Will Deacon <will.deacon@arm.com>
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 7fc5099e44b2..1eb090c187bb 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -104,6 +104,18 @@ config MMC_SDHCI_PLTFM
> > =20
> >  	  If unsure, say N.
> > =20
> > +config MMC_SDHCI_OF_ARASAN
> > +	tristate "SDHCI OF support for the Arasan SDHCI controllers"
> > +	depends on MMC_SDHCI_PLTFM
> > +	depends on OF
> > +	help
> > +	  This selects the Arasan Secure Digital Host Controller Interfac=
e
> > +	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
> > +
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_OF_ESDHC
> >  	tristate "SDHCI OF support for the Freescale eSDHC controller"
> >  	depends on MMC_SDHCI_PLTFM
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index c41d0c364509..f93617ec6548 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+=3D sdhci-cns3x=
xx.o
> >  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+=3D sdhci-esdhc-imx.o
> >  obj-$(CONFIG_MMC_SDHCI_DOVE)		+=3D sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+=3D sdhci-tegra.o
> > +obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+=3D sdhci-of-arasan.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdhc.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+=3D sdhci-of-hlwd.o
> >  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+=3D sdhci-bcm-kona.o
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/=
sdhci-of-arasan.c
> > new file mode 100644
> > index 000000000000..98464bc732f6
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -0,0 +1,224 @@
> > +/*
> > + * Arasan Secure Digital Host Controller Interface.
> > + * Copyright (C) 2011 - 2012 Michal Simek <monstr@monstr.eu>
> > + * Copyright (c) 2012 Wind River Systems, Inc.
> > + * Copyright (C) 2013 Pengutronix e.K.
> > + * Copyright (C) 2013 Xilinx Inc.
> > + *
> > + * Based on sdhci-of-esdhc.c
> > + *
> > + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > + * Copyright (c) 2009 MontaVista Software, Inc.
> > + *
> > + * Authors: Xiaobo Xie <X.Xie@freescale.com>
> > + *	    Anton Vorontsov <avorontsov@ru.mvista.com>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or (at
> > + * your option) any later version.
> > + */
>=20
> The kernel is licensed under GPLv2, not GPLv2 or later.  In fact,
> GPLv2 is incompatible with GPLv3.  Can we stick to GPLv2 only here?
Well, this header allows you to use this source under GPLv2 -
which the kernel obviously does - but also to rip this file out and use
it under newer GPL licenses. This is fully compliant to GPLv2 licensing
in the kernel and commonly used across other drivers as well.
If you look at include/linux/module.h, several valid license strings ar=
e
documented to be used in the MODULE_LICENSE macro.
Let me know if you have any concerns and need this to be changed, but I
think this should be perfectly fine.

> > +
> > +#include <linux/module.h>
> > +#include "sdhci-pltfm.h"
> > +
> > +#define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> > +
> > +#define CLK_CTRL_TIMEOUT_SHIFT		16
> > +#define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
> > +#define CLK_CTRL_TIMEOUT_MIN_EXP	13
> > +
> > +/**
> > + * struct sdhci_arasan_data
> > + * @clk_ahb:	Pointer to the AHB clock
> > + */
> > +struct sdhci_arasan_data {
> > +	struct clk	*clk_ahb;
> > +};
> > +
> > +static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_ho=
st *host)
> > +{
> > +	u32 div;
> > +	unsigned long freq;
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +
> > +	div =3D readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
> > +	div =3D (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
> > +
> > +	freq =3D clk_get_rate(pltfm_host->clk);
> > +	freq /=3D 1 << (CLK_CTRL_TIMEOUT_MIN_EXP + div);
> > +
> > +	return freq;
> > +}
> > +
> > +static struct sdhci_ops sdhci_arasan_ops =3D {
> > +	.get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
> > +	.get_timeout_clock =3D sdhci_arasan_get_timeout_clock,
> > +};
> > +
> > +static struct sdhci_pltfm_data sdhci_arasan_pdata =3D {
> > +	.ops =3D &sdhci_arasan_ops,
> > +};
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +/**
> > + * sdhci_arasan_suspend - Suspend method for the driver
> > + * @dev:	Address of the device structure
> > + * Returns 0 on success and error value on error
> > + *
> > + * Put the device in a low power state.
> > + */
> > +static int sdhci_arasan_suspend(struct device *dev)
> > +{
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> > +	int ret;
> > +
> > +	ret =3D sdhci_suspend_host(host);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable(pltfm_host->clk);
> > +	clk_disable(sdhci_arasan->clk_ahb);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sdhci_arasan_resume - Resume method for the driver
> > + * @dev:	Address of the device structure
> > + * Returns 0 on success and error value on error
> > + *
> > + * Resume operation after suspend
> > + */
> > +static int sdhci_arasan_resume(struct device *dev)
> > +{
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> > +	int ret;
> > +
> > +	ret =3D clk_enable(sdhci_arasan->clk_ahb);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot enable AHB clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_enable(pltfm_host->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot enable SD clock.\n");
> > +		clk_disable(sdhci_arasan->clk_ahb);
> > +		return ret;
> > +	}
> > +
> > +	return sdhci_resume_host(host);
> > +}
> > +#endif /* ! CONFIG_PM_SLEEP */
> > +
> > +static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_sus=
pend,
> > +			 sdhci_arasan_resume);
> > +
> > +static int sdhci_arasan_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct clk *clk_xin;
> > +	struct sdhci_host *host;
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct sdhci_arasan_data *sdhci_arasan;
> > +
> > +	sdhci_arasan =3D devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
> > +			GFP_KERNEL);
> > +	if (!sdhci_arasan)
> > +		return -ENOMEM;
> > +
> > +	sdhci_arasan->clk_ahb =3D devm_clk_get(&pdev->dev, "clk_ahb");
> > +	if (IS_ERR(sdhci_arasan->clk_ahb)) {
> > +		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> > +		return PTR_ERR(sdhci_arasan->clk_ahb);
> > +	}
> > +
> > +	clk_xin =3D devm_clk_get(&pdev->dev, "clk_xin");
> > +	if (IS_ERR(clk_xin)) {
> > +		dev_err(&pdev->dev, "clk_xin clock not found.\n");
> > +		return PTR_ERR(clk_xin);
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(sdhci_arasan->clk_ahb);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(clk_xin);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable SD clock.\n");
> > +		goto clk_dis_ahb;
> > +	}
> > +
> > +	host =3D sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
> > +	if (IS_ERR(host)) {
> > +		ret =3D PTR_ERR(host);
> > +		dev_err(&pdev->dev, "platform init failed (%u)\n", ret);
> > +		goto clk_disable_all;
> > +	}
> > +
> > +	sdhci_get_of_property(pdev);
> > +	pltfm_host =3D sdhci_priv(host);
> > +	pltfm_host->priv =3D sdhci_arasan;
> > +	pltfm_host->clk =3D clk_xin;
> > +
> > +	ret =3D sdhci_add_host(host);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
> > +		goto err_pltfm_free;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_pltfm_free:
> > +	sdhci_pltfm_free(pdev);
> > +clk_disable_all:
> > +	clk_disable_unprepare(clk_xin);
> > +clk_dis_ahb:
> > +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sdhci_arasan_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> > +
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> > +
> > +	return sdhci_pltfm_unregister(pdev);
> > +}
> > +
> > +static const struct of_device_id sdhci_arasan_of_match[] =3D {
> > +	{ .compatible =3D "arasan,sdhci-8.9a" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> > +
> > +static struct platform_driver sdhci_arasan_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "sdhci-arasan",
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D sdhci_arasan_of_match,
> > +		.pm =3D &sdhci_arasan_dev_pm_ops,
> > +	},
> > +	.probe =3D sdhci_arasan_probe,
> > +	.remove =3D sdhci_arasan_remove,
> > +};
> > +
> > +module_platform_driver(sdhci_arasan_driver);
> > +
> > +MODULE_DESCRIPTION("Driver for the Arasan SDHCI Controller");
> > +MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com");
>=20
> Missing a closing ">" here.
Right, I'll add it.

	Thanks,
	S=C3=B6ren


