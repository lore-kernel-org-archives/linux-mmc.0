From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Date: Wed, 2 May 2018 17:16:55 +0900
Message-ID: <90076dd0-1e6a-3678-5357-98f84a03a46a@samsung.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
        <CGME20180501182919epcas2p368101c944e8e4bcdb19a1863fc8d469d@epcas2p3.samsung.com>
        <1525198787-46403-1-git-send-email-lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525198787-46403-1-git-send-email-lsun@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/02/2018 03:19 AM, Liming Sun wrote:
> This commit adds extension to the dw_mmc driver for Mellanox BlueField
> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> this SoC.

Could you heck Shawn's comments? And add the minor comment.

> 
> Cc: stable@kernel.org
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> ---
>  drivers/mmc/host/Kconfig            |  9 +++++
>  drivers/mmc/host/Makefile           |  1 +
>  drivers/mmc/host/dw_mmc-bluefield.c | 72 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9589f9c..26ac6b5 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -717,6 +717,15 @@ config MMC_DW_K3
>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
>  	  for platforms based on Hisilicon K3 SoC's.
>  
> +config MMC_DW_BLUEFIELD
> +	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
> +	depends on MMC_DW
> +	select MMC_DW_PLTFM
> +	help
> +	  This selects support for Mellanox BlueField SoC specific extensions to
> +	  the Synopsys DesignWare Memory Card Interface driver. Select this
> +	  option for platforms based on Mellanox BlueField SoC's.
> +
>  config MMC_DW_PCI
>  	tristate "Synopsys Designware MCI support on PCI bus"
>  	depends on MMC_DW && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6aead24..267b3f1 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
>  obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
> +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> new file mode 100644
> index 0000000..12067b1
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Mellanox Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/of.h>
> +
> +#include "dw_mmc.h"
> +#include "dw_mmc-pltfm.h"
> +
> +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	u32 regs;
> +
> +	/* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT. */
> +	regs = mci_readl(host, UHS_REG_EXT);
> +	regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);

I want to use the macro. Not (4 << 23)..

> +	mci_writel(host, UHS_REG_EXT, regs);
> +}
> +
> +static const struct dw_mci_drv_data bluefield_drv_data = {
> +	.set_ios		= dw_mci_bluefield_set_ios
> +};
> +
> +static const struct of_device_id dw_mci_bluefield_match[] = {
> +	{ .compatible = "mellanox,bluefield-dw-mshc",
> +		.data = &bluefield_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> +
> +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> +{
> +	const struct dw_mci_drv_data *drv_data = NULL;
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match = of_match_node(dw_mci_bluefield_match,
> +				      pdev->dev.of_node);
> +		drv_data = match->data;
> +	}
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> +	.probe		= dw_mci_bluefield_probe,
> +	.remove		= dw_mci_pltfm_remove,
> +	.driver		= {
> +		.name		= "dwmmc_bluefield",
> +		.of_match_table	= dw_mci_bluefield_match,
> +		.pm		= &dw_mci_pltfm_pmops,
> +	},
> +};
> +
> +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> +
> +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL v2");
> 
