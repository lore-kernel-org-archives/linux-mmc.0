From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date: Thu, 24 May 2018 11:35:07 +0300
Message-ID: <abe62da4-3ef9-5660-94e1-a3f919df06cd@intel.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi

This patch is mangled.

On 22/05/18 09:42, Prabu Thangamuthu wrote:
> To enable Synopsys DWC MSHC controller on HPAS-DX platform connected using
> PCIe interface. As Clock generation logic is implemented in MMCM module of
> HAPS-DX platform, we have separate functions to control the MMCM to
> generate required clocks with respect to speed mode. Also we have platform
> specific set_power function to support different VDD of eMMC devices.
> 
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> ---
>  MAINTAINERS                           |   7 ++
>  drivers/mmc/host/Makefile             |   3 +-
>  drivers/mmc/host/sdhci-pci-core.c     |   1 +
>  drivers/mmc/host/sdhci-pci-dwc-mshc.c | 146
> ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci-dwc-mshc.h |  37 +++++++++
>  drivers/mmc/host/sdhci-pci.h          |   3 +
>  6 files changed, 196 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
>  create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9051a9c..f1749c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12643,6 +12643,13 @@ S:    Maintained
>  F:    drivers/mmc/host/sdhci*
>  F:    include/linux/mmc/sdhci*
>  
> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
> +M:    Prabu Thangamuthu <prabu.t@synopsys.com>
> +M:    Manjunath M B <manjumb@synopsys.com>
> +L:    linux-mmc@vger.kernel.org
> +S:    Maintained
> +F:    drivers/mmc/host/sdhci-pci-dwc-mshc*
> +
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>  M:    Ben Dooks <ben-linux@fluff.org>
>  M:    Jaehoon Chung <jh80.chung@samsung.com>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6aead24..6c0d3fb 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC)        += mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)        += mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)        += sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)    += sdhci-pci.o
> -sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o
> sdhci-pci-arasan.o
> +sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o
> sdhci-pci-arasan.o \
> +                   sdhci-pci-dwc-mshc.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))    += sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)    += sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)    += sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c
> b/drivers/mmc/host/sdhci-pci-core.c
> index 77dd352..96b6963 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1511,6 +1511,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>      SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>      SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>      SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
> +    SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC,  snps),
>      SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>      /* Generic SD host controller */
>      {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> new file mode 100644
> index 0000000..bca3db4
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDHCI driver for Synopsys DWC_MSHC controller
> + *
> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors:
> + *    Prabu Thangamuthu <prabu.t@synopsys.com>
> + *    Manjunath M B <manjumb@synopsys.com>
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +#include "sdhci-pci-dwc-mshc.h"
> +
> +/* Default emmc vdd is set to 3.3V */
> +static unsigned int emmc_vdd = SDHC_EMMC_VDD_330V;
> +module_param(emmc_vdd, int, 0444);

Why a module parameter?

> +
> +static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int
> clock)
> +{
> +    u16 clk = 0;
> +    u32 reg = 0;
> +    u32 vendor_ptr = 0;
> +
> +    vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +
> +    /* Disable Software managed rx tuning */
> +    reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
> +    reg &= ~SDHC_SW_TUNE_EN;
> +    sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
> +
> +    if (clock <= 52000000) {
> +        sdhci_set_clock(host, clock);
> +    } else {
> +        /* Assert reset to MMCM */
> +        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +        reg |= SDHC_CCLK_MMCM_RST;
> +        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +        /* Configure MMCM*/

Space between MMCM and *

> +        sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
> +        sdhci_writel(host, CLKFBOUT_100_MHZ,
> +                SDHC_MMCM_CLKFBOUT);
> +
> +        /* De-assert reset to MMCM*/

Space between MMCM and *


> +        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +        reg &= ~SDHC_CCLK_MMCM_RST;
> +        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +        /* Enable clock */
> +        clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
> +            SDHCI_CLOCK_CARD_EN;
> +        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +    }
> +}
> +
> +static void sdhci_snps_set_power(struct sdhci_host *host, unsigned char
> mode,
> +             unsigned short vdd)
> +{
> +    u8 pwr = 0;
> +    u16 ctrl;
> +
> +    if (mode != MMC_POWER_OFF) {
> +        switch (1 << vdd) {
> +        case MMC_VDD_165_195:
> +            pwr = SDHCI_POWER_180;
> +            break;
> +        case MMC_VDD_29_30:
> +        case MMC_VDD_30_31:
> +            pwr = SDHCI_POWER_300;
> +            break;
> +        case MMC_VDD_32_33:
> +        case MMC_VDD_33_34:
> +            pwr = SDHCI_POWER_330;
> +            break;
> +        default:
> +            WARN(1, "%s: Invalid vdd %#x\n",
> +                 mmc_hostname(host->mmc), vdd);
> +            break;
> +        }
> +    }
> +
> +    if (host->pwr == pwr)
> +        return;
> +
> +    host->pwr = pwr;
> +
> +    if (pwr == 0) {
> +        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +    } else {
> +        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +        /*
> +         * Enable it for eMMC phy cfg1 test with 1.8V mode
> +         */
> +        if (emmc_vdd == SDHC_EMMC_VDD_180V) {
> +            pwr = SDHCI_POWER_180;
> +            sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +
> +            ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +            /*
> +             * Enable 1.8V Signal Enable in the Host Control2
> +             * register
> +             */
> +            ctrl |= SDHCI_CTRL_VDD_180;
> +            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +        }
> +        pwr |= SDHCI_POWER_ON;
> +
> +        sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +    }
> +}
> +
> +static int sdhci_snps_pci_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +    struct sdhci_host *host = slot->host;
> +
> +    host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +    host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);

Why read caps here?

> +
> +    return 0;
> +}
> +
> +/* Synopsys DWC MSHC Controller based on SDHCI-PCI */
> +static const struct sdhci_ops sdhci_snps_ops = {
> +    .set_clock    = sdhci_snps_set_clock,
> +    .set_power    = sdhci_snps_set_power,
> +    .enable_dma    = sdhci_pci_enable_dma,
> +    .set_bus_width    = sdhci_set_bus_width,
> +    .reset        = sdhci_reset,
> +    .set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_snps = {
> +    .probe_slot    = sdhci_snps_pci_probe_slot,
> +    .ops        = &sdhci_snps_ops,
> +};
> +
> +MODULE_PARM_DESC(emmc_vdd, "VDD to configure eMMC device supply voltage");
> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.h
> b/drivers/mmc/host/sdhci-pci-dwc-mshc.h
> new file mode 100644
> index 0000000..352bbfd
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.h

Please put the definitions into sdhci-pci-dwc-mshc.c and then this file is
not needed.

> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SDHCI driver for Synopsys DWC_MSHC controller
> + *
> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors:
> + *    Prabu Thangamuthu <prabu.t@synopsys.com>
> + *    Manjunath M B <manjumb@synopsys.com>
> + *
> + */
> +
> +#ifndef __SDHCI_PCI_DWC_MSHC_H__
> +#define __SDHCI_PCI_DWC_MSHC_H__
> +
> +#define SDHCI_VENDOR_PTR_R               0xE8
> +
> +/* Module Parameters */
> +#define SDHC_EMMC_VDD_330V               33
> +#define SDHC_EMMC_VDD_180V               18
> +
> +/* Synopsys Vendor Specific Registers */
> +#define SDHC_GPIO_OUT                          0x34
> +#define SDHC_AT_CTRL_R                   0x40
> +
> +#define SDHC_SW_TUNE_EN                   0x00000010
> +
> +/* MMCM DRP */
> +#define SDHC_MMCM_DIV_REG               0x1020
> +#define DIV_REG_100_MHZ                   0x1145
> +
> +#define SDHC_MMCM_CLKFBOUT               0x1024
> +#define CLKFBOUT_100_MHZ               0x0000
> +
> +#define SDHC_CCLK_MMCM_RST               0x00000001
> +
> +#endif
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index db9cb54..c91dcec 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -59,6 +59,7 @@
>  #define PCI_VENDOR_ID_ARASAN        0x16e6
>  #define PCI_DEVICE_ID_ARASAN_PHY_EMMC    0x0670
>  
> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xC202
>  /*
>   * PCI device class and mask
>   */
> @@ -183,4 +184,6 @@ static inline void *sdhci_pci_priv(struct
> sdhci_pci_slot *slot)
>  
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  
> +extern const struct sdhci_pci_fixes sdhci_snps;
> +
>  #endif /* __SDHCI_PCI_H */
> 
