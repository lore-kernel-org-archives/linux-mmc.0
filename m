From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v5 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 11 Jan 2012 15:03:19 +0530
Message-ID: <CANYdXnognTLqabAedtp3OCFjfoo_UmirpvncS0jC+E3UJO1wQA@mail.gmail.com>
References: <1322732488-21633-1-git-send-email-shashidharh@vayavyalabs.com>
	<4ED74CFF.80705@imgtec.com>
	<CANYdXnr8M0boyisoT16nGPshANHjo84bj33OKOSpGJRm5rzGdg@mail.gmail.com>
	<4ED75F19.70105@imgtec.com>
	<CANYdXnqAiM7qAd10FHGJuzW-8dS4OfQn_j0Tyi-aHFFVJMJ3hw@mail.gmail.com>
	<4EF34079.2000103@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47504 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2AKJdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 04:33:20 -0500
Received: by iabz25 with SMTP id z25so853746iab.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2012 01:33:19 -0800 (PST)
In-Reply-To: <4EF34079.2000103@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi James,

  Since Jae hoon's patch on dev_pm_ops patch is now present in
mmc-next branch. Can I submit  PCI patch again with all the changes
suggested by you and bug found by me while testing ?

Also note that the latest PCI patch has been tested on  XLINX XC2V3000
=46F1152AMT0221 D1215994A VIRTEX FPGA board.

On Thu, Dec 22, 2011 at 8:06 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
>
> I've minimally tested the platform version, but on the current mmc-ne=
xt
> I need the extra includes below. With these changes the patch looks
> okay to me.
>
> Note however that this patch will conflict with Jaehoon Chung's
> dev_pm_ops patch, so it's probably worth fixing it to apply on top of
> that once it's gone into mmc-next.
>
> Thanks
> James
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-=
pci.c
> index 5734cf7..bcfbeb2 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -11,7 +11,9 @@
>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/irq.h>
> +#include <linux/module.h>
> =C2=A0#include <linux/pci.h>
> +#include <linux/slab.h>
> =C2=A0#include <linux/mmc/host.h>
> =C2=A0#include <linux/mmc/mmc.h>
> =C2=A0#include <linux/mmc/dw_mmc.h>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mm=
c-pltfm.c
> index fdf148d..0de2d03 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -11,7 +11,9 @@
> =C2=A0*/
>
> =C2=A0#include <linux/interrupt.h>
> +#include <linux/io.h>
> =C2=A0#include <linux/irq.h>
> +#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/mmc/host.h>
>
>
> On 12/22/2011 05:43 AM, Shashidhar Hiremath wrote:
> > Hi James,
> > Any updates on this patch ?
> >
> > On Thu, Dec 1, 2011 at 4:33 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
> >> On 12/01/2011 10:51 AM, Shashidhar Hiremath wrote:
> >>> yes, I have compiled both the variants.
> >>
> >>> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0drivers/mmc/host/dw_mmc-pltfm.o
> >>> drivers/mmc/host/dw_mmc-pltfm.c: In function =E2=80=98dw_mci_pltf=
m_probe=E2=80=99:
> >>> drivers/mmc/host/dw_mmc-pltfm.c:48: error: implicit declaration o=
f function =E2=80=98ioremap=E2=80=99
> >>> drivers/mmc/host/dw_mmc-pltfm.c:48: warning: assignment makes poi=
nter from integer without a cast
> >>> drivers/mmc/host/dw_mmc-pltfm.c:57: error: implicit declaration o=
f function =E2=80=98iounmap=E2=80=99
> >>
> >> Okay, possibly it's because I'm compiling on x86, and the arm head=
ers are different.
> >> The following fixes it for me:
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw=
_mmc-pltfm.c
> >> index fdf148d..7af2519 100644
> >> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> >> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> >> @@ -11,6 +11,7 @@
> >> =C2=A0*/
> >>
> >> =C2=A0#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> =C2=A0#include <linux/irq.h>
> >> =C2=A0#include <linux/platform_device.h>
> >> =C2=A0#include <linux/slab.h>
> >>
> >> Cheers
> >> James
> >>
> >>>
> >>> On Thu, Dec 1, 2011 at 3:16 PM, James Hogan <james.hogan@imgtec.c=
om> wrote:
> >>>> On 12/01/2011 09:41 AM, Shashidhar Hiremath wrote:
> >>>>> Please forgive me for repetative patches.Some mailing addresses=
 were wrong.
> >>>>> So, resending the patch.
> >>>>> Support of PCI mode for the dw_mmc driver. This Patch adds the
> >>>>> support for the scenario where the Synopsys Designware IP
> >>>>> is present on the PCI bus. The patch adds the minimal modificat=
ions
> >>>>> necessary for the driver to work on PCI platform. Also added se=
parate
> >>>>> files for PCI and PLATFORM modes of operation.
> >>>>>
> >>>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com=
>
> >>>>
> >>>> You might like to try compiling with the platform version enable=
d too.
> >>>>
> >>>> Cheers
> >>>> James
> >>>>
> >>>>> ---
> >>>>> v2:
> >>>>> *As per Suggestions by Will Newton and James Hogan
> >>>>> -Reduced the number of ifdefs
> >>>>> v3:
> >>>>> *As per Suggestions by Will Newton and James Hogan
> >>>>> -Added separate files for PCI and PLATFORM Modes similar to SDH=
CI driver
> >>>>> v4:
> >>>>> *As per Suggestions by James Hogan
> >>>>> -Fixed Indentation Issue.
> >>>>> -Added Proper error Handling for probe and remove sequences.
> >>>>> -Modified location of some code.
> >>>>> -Added isr_flags to dw_mmc.h and removed the ifdef PCI from dri=
ver.
> >>>>> v5:
> >>>>> *As per Suggestions by James Hogan
> >>>>> -removed the redundant code.
> >>>>> -fixed the compilation errors.
> >>>>> -Modified the menuconfig Message for PLATFORM mode.
> >>>>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 25 ++++++
> >>>>> =C2=A0drivers/mmc/host/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A02 +
> >>>>> =C2=A0drivers/mmc/host/dw_mmc-pci.c =C2=A0 | =C2=A0152 ++++++++=
++++++++++++++++++++++++++++++
> >>>>> =C2=A0drivers/mmc/host/dw_mmc-pltfm.c | =C2=A0133 +++++++++++++=
++++++++++++++++++++
> >>>>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A015=
6 +++++++++++++-------------------------
> >>>>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A07 ++
> >>>>> =C2=A0include/linux/mmc/dw_mmc.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A08 ++-
> >>>>> =C2=A07 files changed, 379 insertions(+), 104 deletions(-)
> >>>>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pci.c
> >>>>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfi=
g
> >>>>> index 87d5067..72f48b9 100644
> >>>>> --- a/drivers/mmc/host/Kconfig
> >>>>> +++ b/drivers/mmc/host/Kconfig
> >>>>> @@ -534,6 +534,31 @@ config MMC_DW_IDMAC
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Designware Mobile Storage IP block.=
 This disables the external DMA
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface.
> >>>>>
> >>>>> +config MMC_DW_PLTFM
> >>>>> + =C2=A0 =C2=A0 tristate "Synopsys Designware MCI Support as pl=
atform device"
> >>>>> + =C2=A0 =C2=A0 depends on MMC_DW
> >>>>> + =C2=A0 =C2=A0 default y
> >>>>> + =C2=A0 =C2=A0 help
> >>>>> + =C2=A0 =C2=A0 =C2=A0 This selects the common helper functions=
 support for Host Controller
> >>>>> + =C2=A0 =C2=A0 =C2=A0 Interface based platform driver. Please =
select this option if the IP
> >>>>> + =C2=A0 =C2=A0 =C2=A0 is present as a platform device. This is=
 the common interface for the
> >>>>> + =C2=A0 =C2=A0 =C2=A0 Synopsys Designware IP.
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this inter=
face, say Y or M here.
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say Y.
> >>>>> +
> >>>>> +config MMC_DW_PCI
> >>>>> + =C2=A0 =C2=A0 tristate "Synopsys Designware MCI support on PC=
I bus"
> >>>>> + =C2=A0 =C2=A0 depends on MMC_DW && PCI
> >>>>> + =C2=A0 =C2=A0 help
> >>>>> + =C2=A0 =C2=A0 =C2=A0 This selects the PCI bus for the Synopsy=
s Designware Mobile Storage IP.
> >>>>> + =C2=A0 =C2=A0 =C2=A0 Select this option if the IP is present =
on PCI platform.
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this inter=
face, say Y or M here.
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
> >>>>> +
> >>>>> =C2=A0config MMC_SH_MMCIF
> >>>>> =C2=A0 =C2=A0 =C2=A0 tristate "SuperH Internal MMCIF support"
> >>>>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_BLOCK && (SUPERH || ARCH_SH=
MOBILE)
> >>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makef=
ile
> >>>>> index b4b83f3..3aa2fa3 100644
> >>>>> --- a/drivers/mmc/host/Makefile
> >>>>> +++ b/drivers/mmc/host/Makefile
> >>>>> @@ -38,6 +38,8 @@ obj-$(CONFIG_MMC_CB710) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +=3D cb710-mmc.o
> >>>>> =C2=A0obj-$(CONFIG_MMC_VIA_SDMMC) =C2=A0+=3D via-sdmmc.o
> >>>>> =C2=A0obj-$(CONFIG_SDH_BFIN) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +=3D bfin_sdh.o
> >>>>> =C2=A0obj-$(CONFIG_MMC_DW) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D dw_=
mmc.o
> >>>>> +obj-$(CONFIG_MMC_DW_PLTFM) =C2=A0 +=3D dw_mmc-pltfm.o
> >>>>> +obj-$(CONFIG_MMC_DW_PCI) =C2=A0 =C2=A0 +=3D dw_mmc-pci.o
> >>>>> =C2=A0obj-$(CONFIG_MMC_SH_MMCIF) =C2=A0 +=3D sh_mmcif.o
> >>>>> =C2=A0obj-$(CONFIG_MMC_JZ4740) =C2=A0 =C2=A0 +=3D jz4740_mmc.o
> >>>>> =C2=A0obj-$(CONFIG_MMC_VUB300) =C2=A0 =C2=A0 +=3D vub300.o
> >>>>> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/d=
w_mmc-pci.c
> >>>>> new file mode 100644
> >>>>> index 0000000..5734cf7
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/mmc/host/dw_mmc-pci.c
> >>>>> @@ -0,0 +1,152 @@
> >>>>> +/*
> >>>>> + * Synopsys DesignWare Multimedia Card PCI Interface driver
> >>>>> + *
> >>>>> + * Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
> >>>>> + *
> >>>>> + * This program is free software; you can redistribute it and/=
or modify
> >>>>> + * it under the terms of the GNU General Public License as pub=
lished by
> >>>>> + * the Free Software Foundation; either version 2 of the Licen=
se, or
> >>>>> + * (at your option) any later version.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/interrupt.h>
> >>>>> +#include <linux/irq.h>
> >>>>> +#include <linux/pci.h>
> >>>>> +#include <linux/mmc/host.h>
> >>>>> +#include <linux/mmc/mmc.h>
> >>>>> +#include <linux/mmc/dw_mmc.h>
> >>>>> +#include "dw_mmc.h"
> >>>>> +
> >>>>> +#define PCI_BAR_NO 2
> >>>>> +#define COMPLETE_BAR 0
> >>>>> +#define DW_MCI_VENDOR_ID 0x700
> >>>>> +#define DW_MCI_DEVICE_ID 0x1107
> >>>>> +/* Defining the Capabilities */
> >>>>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_=
HIGHSPEED |\
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BI=
T_DATA |\
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SDIO_IRQ)
> >>>>> +
> >>>>> +static struct dw_mci_board pci_board_data =3D {
> >>>>> + =C2=A0 =C2=A0 .num_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> >>>>> + =C2=A0 =C2=A0 .caps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D DW_MCI_CAPABILITI=
ES,
> >>>>> + =C2=A0 =C2=A0 .bus_hz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 33 * 1000 * 1000,
> >>>>> + =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 200,
> >>>>> + =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
> >>>>> +};
> >>>>> +
> >>>>> +static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *=
entries)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host;
> >>>>> + =C2=A0 =C2=A0 int ret;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 ret =3D pci_enable_device(pdev);
> >>>>> + =C2=A0 =C2=A0 if (ret)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>>> + =C2=A0 =C2=A0 if (pci_request_regions(pdev, "dw_mmc_pci")) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_disable_de=
v;
> >>>>> + =C2=A0 =C2=A0 }
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KER=
NEL);
> >>>>> + =C2=A0 =C2=A0 if (!host) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_release;
> >>>>> + =C2=A0 =C2=A0 }
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host->irq =3D pdev->irq;
> >>>>> + =C2=A0 =C2=A0 host->irq_flags =3D IRQF_SHARED;
> >>>>> + =C2=A0 =C2=A0 host->dev =3D pdev->dev;
> >>>>> + =C2=A0 =C2=A0 host->pdata =3D &pci_board_data;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host->regs =3D pci_iomap(pdev, PCI_BAR_NO, COMP=
LETE_BAR);
> >>>>> + =C2=A0 =C2=A0 if (!host->regs) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EIO;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_unmap;
> >>>>> + =C2=A0 =C2=A0 }
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, host);
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_probe(host);
> >>>>> + =C2=A0 =C2=A0 if (ret)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_probe_fail=
ed;
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +
> >>>>> +err_probe_failed:
> >>>>> + =C2=A0 =C2=A0 pci_iounmap(pdev, host->regs);
> >>>>> +err_unmap:
> >>>>> + =C2=A0 =C2=A0 kfree(host);
> >>>>> +err_release:
> >>>>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
> >>>>> +err_disable_dev:
> >>>>> + =C2=A0 =C2=A0 pci_disable_device(pdev);
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 dw_mci_remove(host);
> >>>>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, NULL);
> >>>>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
> >>>>> + =C2=A0 =C2=A0 pci_iounmap(pdev, host->regs);
> >>>>> + =C2=A0 =C2=A0 kfree(host);
> >>>>> + =C2=A0 =C2=A0 pci_disable_device(pdev);
> >>>>> +}
> >>>>> +
> >>>>> +#ifdef CONFIG_PM
> >>>>> +static int dw_mci_pci_suspend(struct pci_dev *pdev, pm_message=
_t mesg)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 int ret;
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_suspend(host);
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int dw_mci_pci_resume(struct pci_dev *pdev)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 int ret;
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_resume(host);
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +}
> >>>>> +
> >>>>> +#else
> >>>>> +#define dw_mci_pci_suspend =C2=A0 NULL
> >>>>> +#define dw_mci_pci_resume =C2=A0 =C2=A0NULL
> >>>>> +#endif /* CONFIG_PM */
> >>>>> +
> >>>>> +static DEFINE_PCI_DEVICE_TABLE(dw_mci_pci_id) =3D {
> >>>>> + =C2=A0 =C2=A0 { PCI_DEVICE(DW_MCI_DEVICE_ID, DW_MCI_VENDOR_ID=
) },
> >>>>> + =C2=A0 =C2=A0 {}
> >>>>> +};
> >>>>> +MODULE_DEVICE_TABLE(pci, dw_mci_pci_id);
> >>>>> +
> >>>>> +static struct pci_driver dw_mci_pci_driver =3D {
> >>>>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "d=
w_mmc_pci",
> >>>>> + =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_pci_i=
d,
> >>>>> + =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw=
_mci_pci_probe,
> >>>>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_=
pci_remove,
> >>>>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
pci_suspend,
> >>>>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_=
pci_resume,
> >>>>> +};
> >>>>> +
> >>>>> +static int __init dw_mci_init(void)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 return pci_register_driver(&dw_mci_pci_driver);
> >>>>> +}
> >>>>> +
> >>>>> +static void __exit dw_mci_exit(void)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 pci_unregister_driver(&dw_mci_pci_driver);
> >>>>> +}
> >>>>> +
> >>>>> +module_init(dw_mci_init);
> >>>>> +module_exit(dw_mci_exit);
> >>>>> +
> >>>>> +MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
> >>>>> +MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.co=
m>");
> >>>>> +MODULE_AUTHOR("VayavyaLabs Pvt. Ltd.");
> >>>>> +MODULE_LICENSE("GPL v2");
> >>>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host=
/dw_mmc-pltfm.c
> >>>>> new file mode 100644
> >>>>> index 0000000..fdf148d
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> >>>>> @@ -0,0 +1,133 @@
> >>>>> +/*
> >>>>> + * Synopsys DesignWare Multimedia Card Interface driver
> >>>>> + *
> >>>>> + * Copyright (C) 2009 NXP Semiconductors
> >>>>> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
> >>>>> + *
> >>>>> + * This program is free software; you can redistribute it and/=
or modify
> >>>>> + * it under the terms of the GNU General Public License as pub=
lished by
> >>>>> + * the Free Software Foundation; either version 2 of the Licen=
se, or
> >>>>> + * (at your option) any later version.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/interrupt.h>
> >>>>> +#include <linux/irq.h>
> >>>>> +#include <linux/platform_device.h>
> >>>>> +#include <linux/slab.h>
> >>>>> +#include <linux/mmc/host.h>
> >>>>> +#include <linux/mmc/mmc.h>
> >>>>> +#include <linux/mmc/dw_mmc.h>
> >>>>> +#include "dw_mmc.h"
> >>>>> +
> >>>>> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host;
> >>>>> + =C2=A0 =C2=A0 struct resource *regs;
> >>>>> + =C2=A0 =C2=A0 int =C2=A0ret;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KER=
NEL);
> >>>>> + =C2=A0 =C2=A0 if (!host)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> >>>>> + =C2=A0 =C2=A0 if (!regs) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENXIO;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
> >>>>> + =C2=A0 =C2=A0 }
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host->irq =3D platform_get_irq(pdev, 0);
> >>>>> + =C2=A0 =C2=A0 if (host->irq < 0) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D host->irq;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
> >>>>> + =C2=A0 =C2=A0 }
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 host->dev =3D pdev->dev;
> >>>>> + =C2=A0 =C2=A0 host->irq_flags =3D 0;
> >>>>> + =C2=A0 =C2=A0 host->pdata =3D pdev->dev.platform_data;
> >>>>> + =C2=A0 =C2=A0 ret =3D -ENOMEM;
> >>>>> + =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_si=
ze(regs));
> >>>>> + =C2=A0 =C2=A0 if (!host->regs)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
> >>>>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_probe(host);
> >>>>> + =C2=A0 =C2=A0 if (ret)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +err_out:
> >>>>> + =C2=A0 =C2=A0 iounmap(host->regs);
> >>>>> +err_free:
> >>>>> + =C2=A0 =C2=A0 kfree(host);
> >>>>> + =C2=A0 =C2=A0 return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int __exit dw_mci_pltfm_remove(struct platform_device *=
pdev)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> +
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> >>>>> + =C2=A0 =C2=A0 dw_mci_remove(host);
> >>>>> + =C2=A0 =C2=A0 iounmap(host->regs);
> >>>>> + =C2=A0 =C2=A0 kfree(host);
> >>>>> + =C2=A0 =C2=A0 return 0;
> >>>>> +}
> >>>>> +#ifdef CONFIG_PM
> >>>>> +/*
> >>>>> + * TODO: we should probably disable the clock to the card in t=
he suspend path.
> >>>>> + */
> >>>>> +static int dw_mci_pltfm_suspend(struct platform_device *pdev, =
pm_message_t mesg)
> >>>>> +{
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 int =C2=A0ret;
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_suspend(host);
> >>>>> + =C2=A0 =C2=A0 if (ret)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int dw_mci_pltfm_resume(struct platform_device *pdev)
> >>>>> +{
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 int ret;
> >>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 ret =3D dw_mci_resume(host);
> >>>>> + =C2=A0 =C2=A0 if (ret)
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>>> +
> >>>>> + =C2=A0 =C2=A0 return 0;
> >>>>> +}
> >>>>> +#else
> >>>>> +#define dw_mci_pltfm_suspend NULL
> >>>>> +#define dw_mci_pltfm_resume =C2=A0NULL
> >>>>> +#endif /* CONFIG_PM */
> >>>>> +
> >>>>> +static struct platform_driver dw_mci_pltfm_driver =3D {
> >>>>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_=
p(dw_mci_pltfm_remove),
> >>>>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
pltfm_suspend,
> >>>>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_=
pltfm_resume,
> >>>>> + =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc",
> >>>>> + =C2=A0 =C2=A0 },
> >>>>> +};
> >>>>> +
> >>>>> +static int __init dw_mci_init(void)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 return platform_driver_probe(&dw_mci_pltfm_driv=
er, dw_mci_pltfm_probe);
> >>>>> +}
> >>>>> +
> >>>>> +static void __exit dw_mci_exit(void)
> >>>>> +{
> >>>>> + =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_pltfm_driver=
);
> >>>>> +}
> >>>>> +
> >>>>> +module_init(dw_mci_init);
> >>>>> +module_exit(dw_mci_exit);
> >>>>> +
> >>>>> +MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
> >>>>> +MODULE_AUTHOR("NXP Semiconductor VietNam");
> >>>>> +MODULE_AUTHOR("Imagination Technologies Ltd");
> >>>>> +MODULE_LICENSE("GPL v2");
> >>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mm=
c.c
> >>>>> index 3aaeb08..928abc0 100644
> >>>>> --- a/drivers/mmc/host/dw_mmc.c
> >>>>> +++ b/drivers/mmc/host/dw_mmc.c
> >>>>> @@ -269,7 +269,7 @@ static void dw_mci_start_command(struct dw_=
mci *host,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_command *cmd=
, u32 cmd_flags)
> >>>>> =C2=A0{
> >>>>> =C2=A0 =C2=A0 =C2=A0 host->cmd =3D cmd;
> >>>>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev,
> >>>>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"start c=
ommand: ARGR=3D0x%08x CMDR=3D0x%08x\n",
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd->arg=
, cmd_flags);
> >>>>>
> >>>>> @@ -302,7 +302,7 @@ static void dw_mci_dma_cleanup(struct dw_mc=
i *host)
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct mmc_data *data =3D host->data;
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (data)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_unmap_sg(&host-=
>pdev->dev, data->sg, data->sg_len,
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_unmap_sg(&host-=
>dev, data->sg, data->sg_len,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((data->flags & MMC_DATA_WRITE)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
> >>>>> =C2=A0}
> >>>>> @@ -327,7 +327,7 @@ static void dw_mci_idmac_complete_dma(struc=
t dw_mci *host)
> >>>>> =C2=A0{
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct mmc_data *data =3D host->data;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev, "DMA complete\n");
> >>>>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev, "DMA complete\n");
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 host->dma_ops->cleanup(host);
> >>>>>
> >>>>> @@ -463,10 +463,10 @@ static int dw_mci_submit_data_dma(struct =
dw_mci *host, struct mmc_data *data)
> >>>>> =C2=A0 =C2=A0 =C2=A0 else
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction =3D =
DMA_TO_DEVICE;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 sg_len =3D dma_map_sg(&host->pdev->dev, data->s=
g, data->sg_len,
> >>>>> + =C2=A0 =C2=A0 sg_len =3D dma_map_sg(&host->dev, data->sg, dat=
a->sg_len,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 direction);
> >>>>>
> >>>>> - =C2=A0 =C2=A0 dev_vdbg(&host->pdev->dev,
> >>>>> + =C2=A0 =C2=A0 dev_vdbg(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"sd sg_c=
pu: %#lx sg_dma: %#lx sg_len: %d\n",
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigne=
d long)host->sg_cpu, (unsigned long)host->sg_dma,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_len);
> >>>>> @@ -804,12 +804,12 @@ static void dw_mci_request_end(struct dw_=
mci *host, struct mmc_request *mrq)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot =3D list_=
entry(host->queue.next,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot, qu=
eue_node);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&slot=
->queue_node);
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->pde=
v->dev, "list not empty: %s is next\n",
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->dev=
, "list not empty: %s is next\n",
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mmc_hostname(slot->mmc));
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->state =3D=
 STATE_SENDING_CMD;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_mci_start_r=
equest(host, slot);
> >>>>> =C2=A0 =C2=A0 =C2=A0 } else {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->pde=
v->dev, "list empty\n");
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_vdbg(&host->dev=
, "list empty\n");
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->state =3D=
 STATE_IDLE;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> @@ -941,7 +941,7 @@ static void dw_mci_tasklet_func(unsigned lo=
ng priv)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
ata->bytes_xfered =3D 0;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
ata->error =3D -ETIMEDOUT;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err=
(&host->pdev->dev,
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err=
(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "data FIFO error "
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "(status=3D%08x)\n",
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 status);
> >>>>> @@ -1651,7 +1651,7 @@ static int __init dw_mci_init_slot(struct=
 dw_mci *host, unsigned int id)
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct mmc_host *mmc;
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *slot;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slo=
t), &host->pdev->dev);
> >>>>> + =C2=A0 =C2=A0 mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slo=
t), &host->dev);
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (!mmc)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM=
;
> >>>>>
> >>>>> @@ -1757,10 +1757,10 @@ static void dw_mci_cleanup_slot(struct =
dw_mci_slot *slot, unsigned int id)
> >>>>> =C2=A0static void dw_mci_init_dma(struct dw_mci *host)
> >>>>> =C2=A0{
> >>>>> =C2=A0 =C2=A0 =C2=A0 /* Alloc memory for sg translation */
> >>>>> - =C2=A0 =C2=A0 host->sg_cpu =3D dma_alloc_coherent(&host->pdev=
->dev, PAGE_SIZE,
> >>>>> + =C2=A0 =C2=A0 host->sg_cpu =3D dma_alloc_coherent(&host->dev,=
 PAGE_SIZE,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &host->sg_dma, GFP_KERNEL);
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (!host->sg_cpu) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->pdev=
->dev, "%s: could not alloc DMA memory\n",
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,=
 "%s: could not alloc DMA memory\n",
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __func__);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_dma;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> @@ -1768,7 +1768,7 @@ static void dw_mci_init_dma(struct dw_mci=
 *host)
> >>>>> =C2=A0 =C2=A0 =C2=A0 /* Determine which DMA interface to use */
> >>>>> =C2=A0#ifdef CONFIG_MMC_DW_IDMAC
> >>>>> =C2=A0 =C2=A0 =C2=A0 host->dma_ops =3D &dw_mci_idmac_ops;
> >>>>> - =C2=A0 =C2=A0 dev_info(&host->pdev->dev, "Using internal DMA =
controller.\n");
> >>>>> + =C2=A0 =C2=A0 dev_info(&host->dev, "Using internal DMA contro=
ller.\n");
> >>>>> =C2=A0#endif
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (!host->dma_ops)
> >>>>> @@ -1776,12 +1776,12 @@ static void dw_mci_init_dma(struct dw_m=
ci *host)
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->dma_ops->init) {
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->dma_=
ops->init(host)) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&host->pdev->dev, "%s: Unable to initialize "
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&host->dev, "%s: Unable to initialize "
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "DMA Controller.\n", __func__=
);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 goto no_dma;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> >>>>> =C2=A0 =C2=A0 =C2=A0 } else {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->pdev=
->dev, "DMA initialization not found.\n");
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,=
 "DMA initialization not found.\n");
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_dma;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> @@ -1789,7 +1789,7 @@ static void dw_mci_init_dma(struct dw_mci=
 *host)
> >>>>> =C2=A0 =C2=A0 =C2=A0 return;
> >>>>>
> >>>>> =C2=A0no_dma:
> >>>>> - =C2=A0 =C2=A0 dev_info(&host->pdev->dev, "Using PIO mode.\n")=
;
> >>>>> + =C2=A0 =C2=A0 dev_info(&host->dev, "Using PIO mode.\n");
> >>>>> =C2=A0 =C2=A0 =C2=A0 host->use_dma =3D 0;
> >>>>> =C2=A0 =C2=A0 =C2=A0 return;
> >>>>> =C2=A0}
> >>>>> @@ -1815,61 +1815,37 @@ static bool mci_wait_reset(struct devic=
e *dev, struct dw_mci *host)
> >>>>> =C2=A0 =C2=A0 =C2=A0 return false;
> >>>>> =C2=A0}
> >>>>>
> >>>>> -static int dw_mci_probe(struct platform_device *pdev)
> >>>>> +int dw_mci_probe(struct dw_mci *host)
> >>>>> =C2=A0{
> >>>>> - =C2=A0 =C2=A0 struct dw_mci *host;
> >>>>> - =C2=A0 =C2=A0 struct resource *regs;
> >>>>> - =C2=A0 =C2=A0 struct dw_mci_board *pdata;
> >>>>> - =C2=A0 =C2=A0 int irq, ret, i, width;
> >>>>> + =C2=A0 =C2=A0 int width, i, ret =3D 0;
> >>>>> =C2=A0 =C2=A0 =C2=A0 u32 fifo_size;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> >>>>> - =C2=A0 =C2=A0 if (!regs)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
> >>>>> -
> >>>>> - =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
> >>>>> - =C2=A0 =C2=A0 if (irq < 0)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return irq;
> >>>>> -
> >>>>> - =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KER=
NEL);
> >>>>> - =C2=A0 =C2=A0 if (!host)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> >>>>> -
> >>>>> - =C2=A0 =C2=A0 host->pdev =3D pdev;
> >>>>> - =C2=A0 =C2=A0 host->pdata =3D pdata =3D pdev->dev.platform_da=
ta;
> >>>>> - =C2=A0 =C2=A0 if (!pdata || !pdata->init) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
> >>>>> + =C2=A0 =C2=A0 if (!host->pdata || !host->pdata->init) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 "Platform data must supply init function\n");
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> - =C2=A0 =C2=A0 if (!pdata->select_slot && pdata->num_slots > 1=
) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
> >>>>> + =C2=A0 =C2=A0 if (!host->pdata->select_slot && host->pdata->n=
um_slots > 1) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 "Platform data must supply select_slot function\n");
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> - =C2=A0 =C2=A0 if (!pdata->bus_hz) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
> >>>>> + =C2=A0 =C2=A0 if (!host->pdata->bus_hz) {
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&host->dev,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 "Platform data must supply bus speed\n");
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> - =C2=A0 =C2=A0 host->bus_hz =3D pdata->bus_hz;
> >>>>> - =C2=A0 =C2=A0 host->quirks =3D pdata->quirks;
> >>>>> + =C2=A0 =C2=A0 host->bus_hz =3D host->pdata->bus_hz;
> >>>>> + =C2=A0 =C2=A0 host->quirks =3D host->pdata->quirks;
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&host->lock);
> >>>>> =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&host->queue);
> >>>>>
> >>>>> - =C2=A0 =C2=A0 ret =3D -ENOMEM;
> >>>>> - =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_si=
ze(regs));
> >>>>> - =C2=A0 =C2=A0 if (!host->regs)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 host->dma_ops =3D pdata->dma_ops;
> >>>>> + =C2=A0 =C2=A0 host->dma_ops =3D host->pdata->dma_ops;
> >>>>> =C2=A0 =C2=A0 =C2=A0 dw_mci_init_dma(host);
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 /*
> >>>>> @@ -1899,7 +1875,7 @@ static int dw_mci_probe(struct platform_d=
evice *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 /* Reset all blocks */
> >>>>> - =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
> >>>>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&host->dev, host)) {
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODE=
V;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaun=
map;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> @@ -1942,13 +1918,11 @@ static int dw_mci_probe(struct platform=
_device *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (!dw_mci_card_workqueue)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaun=
map;
> >>>>> =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&host->card_work, dw_mci_work_ro=
utine_card);
> >>>>> -
> >>>>> - =C2=A0 =C2=A0 ret =3D request_irq(irq, dw_mci_interrupt, 0, "=
dw-mci", host);
> >>>>> + =C2=A0 =C2=A0 ret =3D request_irq(host->irq, dw_mci_interrupt=
,
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 host->irq_flags, "dw-mci", host);
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (ret)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_workq=
ueue;
> >>>>>
> >>>>> - =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
> >>>>> -
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->pdata->num_slots)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->num_slot=
s =3D host->pdata->num_slots;
> >>>>> =C2=A0 =C2=A0 =C2=A0 else
> >>>>> @@ -1968,7 +1942,7 @@ static int dw_mci_probe(struct platform_d=
evice *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Need to check the version-id and s=
et data-offset for DATA register.
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> >>>>> =C2=A0 =C2=A0 =C2=A0 host->verid =3D SDMMC_GET_VERID(mci_readl(=
host, VERID));
> >>>>> - =C2=A0 =C2=A0 dev_info(&pdev->dev, "Version ID is %04x\n", ho=
st->verid);
> >>>>> + =C2=A0 =C2=A0 dev_info(&host->dev, "Version ID is %04x\n", ho=
st->verid);
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->verid < DW_MMC_240A)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->data_off=
set =3D DATA_OFFSET;
> >>>>> @@ -1985,12 +1959,12 @@ static int dw_mci_probe(struct platform=
_device *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D=
W_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> >>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CTRL, SDMMC_CTRL_INT_ENAB=
LE); /* Enable mci interrupt */
> >>>>>
> >>>>> - =C2=A0 =C2=A0 dev_info(&pdev->dev, "DW MMC controller at irq =
%d, "
> >>>>> + =C2=A0 =C2=A0 dev_info(&host->dev, "DW MMC controller at irq =
%d, "
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%d bit =
host data width, "
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%u deep=
 fifo\n",
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq, width, f=
ifo_size);
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->irq, wi=
dth, fifo_size);
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev=
, "Internal DMAC interrupt fix enabled.\n");
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&host->dev=
, "Internal DMAC interrupt fix enabled.\n");
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 return 0;
> >>>>>
> >>>>> @@ -2001,7 +1975,7 @@ err_init_slot:
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dw_mci_cleanup_slot(host->slot[i], i);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i--;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> - =C2=A0 =C2=A0 free_irq(irq, host);
> >>>>> + =C2=A0 =C2=A0 free_irq(host->irq, host);
> >>>>>
> >>>>> =C2=A0err_workqueue:
> >>>>> =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
> >>>>> @@ -2009,33 +1983,26 @@ err_workqueue:
> >>>>> =C2=A0err_dmaunmap:
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops-=
>exit(host);
> >>>>> - =C2=A0 =C2=A0 dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
> >>>>> + =C2=A0 =C2=A0 dma_free_coherent(&host->dev, PAGE_SIZE,
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 host->sg_cpu, host->sg_dma);
> >>>>> - =C2=A0 =C2=A0 iounmap(host->regs);
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->vmmc) {
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disa=
ble(host->vmmc);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(=
host->vmmc);
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> -
> >>>>> -
> >>>>> -err_freehost:
> >>>>> - =C2=A0 =C2=A0 kfree(host);
> >>>>> =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>>> =C2=A0}
> >>>>> +EXPORT_SYMBOL(dw_mci_probe);
> >>>>>
> >>>>> -static int __exit dw_mci_remove(struct platform_device *pdev)
> >>>>> +void dw_mci_remove(struct dw_mci *host)
> >>>>> =C2=A0{
> >>>>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> =C2=A0 =C2=A0 =C2=A0 int i;
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
> >>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable a=
ll mmc interrupt first */
> >>>>>
> >>>>> - =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> >>>>> -
> >>>>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev,=
 "remove slot %d\n", i);
> >>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&host->dev,=
 "remove slot %d\n", i);
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->slot=
[i])
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dw_mci_cleanup_slot(host->slot[i], i);
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> @@ -2044,9 +2011,9 @@ static int __exit dw_mci_remove(struct pl=
atform_device *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKENA, 0);
> >>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKSRC, 0);
> >>>>>
> >>>>> - =C2=A0 =C2=A0 free_irq(platform_get_irq(pdev, 0), host);
> >>>>> + =C2=A0 =C2=A0 free_irq(host->irq, host);
> >>>>> =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
> >>>>> - =C2=A0 =C2=A0 dma_free_coherent(&pdev->dev, PAGE_SIZE, host->=
sg_cpu, host->sg_dma);
> >>>>> + =C2=A0 =C2=A0 dma_free_coherent(&host->dev, PAGE_SIZE, host->=
sg_cpu, host->sg_dma);
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops-=
>exit(host);
> >>>>> @@ -2056,20 +2023,18 @@ static int __exit dw_mci_remove(struct =
platform_device *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(=
host->vmmc);
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>>
> >>>>> - =C2=A0 =C2=A0 iounmap(host->regs);
> >>>>> -
> >>>>> - =C2=A0 =C2=A0 kfree(host);
> >>>>> - =C2=A0 =C2=A0 return 0;
> >>>>> =C2=A0}
> >>>>> +EXPORT_SYMBOL(dw_mci_remove);
> >>>>> +
> >>>>> +
> >>>>>
> >>>>> =C2=A0#ifdef CONFIG_PM
> >>>>> =C2=A0/*
> >>>>> =C2=A0 * TODO: we should probably disable the clock to the card=
 in the suspend path.
> >>>>> =C2=A0 */
> >>>>> -static int dw_mci_suspend(struct platform_device *pdev, pm_mes=
sage_t mesg)
> >>>>> +int dw_mci_suspend(struct dw_mci *host)
> >>>>> =C2=A0{
> >>>>> - =C2=A0 =C2=A0 int i, ret;
> >>>>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> + =C2=A0 =C2=A0 int i, ret =3D 0;
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_=
slot *slot =3D host->slot[i];
> >>>>> @@ -2091,19 +2056,18 @@ static int dw_mci_suspend(struct platfo=
rm_device *pdev, pm_message_t mesg)
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 return 0;
> >>>>> =C2=A0}
> >>>>> +EXPORT_SYMBOL(dw_mci_suspend);
> >>>>>
> >>>>> -static int dw_mci_resume(struct platform_device *pdev)
> >>>>> +int dw_mci_resume(struct dw_mci *host)
> >>>>> =C2=A0{
> >>>>> =C2=A0 =C2=A0 =C2=A0 int i, ret;
> >>>>> - =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
> >>>>> -
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->vmmc)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_enab=
le(host->vmmc);
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 if (host->dma_ops->init)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops-=
>init(host);
> >>>>>
> >>>>> - =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
> >>>>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&host->dev, host)) {
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODE=
V;
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> @@ -2125,31 +2089,19 @@ static int dw_mci_resume(struct platfor=
m_device *pdev)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return ret;
> >>>>> =C2=A0 =C2=A0 =C2=A0 }
> >>>>> -
> >>>>> =C2=A0 =C2=A0 =C2=A0 return 0;
> >>>>> =C2=A0}
> >>>>> -#else
> >>>>> -#define dw_mci_suspend =C2=A0 =C2=A0 =C2=A0 NULL
> >>>>> -#define dw_mci_resume =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
> >>>>> +EXPORT_SYMBOL(dw_mci_resume);
> >>>>> =C2=A0#endif /* CONFIG_PM */
> >>>>>
> >>>>> -static struct platform_driver dw_mci_driver =3D {
> >>>>> - =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_=
p(dw_mci_remove),
> >>>>> - =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
suspend,
> >>>>> - =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_=
resume,
> >>>>> - =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> >>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc",
> >>>>> - =C2=A0 =C2=A0 },
> >>>>> -};
> >>>>> -
> >>>>> =C2=A0static int __init dw_mci_init(void)
> >>>>> =C2=A0{
> >>>>> - =C2=A0 =C2=A0 return platform_driver_probe(&dw_mci_driver, dw=
_mci_probe);
> >>>>> + =C2=A0 =C2=A0 printk(KERN_INFO "Synopsys Designware Multimedi=
a Card Interface Driver");
> >>>>> + =C2=A0 =C2=A0 return 0;
> >>>>> =C2=A0}
> >>>>>
> >>>>> =C2=A0static void __exit dw_mci_exit(void)
> >>>>> =C2=A0{
> >>>>> - =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_driver);
> >>>>> =C2=A0}
> >>>>>
> >>>>> =C2=A0module_init(dw_mci_init);
> >>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mm=
c.h
> >>>>> index 72c071f..70078f6 100644
> >>>>> --- a/drivers/mmc/host/dw_mmc.h
> >>>>> +++ b/drivers/mmc/host/dw_mmc.h
> >>>>> @@ -175,4 +175,11 @@
> >>>>> =C2=A0 =C2=A0 =C2=A0 (*(volatile u64 __force *)((dev)->regs + S=
DMMC_##reg) =3D (value))
> >>>>> =C2=A0#endif
> >>>>>
> >>>>> +extern int dw_mci_probe(struct dw_mci *host);
> >>>>> +extern void dw_mci_remove(struct dw_mci *host);
> >>>>> +#ifdef CONFIG_PM
> >>>>> +extern int dw_mci_suspend(struct dw_mci *host);
> >>>>> +extern int dw_mci_resume(struct dw_mci *host);
> >>>>> +#endif
> >>>>> +
> >>>>> =C2=A0#endif /* _DW_MMC_H_ */
> >>>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_=
mmc.h
> >>>>> index 6dc9b80..9cf592c 100644
> >>>>> --- a/include/linux/mmc/dw_mmc.h
> >>>>> +++ b/include/linux/mmc/dw_mmc.h
> >>>>> @@ -74,7 +74,7 @@ struct mmc_data;
> >>>>> =C2=A0 * @num_slots: Number of slots available.
> >>>>> =C2=A0 * @verid: Denote Version ID.
> >>>>> =C2=A0 * @data_offset: Set the offset of DATA register accordin=
g to VERID.
> >>>>> - * @pdev: Platform device associated with the MMC controller.
> >>>>> + * @dev: Device associated with the MMC controller.
> >>>>> =C2=A0 * @pdata: Platform data associated with the MMC controll=
er.
> >>>>> =C2=A0 * @slot: Slots sharing this MMC controller.
> >>>>> =C2=A0 * @fifo_depth: depth of FIFO.
> >>>>> @@ -85,6 +85,8 @@ struct mmc_data;
> >>>>> =C2=A0 * @push_data: Pointer to FIFO push function.
> >>>>> =C2=A0 * @pull_data: Pointer to FIFO pull function.
> >>>>> =C2=A0 * @quirks: Set of quirks that apply to specific versions=
 of the IP.
> >>>>> + * @irq_flags: The flags to be passed to request_irq.
> >>>>> + * @irq: The irq value to be passed to request_irq.
> >>>>> =C2=A0 *
> >>>>> =C2=A0 * Locking
> >>>>> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D
> >>>>> @@ -151,7 +153,7 @@ struct dw_mci {
> >>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifoth_val;
> >>>>> =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verid;
> >>>>> =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_offset;
> >>>>> - =C2=A0 =C2=A0 struct platform_device =C2=A0*pdev;
> >>>>> + =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 dev;
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_board =C2=A0 =C2=A0 *pdata;
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =C2=A0 =C2=A0 =C2=A0*sl=
ot[MAX_MCI_SLOTS];
> >>>>>
> >>>>> @@ -172,6 +174,8 @@ struct dw_mci {
> >>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 quirks;
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 struct regulator =C2=A0 =C2=A0 =C2=A0 =C2=A0=
*vmmc; =C2=A0/* Power regulator */
> >>>>> + =C2=A0 =C2=A0 unsigned long =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 irq_flags; /* IRQ flags */
> >>>>> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0irq;
> >>>>> =C2=A0};
> >>>>>
> >>>>> =C2=A0/* DMA ops for Internal/External DMAC interface */
> >>>>
> >>>
> >>>
> >>>
> >>
> >
> >
> >
>



--
regards,
Shashidhar Hiremath
