From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v5 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 11 Jan 2012 09:37:29 +0000
Message-ID: <4F0D5859.9010505@imgtec.com>
References: <1322732488-21633-1-git-send-email-shashidharh@vayavyalabs.com>	<4ED74CFF.80705@imgtec.com>	<CANYdXnr8M0boyisoT16nGPshANHjo84bj33OKOSpGJRm5rzGdg@mail.gmail.com>	<4ED75F19.70105@imgtec.com>	<CANYdXnqAiM7qAd10FHGJuzW-8dS4OfQn_j0Tyi-aHFFVJMJ3hw@mail.gmail.com>	<4EF34079.2000103@imgtec.com> <CANYdXnognTLqabAedtp3OCFjfoo_UmirpvncS0jC+E3UJO1wQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:1337 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab2AKJhw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 04:37:52 -0500
In-Reply-To: <CANYdXnognTLqabAedtp3OCFjfoo_UmirpvncS0jC+E3UJO1wQA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi Shashidhar,

Yeh, go for it!

Cheers
James

On 11/01/12 09:33, Shashidhar Hiremath wrote:
> Hi James,
>=20
>   Since Jae hoon's patch on dev_pm_ops patch is now present in
> mmc-next branch. Can I submit  PCI patch again with all the changes
> suggested by you and bug found by me while testing ?
>=20
> Also note that the latest PCI patch has been tested on  XLINX XC2V300=
0
> FF1152AMT0221 D1215994A VIRTEX FPGA board.
>=20
> On Thu, Dec 22, 2011 at 8:06 PM, James Hogan <james.hogan@imgtec.com>=
 wrote:
>>
>> I've minimally tested the platform version, but on the current mmc-n=
ext
>> I need the extra includes below. With these changes the patch looks
>> okay to me.
>>
>> Note however that this patch will conflict with Jaehoon Chung's
>> dev_pm_ops patch, so it's probably worth fixing it to apply on top o=
f
>> that once it's gone into mmc-next.
>>
>> Thanks
>> James
>>
>> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc=
-pci.c
>> index 5734cf7..bcfbeb2 100644
>> --- a/drivers/mmc/host/dw_mmc-pci.c
>> +++ b/drivers/mmc/host/dw_mmc-pci.c
>> @@ -11,7 +11,9 @@
>>
>>  #include <linux/interrupt.h>
>>  #include <linux/irq.h>
>> +#include <linux/module.h>
>>  #include <linux/pci.h>
>> +#include <linux/slab.h>
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/mmc.h>
>>  #include <linux/mmc/dw_mmc.h>
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_m=
mc-pltfm.c
>> index fdf148d..0de2d03 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -11,7 +11,9 @@
>>  */
>>
>>  #include <linux/interrupt.h>
>> +#include <linux/io.h>
>>  #include <linux/irq.h>
>> +#include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/mmc/host.h>
>>
>>
>> On 12/22/2011 05:43 AM, Shashidhar Hiremath wrote:
>>> Hi James,
>>> Any updates on this patch ?
>>>
>>> On Thu, Dec 1, 2011 at 4:33 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
>>>> On 12/01/2011 10:51 AM, Shashidhar Hiremath wrote:
>>>>> yes, I have compiled both the variants.
>>>>
>>>>>   CC      drivers/mmc/host/dw_mmc-pltfm.o
>>>>> drivers/mmc/host/dw_mmc-pltfm.c: In function =E2=80=98dw_mci_pltf=
m_probe=E2=80=99:
>>>>> drivers/mmc/host/dw_mmc-pltfm.c:48: error: implicit declaration o=
f function =E2=80=98ioremap=E2=80=99
>>>>> drivers/mmc/host/dw_mmc-pltfm.c:48: warning: assignment makes poi=
nter from integer without a cast
>>>>> drivers/mmc/host/dw_mmc-pltfm.c:57: error: implicit declaration o=
f function =E2=80=98iounmap=E2=80=99
>>>>
>>>> Okay, possibly it's because I'm compiling on x86, and the arm head=
ers are different.
>>>> The following fixes it for me:
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw=
_mmc-pltfm.c
>>>> index fdf148d..7af2519 100644
>>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>> @@ -11,6 +11,7 @@
>>>>  */
>>>>
>>>>  #include <linux/interrupt.h>
>>>> +#include <linux/io.h>
>>>>  #include <linux/irq.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/slab.h>
>>>>
>>>> Cheers
>>>> James
>>>>
>>>>>
>>>>> On Thu, Dec 1, 2011 at 3:16 PM, James Hogan <james.hogan@imgtec.c=
om> wrote:
>>>>>> On 12/01/2011 09:41 AM, Shashidhar Hiremath wrote:
>>>>>>> Please forgive me for repetative patches.Some mailing addresses=
 were wrong.
>>>>>>> So, resending the patch.
>>>>>>> Support of PCI mode for the dw_mmc driver. This Patch adds the
>>>>>>> support for the scenario where the Synopsys Designware IP
>>>>>>> is present on the PCI bus. The patch adds the minimal modificat=
ions
>>>>>>> necessary for the driver to work on PCI platform. Also added se=
parate
>>>>>>> files for PCI and PLATFORM modes of operation.
>>>>>>>
>>>>>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com=
>
>>>>>>
>>>>>> You might like to try compiling with the platform version enable=
d too.
>>>>>>
>>>>>> Cheers
>>>>>> James
>>>>>>
>>>>>>> ---
>>>>>>> v2:
>>>>>>> *As per Suggestions by Will Newton and James Hogan
>>>>>>> -Reduced the number of ifdefs
>>>>>>> v3:
>>>>>>> *As per Suggestions by Will Newton and James Hogan
>>>>>>> -Added separate files for PCI and PLATFORM Modes similar to SDH=
CI driver
>>>>>>> v4:
>>>>>>> *As per Suggestions by James Hogan
>>>>>>> -Fixed Indentation Issue.
>>>>>>> -Added Proper error Handling for probe and remove sequences.
>>>>>>> -Modified location of some code.
>>>>>>> -Added isr_flags to dw_mmc.h and removed the ifdef PCI from dri=
ver.
>>>>>>> v5:
>>>>>>> *As per Suggestions by James Hogan
>>>>>>> -removed the redundant code.
>>>>>>> -fixed the compilation errors.
>>>>>>> -Modified the menuconfig Message for PLATFORM mode.
>>>>>>>  drivers/mmc/host/Kconfig        |   25 ++++++
>>>>>>>  drivers/mmc/host/Makefile       |    2 +
>>>>>>>  drivers/mmc/host/dw_mmc-pci.c   |  152 +++++++++++++++++++++++=
+++++++++++++++
>>>>>>>  drivers/mmc/host/dw_mmc-pltfm.c |  133 +++++++++++++++++++++++=
++++++++++
>>>>>>>  drivers/mmc/host/dw_mmc.c       |  156 +++++++++++++----------=
---------------
>>>>>>>  drivers/mmc/host/dw_mmc.h       |    7 ++
>>>>>>>  include/linux/mmc/dw_mmc.h      |    8 ++-
>>>>>>>  7 files changed, 379 insertions(+), 104 deletions(-)
>>>>>>>  create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>>>>>>>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfi=
g
>>>>>>> index 87d5067..72f48b9 100644
>>>>>>> --- a/drivers/mmc/host/Kconfig
>>>>>>> +++ b/drivers/mmc/host/Kconfig
>>>>>>> @@ -534,6 +534,31 @@ config MMC_DW_IDMAC
>>>>>>>         Designware Mobile Storage IP block. This disables the e=
xternal DMA
>>>>>>>         interface.
>>>>>>>
>>>>>>> +config MMC_DW_PLTFM
>>>>>>> +     tristate "Synopsys Designware MCI Support as platform dev=
ice"
>>>>>>> +     depends on MMC_DW
>>>>>>> +     default y
>>>>>>> +     help
>>>>>>> +       This selects the common helper functions support for Ho=
st Controller
>>>>>>> +       Interface based platform driver. Please select this opt=
ion if the IP
>>>>>>> +       is present as a platform device. This is the common int=
erface for the
>>>>>>> +       Synopsys Designware IP.
>>>>>>> +
>>>>>>> +       If you have a controller with this interface, say Y or =
M here.
>>>>>>> +
>>>>>>> +       If unsure, say Y.
>>>>>>> +
>>>>>>> +config MMC_DW_PCI
>>>>>>> +     tristate "Synopsys Designware MCI support on PCI bus"
>>>>>>> +     depends on MMC_DW && PCI
>>>>>>> +     help
>>>>>>> +       This selects the PCI bus for the Synopsys Designware Mo=
bile Storage IP.
>>>>>>> +       Select this option if the IP is present on PCI platform=
=2E
>>>>>>> +
>>>>>>> +       If you have a controller with this interface, say Y or =
M here.
>>>>>>> +
>>>>>>> +       If unsure, say N.
>>>>>>> +
>>>>>>>  config MMC_SH_MMCIF
>>>>>>>       tristate "SuperH Internal MMCIF support"
>>>>>>>       depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
>>>>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makef=
ile
>>>>>>> index b4b83f3..3aa2fa3 100644
>>>>>>> --- a/drivers/mmc/host/Makefile
>>>>>>> +++ b/drivers/mmc/host/Makefile
>>>>>>> @@ -38,6 +38,8 @@ obj-$(CONFIG_MMC_CB710)             +=3D cb71=
0-mmc.o
>>>>>>>  obj-$(CONFIG_MMC_VIA_SDMMC)  +=3D via-sdmmc.o
>>>>>>>  obj-$(CONFIG_SDH_BFIN)               +=3D bfin_sdh.o
>>>>>>>  obj-$(CONFIG_MMC_DW)         +=3D dw_mmc.o
>>>>>>> +obj-$(CONFIG_MMC_DW_PLTFM)   +=3D dw_mmc-pltfm.o
>>>>>>> +obj-$(CONFIG_MMC_DW_PCI)     +=3D dw_mmc-pci.o
>>>>>>>  obj-$(CONFIG_MMC_SH_MMCIF)   +=3D sh_mmcif.o
>>>>>>>  obj-$(CONFIG_MMC_JZ4740)     +=3D jz4740_mmc.o
>>>>>>>  obj-$(CONFIG_MMC_VUB300)     +=3D vub300.o
>>>>>>> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/d=
w_mmc-pci.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000..5734cf7
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/mmc/host/dw_mmc-pci.c
>>>>>>> @@ -0,0 +1,152 @@
>>>>>>> +/*
>>>>>>> + * Synopsys DesignWare Multimedia Card PCI Interface driver
>>>>>>> + *
>>>>>>> + * Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/=
or modify
>>>>>>> + * it under the terms of the GNU General Public License as pub=
lished by
>>>>>>> + * the Free Software Foundation; either version 2 of the Licen=
se, or
>>>>>>> + * (at your option) any later version.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/interrupt.h>
>>>>>>> +#include <linux/irq.h>
>>>>>>> +#include <linux/pci.h>
>>>>>>> +#include <linux/mmc/host.h>
>>>>>>> +#include <linux/mmc/mmc.h>
>>>>>>> +#include <linux/mmc/dw_mmc.h>
>>>>>>> +#include "dw_mmc.h"
>>>>>>> +
>>>>>>> +#define PCI_BAR_NO 2
>>>>>>> +#define COMPLETE_BAR 0
>>>>>>> +#define DW_MCI_VENDOR_ID 0x700
>>>>>>> +#define DW_MCI_DEVICE_ID 0x1107
>>>>>>> +/* Defining the Capabilities */
>>>>>>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_=
HIGHSPEED |\
>>>>>>> +                             MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_=
BIT_DATA |\
>>>>>>> +                             MMC_CAP_SDIO_IRQ)
>>>>>>> +
>>>>>>> +static struct dw_mci_board pci_board_data =3D {
>>>>>>> +     .num_slots                      =3D 1,
>>>>>>> +     .caps                           =3D DW_MCI_CAPABILITIES,
>>>>>>> +     .bus_hz                         =3D 33 * 1000 * 1000,
>>>>>>> +     .detect_delay_ms                =3D 200,
>>>>>>> +     .fifo_depth                     =3D 32,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
>>>>>>> +                               const struct pci_device_id *ent=
ries)
>>>>>>> +{
>>>>>>> +     struct dw_mci *host;
>>>>>>> +     int ret;
>>>>>>> +
>>>>>>> +     ret =3D pci_enable_device(pdev);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +     if (pci_request_regions(pdev, "dw_mmc_pci")) {
>>>>>>> +             ret =3D -ENODEV;
>>>>>>> +             goto err_disable_dev;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>>>>>> +     if (!host) {
>>>>>>> +             ret =3D -ENOMEM;
>>>>>>> +             goto err_release;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     host->irq =3D pdev->irq;
>>>>>>> +     host->irq_flags =3D IRQF_SHARED;
>>>>>>> +     host->dev =3D pdev->dev;
>>>>>>> +     host->pdata =3D &pci_board_data;
>>>>>>> +
>>>>>>> +     host->regs =3D pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
>>>>>>> +     if (!host->regs) {
>>>>>>> +             ret =3D -EIO;
>>>>>>> +             goto err_unmap;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     pci_set_drvdata(pdev, host);
>>>>>>> +     ret =3D dw_mci_probe(host);
>>>>>>> +     if (ret)
>>>>>>> +             goto err_probe_failed;
>>>>>>> +     return ret;
>>>>>>> +
>>>>>>> +err_probe_failed:
>>>>>>> +     pci_iounmap(pdev, host->regs);
>>>>>>> +err_unmap:
>>>>>>> +     kfree(host);
>>>>>>> +err_release:
>>>>>>> +     pci_release_regions(pdev);
>>>>>>> +err_disable_dev:
>>>>>>> +     pci_disable_device(pdev);
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
>>>>>>> +{
>>>>>>> +     struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +     dw_mci_remove(host);
>>>>>>> +     pci_set_drvdata(pdev, NULL);
>>>>>>> +     pci_release_regions(pdev);
>>>>>>> +     pci_iounmap(pdev, host->regs);
>>>>>>> +     kfree(host);
>>>>>>> +     pci_disable_device(pdev);
>>>>>>> +}
>>>>>>> +
>>>>>>> +#ifdef CONFIG_PM
>>>>>>> +static int dw_mci_pci_suspend(struct pci_dev *pdev, pm_message=
_t mesg)
>>>>>>> +{
>>>>>>> +     int ret;
>>>>>>> +     struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +     ret =3D dw_mci_suspend(host);
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int dw_mci_pci_resume(struct pci_dev *pdev)
>>>>>>> +{
>>>>>>> +     int ret;
>>>>>>> +     struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +     ret =3D dw_mci_resume(host);
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#else
>>>>>>> +#define dw_mci_pci_suspend   NULL
>>>>>>> +#define dw_mci_pci_resume    NULL
>>>>>>> +#endif /* CONFIG_PM */
>>>>>>> +
>>>>>>> +static DEFINE_PCI_DEVICE_TABLE(dw_mci_pci_id) =3D {
>>>>>>> +     { PCI_DEVICE(DW_MCI_DEVICE_ID, DW_MCI_VENDOR_ID) },
>>>>>>> +     {}
>>>>>>> +};
>>>>>>> +MODULE_DEVICE_TABLE(pci, dw_mci_pci_id);
>>>>>>> +
>>>>>>> +static struct pci_driver dw_mci_pci_driver =3D {
>>>>>>> +     .name           =3D "dw_mmc_pci",
>>>>>>> +     .id_table       =3D dw_mci_pci_id,
>>>>>>> +     .probe          =3D dw_mci_pci_probe,
>>>>>>> +     .remove         =3D dw_mci_pci_remove,
>>>>>>> +     .suspend        =3D dw_mci_pci_suspend,
>>>>>>> +     .resume         =3D dw_mci_pci_resume,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int __init dw_mci_init(void)
>>>>>>> +{
>>>>>>> +     return pci_register_driver(&dw_mci_pci_driver);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void __exit dw_mci_exit(void)
>>>>>>> +{
>>>>>>> +     pci_unregister_driver(&dw_mci_pci_driver);
>>>>>>> +}
>>>>>>> +
>>>>>>> +module_init(dw_mci_init);
>>>>>>> +module_exit(dw_mci_exit);
>>>>>>> +
>>>>>>> +MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
>>>>>>> +MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.co=
m>");
>>>>>>> +MODULE_AUTHOR("VayavyaLabs Pvt. Ltd.");
>>>>>>> +MODULE_LICENSE("GPL v2");
>>>>>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host=
/dw_mmc-pltfm.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000..fdf148d
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>>> @@ -0,0 +1,133 @@
>>>>>>> +/*
>>>>>>> + * Synopsys DesignWare Multimedia Card Interface driver
>>>>>>> + *
>>>>>>> + * Copyright (C) 2009 NXP Semiconductors
>>>>>>> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/=
or modify
>>>>>>> + * it under the terms of the GNU General Public License as pub=
lished by
>>>>>>> + * the Free Software Foundation; either version 2 of the Licen=
se, or
>>>>>>> + * (at your option) any later version.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/interrupt.h>
>>>>>>> +#include <linux/irq.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/slab.h>
>>>>>>> +#include <linux/mmc/host.h>
>>>>>>> +#include <linux/mmc/mmc.h>
>>>>>>> +#include <linux/mmc/dw_mmc.h>
>>>>>>> +#include "dw_mmc.h"
>>>>>>> +
>>>>>>> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +     struct dw_mci *host;
>>>>>>> +     struct resource *regs;
>>>>>>> +     int  ret;
>>>>>>> +
>>>>>>> +     host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>>>>>> +     if (!host)
>>>>>>> +             return -ENOMEM;
>>>>>>> +
>>>>>>> +     regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>>> +     if (!regs) {
>>>>>>> +             ret =3D -ENXIO;
>>>>>>> +             goto err_free;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     host->irq =3D platform_get_irq(pdev, 0);
>>>>>>> +     if (host->irq < 0) {
>>>>>>> +             ret =3D host->irq;
>>>>>>> +             goto err_free;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     host->dev =3D pdev->dev;
>>>>>>> +     host->irq_flags =3D 0;
>>>>>>> +     host->pdata =3D pdev->dev.platform_data;
>>>>>>> +     ret =3D -ENOMEM;
>>>>>>> +     host->regs =3D ioremap(regs->start, resource_size(regs));
>>>>>>> +     if (!host->regs)
>>>>>>> +             goto err_free;
>>>>>>> +     platform_set_drvdata(pdev, host);
>>>>>>> +     ret =3D dw_mci_probe(host);
>>>>>>> +     if (ret)
>>>>>>> +             goto err_out;
>>>>>>> +     return ret;
>>>>>>> +err_out:
>>>>>>> +     iounmap(host->regs);
>>>>>>> +err_free:
>>>>>>> +     kfree(host);
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int __exit dw_mci_pltfm_remove(struct platform_device *=
pdev)
>>>>>>> +{
>>>>>>> +     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +
>>>>>>> +     platform_set_drvdata(pdev, NULL);
>>>>>>> +     dw_mci_remove(host);
>>>>>>> +     iounmap(host->regs);
>>>>>>> +     kfree(host);
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +#ifdef CONFIG_PM
>>>>>>> +/*
>>>>>>> + * TODO: we should probably disable the clock to the card in t=
he suspend path.
>>>>>>> + */
>>>>>>> +static int dw_mci_pltfm_suspend(struct platform_device *pdev, =
pm_message_t mesg)
>>>>>>> +{
>>>>>>> +
>>>>>>> +     int  ret;
>>>>>>> +     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +     ret =3D dw_mci_suspend(host);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int dw_mci_pltfm_resume(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +
>>>>>>> +     int ret;
>>>>>>> +     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +     ret =3D dw_mci_resume(host);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +#else
>>>>>>> +#define dw_mci_pltfm_suspend NULL
>>>>>>> +#define dw_mci_pltfm_resume  NULL
>>>>>>> +#endif /* CONFIG_PM */
>>>>>>> +
>>>>>>> +static struct platform_driver dw_mci_pltfm_driver =3D {
>>>>>>> +     .remove         =3D __exit_p(dw_mci_pltfm_remove),
>>>>>>> +     .suspend        =3D dw_mci_pltfm_suspend,
>>>>>>> +     .resume         =3D dw_mci_pltfm_resume,
>>>>>>> +     .driver         =3D {
>>>>>>> +             .name           =3D "dw_mmc",
>>>>>>> +     },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int __init dw_mci_init(void)
>>>>>>> +{
>>>>>>> +     return platform_driver_probe(&dw_mci_pltfm_driver, dw_mci=
_pltfm_probe);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void __exit dw_mci_exit(void)
>>>>>>> +{
>>>>>>> +     platform_driver_unregister(&dw_mci_pltfm_driver);
>>>>>>> +}
>>>>>>> +
>>>>>>> +module_init(dw_mci_init);
>>>>>>> +module_exit(dw_mci_exit);
>>>>>>> +
>>>>>>> +MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>>>>>>> +MODULE_AUTHOR("NXP Semiconductor VietNam");
>>>>>>> +MODULE_AUTHOR("Imagination Technologies Ltd");
>>>>>>> +MODULE_LICENSE("GPL v2");
>>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mm=
c.c
>>>>>>> index 3aaeb08..928abc0 100644
>>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>>> @@ -269,7 +269,7 @@ static void dw_mci_start_command(struct dw_=
mci *host,
>>>>>>>                                struct mmc_command *cmd, u32 cmd=
_flags)
>>>>>>>  {
>>>>>>>       host->cmd =3D cmd;
>>>>>>> -     dev_vdbg(&host->pdev->dev,
>>>>>>> +     dev_vdbg(&host->dev,
>>>>>>>                "start command: ARGR=3D0x%08x CMDR=3D0x%08x\n",
>>>>>>>                cmd->arg, cmd_flags);
>>>>>>>
>>>>>>> @@ -302,7 +302,7 @@ static void dw_mci_dma_cleanup(struct dw_mc=
i *host)
>>>>>>>       struct mmc_data *data =3D host->data;
>>>>>>>
>>>>>>>       if (data)
>>>>>>> -             dma_unmap_sg(&host->pdev->dev, data->sg, data->sg=
_len,
>>>>>>> +             dma_unmap_sg(&host->dev, data->sg, data->sg_len,
>>>>>>>                            ((data->flags & MMC_DATA_WRITE)
>>>>>>>                             ? DMA_TO_DEVICE : DMA_FROM_DEVICE))=
;
>>>>>>>  }
>>>>>>> @@ -327,7 +327,7 @@ static void dw_mci_idmac_complete_dma(struc=
t dw_mci *host)
>>>>>>>  {
>>>>>>>       struct mmc_data *data =3D host->data;
>>>>>>>
>>>>>>> -     dev_vdbg(&host->pdev->dev, "DMA complete\n");
>>>>>>> +     dev_vdbg(&host->dev, "DMA complete\n");
>>>>>>>
>>>>>>>       host->dma_ops->cleanup(host);
>>>>>>>
>>>>>>> @@ -463,10 +463,10 @@ static int dw_mci_submit_data_dma(struct =
dw_mci *host, struct mmc_data *data)
>>>>>>>       else
>>>>>>>               direction =3D DMA_TO_DEVICE;
>>>>>>>
>>>>>>> -     sg_len =3D dma_map_sg(&host->pdev->dev, data->sg, data->s=
g_len,
>>>>>>> +     sg_len =3D dma_map_sg(&host->dev, data->sg, data->sg_len,
>>>>>>>                           direction);
>>>>>>>
>>>>>>> -     dev_vdbg(&host->pdev->dev,
>>>>>>> +     dev_vdbg(&host->dev,
>>>>>>>                "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
>>>>>>>                (unsigned long)host->sg_cpu, (unsigned long)host=
->sg_dma,
>>>>>>>                sg_len);
>>>>>>> @@ -804,12 +804,12 @@ static void dw_mci_request_end(struct dw_=
mci *host, struct mmc_request *mrq)
>>>>>>>               slot =3D list_entry(host->queue.next,
>>>>>>>                                 struct dw_mci_slot, queue_node)=
;
>>>>>>>               list_del(&slot->queue_node);
>>>>>>> -             dev_vdbg(&host->pdev->dev, "list not empty: %s is=
 next\n",
>>>>>>> +             dev_vdbg(&host->dev, "list not empty: %s is next\=
n",
>>>>>>>                        mmc_hostname(slot->mmc));
>>>>>>>               host->state =3D STATE_SENDING_CMD;
>>>>>>>               dw_mci_start_request(host, slot);
>>>>>>>       } else {
>>>>>>> -             dev_vdbg(&host->pdev->dev, "list empty\n");
>>>>>>> +             dev_vdbg(&host->dev, "list empty\n");
>>>>>>>               host->state =3D STATE_IDLE;
>>>>>>>       }
>>>>>>>
>>>>>>> @@ -941,7 +941,7 @@ static void dw_mci_tasklet_func(unsigned lo=
ng priv)
>>>>>>>                                       data->bytes_xfered =3D 0;
>>>>>>>                                       data->error =3D -ETIMEDOU=
T;
>>>>>>>                               } else {
>>>>>>> -                                     dev_err(&host->pdev->dev,
>>>>>>> +                                     dev_err(&host->dev,
>>>>>>>                                               "data FIFO error =
"
>>>>>>>                                               "(status=3D%08x)\=
n",
>>>>>>>                                               status);
>>>>>>> @@ -1651,7 +1651,7 @@ static int __init dw_mci_init_slot(struct=
 dw_mci *host, unsigned int id)
>>>>>>>       struct mmc_host *mmc;
>>>>>>>       struct dw_mci_slot *slot;
>>>>>>>
>>>>>>> -     mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slot), &host-=
>pdev->dev);
>>>>>>> +     mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slot), &host-=
>dev);
>>>>>>>       if (!mmc)
>>>>>>>               return -ENOMEM;
>>>>>>>
>>>>>>> @@ -1757,10 +1757,10 @@ static void dw_mci_cleanup_slot(struct =
dw_mci_slot *slot, unsigned int id)
>>>>>>>  static void dw_mci_init_dma(struct dw_mci *host)
>>>>>>>  {
>>>>>>>       /* Alloc memory for sg translation */
>>>>>>> -     host->sg_cpu =3D dma_alloc_coherent(&host->pdev->dev, PAG=
E_SIZE,
>>>>>>> +     host->sg_cpu =3D dma_alloc_coherent(&host->dev, PAGE_SIZE=
,
>>>>>>>                                         &host->sg_dma, GFP_KERN=
EL);
>>>>>>>       if (!host->sg_cpu) {
>>>>>>> -             dev_err(&host->pdev->dev, "%s: could not alloc DM=
A memory\n",
>>>>>>> +             dev_err(&host->dev, "%s: could not alloc DMA memo=
ry\n",
>>>>>>>                       __func__);
>>>>>>>               goto no_dma;
>>>>>>>       }
>>>>>>> @@ -1768,7 +1768,7 @@ static void dw_mci_init_dma(struct dw_mci=
 *host)
>>>>>>>       /* Determine which DMA interface to use */
>>>>>>>  #ifdef CONFIG_MMC_DW_IDMAC
>>>>>>>       host->dma_ops =3D &dw_mci_idmac_ops;
>>>>>>> -     dev_info(&host->pdev->dev, "Using internal DMA controller=
=2E\n");
>>>>>>> +     dev_info(&host->dev, "Using internal DMA controller.\n");
>>>>>>>  #endif
>>>>>>>
>>>>>>>       if (!host->dma_ops)
>>>>>>> @@ -1776,12 +1776,12 @@ static void dw_mci_init_dma(struct dw_m=
ci *host)
>>>>>>>
>>>>>>>       if (host->dma_ops->init) {
>>>>>>>               if (host->dma_ops->init(host)) {
>>>>>>> -                     dev_err(&host->pdev->dev, "%s: Unable to =
initialize "
>>>>>>> +                     dev_err(&host->dev, "%s: Unable to initia=
lize "
>>>>>>>                               "DMA Controller.\n", __func__);
>>>>>>>                       goto no_dma;
>>>>>>>               }
>>>>>>>       } else {
>>>>>>> -             dev_err(&host->pdev->dev, "DMA initialization not=
 found.\n");
>>>>>>> +             dev_err(&host->dev, "DMA initialization not found=
=2E\n");
>>>>>>>               goto no_dma;
>>>>>>>       }
>>>>>>>
>>>>>>> @@ -1789,7 +1789,7 @@ static void dw_mci_init_dma(struct dw_mci=
 *host)
>>>>>>>       return;
>>>>>>>
>>>>>>>  no_dma:
>>>>>>> -     dev_info(&host->pdev->dev, "Using PIO mode.\n");
>>>>>>> +     dev_info(&host->dev, "Using PIO mode.\n");
>>>>>>>       host->use_dma =3D 0;
>>>>>>>       return;
>>>>>>>  }
>>>>>>> @@ -1815,61 +1815,37 @@ static bool mci_wait_reset(struct devic=
e *dev, struct dw_mci *host)
>>>>>>>       return false;
>>>>>>>  }
>>>>>>>
>>>>>>> -static int dw_mci_probe(struct platform_device *pdev)
>>>>>>> +int dw_mci_probe(struct dw_mci *host)
>>>>>>>  {
>>>>>>> -     struct dw_mci *host;
>>>>>>> -     struct resource *regs;
>>>>>>> -     struct dw_mci_board *pdata;
>>>>>>> -     int irq, ret, i, width;
>>>>>>> +     int width, i, ret =3D 0;
>>>>>>>       u32 fifo_size;
>>>>>>>
>>>>>>> -     regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>>> -     if (!regs)
>>>>>>> -             return -ENXIO;
>>>>>>> -
>>>>>>> -     irq =3D platform_get_irq(pdev, 0);
>>>>>>> -     if (irq < 0)
>>>>>>> -             return irq;
>>>>>>> -
>>>>>>> -     host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>>>>>> -     if (!host)
>>>>>>> -             return -ENOMEM;
>>>>>>> -
>>>>>>> -     host->pdev =3D pdev;
>>>>>>> -     host->pdata =3D pdata =3D pdev->dev.platform_data;
>>>>>>> -     if (!pdata || !pdata->init) {
>>>>>>> -             dev_err(&pdev->dev,
>>>>>>> +     if (!host->pdata || !host->pdata->init) {
>>>>>>> +             dev_err(&host->dev,
>>>>>>>                       "Platform data must supply init function\=
n");
>>>>>>> -             ret =3D -ENODEV;
>>>>>>> -             goto err_freehost;
>>>>>>> +             return -ENODEV;
>>>>>>>       }
>>>>>>>
>>>>>>> -     if (!pdata->select_slot && pdata->num_slots > 1) {
>>>>>>> -             dev_err(&pdev->dev,
>>>>>>> +     if (!host->pdata->select_slot && host->pdata->num_slots >=
 1) {
>>>>>>> +             dev_err(&host->dev,
>>>>>>>                       "Platform data must supply select_slot fu=
nction\n");
>>>>>>> -             ret =3D -ENODEV;
>>>>>>> -             goto err_freehost;
>>>>>>> +             return -ENODEV;
>>>>>>>       }
>>>>>>>
>>>>>>> -     if (!pdata->bus_hz) {
>>>>>>> -             dev_err(&pdev->dev,
>>>>>>> +     if (!host->pdata->bus_hz) {
>>>>>>> +             dev_err(&host->dev,
>>>>>>>                       "Platform data must supply bus speed\n");
>>>>>>> -             ret =3D -ENODEV;
>>>>>>> -             goto err_freehost;
>>>>>>> +             return -ENODEV;
>>>>>>>       }
>>>>>>>
>>>>>>> -     host->bus_hz =3D pdata->bus_hz;
>>>>>>> -     host->quirks =3D pdata->quirks;
>>>>>>> +     host->bus_hz =3D host->pdata->bus_hz;
>>>>>>> +     host->quirks =3D host->pdata->quirks;
>>>>>>>
>>>>>>>       spin_lock_init(&host->lock);
>>>>>>>       INIT_LIST_HEAD(&host->queue);
>>>>>>>
>>>>>>> -     ret =3D -ENOMEM;
>>>>>>> -     host->regs =3D ioremap(regs->start, resource_size(regs));
>>>>>>> -     if (!host->regs)
>>>>>>> -             goto err_freehost;
>>>>>>>
>>>>>>> -     host->dma_ops =3D pdata->dma_ops;
>>>>>>> +     host->dma_ops =3D host->pdata->dma_ops;
>>>>>>>       dw_mci_init_dma(host);
>>>>>>>
>>>>>>>       /*
>>>>>>> @@ -1899,7 +1875,7 @@ static int dw_mci_probe(struct platform_d=
evice *pdev)
>>>>>>>       }
>>>>>>>
>>>>>>>       /* Reset all blocks */
>>>>>>> -     if (!mci_wait_reset(&pdev->dev, host)) {
>>>>>>> +     if (!mci_wait_reset(&host->dev, host)) {
>>>>>>>               ret =3D -ENODEV;
>>>>>>>               goto err_dmaunmap;
>>>>>>>       }
>>>>>>> @@ -1942,13 +1918,11 @@ static int dw_mci_probe(struct platform=
_device *pdev)
>>>>>>>       if (!dw_mci_card_workqueue)
>>>>>>>               goto err_dmaunmap;
>>>>>>>       INIT_WORK(&host->card_work, dw_mci_work_routine_card);
>>>>>>> -
>>>>>>> -     ret =3D request_irq(irq, dw_mci_interrupt, 0, "dw-mci", h=
ost);
>>>>>>> +     ret =3D request_irq(host->irq, dw_mci_interrupt,
>>>>>>> +                       host->irq_flags, "dw-mci", host);
>>>>>>>       if (ret)
>>>>>>>               goto err_workqueue;
>>>>>>>
>>>>>>> -     platform_set_drvdata(pdev, host);
>>>>>>> -
>>>>>>>       if (host->pdata->num_slots)
>>>>>>>               host->num_slots =3D host->pdata->num_slots;
>>>>>>>       else
>>>>>>> @@ -1968,7 +1942,7 @@ static int dw_mci_probe(struct platform_d=
evice *pdev)
>>>>>>>        * Need to check the version-id and set data-offset for D=
ATA register.
>>>>>>>        */
>>>>>>>       host->verid =3D SDMMC_GET_VERID(mci_readl(host, VERID));
>>>>>>> -     dev_info(&pdev->dev, "Version ID is %04x\n", host->verid)=
;
>>>>>>> +     dev_info(&host->dev, "Version ID is %04x\n", host->verid)=
;
>>>>>>>
>>>>>>>       if (host->verid < DW_MMC_240A)
>>>>>>>               host->data_offset =3D DATA_OFFSET;
>>>>>>> @@ -1985,12 +1959,12 @@ static int dw_mci_probe(struct platform=
_device *pdev)
>>>>>>>                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>>>>>>>       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable =
mci interrupt */
>>>>>>>
>>>>>>> -     dev_info(&pdev->dev, "DW MMC controller at irq %d, "
>>>>>>> +     dev_info(&host->dev, "DW MMC controller at irq %d, "
>>>>>>>                "%d bit host data width, "
>>>>>>>                "%u deep fifo\n",
>>>>>>> -              irq, width, fifo_size);
>>>>>>> +              host->irq, width, fifo_size);
>>>>>>>       if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>>>>>>> -             dev_info(&pdev->dev, "Internal DMAC interrupt fix=
 enabled.\n");
>>>>>>> +             dev_info(&host->dev, "Internal DMAC interrupt fix=
 enabled.\n");
>>>>>>>
>>>>>>>       return 0;
>>>>>>>
>>>>>>> @@ -2001,7 +1975,7 @@ err_init_slot:
>>>>>>>                       dw_mci_cleanup_slot(host->slot[i], i);
>>>>>>>               i--;
>>>>>>>       }
>>>>>>> -     free_irq(irq, host);
>>>>>>> +     free_irq(host->irq, host);
>>>>>>>
>>>>>>>  err_workqueue:
>>>>>>>       destroy_workqueue(dw_mci_card_workqueue);
>>>>>>> @@ -2009,33 +1983,26 @@ err_workqueue:
>>>>>>>  err_dmaunmap:
>>>>>>>       if (host->use_dma && host->dma_ops->exit)
>>>>>>>               host->dma_ops->exit(host);
>>>>>>> -     dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
>>>>>>> +     dma_free_coherent(&host->dev, PAGE_SIZE,
>>>>>>>                         host->sg_cpu, host->sg_dma);
>>>>>>> -     iounmap(host->regs);
>>>>>>>
>>>>>>>       if (host->vmmc) {
>>>>>>>               regulator_disable(host->vmmc);
>>>>>>>               regulator_put(host->vmmc);
>>>>>>>       }
>>>>>>> -
>>>>>>> -
>>>>>>> -err_freehost:
>>>>>>> -     kfree(host);
>>>>>>>       return ret;
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL(dw_mci_probe);
>>>>>>>
>>>>>>> -static int __exit dw_mci_remove(struct platform_device *pdev)
>>>>>>> +void dw_mci_remove(struct dw_mci *host)
>>>>>>>  {
>>>>>>> -     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>>       int i;
>>>>>>>
>>>>>>>       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>>>>>       mci_writel(host, INTMASK, 0); /* disable all mmc interrup=
t first */
>>>>>>>
>>>>>>> -     platform_set_drvdata(pdev, NULL);
>>>>>>> -
>>>>>>>       for (i =3D 0; i < host->num_slots; i++) {
>>>>>>> -             dev_dbg(&pdev->dev, "remove slot %d\n", i);
>>>>>>> +             dev_dbg(&host->dev, "remove slot %d\n", i);
>>>>>>>               if (host->slot[i])
>>>>>>>                       dw_mci_cleanup_slot(host->slot[i], i);
>>>>>>>       }
>>>>>>> @@ -2044,9 +2011,9 @@ static int __exit dw_mci_remove(struct pl=
atform_device *pdev)
>>>>>>>       mci_writel(host, CLKENA, 0);
>>>>>>>       mci_writel(host, CLKSRC, 0);
>>>>>>>
>>>>>>> -     free_irq(platform_get_irq(pdev, 0), host);
>>>>>>> +     free_irq(host->irq, host);
>>>>>>>       destroy_workqueue(dw_mci_card_workqueue);
>>>>>>> -     dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, ho=
st->sg_dma);
>>>>>>> +     dma_free_coherent(&host->dev, PAGE_SIZE, host->sg_cpu, ho=
st->sg_dma);
>>>>>>>
>>>>>>>       if (host->use_dma && host->dma_ops->exit)
>>>>>>>               host->dma_ops->exit(host);
>>>>>>> @@ -2056,20 +2023,18 @@ static int __exit dw_mci_remove(struct =
platform_device *pdev)
>>>>>>>               regulator_put(host->vmmc);
>>>>>>>       }
>>>>>>>
>>>>>>> -     iounmap(host->regs);
>>>>>>> -
>>>>>>> -     kfree(host);
>>>>>>> -     return 0;
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL(dw_mci_remove);
>>>>>>> +
>>>>>>> +
>>>>>>>
>>>>>>>  #ifdef CONFIG_PM
>>>>>>>  /*
>>>>>>>   * TODO: we should probably disable the clock to the card in t=
he suspend path.
>>>>>>>   */
>>>>>>> -static int dw_mci_suspend(struct platform_device *pdev, pm_mes=
sage_t mesg)
>>>>>>> +int dw_mci_suspend(struct dw_mci *host)
>>>>>>>  {
>>>>>>> -     int i, ret;
>>>>>>> -     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>> +     int i, ret =3D 0;
>>>>>>>
>>>>>>>       for (i =3D 0; i < host->num_slots; i++) {
>>>>>>>               struct dw_mci_slot *slot =3D host->slot[i];
>>>>>>> @@ -2091,19 +2056,18 @@ static int dw_mci_suspend(struct platfo=
rm_device *pdev, pm_message_t mesg)
>>>>>>>
>>>>>>>       return 0;
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL(dw_mci_suspend);
>>>>>>>
>>>>>>> -static int dw_mci_resume(struct platform_device *pdev)
>>>>>>> +int dw_mci_resume(struct dw_mci *host)
>>>>>>>  {
>>>>>>>       int i, ret;
>>>>>>> -     struct dw_mci *host =3D platform_get_drvdata(pdev);
>>>>>>> -
>>>>>>>       if (host->vmmc)
>>>>>>>               regulator_enable(host->vmmc);
>>>>>>>
>>>>>>>       if (host->dma_ops->init)
>>>>>>>               host->dma_ops->init(host);
>>>>>>>
>>>>>>> -     if (!mci_wait_reset(&pdev->dev, host)) {
>>>>>>> +     if (!mci_wait_reset(&host->dev, host)) {
>>>>>>>               ret =3D -ENODEV;
>>>>>>>               return ret;
>>>>>>>       }
>>>>>>> @@ -2125,31 +2089,19 @@ static int dw_mci_resume(struct platfor=
m_device *pdev)
>>>>>>>               if (ret < 0)
>>>>>>>                       return ret;
>>>>>>>       }
>>>>>>> -
>>>>>>>       return 0;
>>>>>>>  }
>>>>>>> -#else
>>>>>>> -#define dw_mci_suspend       NULL
>>>>>>> -#define dw_mci_resume        NULL
>>>>>>> +EXPORT_SYMBOL(dw_mci_resume);
>>>>>>>  #endif /* CONFIG_PM */
>>>>>>>
>>>>>>> -static struct platform_driver dw_mci_driver =3D {
>>>>>>> -     .remove         =3D __exit_p(dw_mci_remove),
>>>>>>> -     .suspend        =3D dw_mci_suspend,
>>>>>>> -     .resume         =3D dw_mci_resume,
>>>>>>> -     .driver         =3D {
>>>>>>> -             .name           =3D "dw_mmc",
>>>>>>> -     },
>>>>>>> -};
>>>>>>> -
>>>>>>>  static int __init dw_mci_init(void)
>>>>>>>  {
>>>>>>> -     return platform_driver_probe(&dw_mci_driver, dw_mci_probe=
);
>>>>>>> +     printk(KERN_INFO "Synopsys Designware Multimedia Card Int=
erface Driver");
>>>>>>> +     return 0;
>>>>>>>  }
>>>>>>>
>>>>>>>  static void __exit dw_mci_exit(void)
>>>>>>>  {
>>>>>>> -     platform_driver_unregister(&dw_mci_driver);
>>>>>>>  }
>>>>>>>
>>>>>>>  module_init(dw_mci_init);
>>>>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mm=
c.h
>>>>>>> index 72c071f..70078f6 100644
>>>>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>>>>> @@ -175,4 +175,11 @@
>>>>>>>       (*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) =3D=
 (value))
>>>>>>>  #endif
>>>>>>>
>>>>>>> +extern int dw_mci_probe(struct dw_mci *host);
>>>>>>> +extern void dw_mci_remove(struct dw_mci *host);
>>>>>>> +#ifdef CONFIG_PM
>>>>>>> +extern int dw_mci_suspend(struct dw_mci *host);
>>>>>>> +extern int dw_mci_resume(struct dw_mci *host);
>>>>>>> +#endif
>>>>>>> +
>>>>>>>  #endif /* _DW_MMC_H_ */
>>>>>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_=
mmc.h
>>>>>>> index 6dc9b80..9cf592c 100644
>>>>>>> --- a/include/linux/mmc/dw_mmc.h
>>>>>>> +++ b/include/linux/mmc/dw_mmc.h
>>>>>>> @@ -74,7 +74,7 @@ struct mmc_data;
>>>>>>>   * @num_slots: Number of slots available.
>>>>>>>   * @verid: Denote Version ID.
>>>>>>>   * @data_offset: Set the offset of DATA register according to =
VERID.
>>>>>>> - * @pdev: Platform device associated with the MMC controller.
>>>>>>> + * @dev: Device associated with the MMC controller.
>>>>>>>   * @pdata: Platform data associated with the MMC controller.
>>>>>>>   * @slot: Slots sharing this MMC controller.
>>>>>>>   * @fifo_depth: depth of FIFO.
>>>>>>> @@ -85,6 +85,8 @@ struct mmc_data;
>>>>>>>   * @push_data: Pointer to FIFO push function.
>>>>>>>   * @pull_data: Pointer to FIFO pull function.
>>>>>>>   * @quirks: Set of quirks that apply to specific versions of t=
he IP.
>>>>>>> + * @irq_flags: The flags to be passed to request_irq.
>>>>>>> + * @irq: The irq value to be passed to request_irq.
>>>>>>>   *
>>>>>>>   * Locking
>>>>>>>   * =3D=3D=3D=3D=3D=3D=3D
>>>>>>> @@ -151,7 +153,7 @@ struct dw_mci {
>>>>>>>       u32                     fifoth_val;
>>>>>>>       u16                     verid;
>>>>>>>       u16                     data_offset;
>>>>>>> -     struct platform_device  *pdev;
>>>>>>> +     struct device           dev;
>>>>>>>       struct dw_mci_board     *pdata;
>>>>>>>       struct dw_mci_slot      *slot[MAX_MCI_SLOTS];
>>>>>>>
>>>>>>> @@ -172,6 +174,8 @@ struct dw_mci {
>>>>>>>       u32                     quirks;
>>>>>>>
>>>>>>>       struct regulator        *vmmc;  /* Power regulator */
>>>>>>> +     unsigned long           irq_flags; /* IRQ flags */
>>>>>>> +     unsigned int            irq;
>>>>>>>  };
>>>>>>>
>>>>>>>  /* DMA ops for Internal/External DMAC interface */
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>
>>
>=20
>=20
>=20
> --
> regards,
> Shashidhar Hiremath

