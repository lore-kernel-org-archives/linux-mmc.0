From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v3 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Fri, 13 Dec 2013 09:04:11 -0800
Message-ID: <5feb9c16-f956-4072-9ea1-c3d708fadc53@DB9EHSMHS006.ehs.local>
References: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:20777
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab3LMRE3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Dec 2013 12:04:29 -0500
Content-Disposition: inline
In-Reply-To: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org

ping?

On Mon, Dec 02, 2013 at 10:02:36AM -0800, Soren Brinkmann wrote:
> Add a driver for Arasan's SDHCI controller core.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com> [binding]
> ---
> As discussed, I left binding and license header as is and fixed the t=
ypos.
>=20
> v3:
>  - fix typo in binding documentation
>  - add missing '>' in MODULE_AUTHOR string
> v2:
>  - document 'interrupts' and 'interrupt-parent' properties in the dri=
ver
>    bindings
>  - append '-8.9a' IP version specifier to comaptibility string
>=20
>    	Thanks,
> 	S=C3=B6ren
>=20
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  27 +++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 224 +++++++++++=
++++++++++
>  5 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhc=
i.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-arasan.c
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b=
/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> new file mode 100644
> index 000000000000..98ee2abbe138
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -0,0 +1,27 @@
> +Device Tree Bindings for the Arasan SDHCI Controller
> +
> +  The bindings follow the mmc[1], clock[2] and interrupt[3] bindings=
=2E Only
> +  deviations are documented here.
> +
> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +  [3] Documentation/devicetree/bindings/interrupt-controller/interru=
pts.txt
> +
> +Required Properties:
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - reg: From mmc bindings: Register location and length.
> +  - clocks: From clock bindings: Handles to clock inputs.
> +  - clock-names: From clock bindings: Tuple including "clk_xin" and =
"clk_ahb"
> +  - interrupts: Interrupt specifier
> +  - interrupt-parent: Phandle for the interrupt controller that serv=
ices
> +		      interrupts for this device.
> +
> +Example:
> +	sdhci@e0100000 {
> +		compatible =3D "arasan,sdhci-8.9a";
> +		reg =3D <0xe0100000 0x1000>;
> +		clock-names =3D "clk_xin", "clk_ahb";
> +		clocks =3D <&clkc 21>, <&clkc 32>;
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <0 24 4>;
> +	} ;
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f216db847022..9c98792335d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1371,6 +1371,7 @@ T:	git git://git.xilinx.com/linux-xlnx.git
>  S:	Supported
>  F:	arch/arm/mach-zynq/
>  F:	drivers/cpuidle/cpuidle-zynq.c
> +F:	drivers/mmc/host/sdhci-of-arasan.c
> =20
>  ARM SMMU DRIVER
>  M:	Will Deacon <will.deacon@arm.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099e44b2..1eb090c187bb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -104,6 +104,18 @@ config MMC_SDHCI_PLTFM
> =20
>  	  If unsure, say N.
> =20
> +config MMC_SDHCI_OF_ARASAN
> +	tristate "SDHCI OF support for the Arasan SDHCI controllers"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects the Arasan Secure Digital Host Controller Interface
> +	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_ESDHC
>  	tristate "SDHCI OF support for the Freescale eSDHC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index c41d0c364509..f93617ec6548 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+=3D sdhci-cns3xxx=
=2Eo
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+=3D sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)		+=3D sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+=3D sdhci-tegra.o
> +obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+=3D sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+=3D sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+=3D sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sd=
hci-of-arasan.c
> new file mode 100644
> index 000000000000..f7c7cf62437d
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -0,0 +1,224 @@
> +/*
> + * Arasan Secure Digital Host Controller Interface.
> + * Copyright (C) 2011 - 2012 Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2012 Wind River Systems, Inc.
> + * Copyright (C) 2013 Pengutronix e.K.
> + * Copyright (C) 2013 Xilinx Inc.
> + *
> + * Based on sdhci-of-esdhc.c
> + *
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + * Copyright (c) 2009 MontaVista Software, Inc.
> + *
> + * Authors: Xiaobo Xie <X.Xie@freescale.com>
> + *	    Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or=
 (at
> + * your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include "sdhci-pltfm.h"
> +
> +#define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> +
> +#define CLK_CTRL_TIMEOUT_SHIFT		16
> +#define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
> +#define CLK_CTRL_TIMEOUT_MIN_EXP	13
> +
> +/**
> + * struct sdhci_arasan_data
> + * @clk_ahb:	Pointer to the AHB clock
> + */
> +struct sdhci_arasan_data {
> +	struct clk	*clk_ahb;
> +};
> +
> +static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host=
 *host)
> +{
> +	u32 div;
> +	unsigned long freq;
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +
> +	div =3D readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
> +	div =3D (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
> +
> +	freq =3D clk_get_rate(pltfm_host->clk);
> +	freq /=3D 1 << (CLK_CTRL_TIMEOUT_MIN_EXP + div);
> +
> +	return freq;
> +}
> +
> +static struct sdhci_ops sdhci_arasan_ops =3D {
> +	.get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock =3D sdhci_arasan_get_timeout_clock,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_arasan_pdata =3D {
> +	.ops =3D &sdhci_arasan_ops,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +/**
> + * sdhci_arasan_suspend - Suspend method for the driver
> + * @dev:	Address of the device structure
> + * Returns 0 on success and error value on error
> + *
> + * Put the device in a low power state.
> + */
> +static int sdhci_arasan_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> +	int ret;
> +
> +	ret =3D sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return 0;
> +}
> +
> +/**
> + * sdhci_arasan_resume - Resume method for the driver
> + * @dev:	Address of the device structure
> + * Returns 0 on success and error value on error
> + *
> + * Resume operation after suspend
> + */
> +static int sdhci_arasan_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> +	int ret;
> +
> +	ret =3D clk_enable(sdhci_arasan->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable AHB clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SD clock.\n");
> +		clk_disable(sdhci_arasan->clk_ahb);
> +		return ret;
> +	}
> +
> +	return sdhci_resume_host(host);
> +}
> +#endif /* ! CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspe=
nd,
> +			 sdhci_arasan_resume);
> +
> +static int sdhci_arasan_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct clk *clk_xin;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_arasan_data *sdhci_arasan;
> +
> +	sdhci_arasan =3D devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
> +			GFP_KERNEL);
> +	if (!sdhci_arasan)
> +		return -ENOMEM;
> +
> +	sdhci_arasan->clk_ahb =3D devm_clk_get(&pdev->dev, "clk_ahb");
> +	if (IS_ERR(sdhci_arasan->clk_ahb)) {
> +		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> +		return PTR_ERR(sdhci_arasan->clk_ahb);
> +	}
> +
> +	clk_xin =3D devm_clk_get(&pdev->dev, "clk_xin");
> +	if (IS_ERR(clk_xin)) {
> +		dev_err(&pdev->dev, "clk_xin clock not found.\n");
> +		return PTR_ERR(clk_xin);
> +	}
> +
> +	ret =3D clk_prepare_enable(sdhci_arasan->clk_ahb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(clk_xin);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable SD clock.\n");
> +		goto clk_dis_ahb;
> +	}
> +
> +	host =3D sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
> +	if (IS_ERR(host)) {
> +		ret =3D PTR_ERR(host);
> +		dev_err(&pdev->dev, "platform init failed (%u)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	sdhci_get_of_property(pdev);
> +	pltfm_host =3D sdhci_priv(host);
> +	pltfm_host->priv =3D sdhci_arasan;
> +	pltfm_host->clk =3D clk_xin;
> +
> +	ret =3D sdhci_add_host(host);
> +	if (ret) {
> +		dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
> +		goto err_pltfm_free;
> +	}
> +
> +	return 0;
> +
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +clk_disable_all:
> +	clk_disable_unprepare(clk_xin);
> +clk_dis_ahb:
> +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> +
> +	return ret;
> +}
> +
> +static int sdhci_arasan_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> +
> +	return sdhci_pltfm_unregister(pdev);
> +}
> +
> +static const struct of_device_id sdhci_arasan_of_match[] =3D {
> +	{ .compatible =3D "arasan,sdhci-8.9a" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> +
> +static struct platform_driver sdhci_arasan_driver =3D {
> +	.driver =3D {
> +		.name =3D "sdhci-arasan",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D sdhci_arasan_of_match,
> +		.pm =3D &sdhci_arasan_dev_pm_ops,
> +	},
> +	.probe =3D sdhci_arasan_probe,
> +	.remove =3D sdhci_arasan_remove,
> +};
> +
> +module_platform_driver(sdhci_arasan_driver);
> +
> +MODULE_DESCRIPTION("Driver for the Arasan SDHCI Controller");
> +MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 1.8.4.4
>=20
>=20

