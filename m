From: Atul Garg <agarg@arasan.com>
Subject: Re: [PATCH] mmc:host:sdhci-pci:V2-Addition of Arasan PCI controller
 with integrated phy.
Date: Thu, 12 Oct 2017 19:22:54 -0700
Message-ID: <CAEJoYxEzPQrFznb_wCfOUjU9NoZV-qUGb6CHZT5NOYnpZnyADw@mail.gmail.com>
References: <1507657369-2657-1-git-send-email-agarg@arasan.com> <f2fa2b60-2555-19a3-19c0-e90170a475cb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:51639 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdJMCWz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 22:22:55 -0400
Received: by mail-it0-f49.google.com with SMTP id o135so9025812itb.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 19:22:55 -0700 (PDT)
In-Reply-To: <f2fa2b60-2555-19a3-19c0-e90170a475cb@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: linux-mmc@vger.kernel.org, KISHON VIJAY ABRAHAM <kishon@ti.com>, "Kattekola, Ravikumar" <rk@ti.com>, "Menon, Nishanth" <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, linux-kernel@vger.kernel.org

Hi Sekhar,
Thanks for comments.

On Wed, Oct 11, 2017 at 7:23 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Atul,
>
> On Tuesday 10 October 2017 11:12 PM, Atul Garg wrote:
>> The Arasan controller is based on a FPGA platform and has integrated phy
>> with specific phy registers used during the initialization and
>> management of different modes. The phy and the controller are integrated
>> and registers are very specific to Arasan.
>>
>> Arasan being an IP provider, licenses these IPs to various companies for
>> integration of IP in custom SOCs. The custom SOCs define own register
>> map depending on how bits are tied inside the SOC for phy registers,
>> depending on SOC memory plan and hence will require own platform drivers=
.
>>
>> If more details on phy registers are required, an interface document is
>> hosted at https://arasan.com/NF/eMMC5.1 PHY Programming in Linux.pdf.
>>
>> Signed-off-by: Atul Garg <agarg@arasan.com>
>> ---
>>  drivers/mmc/host/Makefile           |  18 +-
>>  drivers/mmc/host/sdhci-pci-arasan.c | 325 +++++++++++++++++++++++++++++=
+++++++
>>  drivers/mmc/host/sdhci-pci-arasan.h |  80 +++++++++
>>  drivers/mmc/host/sdhci-pci-core.c   |  16 ++
>>  drivers/mmc/host/sdhci-pci.h        |   4 +
>>  5 files changed, 431 insertions(+), 12 deletions(-)
>>  create mode 100644 drivers/mmc/host/sdhci-pci-arasan.c
>>  create mode 100644 drivers/mmc/host/sdhci-pci-arasan.h
>>
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index 2b5a813..b9b2c6c 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -2,15 +2,14 @@
>>  # Makefile for MMC/SD host controller drivers
>>  #
>>
>> -obj-$(CONFIG_MMC_ARMMMCI) +=3D armmmci.o
>> -armmmci-y :=3D mmci.o
>> -armmmci-$(CONFIG_MMC_QCOM_DML) +=3D mmci_qcom_dml.o
>> +obj-$(CONFIG_MMC_ARMMMCI)    +=3D mmci.o
>> +obj-$(CONFIG_MMC_QCOM_DML)   +=3D mmci_qcom_dml.o
>
> These look like stray changes unrelated to this patch?

Yes will take care of them

>
>>  obj-$(CONFIG_MMC_PXA)                +=3D pxamci.o
>>  obj-$(CONFIG_MMC_MXC)                +=3D mxcmmc.o
>>  obj-$(CONFIG_MMC_MXS)                +=3D mxs-mmc.o
>>  obj-$(CONFIG_MMC_SDHCI)              +=3D sdhci.o
>>  obj-$(CONFIG_MMC_SDHCI_PCI)  +=3D sdhci-pci.o
>> -sdhci-pci-y                  +=3D sdhci-pci-core.o sdhci-pci-o2micro.o
>> +sdhci-pci-y                  +=3D sdhci-pci-core.o sdhci-pci-o2micro.o =
sdhci-pci-arasan.o
>>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))     +=3D sdhci-pci-data.o
>>  obj-$(CONFIG_MMC_SDHCI_ACPI) +=3D sdhci-acpi.o
>>  obj-$(CONFIG_MMC_SDHCI_PXAV3)        +=3D sdhci-pxav3.o
>> @@ -37,13 +36,9 @@ obj-$(CONFIG_MMC_S3C)      +=3D s3cmci.o
>>  obj-$(CONFIG_MMC_SDRICOH_CS) +=3D sdricoh_cs.o
>>  obj-$(CONFIG_MMC_TMIO)               +=3D tmio_mmc.o
>>  obj-$(CONFIG_MMC_TMIO_CORE)  +=3D tmio_mmc_core.o
>> -obj-$(CONFIG_MMC_SDHI)               +=3D renesas_sdhi_core.o
>> -ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYS_DMAC)),y)
>> -obj-$(CONFIG_MMC_SDHI)               +=3D renesas_sdhi_sys_dmac.o
>> -endif
>> -ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_INTERNAL_DMAC)),y)
>> -obj-$(CONFIG_MMC_SDHI)               +=3D renesas_sdhi_internal_dmac.o
>> -endif
>> +tmio_mmc_core-y                      :=3D tmio_mmc_pio.o
>> +tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))        +=3D tmio_mmc_dma.=
o
>> +obj-$(CONFIG_MMC_SDHI)               +=3D sh_mobile_sdhi.o
>
> These too look unrelated to $SUBJECT

will take care of them

>
>>  obj-$(CONFIG_MMC_CB710)              +=3D cb710-mmc.o
>>  obj-$(CONFIG_MMC_VIA_SDMMC)  +=3D via-sdmmc.o
>>  obj-$(CONFIG_SDH_BFIN)               +=3D bfin_sdh.o
>> @@ -89,7 +84,6 @@ obj-$(CONFIG_MMC_SDHCI_MSM)         +=3D sdhci-msm.o
>>  obj-$(CONFIG_MMC_SDHCI_ST)           +=3D sdhci-st.o
>>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)      +=3D sdhci-pic32.o
>>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)              +=3D sdhci-brcmstb.o
>> -obj-$(CONFIG_MMC_SDHCI_OMAP)         +=3D sdhci-omap.o
>
> This too is unrelated.

will take care of them

>
>>
>>  ifeq ($(CONFIG_CB710_DEBUG),y)
>>       CFLAGS-cb710-mmc        +=3D -DDEBUG
>> diff --git a/drivers/mmc/host/sdhci-pci-arasan.c b/drivers/mmc/host/sdhc=
i-pci-arasan.c
>> new file mode 100644
>> index 0000000..57fbf8f
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-pci-arasan.c
>> @@ -0,0 +1,325 @@
>> +/*
>> + * Copyright (C) 2017 Arasan Chip Systems Inc.,
>> + *
>> + * Authors: Atul Garg <agarg@arasan.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/delay.h>
>> +
>> +#include "sdhci.h"
>> +#include "sdhci-pci.h"
>> +#include "sdhci-pci-arasan.h"
>> +
>> +static int arasan_phy_write(struct sdhci_host *host, u8 data, u8 offset=
)
>> +{
>> +     u32 timeout;
>> +     u8 busy;
>> +
>> +     sdhci_writew(host, data, HOST_PHY_DATA_REG);
>> +     sdhci_writew(host, ((1<<8) | offset), HOST_PHY_ADDR_REG);
>> +     timeout =3D 20;
>> +     do {
>> +             busy =3D sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);
>> +             if (!busy)
>> +                     break;
>> +             mdelay(1);
>> +     } while (timeout--);
>> +     if (!timeout)
>> +             return -ENODEV;
>> +     return 0;
>> +}
>> +
>> +static int arasan_phy_read(struct sdhci_host *host, u8 offset, u8 *data=
)
>> +{
>> +     u32 timeout;
>> +     u8 busy;
>> +
>> +     sdhci_writew(host, 0, HOST_PHY_DATA_REG);
>> +     *data =3D sdhci_readw(host, HOST_PHY_DATA_REG) & 0xFF;
>
> Is this a superfluous read to make sure the write before really took
> effect? If yes, a comment would be useful and you dont have to gather
> the result of it and you can drop the masking too.
>

Yes the read is to make sure the write before has effect. Anyway
removing it as the read value is not checked.

>> +     sdhci_writew(host, ((0<<8) | offset), HOST_PHY_ADDR_REG);
>
> The 0 << 8 is not needed.
>

will take care of it

>> +     timeout =3D 20;

will take care of it

>
> This can be initialized at declaration.
>
>> +     do {
>> +             busy =3D sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);
>> +             if (!busy)
>> +                     break;
>> +             mdelay(1);
>
> Do you really mean to wait for 1 millisecond here? Or us udelay(1)
> sufficient? Unfortunately section 4 of the document you referenced gives
> no information on the timing involved, but presumably the hardware is
> much faster than needing upto 20 milliseconds for reading a register.
>

The platform needs some time to settle down we will revisit it with
our team members and see what we can do about this

>> +     } while (timeout--);
>> +     if (!timeout)
>> +             return -ENODEV;
>> +     *data =3D sdhci_readw(host, HOST_PHY_DATA_REG) & 0xFF;
>> +     return 0;
>> +}
>> +
>> +/* Initialize the Arasan PHY */
>> +static int arasan_phy_init(struct sdhci_host *host)
>> +{
>> +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
>> +     struct pci_dev *pdev =3D slot->chip->pdev;
>> +     u8 val;
>> +
>> +     if (arasan_phy_write(host, 0, PHY_CONTROL))
>> +             return -ENODEV;
>
> Section 5 of the document you linked to says the first step is:
>
> "
> If operating in 4-bit PHY mode, write 1=E2=80=99b1 to phyCONTROL_select (=
bit 0)
> bit of reg_phyCONTROL_ctrl register (offset 0x24).If operating in 8-bit
> mode this register write is NOT required.
> "
>
> Are you in 4-bit or 8-bit mode for the PCIe card you are testing with?
> In any case, clearing PHY_CONTROL to 0 upfront seems to go against the
> Arasan specification.
>

8bit mode. As it defaults to 0 anyway, programming againis not required

>> +     if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
>> +             return -ENODEV;
>
> The second step per the document is to enable DLL (page 24). This seems
> to be doing something different. Am I misreading the document?
>
> Also, in general, it is not good to ignore and override the return value
> from a function. So you would rather do.
>
>         ret =3D arasan_phy_read(host, PHY_IOPADCONTROL1, &val);
>         if (ret)
>                 return ret;
>
> to preserve the return value.
>
> I have ignored reviewing the rest of the initialization sequence since I
> seem to be missing something. Also, at the end of the initialization
> sequence there is a table with values to be written to and read back
> from the PHY. Is that a summary of the initialization sequence or
> something that needs to be done after follow through of the steps before
> that. If its the later, curious as to why its tabled separately.
>
> Also, looks like the document really is not consistent in terms of
> naming registers. For example, the document refers to IO_PADS_CTRL1 in
> the table on page 25, but searching for it leads you nowwhere. It will
> also be nice if you follow the same convention as the hardware document
> in code..
>
>> +     if (arasan_phy_write(host, val | RETB_ENABLE, PHY_IOPADCONTROL1))
>
> .. so call this IO_PADS_CTRL1 instead of PHY_IOPADCONTROL1?
>

we will update the document

>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_IOPADCONTROL2, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | RTRIM_ENABLE, PHY_IOPADCONTROL2))
>> +             return -ENODEV;
>> +     mdelay(10);
>> +
>> +     if (arasan_phy_read(host, PHY_IOPADSTATUS, &val)) {
>> +             if (!(val & CALDONE_MASK)) {
>> +                     dev_err(&pdev->dev, "Phy calibration not done\n");
>> +                     return -ENODEV;
>> +             }
>> +     }
>> +     if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PDB_ENABLE, PHY_IOPADCONTROL1))
>> +             return -ENODEV;
>> +     mdelay(10);
>> +
>> +     if (arasan_phy_read(host, PHY_IOPADSTATUS, &val)) {
>> +             if (!(val & CALDONE_MASK)) {
>> +                     dev_err(&pdev->dev, "Phy calibration not done\n");
>> +                     return -ENODEV;
>> +             }
>> +     }
>> +     if (arasan_phy_read(host, PHY_IORENCONTROL1, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | REN_CMD | REN_STRB, PHY_IORENCONT=
ROL1))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_IOPUCONTROL1, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PU_CMD, PHY_IOPUCONTROL1))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_CMDCONTROL, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PDB_CMD, PHY_CMDCONTROL))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_IORENCONTROL2, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | REN_DAT, PHY_IORENCONTROL2))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_IOPUCONTROL2, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PU_DAT, PHY_IOPUCONTROL2))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_DATACONTROL, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PDB_DAT, PHY_DATACONTROL))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_STROBECONTROL, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PDB_STRB, PHY_STROBECONTROL))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_CLKCONTROL, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | PDB_CLK, PHY_CLKCONTROL))
>> +             return -ENODEV;
>> +     if (arasan_phy_read(host, PHY_CLKBUFSELECT, &val))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, val | 0x7, PHY_CLKBUFSELECT))
>> +             return -ENODEV;
>> +     if (arasan_phy_write(host, 0x4, PHY_MODECONTROL))
>> +             return -ENODEV;
>> +     return 0;
>> +}
>> +
>> +
>> +static int arasan_set_phy(struct sdhci_host *host)
>> +{
>> +     u8 clk_sel;
>> +     static u32 chg_clk;
>> +     u8 val;
>> +     u8 otap, itap, dll_sts, io_pad;
>> +
>> +     if (chg_clk !=3D host->mmc->ios.clock) {
>> +             chg_clk =3D host->mmc->ios.clock;
>> +             if (host->mmc->ios.clock =3D=3D 200000000)
>> +                     clk_sel =3D 0;
>> +             else if (host->mmc->ios.clock =3D=3D 100000000)
>> +                     clk_sel =3D 2;
>> +             else if (host->mmc->ios.clock =3D=3D 50000000)
>> +                     clk_sel =3D 1;
>> +             else
>> +                     clk_sel =3D 0;
>> +             /* Change phy settings only if there is a change in clock =
*/
>> +             goto set_phy;
>
> This goto is not really needed.
>
>> +     } else
>> +             return 0;
>
> In fact, the code will be much easier to read if you do:
>
>         if (chg_clk =3D=3D host->mmc->ios.clock)
>                 return 0;
>
>         /* rest of logic follows */
>

will take care of it

>> +set_phy:
>> +     if (host->mmc_host_ops.hs400_enhanced_strobe) {
>> +             if (arasan_phy_write(host, 0x1, PHY_MODECONTROL))
>> +                     return -ENODEV;
>> +             otap =3D ((0x2<<1) | OTAP_DLY_EN);
>
> I think such code will be easier to read if you define a macro of the sor=
t:
>
> #define OTAP_DELAY(x)   ((x) << 1)
>
> and then do:
>
>                 otap =3D OTAP_DELAY(0x2) | OTAP_DLY_EN;
>
>> +             if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
>> +                     return -ENODEV;
>> +             if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
>> +                     return -ENODEV;
>> +             if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
>> +                     return -ENODEV;
>> +             if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                     return -ENODEV;
>> +             dll_sts =3D (clk_sel<<5) | DLL_ENABLE;
>
> Similarly here and in other places throughout the patch.
>

will take care of it after looking at other places too

>> +             if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
>> +                     return -ENODEV;
>> +             if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                     return -ENODEV;
>> +     } else {
>> +             switch (host->mmc->ios.timing) {
>> +             case MMC_TIMING_LEGACY:
>> +                     if (arasan_phy_write(host, 0x4, PHY_MODECONTROL))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_OUTPUTTAPDELAY))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     break;
>> +             case MMC_TIMING_MMC_HS:
>> +                     if (arasan_phy_write(host, 0, PHY_MODECONTROL))
>> +                             return -ENODEV;
>> +                     otap =3D ((0x2<<3) | OTAP_DLY_EN);
>> +                     if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELA=
Y))
>> +                             return -ENODEV;
>> +                     itap =3D ((0x2<<1) | ITAP_DLY_EN);
>> +                     if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                             return -ENODEV;
>> +                     dll_sts =3D (clk_sel<<5) | DLL_ENABLE;
>> +                     if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     break;
>> +             case MMC_TIMING_MMC_HS200:
>> +                     if (arasan_phy_write(host, 0, PHY_MODECONTROL))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val)=
)
>> +                             return -ENODEV;
>> +                     io_pad =3D val | (host->mmc->ios.drv_type<<2);
>> +                     if (arasan_phy_write(host, io_pad, PHY_IOPADCONTRO=
L1))
>> +                             return -ENODEV;
>> +                     otap =3D ((0x2<<1) | OTAP_DLY_EN);
>> +                     if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELA=
Y))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                             return -ENODEV;
>> +                     dll_sts =3D (clk_sel<<5) | DLL_ENABLE;
>> +                     if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     break;
>> +             case MMC_TIMING_UHS_DDR50:
>> +                     if (arasan_phy_write(host, 0x8, PHY_MODECONTROL))
>> +                             return -ENODEV;
>> +                     otap =3D ((0x2<<3) | OTAP_DLY_EN);
>
> Is the shift by 3 a typo? If the idea was to set SEL_DLY_TXCLK, you
> should be doing BIT(5) instead.
>

will update

>> +                     if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELA=
Y))
>> +                             return -ENODEV;
>> +                     itap =3D ((0x2<<1) | ITAP_DLY_EN);
>> +                     if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                             return -ENODEV;
>> +                     dll_sts =3D (clk_sel<<5) | DLL_ENABLE;
>> +                     if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     break;
>> +             case MMC_TIMING_MMC_HS400:
>> +                     if (arasan_phy_write(host, 0x2, PHY_MODECONTROL))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val)=
)
>> +                             return -ENODEV;
>> +                     io_pad =3D val | (host->mmc->ios.drv_type<<2);
>> +                     if (arasan_phy_write(host, io_pad, PHY_IOPADCONTRO=
L1))
>> +                             return -ENODEV;
>> +                     otap =3D ((0x2<<1) | OTAP_DLY_EN);
>> +                     if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELA=
Y))
>> +                             return -ENODEV;
>> +                     itap =3D ((0xA<<1) | ITAP_DLY_EN);
>> +                     if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
>> +                             return -ENODEV;
>> +                     dll_sts =3D (clk_sel<<5) | DLL_ENABLE;
>> +                     if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL=
))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
>> +                             return -ENODEV;
>> +                     if (arasan_phy_write(host, 0x0E, PHY_CLKBUFSELECT)=
)
>> +                             return -ENODEV;
>
> There is no setp to write PHY_CLKBUFSELECT for HS400 in the document
> (pages 26-27)?
>

will update the document

> Thanks,
> Sekhar

--=20
ATTENTION:=20

The information contained in this message may be legally privileged and=20
confidential.  It is intended to be read only by the individual or entity=
=20
to whom it is addressed or by their designee. If the reader of this message=
=20
is not the intended recipient, you are on notice that any distribution of=
=20
this message, in any form, is strictly prohibited by law.


If you have received this message in error, please immediately notify the=
=20
sender and/or Arasan Chip Systems, Inc. by telephone at (408) 282-1600 and=
=20
delete or destroy any copy of this message.
