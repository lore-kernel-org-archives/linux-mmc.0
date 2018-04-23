From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-bluefield: Add driver extension
Date: Mon, 23 Apr 2018 11:31:51 +0200
Message-ID: <CAPDyKFoPgMeCmAC9JeC4hzW4OBDqCq5cdjPoRd0AfYpq=FErwg@mail.gmail.com>
References: <1524245538-34137-1-git-send-email-lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524245538-34137-1-git-send-email-lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 April 2018 at 19:32, Liming Sun <lsun@mellanox.com> wrote:
> This commit adds extension to the dw_mmc driver for Mellanox BlueField
> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> this SoC.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29 +++++++++

Please move changes to DT docs into a separate patch.

Otherwise this looks good to me.

Kind regards
Uffe

>  drivers/mmc/host/Kconfig                           |  9 +++
>  drivers/mmc/host/Makefile                          |  1 +
>  drivers/mmc/host/dw_mmc-bluefield.c                | 72 ++++++++++++++++++++++
>  4 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> new file mode 100644
> index 0000000..ee0dd61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> @@ -0,0 +1,29 @@
> +* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
> +  Mobile Storage Host Controller
> +
> +Read synopsys-dw-mshc.txt for more details
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Mellanox Bluefield SoC
> +specific extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following.
> +  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield SoC
> +    specific extensions.
> +
> +Example:
> +
> +       /* Mellanox Bluefield SoC MMC */
> +       dwmmc0@4,0 {
> +               compatible = "mellanox,bluefield-dw-mshc";
> +               reg = <4 0x8000 0x400>;
> +               interrupts = <32>;
> +               fifo-depth = <0x100>;
> +               clock-frequency = <24000000>;
> +               bus-width = <8>;
> +               cap-mmc-highspeed;
> +       };
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9589f9c..26ac6b5 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -717,6 +717,15 @@ config MMC_DW_K3
>           Synopsys DesignWare Memory Card Interface driver. Select this option
>           for platforms based on Hisilicon K3 SoC's.
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
>  config MMC_DW_PCI
>         tristate "Synopsys Designware MCI support on PCI bus"
>         depends on MMC_DW && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6aead24..267b3f1 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)               += dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)       += dw_mmc-pci.o
>  obj-$(CONFIG_MMC_DW_ROCKCHIP)  += dw_mmc-rockchip.o
>  obj-$(CONFIG_MMC_DW_ZX)                += dw_mmc-zx.o
> +obj-$(CONFIG_MMC_DW_BLUEFIELD) += dw_mmc-bluefield.o
>  obj-$(CONFIG_MMC_SH_MMCIF)     += sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)       += jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)       += vub300.o
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
> +       u32 regs;
> +
> +       /* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT. */
> +       regs = mci_readl(host, UHS_REG_EXT);
> +       regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);
> +       mci_writel(host, UHS_REG_EXT, regs);
> +}
> +
> +static const struct dw_mci_drv_data bluefield_drv_data = {
> +       .set_ios                = dw_mci_bluefield_set_ios
> +};
> +
> +static const struct of_device_id dw_mci_bluefield_match[] = {
> +       { .compatible = "mellanox,bluefield-dw-mshc",
> +               .data = &bluefield_drv_data },
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
