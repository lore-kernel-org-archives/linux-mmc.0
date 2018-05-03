From: Liming Sun <lsun@mellanox.com>
Subject: RE: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Date: Thu, 3 May 2018 14:35:59 +0000
Message-ID: <DB4PR05MB076851D9F7AD93D88B2A0533A1870@DB4PR05MB0768.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525198787-46403-1-git-send-email-lsun@mellanox.com>
 <c95b926f-2129-c6de-7112-728eea9c7a3a@rock-chips.com>
 <AM2PR05MB0753973D8C92F831D48DA19CA1800@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <485d5c78-e16f-5034-9314-9e17e48d3570@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <485d5c78-e16f-5034-9314-9e17e48d3570@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Shawn Lin
> Sent: Thursday, May 3, 2018 3:25 AM
> To: Liming Sun <lsun@mellanox.com>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>
> Cc: shawn.lin@rock-chips.com; Ulf Hansson <ulf.hansson@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
>=20
>=20
> On 2018/5/2 20:45, Liming Sun wrote:
> > Please see response inline.
> >
> > Thanks,
> > Liming
> >
> >> -----Original Message-----
> >> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> >> Sent: Tuesday, May 1, 2018 9:02 PM
> >> To: Liming Sun <lsun@mellanox.com>; Mark Rutland
> >> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> >> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> >> <will.deacon@arm.com>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> >> <robh+dt@kernel.org>; shawn.lin@rock-chips.com; linux-
> >> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; stable@kernel.org
> >> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver
> extension
> >>
> >> On 2018/5/2 2:19, Liming Sun wrote:
> >>> This commit adds extension to the dw_mmc driver for Mellanox
> BlueField
> >>> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card
> on
> >>> this SoC.
> >>>
> >>> Cc: stable@kernel.org
> >>
> >> Why?
> >
> > [Liming] This is recommended value from HW team. Without this setting,
> the eMMC
> > controller and cards can be found in Linux, but not stable. Writing to =
it could
> caused
> > CRC error.
>=20
> Well, I refered to the "Cc: stable@kernel.org" in the commit msg.

[Liming] Sorry, a typo.  I meant "stable@vger.kernel.org". Will update it i=
n v6. Thanks!

>=20
> >
> >>
> >>> Signed-off-by: Liming Sun <lsun@mellanox.com>
> >>> Reviewed-by: David Woods <dwoods@mellanox.com>
> >>> ---
> >>>    drivers/mmc/host/Kconfig            |  9 +++++
> >>>    drivers/mmc/host/Makefile           |  1 +
> >>>    drivers/mmc/host/dw_mmc-bluefield.c | 72
> >> +++++++++++++++++++++++++++++++++++++
> >>>    3 files changed, 82 insertions(+)
> >>>    create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> >>>
> >>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>> index 9589f9c..26ac6b5 100644
> >>> --- a/drivers/mmc/host/Kconfig
> >>> +++ b/drivers/mmc/host/Kconfig
> >>> @@ -717,6 +717,15 @@ config MMC_DW_K3
> >>>    	  Synopsys DesignWare Memory Card Interface driver. Select this
> >> option
> >>>    	  for platforms based on Hisilicon K3 SoC's.
> >>>
> >>> +config MMC_DW_BLUEFIELD
> >>
> >> And did you have feedback of my comment in V2=1B$B!)=1B(B
> >> http://lists-archives.com/linux-kernel/29104830-mmc-dw_mmc-
> bluefield-
> >> add-driver-extension.html
> >>
> >>> +	tristate "BlueField specific extensions for Synopsys DW Memory Card
> >> Interface"
> >>> +	depends on MMC_DW
> >>> +	select MMC_DW_PLTFM
> >>> +	help
> >>> +	  This selects support for Mellanox BlueField SoC specific extensio=
ns
> >> to
> >>> +	  the Synopsys DesignWare Memory Card Interface driver. Select this
> >>> +	  option for platforms based on Mellanox BlueField SoC's.
> >>> +
> >>>    config MMC_DW_PCI
> >>>    	tristate "Synopsys Designware MCI support on PCI bus"
> >>>    	depends on MMC_DW && PCI
> >>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> >>> index 6aead24..267b3f1 100644
> >>> --- a/drivers/mmc/host/Makefile
> >>> +++ b/drivers/mmc/host/Makefile
> >>> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+=3D
> dw_mmc-
> >> k3.o
> >>>    obj-$(CONFIG_MMC_DW_PCI)	+=3D dw_mmc-pci.o
> >>>    obj-$(CONFIG_MMC_DW_ROCKCHIP)	+=3D dw_mmc-rockchip.o
> >>>    obj-$(CONFIG_MMC_DW_ZX)		+=3D dw_mmc-zx.o
> >>> +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+=3D dw_mmc-bluefield.o
> >>>    obj-$(CONFIG_MMC_SH_MMCIF)	+=3D sh_mmcif.o
> >>>    obj-$(CONFIG_MMC_JZ4740)	+=3D jz4740_mmc.o
> >>>    obj-$(CONFIG_MMC_VUB300)	+=3D vub300.o
> >>> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c
> >> b/drivers/mmc/host/dw_mmc-bluefield.c
> >>> new file mode 100644
> >>> index 0000000..12067b1
> >>> --- /dev/null
> >>> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> >>> @@ -0,0 +1,72 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (C) 2018 Mellanox Technologies.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or mod=
ify
> >>> + * it under the terms of the GNU General Public License as published=
 by
> >>> + * the Free Software Foundation; either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>> + */
> >>> +
> >>> +#include <linux/module.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/irq.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/pm_runtime.h>
> >>> +#include <linux/mmc/host.h>
> >>> +#include <linux/mmc/mmc.h>
> >>> +#include <linux/of.h>
> >>> +
> >>> +#include "dw_mmc.h"
> >>> +#include "dw_mmc-pltfm.h"
> >>> +
> >>> +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct
> >> mmc_ios *ios)
> >>> +{
> >>> +	u32 regs;
> >>> +
> >>> +	/* Set drive=3D4 (bit 29:23) and sample=3D2 (bit 22:16) in UHS_REG_=
EXT.
> >> */
> >>> +	regs =3D mci_readl(host, UHS_REG_EXT);
> >>> +	regs =3D (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);
> >>> +	mci_writel(host, UHS_REG_EXT, regs);
> >>> +}
> >>> +
> >>> +static const struct dw_mci_drv_data bluefield_drv_data =3D {
> >>> +	.set_ios		=3D dw_mci_bluefield_set_ios
> >>> +};
> >>> +
> >>> +static const struct of_device_id dw_mci_bluefield_match[] =3D {
> >>> +	{ .compatible =3D "mellanox,bluefield-dw-mshc",
> >>> +		.data =3D &bluefield_drv_data },
> >>> +	{},
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> >>> +
> >>> +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> >>> +{
> >>> +	const struct dw_mci_drv_data *drv_data =3D NULL;
> >>> +	const struct of_device_id *match;
> >>> +
> >>> +	if (pdev->dev.of_node) {
> >>> +		match =3D of_match_node(dw_mci_bluefield_match,
> >>> +				      pdev->dev.of_node);
> >>> +		drv_data =3D match->data;
> >>> +	}
> >>> +
> >>> +	return dw_mci_pltfm_register(pdev, drv_data);
> >>> +}
> >>> +
> >>> +static struct platform_driver dw_mci_bluefield_pltfm_driver =3D {
> >>> +	.probe		=3D dw_mci_bluefield_probe,
> >>> +	.remove		=3D dw_mci_pltfm_remove,
> >>> +	.driver		=3D {
> >>> +		.name		=3D "dwmmc_bluefield",
> >>> +		.of_match_table	=3D dw_mci_bluefield_match,
> >>> +		.pm		=3D &dw_mci_pltfm_pmops,
> >>> +	},
> >>> +};
> >>> +
> >>> +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> >>> +
> >>> +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> >>> +MODULE_AUTHOR("Mellanox Technologies");
> >>> +MODULE_LICENSE("GPL v2");
> >>>
> >
> >
> >
> >
