From: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/8] IBM Akebono: Add a SDHCI platform driver
Date: Tue, 17 Dec 2013 12:11:28 +1100
Message-ID: <1449993.dLHmhtoyuX@mexican>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au> <1385086116-10972-2-git-send-email-alistair@popple.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:45797 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751944Ab3LQBPn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Dec 2013 20:15:43 -0500
In-Reply-To: <1385086116-10972-2-git-send-email-alistair@popple.id.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org

Hi,

I originally sent this to the linuxppc-dev list thinking Ben H might ta=
ke it,=20
however it should go through the appropriate subsystem. Can someone ple=
ase=20
merge it into the appropriate tree (unless the are problems with it)?

Thanks.

Regards,

Alistair

On Fri, 22 Nov 2013 13:08:30 Alistair Popple wrote:
> This patch adds a SDHCI platform driver for the new IBM PPC476GTR SoC
> which is on the Akebono board.
>=20
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/Kconfig           |   12 ++++++++
>  drivers/mmc/host/Makefile          |    1 +
>  drivers/mmc/host/sdhci-of-476gtr.c |   60
> ++++++++++++++++++++++++++++++++++++ 3 files changed, 73 insertions(+=
)
>  create mode 100644 drivers/mmc/host/sdhci-of-476gtr.c
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..14210df 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -130,6 +130,18 @@ config MMC_SDHCI_OF_HLWD
>=20
>  	  If unsure, say N.
>=20
> +config MMC_SDHCI_OF_476GTR
> +	tristate "SDHCI OF support for the IBM PPC476GTR SoC"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on PPC_OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found on the PPC476GTR SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CNS3XXX
>  	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>  	depends on ARCH_CNS3XXX
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index c41d0c3..92beff3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+=3D sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+=3D sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+=3D sdhci-of-hlwd.o
> +obj-$(CONFIG_MMC_SDHCI_OF_476GTR)	+=3D sdhci-of-476gtr.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+=3D sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_BCM2835)		+=3D sdhci-bcm2835.o
>=20
> diff --git a/drivers/mmc/host/sdhci-of-476gtr.c
> b/drivers/mmc/host/sdhci-of-476gtr.c new file mode 100644
> index 0000000..1310f8c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-476gtr.c
> @@ -0,0 +1,60 @@
> +/*
> + * drivers/mmc/host/sdhci-of-476gtr.c
> + *
> + * Copyright =A9 2013 Alistair Popple <alistair@popple.id.au> IBM Co=
rporation
> + *
> + * Based on sdhci-of-hlwd.c
> + *
> + * Copyright (C) 2009 The GameCube Linux Team
> + * Copyright (C) 2009 Albert Herranz
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
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/mmc/host.h>
> +#include "sdhci-pltfm.h"
> +
> +static const struct sdhci_ops sdhci_476gtr_ops =3D {
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_476gtr_pdata =3D {
> +	.ops =3D &sdhci_476gtr_ops,
> +};
> +
> +static int sdhci_476gtr_probe(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_register(pdev, &sdhci_476gtr_pdata, 0);
> +}
> +
> +static int sdhci_476gtr_remove(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_unregister(pdev);
> +}
> +
> +static const struct of_device_id sdhci_476gtr_of_match[] =3D {
> +	{ .compatible =3D "ibm,476gtr-sdhci" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_476gtr_of_match);
> +
> +static struct platform_driver sdhci_476gtr_driver =3D {
> +	.driver =3D {
> +		.name =3D "sdhci-476gtr",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D sdhci_476gtr_of_match,
> +		.pm =3D SDHCI_PLTFM_PMOPS,
> +	},
> +	.probe =3D sdhci_476gtr_probe,
> +	.remove =3D sdhci_476gtr_remove,
> +};
> +
> +module_platform_driver(sdhci_476gtr_driver);
> +
> +MODULE_DESCRIPTION("PPC476GTR SDHCI OF driver");
> +MODULE_AUTHOR("Alistair Popple");
> +MODULE_LICENSE("GPL v2");
