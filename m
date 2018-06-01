From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date: Fri, 1 Jun 2018 11:35:17 +0300
Message-ID: <a823deb3-4f94-fa55-fc56-c838a7ab9deb@intel.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B769C@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A9B769C@IN01WEMBXB.internal.synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi

This patch is still corrupt.  Your mail program is converting it to
quoted-printable - try saving and applying it yourself.  I suggest you learn
to use git send-mail.

On 30/05/18 18:07, Prabu Thangamuthu wrote:
> 
> Synopsys has DWC MSHC controller on HPAS-DX platform connected using PCIe
> interface with SD card slot and eMMC device slots. This patch is to
> enable SD cards connected on this platform. As Clock generation logic
> is implemented using MMCM module of HAPS-DX platform, we have separate
> functions to control the MMCM to generate required clocks with respect
> to speed mode.
> 
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> ---
> V2 - Removed sdhci-pci-dwc-mshc.h and moved into sdhci-pci-dwc-mshc.c
> Fixed coding style issue.
> Removed sdhci_snps_set_power and new approach to support eMMC device
> voltages will be submitted after completeing validations.
> V1 - Initial Patch.
> 
> MAINTAINERS | 7 +++
> drivers/mmc/host/Makefile | 3 +-
> drivers/mmc/host/sdhci-pci-core.c | 1 +
> drivers/mmc/host/sdhci-pci-dwc-mshc.c | 88 +++++++++++++++++++++++++++++++++++
> drivers/mmc/host/sdhci-pci.h | 3 ++
> 5 files changed, 101 insertions(+), 1 deletion(-)
> create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4863175..aba98b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12684,6 +12684,13 @@ S: Maintained
> F: drivers/mmc/host/sdhci*
> F: include/linux/mmc/sdhci*
> 
> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
> +M: Prabu Thangamuthu <prabu.t@synopsys.com>
> +M: Manjunath M B <manjumb@synopsys.com>
> +L: linux-mmc@vger.kernel.org
> +S: Maintained
> +F: drivers/mmc/host/sdhci-pci-dwc-mshc.c
> +
> SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
> M: Ben Dooks <ben-linux@fluff.org>
> M: Jaehoon Chung <jh80.chung@samsung.com>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 85dc132..20490f3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC) += mxcmmc.o
> obj-$(CONFIG_MMC_MXS) += mxs-mmc.o
> obj-$(CONFIG_MMC_SDHCI) += sdhci.o
> obj-$(CONFIG_MMC_SDHCI_PCI) += sdhci-pci.o
> -sdhci-pci-y += sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o
> +sdhci-pci-y += sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> + sdhci-pci-dwc-mshc.o
> obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI)) += sdhci-pci-data.o
> obj-$(CONFIG_MMC_SDHCI_ACPI) += sdhci-acpi.o
> obj-$(CONFIG_MMC_SDHCI_PXAV3) += sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 77dd352..ca1d4f7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1511,6 +1511,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
> SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
> SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
> + SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
> SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
> /* Generic SD host controller */
> {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> new file mode 100644
> index 0000000..0706055
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDHCI driver for Synopsys DWC_MSHC controller
> + *
> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors:
> + * Prabu Thangamuthu <prabu.t@synopsys.com>
> + * Manjunath M B <manjumb@synopsys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Do not put license text when using SPDX identifiers

> + */
> +
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +#define SDHCI_VENDOR_PTR_R 0xE8
> +
> +/* Synopsys vendor specific registers */
> +#define SDHC_GPIO_OUT 0x34
> +#define SDHC_AT_CTRL_R 0x40
> +#define SDHC_SW_TUNE_EN 0x00000010
> +
> +/* MMCM DRP */
> +#define SDHC_MMCM_DIV_REG 0x1020
> +#define DIV_REG_100_MHZ 0x1145
> +#define DIV_REG_200_MHZ 0x1083
> +#define SDHC_MMCM_CLKFBOUT 0x1024
> +#define CLKFBOUT_100_MHZ 0x0000
> +#define CLKFBOUT_200_MHZ 0x0080
> +#define SDHC_CCLK_MMCM_RST 0x00000001
> +
> +static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> + u16 clk;
> + u32 reg, vendor_ptr;
> +
> + vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +
> + /* Disable software managed rx tuning */
> + reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
> + reg &= ~SDHC_SW_TUNE_EN;
> + sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
> +
> + if (clock <= 52000000) {
> + sdhci_set_clock(host, clock);
> + } else {
> + /* Assert reset to MMCM */
> + reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> + reg |= SDHC_CCLK_MMCM_RST;
> + sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> + /* Configure MMCM */
> + if (clock == 100000000) {
> + sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
> + sdhci_writel(host, CLKFBOUT_100_MHZ,
> + SDHC_MMCM_CLKFBOUT);
> + } else {
> + sdhci_writel(host, DIV_REG_200_MHZ, SDHC_MMCM_DIV_REG);
> + sdhci_writel(host, CLKFBOUT_200_MHZ,
> + SDHC_MMCM_CLKFBOUT);
> + }
> +
> + /* De-assert reset to MMCM */
> + reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> + reg &= ~SDHC_CCLK_MMCM_RST;
> + sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> + /* Enable clock */
> + clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
> + SDHCI_CLOCK_CARD_EN;
> + sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> + }
> +}
> +
> +static const struct sdhci_ops sdhci_snps_ops = {
> + .set_clock = sdhci_snps_set_clock,
> + .enable_dma = sdhci_pci_enable_dma,
> + .set_bus_width = sdhci_set_bus_width,
> + .reset = sdhci_reset,
> + .set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_snps = {
> + .ops = &sdhci_snps_ops,
> +};
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index db9cb54..60131b8 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -59,6 +59,8 @@
> #define PCI_VENDOR_ID_ARASAN 0x16e6
> #define PCI_DEVICE_ID_ARASAN_PHY_EMMC 0x0670
> 
> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
> +
> /*
> * PCI device class and mask
> */
> @@ -182,5 +184,6 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
> #endif
> 
> extern const struct sdhci_pci_fixes sdhci_arasan;
> +extern const struct sdhci_pci_fixes sdhci_snps;
> 
> #endif /* __SDHCI_PCI_H */
> 
