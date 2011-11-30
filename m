From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v3 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 15:31:16 +0530
Message-ID: <CANYdXnqB6DhFd6Sd72OE+YZ5tpEnkN3a68vZKBLXSn9FyHUaPA@mail.gmail.com>
References: <1322591437-4494-1-git-send-email-shashidharh@vayavyalabs.com>
	<20111129212633.GB26823@balrog>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54774 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1K3KBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 05:01:18 -0500
Received: by ywa9 with SMTP id 9so423241ywa.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 02:01:17 -0800 (PST)
In-Reply-To: <20111129212633.GB26823@balrog>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi James,
  thanks for the reply.

On Wed, Nov 30, 2011 at 2:56 AM, James Hogan <james@albanarts.com> wrot=
e:
> Hi,
>
> Thanks for the update. It's better, but there's still a few issues...
>
> On Wed, Nov 30, 2011 at 12:00:37AM +0530, Shashidhar Hiremath wrote:
>> Support of PCI mode for the dw_mmc driver This Patch adds the suppor=
t for the scenario where the Synopsys Designware IP is present on the P=
CI bus.The patch adds the minimal modifications necessary for the drive=
r to work on PCI platform.Also added separate files for PCI and PLATFOR=
M modes of operation
>
> Being picky, but full stop at end of sentences, and a space between
> sentences would be nice. Wrapping to 72 characters is nice too. :)
>
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> v2:
>> *As per Suggestions by Will Newton and James Hogan
>> -Reduced the number of ifdefs
>> v3:
>> *As per Suggestions by Will Newton and James Hogan
>> -Added separate files for PCI and PLATFORM Modes similar to SDHCI dr=
iver
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2=
3 ++++++
>> =C2=A0drivers/mmc/host/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
2 +
>> =C2=A0drivers/mmc/host/dw_mmc-pci.c =C2=A0 | =C2=A0159 +++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc-pltfm.c | =C2=A0125 ++++++++++++++++++=
++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0155 +++=
+++++++++++------------------------
>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
7 ++
>> =C2=A0include/linux/mmc/dw_mmc.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
4 +-
>> =C2=A07 files changed, 374 insertions(+), 101 deletions(-)
>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 87d5067..6735fbe 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -534,6 +534,29 @@ config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Designware Mobile Storage IP block. This=
 disables the external DMA
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface.
>>
>> +config MMC_DW_PCI
>> + =C2=A0 =C2=A0 tristate "Synopsys Designware MCI support on PCI bus=
"
>> + =C2=A0 =C2=A0 depends on MMC_DW && PCI
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 This selects the PCI bus for the Synopsys Des=
ignware Mobile Storage IP.
>> + =C2=A0 =C2=A0 =C2=A0 Select this option if the IP is present on PC=
I platform.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interface,=
 say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> +config MMC_DW_PLTFM
>> + =C2=A0 =C2=A0 tristate "platform driver helper for Synopsys Design=
ware Mobile Storage IP"
>> + =C2=A0 =C2=A0 depends on MMC_DW
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 This selects the common helper functions supp=
ort for Host Controller
>> + =C2=A0 =C2=A0 =C2=A0 Interface based platform driver.Please select=
 this option if the IP
>> + =C2=A0 =C2=A0 =C2=A0 is present as a platform device.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interface,=
 say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> =C2=A0config MMC_SH_MMCIF
>> =C2=A0 =C2=A0 =C2=A0 tristate "SuperH Internal MMCIF support"
>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBIL=
E)
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index b4b83f3..3aa2fa3 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -38,6 +38,8 @@ obj-$(CONFIG_MMC_CB710) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +=3D cb710-mmc.o
>> =C2=A0obj-$(CONFIG_MMC_VIA_SDMMC) =C2=A0+=3D via-sdmmc.o
>> =C2=A0obj-$(CONFIG_SDH_BFIN) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D bfin_sdh.o
>> =C2=A0obj-$(CONFIG_MMC_DW) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D dw_mmc.o
>> +obj-$(CONFIG_MMC_DW_PLTFM) =C2=A0 +=3D dw_mmc-pltfm.o
>> +obj-$(CONFIG_MMC_DW_PCI) =C2=A0 =C2=A0 +=3D dw_mmc-pci.o
>> =C2=A0obj-$(CONFIG_MMC_SH_MMCIF) =C2=A0 +=3D sh_mmcif.o
>> =C2=A0obj-$(CONFIG_MMC_JZ4740) =C2=A0 =C2=A0 +=3D jz4740_mmc.o
>> =C2=A0obj-$(CONFIG_MMC_VUB300) =C2=A0 =C2=A0 +=3D vub300.o
>> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc=
-pci.c
>> new file mode 100644
>> index 0000000..7d8fb5e
>> --- /dev/null
>> +++ b/drivers/mmc/host/dw_mmc-pci.c
>> @@ -0,0 +1,159 @@
>> +/*
>> + * Synopsys DesignWare Multimedia Card PCI Interface driver
>> + *
>> + * Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/pci.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/mmc.h>
>> +#include <linux/mmc/dw_mmc.h>
>> +#include "dw_mmc.h"
>> +
>> +#define PCI_BAR_NO 2
>> +#define COMPLETE_BAR 0
>> +#define DW_MCI_VENDOR_ID 0x700
>> +#define DW_MCI_DEVICE_ID 0x1107
>> +/* Defining the Capabilities */
>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHS=
PEED |\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DA=
TA |\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SDIO_IRQ)
>> +
>> +static struct dw_mci_board pci_board_data =3D {
>> + =C2=A0 =C2=A0 .num_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> + =C2=A0 =C2=A0 .caps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D DW_MCI_CAPABILITIES,
>> + =C2=A0 =C2=A0 .bus_hz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 33 * 1000 * 1000,
>> + =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D 200,
>> + =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
>> +};
>> +
>> +static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *entr=
ies)
>> +{
>> + =C2=A0 =C2=A0 struct =C2=A0dw_mci *host;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 ret;
>> +
>> + =C2=A0 =C2=A0 ret =3D pci_enable_device(pdev);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 if (pci_request_regions(pdev, "dw_mmc_pci")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>
> This will kfree the as yet uninitialised host.
>
> Should this (and later error handlers) also undo the effects of
> pci_enable_device with pci_disable_device?
>
Yes , Will make the change
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!host)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> +
>> + =C2=A0 =C2=A0 host->irq =3D pdev->irq;
>> + =C2=A0 =C2=A0 host->dev =3D pdev->dev;
>> + =C2=A0 =C2=A0 host->pdata =3D &pci_board_data;
>> +
>> + =C2=A0 =C2=A0 ret =3D -ENOMEM;
>
> what's this for?
>
This has somehow creeped from the old code.Will clean it up.
>> + =C2=A0 =C2=A0 host->regs =3D pci_iomap(pdev, PCI_BAR_NO, COMPLETE_=
BAR);
>> + =C2=A0 =C2=A0 if (!host->regs) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_release_regions(pdev=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EIO;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 }
>> +
>> +
>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, host);
>> + =C2=A0 =C2=A0 ret =3D dw_mci_probe(host);
>> + =C2=A0 =C2=A0 if (ret)
>> +err_freehost:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(host);
>
> pci_iounmap?
>
will add this.
>> + =C2=A0 =C2=A0 return ret;
>
> Since there are several things that need cleaning up on failure, it
> should really have the error handling labels after the return like a =
lot
> of other kernel drivers do (e.g. see ioapic_probe() in
> drivers/pci/ioapic.c). This makes the code a lot neater and easier to
> read.
>
>> +}
>> +
>> +
>> +
>> +
>> +static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
>> +{
>> +
>
> no need for a newline here
>
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mmc int=
errupt first */
>> +
>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, NULL);
>> + =C2=A0 =C2=A0 dw_mci_remove(host);
>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
>> + =C2=A0 =C2=A0 kfree(host);
>
> should this also be pci_iounmap'ing, and pci_disable_device'ing?
>
Yes, will make the change.
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int dw_mci_pci_suspend(struct pci_dev *pdev, pm_message_t me=
sg)
>> +{
>> + =C2=A0 =C2=A0 int =C2=A0ret;
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 ret =3D dw_mci_suspend(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +/*
>> + * TODO: we should probably disable the clock to the card in the su=
spend path.
>> + */
>> +
>> +
>> +static int dw_mci_pci_resume(struct pci_dev *pdev)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 ret =3D dw_mci_resume(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +#else
>> +#define dw_mci_pci_suspend =C2=A0 NULL
>> +#define dw_mci_pci_resume =C2=A0 =C2=A0NULL
>> +#endif /* CONFIG_PM */
>> +
>> +static DEFINE_PCI_DEVICE_TABLE(dw_mci_pci_id) =3D {
>> + =C2=A0 =C2=A0 { PCI_DEVICE(DW_MCI_DEVICE_ID, DW_MCI_VENDOR_ID) },
>> + =C2=A0 =C2=A0 {}
>> +};
>> +MODULE_DEVICE_TABLE(pci, dw_mci_pci_id);
>> +
>> +static struct pci_driver dw_mci_pci_driver =3D {
>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc=
_pci",
>> + =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_pci_id,
>> + =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
pci_probe,
>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_pci_r=
emove,
>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_pci_s=
uspend,
>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_pci_r=
esume,
>> +};
>> +
>> +static int __init dw_mci_init(void)
>> +{
>> + =C2=A0 =C2=A0 return pci_register_driver(&dw_mci_pci_driver);
>> +}
>> +
>> +static void __exit dw_mci_exit(void)
>> +{
>> + =C2=A0 =C2=A0 pci_unregister_driver(&dw_mci_pci_driver);
>> +}
>> +
>> +module_init(dw_mci_init);
>> +module_exit(dw_mci_exit);
>> +
>> +MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
>> +MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.com>");
>> +MODULE_AUTHOR("VayavyaLabs Pvt. Ltd.");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_m=
mc-pltfm.c
>> new file mode 100644
>> index 0000000..0c6a95df
>> --- /dev/null
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -0,0 +1,125 @@
>> +/*
>> + * Synopsys DesignWare Multimedia Card Interface driver
>> + *
>> + * Copyright (C) 2009 NXP Semiconductors
>> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/mmc.h>
>> +#include <linux/mmc/dw_mmc.h>
>> +#include "dw_mmc.h"
>> +
>> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 struct dw_mci *host;
>> + =C2=A0 =C2=A0 struct resource *regs;
>> + =C2=A0 =C2=A0 int =C2=A0ret;
>
> no need for the extra space before ret.
>
>> +
>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!host)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> +
>> + =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
>> + =C2=A0 =C2=A0 if (!regs)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
>> +
>> + =C2=A0 =C2=A0 host->irq =3D platform_get_irq(pdev, 0);
>> + =C2=A0 =C2=A0 if (host->irq < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return host->irq;
>> +
>> + =C2=A0 =C2=A0 host->dev =3D pdev->dev;
>> + =C2=A0 =C2=A0 host->pdata =3D pdev->dev.platform_data;
>> + =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_size(re=
gs));
>> + =C2=A0 =C2=A0 if (!host->regs)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>> + =C2=A0 =C2=A0 ret =3D dw_mci_probe(host);
>> + =C2=A0 =C2=A0 if (ret)
>> +err_freehost:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(host);
>> + =C2=A0 =C2=A0 return ret;
>
> same stuff again, please fix the error handling.
>
will do the change.
>> +}
>> +
>> +static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mmc int=
errupt first */
>> +
>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
>> + =C2=A0 =C2=A0 dw_mci_remove(host);
>> + =C2=A0 =C2=A0 kfree(host);
>
> iounmap (see below)?
>
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +#ifdef CONFIG_PM
>> +/*
>> + * TODO: we should probably disable the clock to the card in the su=
spend path.
>> + */
>> +static int dw_mci_pltfm_suspend(struct platform_device *pdev, pm_me=
ssage_t mesg)
>> +{
>> +
>> + =C2=A0 =C2=A0 int =C2=A0ret;
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 ret =3D dw_mci_suspend(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int dw_mci_pltfm_resume(struct platform_device *pdev)
>> +{
>> +
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 ret =3D dw_mci_resume(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +#else
>> +#define dw_mci_pltfm_suspend NULL
>> +#define dw_mci_pltfm_resume =C2=A0NULL
>> +#endif /* CONFIG_PM */
>> +
>> +static struct platform_driver dw_mci_pltfm_driver =3D {
>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_p(dw_=
mci_pltfm_remove),
>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_pltfm=
_suspend,
>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_pltfm=
_resume,
>> + =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =3D "dw_mmc",
>> + =C2=A0 =C2=A0 },
>> +};
>> +
>> +static int __init dw_mci_init(void)
>> +{
>> + =C2=A0 =C2=A0 return platform_driver_probe(&dw_mci_pltfm_driver, d=
w_mci_pltfm_probe);
>> +}
>> +
>> +static void __exit dw_mci_exit(void)
>> +{
>> + =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_pltfm_driver);
>> +}
>> +
>> +module_init(dw_mci_init);
>> +module_exit(dw_mci_exit);
>> +
>> +MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>> +MODULE_AUTHOR("NXP Semiconductor VietNam");
>> +MODULE_AUTHOR("Imagination Technologies Ltd");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3aaeb08..7d33626 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -269,7 +269,7 @@ static void dw_mci_start_command(struct dw_mci *=
host,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_command *cmd, u32 =
cmd_flags)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 host->cmd =3D cmd;
>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev,
>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"start comman=
d: ARGR=3D0x%08x CMDR=3D0x%08x\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd->arg, cmd=
_flags);
>>
>> @@ -302,7 +302,7 @@ static void dw_mci_dma_cleanup(struct dw_mci *ho=
st)
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_data *data =3D host->data;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (data)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_unmap_sg(&host->pdev=
->dev, data->sg, data->sg_len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_unmap_sg(&host->dev,=
 data->sg, data->sg_len,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0((data->flags & MMC_DATA_WRITE)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
>> =C2=A0}
>> @@ -327,7 +327,7 @@ static void dw_mci_idmac_complete_dma(struct dw_=
mci *host)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_data *data =3D host->data;
>>
>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev, "DMA complete\n");
>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev, "DMA complete\n");
>>
>> =C2=A0 =C2=A0 =C2=A0 host->dma_ops->cleanup(host);
>>
>> @@ -463,10 +463,10 @@ static int dw_mci_submit_data_dma(struct dw_mc=
i *host, struct mmc_data *data)
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction =3D DMA_T=
O_DEVICE;
>>
>> - =C2=A0 =C2=A0 sg_len =3D dma_map_sg(&host->pdev->dev, data->sg, da=
ta->sg_len,
>> + =C2=A0 =C2=A0 sg_len =3D dma_map_sg(&host->dev, data->sg, data->sg=
_len,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 direction);
>>
>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev,
>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"sd sg_cpu: %=
#lx sg_dma: %#lx sg_len: %d\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned lon=
g)host->sg_cpu, (unsigned long)host->sg_dma,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_len);
>> @@ -716,6 +716,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>> =C2=A0 =C2=A0 =C2=A0 switch (ios->power_mode) {
>> =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_UP:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(DW_MMC_CARD=
_NEED_INIT, &slot->flags);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host, P=
WREN, (0x1 << (slot->id)));
>
> Was this something that the original driver should have been doing? (=
it
> might be best as a separate patch if so).
>
Yes, I will submit another patch on this.
> Does it need to be undone somewhere?
>
> Won't it unintentionally power down all other slots by writing 0 to
> them?
>
> Do you "wait for regulator/switch ramp-up time before trying to
> initialize card" (quoting TRM) or is that handled by other code?
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 default:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> @@ -804,12 +805,12 @@ static void dw_mci_request_end(struct dw_mci *=
host, struct mmc_request *mrq)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot =3D list_entry=
(host->queue.next,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot, queue_no=
de);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&slot->que=
ue_node);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->pdev->de=
v, "list not empty: %s is next\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->dev, "li=
st not empty: %s is next\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mmc_hostname(slot->mmc));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->state =3D STA=
TE_SENDING_CMD;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_mci_start_reques=
t(host, slot);
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->pdev->de=
v, "list empty\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->dev, "li=
st empty\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->state =3D STA=
TE_IDLE;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> @@ -941,7 +942,7 @@ static void dw_mci_tasklet_func(unsigned long pr=
iv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data->b=
ytes_xfered =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data->e=
rror =3D -ETIMEDOUT;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&ho=
st->pdev->dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&ho=
st->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 "data FIFO error "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 "(status=3D%08x)\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 status);
>> @@ -1651,7 +1652,7 @@ static int __init dw_mci_init_slot(struct dw_m=
ci *host, unsigned int id)
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_host *mmc;
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *slot;
>>
>> - =C2=A0 =C2=A0 mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slot), &=
host->pdev->dev);
>> + =C2=A0 =C2=A0 mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slot), &=
host->dev);
>> =C2=A0 =C2=A0 =C2=A0 if (!mmc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>>
>> @@ -1757,10 +1758,10 @@ static void dw_mci_cleanup_slot(struct dw_mc=
i_slot *slot, unsigned int id)
>> =C2=A0static void dw_mci_init_dma(struct dw_mci *host)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 /* Alloc memory for sg translation */
>> - =C2=A0 =C2=A0 host->sg_cpu =3D dma_alloc_coherent(&host->pdev->dev=
, PAGE_SIZE,
>> + =C2=A0 =C2=A0 host->sg_cpu =3D dma_alloc_coherent(&host->dev, PAGE=
_SIZE,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&host->sg_dma, GFP_KERNEL);
>> =C2=A0 =C2=A0 =C2=A0 if (!host->sg_cpu) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->pdev->dev=
, "%s: could not alloc DMA memory\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev, "%s:=
 could not alloc DMA memory\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_dma;
>> =C2=A0 =C2=A0 =C2=A0 }
>> @@ -1768,7 +1769,7 @@ static void dw_mci_init_dma(struct dw_mci *hos=
t)
>> =C2=A0 =C2=A0 =C2=A0 /* Determine which DMA interface to use */
>> =C2=A0#ifdef CONFIG_MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 host->dma_ops =3D &dw_mci_idmac_ops;
>> - =C2=A0 =C2=A0 dev_info(&host->pdev->dev, "Using internal DMA contr=
oller.\n");
>> + =C2=A0 =C2=A0 dev_info(&host->dev, "Using internal DMA controller.=
\n");
>> =C2=A0#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!host->dma_ops)
>> @@ -1776,12 +1777,12 @@ static void dw_mci_init_dma(struct dw_mci *h=
ost)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->dma_ops->init) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->dma_ops->=
init(host)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&host->pdev->dev, "%s: Unable to initialize "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&host->dev, "%s: Unable to initialize "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "DMA Controller.\n", __func__);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto no_dma;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->pdev->dev=
, "DMA initialization not found.\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev, "DMA=
 initialization not found.\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_dma;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> @@ -1789,7 +1790,7 @@ static void dw_mci_init_dma(struct dw_mci *hos=
t)
>> =C2=A0 =C2=A0 =C2=A0 return;
>>
>> =C2=A0no_dma:
>> - =C2=A0 =C2=A0 dev_info(&host->pdev->dev, "Using PIO mode.\n");
>> + =C2=A0 =C2=A0 dev_info(&host->dev, "Using PIO mode.\n");
>> =C2=A0 =C2=A0 =C2=A0 host->use_dma =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0}
>> @@ -1815,61 +1816,37 @@ static bool mci_wait_reset(struct device *de=
v, struct dw_mci *host)
>> =C2=A0 =C2=A0 =C2=A0 return false;
>> =C2=A0}
>>
>> -static int dw_mci_probe(struct platform_device *pdev)
>> +int dw_mci_probe(struct dw_mci *host)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct dw_mci *host;
>> - =C2=A0 =C2=A0 struct resource *regs;
>> - =C2=A0 =C2=A0 struct dw_mci_board *pdata;
>> - =C2=A0 =C2=A0 int irq, ret, i, width;
>> + =C2=A0 =C2=A0 int width, i , ret;
>
> no need for a space after the i.
>
>> =C2=A0 =C2=A0 =C2=A0 u32 fifo_size;
>>
>> - =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
>> - =C2=A0 =C2=A0 if (!regs)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
>> -
>> - =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
>> - =C2=A0 =C2=A0 if (irq < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return irq;
>> -
>> - =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>> - =C2=A0 =C2=A0 if (!host)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> -
>> - =C2=A0 =C2=A0 host->pdev =3D pdev;
>> - =C2=A0 =C2=A0 host->pdata =3D pdata =3D pdev->dev.platform_data;
>> - =C2=A0 =C2=A0 if (!pdata || !pdata->init) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> + =C2=A0 =C2=A0 if (!host->pdata || !host->pdata->init) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "Platform data must supply init function\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 if (!pdata->select_slot && pdata->num_slots > 1) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> + =C2=A0 =C2=A0 if (!host->pdata->select_slot && host->pdata->num_sl=
ots > 1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "Platform data must supply select_slot function\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 if (!pdata->bus_hz) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> + =C2=A0 =C2=A0 if (!host->pdata->bus_hz) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "Platform data must supply bus speed\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 host->bus_hz =3D pdata->bus_hz;
>> - =C2=A0 =C2=A0 host->quirks =3D pdata->quirks;
>> + =C2=A0 =C2=A0 host->bus_hz =3D host->pdata->bus_hz;
>> + =C2=A0 =C2=A0 host->quirks =3D host->pdata->quirks;
>>
>> =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&host->lock);
>> =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&host->queue);
>>
>> - =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> - =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_size(re=
gs));
>> - =C2=A0 =C2=A0 if (!host->regs)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>>
>> - =C2=A0 =C2=A0 host->dma_ops =3D pdata->dma_ops;
>> + =C2=A0 =C2=A0 host->dma_ops =3D host->pdata->dma_ops;
>> =C2=A0 =C2=A0 =C2=A0 dw_mci_init_dma(host);
>>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> @@ -1899,7 +1876,7 @@ static int dw_mci_probe(struct platform_device=
 *pdev)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Reset all blocks */
>> - =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&host->dev, host)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaunmap;
>> =C2=A0 =C2=A0 =C2=A0 }
>> @@ -1942,13 +1919,13 @@ static int dw_mci_probe(struct platform_devi=
ce *pdev)
>> =C2=A0 =C2=A0 =C2=A0 if (!dw_mci_card_workqueue)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaunmap;
>> =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&host->card_work, dw_mci_work_routine=
_card);
>> -
>> - =C2=A0 =C2=A0 ret =3D request_irq(irq, dw_mci_interrupt, 0, "dw-mc=
i", host);
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 ret =3D request_irq(host->irq, dw_mci_interrupt, IRQ=
=46_SHARED, "dw-mci", host);
>> +#else
>> + =C2=A0 =C2=A0 ret =3D request_irq(host->irq, dw_mci_interrupt, 0, =
"dw-mci", host);
>> +#endif
>
> is this necessary? perhaps it could pass in the irq flags from the
> caller somehow.
>
>> =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_workqueue;
>> -
>> - =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>> -
>> =C2=A0 =C2=A0 =C2=A0 if (host->pdata->num_slots)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->num_slots =3D=
 host->pdata->num_slots;
>> =C2=A0 =C2=A0 =C2=A0 else
>> @@ -1985,12 +1962,12 @@ static int dw_mci_probe(struct platform_devi=
ce *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DW_MCI=
_ERROR_FLAGS | SDMMC_INT_CD);
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); =
/* Enable mci interrupt */
>>
>> - =C2=A0 =C2=A0 dev_info(&pdev->dev, "DW MMC controller at irq %d, "
>> + =C2=A0 =C2=A0 dev_info(&host->dev, "DW MMC controller at irq %d, "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%d bit host =
data width, "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%u deep fifo=
\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq, width, fifo_s=
ize);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->irq, width, =
fifo_size);
>> =C2=A0 =C2=A0 =C2=A0 if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "In=
ternal DMAC interrupt fix enabled.\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&host->dev, "In=
ternal DMAC interrupt fix enabled.\n");
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> @@ -2001,7 +1978,7 @@ err_init_slot:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dw_mci_cleanup_slot(host->slot[i], i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i--;
>> =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 free_irq(irq, host);
>> + =C2=A0 =C2=A0 free_irq(host->irq, host);
>>
>> =C2=A0err_workqueue:
>> =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
>> @@ -2009,7 +1986,7 @@ err_workqueue:
>> =C2=A0err_dmaunmap:
>> =C2=A0 =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->exit=
(host);
>> - =C2=A0 =C2=A0 dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
>> + =C2=A0 =C2=A0 dma_free_coherent(&host->dev, PAGE_SIZE,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 host->sg_cpu, host->sg_dma);
>> =C2=A0 =C2=A0 =C2=A0 iounmap(host->regs);
>
> this iounmap can be moved out to caller now that regs it initialised =
by
> caller.
>
>>
>> @@ -2017,25 +1994,16 @@ err_dmaunmap:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disable(h=
ost->vmmc);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(host-=
>vmmc);
>> =C2=A0 =C2=A0 =C2=A0 }
>> -
>> -
>> -err_freehost:
>> - =C2=A0 =C2=A0 kfree(host);
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>> +EXPORT_SYMBOL(dw_mci_probe);
>>
>> -static int __exit dw_mci_remove(struct platform_device *pdev)
>> +void dw_mci_remove(struct dw_mci *host)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> - =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> - =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mmc int=
errupt first */
>
> This seems pretty independent of PCI/platform, and is done by both
> callers anyway. Perhaps it should stay where it is.
>
>> -
>> - =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
>> -
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "rem=
ove slot %d\n", i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&host->dev, "rem=
ove slot %d\n", i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->slot[i])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dw_mci_cleanup_slot(host->slot[i], i);
>> =C2=A0 =C2=A0 =C2=A0 }
>> @@ -2044,9 +2012,9 @@ static int __exit dw_mci_remove(struct platfor=
m_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKENA, 0);
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKSRC, 0);
>>
>> - =C2=A0 =C2=A0 free_irq(platform_get_irq(pdev, 0), host);
>> + =C2=A0 =C2=A0 free_irq(host->irq, host);
>> =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
>> - =C2=A0 =C2=A0 dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cp=
u, host->sg_dma);
>> + =C2=A0 =C2=A0 dma_free_coherent(&host->dev, PAGE_SIZE, host->sg_cp=
u, host->sg_dma);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->exit=
(host);
>> @@ -2057,19 +2025,18 @@ static int __exit dw_mci_remove(struct platf=
orm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 iounmap(host->regs);
>
> same here (move out to caller)
>
>> -
>> - =C2=A0 =C2=A0 kfree(host);
>> - =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>> +EXPORT_SYMBOL(dw_mci_remove);
>> +
>> +
>>
>> =C2=A0#ifdef CONFIG_PM
>> =C2=A0/*
>> =C2=A0 * TODO: we should probably disable the clock to the card in t=
he suspend path.
>> =C2=A0 */
>> -static int dw_mci_suspend(struct platform_device *pdev, pm_message_=
t mesg)
>> +int dw_mci_suspend(struct dw_mci *host)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i, ret;
>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>>
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =
*slot =3D host->slot[i];
>> @@ -2091,19 +2058,18 @@ static int dw_mci_suspend(struct platform_de=
vice *pdev, pm_message_t mesg)
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>> +EXPORT_SYMBOL(dw_mci_suspend);
>>
>> -static int dw_mci_resume(struct platform_device *pdev)
>> +int dw_mci_resume(struct dw_mci *host)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i, ret;
>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pdev);
>> -
>> =C2=A0 =C2=A0 =C2=A0 if (host->vmmc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_enable(ho=
st->vmmc);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->dma_ops->init)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->init=
(host);
>>
>> - =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&host->dev, host)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0 =C2=A0 =C2=A0 }
>> @@ -2125,31 +2091,22 @@ static int dw_mci_resume(struct platform_dev=
ice *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ret;
>> =C2=A0 =C2=A0 =C2=A0 }
>> -
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>> +EXPORT_SYMBOL(dw_mci_resume);
>> =C2=A0#else
>> =C2=A0#define dw_mci_suspend =C2=A0 =C2=A0 =C2=A0 NULL
>> =C2=A0#define dw_mci_resume =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
>
> this else bit can probably go since the #defines aren't being used
> any more.
>
>> =C2=A0#endif /* CONFIG_PM */
>>
>> -static struct platform_driver dw_mci_driver =3D {
>> - =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_p(dw_=
mci_remove),
>> - =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_suspe=
nd,
>> - =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_resum=
e,
>> - =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =3D "dw_mmc",
>> - =C2=A0 =C2=A0 },
>> -};
>> -
>> =C2=A0static int __init dw_mci_init(void)
>> =C2=A0{
>> - =C2=A0 =C2=A0 return platform_driver_probe(&dw_mci_driver, dw_mci_=
probe);
>> + =C2=A0 =C2=A0 printk(KERN_INFO "Synopsys Designware Multimedia Car=
d Interface Driver");
>> + =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> =C2=A0static void __exit dw_mci_exit(void)
>> =C2=A0{
>> - =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_driver);
>> =C2=A0}
>>
>> =C2=A0module_init(dw_mci_init);
>
> if the init and exit functions of the main driver no longer do anythi=
ng,
> they can probably go too.
Actually, when I looked at the SDHCI-PCI drivers, these are still
present because the the plain sdhci.ko can be loaded as an independent
module, after that we can insert either pltfm.ko module or pci.ko
module. So I feel it would be better to keep them as it is.
>
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 72c071f..70078f6 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -175,4 +175,11 @@
>> =C2=A0 =C2=A0 =C2=A0 (*(volatile u64 __force *)((dev)->regs + SDMMC_=
##reg) =3D (value))
>> =C2=A0#endif
>>
>> +extern int dw_mci_probe(struct dw_mci *host);
>> +extern void dw_mci_remove(struct dw_mci *host);
>> +#ifdef CONFIG_PM
>> +extern int dw_mci_suspend(struct dw_mci *host);
>> +extern int dw_mci_resume(struct dw_mci *host);
>> +#endif
>> +
>> =C2=A0#endif /* _DW_MMC_H_ */
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 6dc9b80..5240446 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -74,7 +74,7 @@ struct mmc_data;
>> =C2=A0 * @num_slots: Number of slots available.
>> =C2=A0 * @verid: Denote Version ID.
>> =C2=A0 * @data_offset: Set the offset of DATA register according to =
VERID.
>> - * @pdev: Platform device associated with the MMC controller.
>> + * @dev: device associated with the MMC controller.
>
> I'm being picky here, but you could capitalise the d of device, for
> consistency with the rest of the descriptions.
>
>> =C2=A0 * @pdata: Platform data associated with the MMC controller.
>> =C2=A0 * @slot: Slots sharing this MMC controller.
>> =C2=A0 * @fifo_depth: depth of FIFO.
>> @@ -151,7 +151,7 @@ struct dw_mci {
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fifoth_val;
>> =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 verid;
>> =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 data_offset;
>> - =C2=A0 =C2=A0 struct platform_device =C2=A0*pdev;
>> + =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *de=
v;
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_board =C2=A0 =C2=A0 *pdata;
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =C2=A0 =C2=A0 =C2=A0*slot[MA=
X_MCI_SLOTS];
>>
>> --
>> 1.7.6.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> Thanks
> James



--=20
regards,
Shashidhar Hiremath
