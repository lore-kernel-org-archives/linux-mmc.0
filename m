From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc
 support
Date: Fri, 1 Jun 2018 11:20:09 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9B94BD@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B769C@IN01WEMBXB.internal.synopsys.com>
 <a823deb3-4f94-fa55-fc56-c838a7ab9deb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,=0A=
=0A=
On 6/1/2018 2:06 PM, Adrian Hunter wrote:=0A=
> Hi=0A=
>=0A=
> This patch is still corrupt.  Your mail program is converting it to=0A=
> quoted-printable - try saving and applying it yourself.  I suggest you le=
arn=0A=
> to use git send-mail.=0A=
I was using Thunderbird (GUI) with configuration mentioned as per=0A=
https://www.kernel.org/doc/html/v4.10/process/email-clients.html.=0A=
Not sure what went wrong in my configuration. Sorry for that.=0A=
=0A=
I will re-send the patch with git send-mail.=0A=
=0A=
Thanks,=0A=
Prabu=0A=
=0A=
> On 30/05/18 18:07, Prabu Thangamuthu wrote:=0A=
>> Synopsys has DWC MSHC controller on HPAS-DX platform connected using PCI=
e=0A=
>> interface with SD card slot and eMMC device slots. This patch is to=0A=
>> enable SD cards connected on this platform. As Clock generation logic=0A=
>> is implemented using MMCM module of HAPS-DX platform, we have separate=
=0A=
>> functions to control the MMCM to generate required clocks with respect=
=0A=
>> to speed mode.=0A=
>>=0A=
>> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
>> ---=0A=
>> V2 - Removed sdhci-pci-dwc-mshc.h and moved into sdhci-pci-dwc-mshc.c=0A=
>> Fixed coding style issue.=0A=
>> Removed sdhci_snps_set_power and new approach to support eMMC device=0A=
>> voltages will be submitted after completeing validations.=0A=
>> V1 - Initial Patch.=0A=
>>=0A=
>> MAINTAINERS | 7 +++=0A=
>> drivers/mmc/host/Makefile | 3 +-=0A=
>> drivers/mmc/host/sdhci-pci-core.c | 1 +=0A=
>> drivers/mmc/host/sdhci-pci-dwc-mshc.c | 88 +++++++++++++++++++++++++++++=
++++++=0A=
>> drivers/mmc/host/sdhci-pci.h | 3 ++=0A=
>> 5 files changed, 101 insertions(+), 1 deletion(-)=0A=
>> create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
>>=0A=
>> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>> index 4863175..aba98b6 100644=0A=
>> --- a/MAINTAINERS=0A=
>> +++ b/MAINTAINERS=0A=
>> @@ -12684,6 +12684,13 @@ S: Maintained=0A=
>> F: drivers/mmc/host/sdhci*=0A=
>> F: include/linux/mmc/sdhci*=0A=
>>=0A=
>> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER=0A=
>> +M: Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
>> +M: Manjunath M B <manjumb@synopsys.com>=0A=
>> +L: linux-mmc@vger.kernel.org=0A=
>> +S: Maintained=0A=
>> +F: drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
>> +=0A=
>> SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER=0A=
>> M: Ben Dooks <ben-linux@fluff.org>=0A=
>> M: Jaehoon Chung <jh80.chung@samsung.com>=0A=
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile=0A=
>> index 85dc132..20490f3 100644=0A=
>> --- a/drivers/mmc/host/Makefile=0A=
>> +++ b/drivers/mmc/host/Makefile=0A=
>> @@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC) +=3D mxcmmc.o=0A=
>> obj-$(CONFIG_MMC_MXS) +=3D mxs-mmc.o=0A=
>> obj-$(CONFIG_MMC_SDHCI) +=3D sdhci.o=0A=
>> obj-$(CONFIG_MMC_SDHCI_PCI) +=3D sdhci-pci.o=0A=
>> -sdhci-pci-y +=3D sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.=
o=0A=
>> +sdhci-pci-y +=3D sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.=
o \=0A=
>> + sdhci-pci-dwc-mshc.o=0A=
>> obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI)) +=3D sdhci-pci-data.o=0A=
>> obj-$(CONFIG_MMC_SDHCI_ACPI) +=3D sdhci-acpi.o=0A=
>> obj-$(CONFIG_MMC_SDHCI_PXAV3) +=3D sdhci-pxav3.o=0A=
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-=
pci-core.c=0A=
>> index 77dd352..ca1d4f7 100644=0A=
>> --- a/drivers/mmc/host/sdhci-pci-core.c=0A=
>> +++ b/drivers/mmc/host/sdhci-pci-core.c=0A=
>> @@ -1511,6 +1511,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)=
=0A=
>> SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),=0A=
>> SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),=0A=
>> SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),=0A=
>> + SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),=0A=
>> SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),=0A=
>> /* Generic SD host controller */=0A=
>> {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},=0A=
>> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c b/drivers/mmc/host/sd=
hci-pci-dwc-mshc.c=0A=
>> new file mode 100644=0A=
>> index 0000000..0706055=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
>> @@ -0,0 +1,88 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * SDHCI driver for Synopsys DWC_MSHC controller=0A=
>> + *=0A=
>> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)=0A=
>> + *=0A=
>> + * Authors:=0A=
>> + * Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
>> + * Manjunath M B <manjumb@synopsys.com>=0A=
>> + *=0A=
>> + * This program is free software; you can redistribute it and/or modify=
=0A=
>> + * it under the terms of the GNU General Public License version 2 as=0A=
>> + * published by the Free Software Foundation.=0A=
> Do not put license text when using SPDX identifiers=0A=
>=0A=
>> + */=0A=
>> +=0A=
>> +#include "sdhci.h"=0A=
>> +#include "sdhci-pci.h"=0A=
>> +=0A=
>> +#define SDHCI_VENDOR_PTR_R 0xE8=0A=
>> +=0A=
>> +/* Synopsys vendor specific registers */=0A=
>> +#define SDHC_GPIO_OUT 0x34=0A=
>> +#define SDHC_AT_CTRL_R 0x40=0A=
>> +#define SDHC_SW_TUNE_EN 0x00000010=0A=
>> +=0A=
>> +/* MMCM DRP */=0A=
>> +#define SDHC_MMCM_DIV_REG 0x1020=0A=
>> +#define DIV_REG_100_MHZ 0x1145=0A=
>> +#define DIV_REG_200_MHZ 0x1083=0A=
>> +#define SDHC_MMCM_CLKFBOUT 0x1024=0A=
>> +#define CLKFBOUT_100_MHZ 0x0000=0A=
>> +#define CLKFBOUT_200_MHZ 0x0080=0A=
>> +#define SDHC_CCLK_MMCM_RST 0x00000001=0A=
>> +=0A=
>> +static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int =
clock)=0A=
>> +{=0A=
>> + u16 clk;=0A=
>> + u32 reg, vendor_ptr;=0A=
>> +=0A=
>> + vendor_ptr =3D sdhci_readw(host, SDHCI_VENDOR_PTR_R);=0A=
>> +=0A=
>> + /* Disable software managed rx tuning */=0A=
>> + reg =3D sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));=0A=
>> + reg &=3D ~SDHC_SW_TUNE_EN;=0A=
>> + sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));=0A=
>> +=0A=
>> + if (clock <=3D 52000000) {=0A=
>> + sdhci_set_clock(host, clock);=0A=
>> + } else {=0A=
>> + /* Assert reset to MMCM */=0A=
>> + reg =3D sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));=0A=
>> + reg |=3D SDHC_CCLK_MMCM_RST;=0A=
>> + sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));=0A=
>> +=0A=
>> + /* Configure MMCM */=0A=
>> + if (clock =3D=3D 100000000) {=0A=
>> + sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);=0A=
>> + sdhci_writel(host, CLKFBOUT_100_MHZ,=0A=
>> + SDHC_MMCM_CLKFBOUT);=0A=
>> + } else {=0A=
>> + sdhci_writel(host, DIV_REG_200_MHZ, SDHC_MMCM_DIV_REG);=0A=
>> + sdhci_writel(host, CLKFBOUT_200_MHZ,=0A=
>> + SDHC_MMCM_CLKFBOUT);=0A=
>> + }=0A=
>> +=0A=
>> + /* De-assert reset to MMCM */=0A=
>> + reg =3D sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));=0A=
>> + reg &=3D ~SDHC_CCLK_MMCM_RST;=0A=
>> + sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));=0A=
>> +=0A=
>> + /* Enable clock */=0A=
>> + clk =3D SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |=0A=
>> + SDHCI_CLOCK_CARD_EN;=0A=
>> + sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);=0A=
>> + }=0A=
>> +}=0A=
>> +=0A=
>> +static const struct sdhci_ops sdhci_snps_ops =3D {=0A=
>> + .set_clock =3D sdhci_snps_set_clock,=0A=
>> + .enable_dma =3D sdhci_pci_enable_dma,=0A=
>> + .set_bus_width =3D sdhci_set_bus_width,=0A=
>> + .reset =3D sdhci_reset,=0A=
>> + .set_uhs_signaling =3D sdhci_set_uhs_signaling,=0A=
>> +};=0A=
>> +=0A=
>> +const struct sdhci_pci_fixes sdhci_snps =3D {=0A=
>> + .ops =3D &sdhci_snps_ops,=0A=
>> +};=0A=
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h=
=0A=
>> index db9cb54..60131b8 100644=0A=
>> --- a/drivers/mmc/host/sdhci-pci.h=0A=
>> +++ b/drivers/mmc/host/sdhci-pci.h=0A=
>> @@ -59,6 +59,8 @@=0A=
>> #define PCI_VENDOR_ID_ARASAN 0x16e6=0A=
>> #define PCI_DEVICE_ID_ARASAN_PHY_EMMC 0x0670=0A=
>>=0A=
>> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202=0A=
>> +=0A=
>> /*=0A=
>> * PCI device class and mask=0A=
>> */=0A=
>> @@ -182,5 +184,6 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_=
slot *slot)=0A=
>> #endif=0A=
>>=0A=
>> extern const struct sdhci_pci_fixes sdhci_arasan;=0A=
>> +extern const struct sdhci_pci_fixes sdhci_snps;=0A=
>>=0A=
>> #endif /* __SDHCI_PCI_H */=0A=
>>=0A=
>=0A=
=0A=
