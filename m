From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 1/3] mmc: dw_mmc-bluefield: Add driver extension
Date: Mon, 21 May 2018 13:36:10 +0200
Message-ID: <CAPDyKFoH2XX3vgR+SEPEq+R9Xh0kSsBpC1qHwe0i0QOMTze1fw@mail.gmail.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 May 2018 at 20:46, Liming Sun <lsun@mellanox.com> wrote:
> This commit adds extension to the dw_mmc driver for Mellanox BlueField
> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> this SoC.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> Reviewed-by: David Woods <dwoods@mellanox.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig            |  9 +++++
>  drivers/mmc/host/Makefile           |  1 +
>  drivers/mmc/host/dw_mmc-bluefield.c | 81 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9589f9c..7784f76 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -690,6 +690,15 @@ config MMC_DW_PLTFM
>
>           If unsure, say Y.
>
> +config MMC_DW_BLUEFIELD
> +       tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
> +       depends on MMC_DW
> +       select MMC_DW_PLTFM
> +       help
> +         This selects support for Mellanox BlueField SoC specific extensions to
> +         the Synopsys DesignWare Memory Card Interface driver. Select this
> +         option for platforms based on Mellanox BlueField SoC's.
> +
>  config MMC_DW_EXYNOS
>         tristate "Exynos specific extensions for Synopsys DW Memory Card Interface"
>         depends on MMC_DW
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6aead24..85dc132 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -49,6 +49,7 @@ thunderx-mmc-objs := cavium.o cavium-thunderx.o
>  obj-$(CONFIG_MMC_CAVIUM_THUNDERX) += thunderx-mmc.o
>  obj-$(CONFIG_MMC_DW)           += dw_mmc.o
>  obj-$(CONFIG_MMC_DW_PLTFM)     += dw_mmc-pltfm.o
> +obj-$(CONFIG_MMC_DW_BLUEFIELD) += dw_mmc-bluefield.o
>  obj-$(CONFIG_MMC_DW_EXYNOS)    += dw_mmc-exynos.o
>  obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
>  obj-$(CONFIG_MMC_DW_K3)                += dw_mmc-k3.o
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> new file mode 100644
> index 0000000..54c3fbb
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -0,0 +1,81 @@
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
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "dw_mmc.h"
> +#include "dw_mmc-pltfm.h"
> +
> +#define UHS_REG_EXT_SAMPLE_MASK                GENMASK(22, 16)
> +#define UHS_REG_EXT_DRIVE_MASK         GENMASK(29, 23)
> +#define BLUEFIELD_UHS_REG_EXT_SAMPLE   2
> +#define BLUEFIELD_UHS_REG_EXT_DRIVE    4
> +
> +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +       u32 reg;
> +
> +       /* Update the Drive and Sample fields in register UHS_REG_EXT. */
> +       reg = mci_readl(host, UHS_REG_EXT);
> +       reg &= ~UHS_REG_EXT_SAMPLE_MASK;
> +       reg |= FIELD_PREP(UHS_REG_EXT_SAMPLE_MASK,
> +                         BLUEFIELD_UHS_REG_EXT_SAMPLE);
> +       reg &= ~UHS_REG_EXT_DRIVE_MASK;
> +       reg |= FIELD_PREP(UHS_REG_EXT_DRIVE_MASK, BLUEFIELD_UHS_REG_EXT_DRIVE);
> +       mci_writel(host, UHS_REG_EXT, reg);
> +}
> +
> +static const struct dw_mci_drv_data bluefield_drv_data = {
> +       .set_ios                = dw_mci_bluefield_set_ios
> +};
> +
> +static const struct of_device_id dw_mci_bluefield_match[] = {
> +       { .compatible = "mellanox,bluefield-dw-mshc",
> +         .data = &bluefield_drv_data },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> +
> +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> +{
> +       const struct dw_mci_drv_data *drv_data = NULL;
> +       const struct of_device_id *match;
> +
> +       if (pdev->dev.of_node) {
> +               match = of_match_node(dw_mci_bluefield_match,
> +                                     pdev->dev.of_node);
> +               drv_data = match->data;
> +       }
> +
> +       return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> +       .probe          = dw_mci_bluefield_probe,
> +       .remove         = dw_mci_pltfm_remove,
> +       .driver         = {
> +               .name           = "dwmmc_bluefield",
> +               .of_match_table = dw_mci_bluefield_match,
> +               .pm             = &dw_mci_pltfm_pmops,
> +       },
> +};
> +
> +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> +
> +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL v2");
> --
> 1.8.3.1
>
