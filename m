From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Wed, 02 Jul 2014 11:48:18 +0200
Message-ID: <53B3D562.1030707@rempel-privat.de>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de> <CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WSoVdwAoTbWoxHhaGCqJdMpaX0fMTHGKa"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54117 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaGBJs2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Jul 2014 05:48:28 -0400
In-Reply-To: <CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WSoVdwAoTbWoxHhaGCqJdMpaX0fMTHGKa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

Am 16.06.2014 12:02, schrieb Ulf Hansson:
> Hi Oleksij,
>=20
> Sorry for a late reply.

no problem. Right now i have problems to response too :(

>=20
> On 8 May 2014 11:58, Oleksij Rempel <linux@rempel-privat.de> wrote:
>> This driver is based on documentation which was based on my RE-work an=
d
>> comparision with other MMC drivers.
>> It works in legacy mode and can provide 20MB/s R/W spead for most mode=
rn
>> SD cards, even if at least 40MB/s should be possible on this hardware.=

>> It was not possible provide description for all register. But some of =
them
>> are important to make this hardware work in some unknown way.
>>
>> Biggest part of RE-work was done by emulating AU6601 in QEMU.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  drivers/mmc/host/Kconfig  |    8 +
>>  drivers/mmc/host/Makefile |    1 +
>>  drivers/mmc/host/au6601.c | 1276 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 1285 insertions(+)
>>  create mode 100644 drivers/mmc/host/au6601.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 8aaf8c1..99b309f 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -315,6 +315,14 @@ config MMC_WBSD
>>
>>           If unsure, say N.
>>
>> +config MMC_AU6601
>> +       tristate "Alcor Micro AU6601"
>> +       help
>> +         This selects the Alcor Micro Multimedia card interface.
>> +
>> +         If unsure, say N.
>> +
>> +
>>  config MMC_AU1X
>>         tristate "Alchemy AU1XX0 MMC Card Interface support"
>>         depends on MIPS_ALCHEMY
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index 0c8aa5e..8f3c64c 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_MMC_SDHCI_SIRF)          +=3D sdhci-sir=
f.o
>>  obj-$(CONFIG_MMC_SDHCI_SPEAR)  +=3D sdhci-spear.o
>>  obj-$(CONFIG_MMC_WBSD)         +=3D wbsd.o
>>  obj-$(CONFIG_MMC_AU1X)         +=3D au1xmmc.o
>> +obj-$(CONFIG_MMC_AU6601)       +=3D au6601.o
>>  obj-$(CONFIG_MMC_OMAP)         +=3D omap.o
>>  obj-$(CONFIG_MMC_OMAP_HS)      +=3D omap_hsmmc.o
>>  obj-$(CONFIG_MMC_ATMELMCI)     +=3D atmel-mci.o
>> diff --git a/drivers/mmc/host/au6601.c b/drivers/mmc/host/au6601.c
>> new file mode 100644
>> index 0000000..92d639f
>> --- /dev/null
>> +++ b/drivers/mmc/host/au6601.c
>> @@ -0,0 +1,1276 @@
>> +/*
>> + * Copyright (C) 2014 Oleksij Rempel.
>> + *
>> + * Authors: Oleksij Rempel <linux@rempel-privat.de>
>> + *
>> + * This software is licensed under the terms of the GNU General Publi=
c
>> + * License version 2, as published by the Free Software Foundation, a=
nd
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +
>> +#include <linux/delay.h>
>> +#include <linux/pci.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/mmc.h>
>> +
>> +#define DRVNAME                        "au6601-pci"
>> +#define PCI_ID_ALCOR_MICRO     0x1aea
>> +#define PCI_ID_AU6601          0x6601
>> +
>> +#define MHZ_TO_HZ(freq)        ((freq) * 1000 * 1000)
>> +
>> +#define AU6601_MIN_CLOCK               (150 * 1000)
>> +#define AU6601_MAX_CLOCK               MHZ_TO_HZ(208)
>> +#define AU6601_MAX_SEGMENTS            512
>> +#define AU6601_MAX_BLOCK_LENGTH                512
>> +#define AU6601_MAX_DMA_BLOCKS          8
>> +#define AU6601_MAX_BLOCK_COUNT         65536
>> +
>> +/* SDMA phy address. Higer then 0x0800.0000? */
>> +#define AU6601_REG_SDMA_ADDR   0x00
>> +/* ADMA block count? AU6621 only. */
>> +#define REG_05 0x05
>> +/* PIO */
>> +#define AU6601_REG_BUFFER      0x08
>> +/* ADMA ctrl? AU6621 only. */
>> +#define REG_0C 0x0c
>> +/* ADMA phy address. AU6621 only. */
>> +#define REG_10 0x10
>> +/* CMD index */
>> +#define AU6601_REG_CMD_OPCODE  0x23
>> +/* CMD parametr */
>> +#define AU6601_REG_CMD_ARG     0x24
>> +/* CMD response 4x4 Bytes */
>> +#define AU6601_REG_CMD_RSP0    0x30
>> +#define AU6601_REG_CMD_RSP1    0x34
>> +#define AU6601_REG_CMD_RSP2    0x38
>> +#define AU6601_REG_CMD_RSP3    0x3C
>> +/* LED ctrl? */
>> +#define REG_51 0x51
>> +/* ??? */
>> +#define REG_52 0x52
>> +/* LED related? Always toggled BIT0 */
>> +#define REG_61 0x61
>> +/* Same as REG_61? */
>> +#define REG_63 0x63
>> +/* ??? */
>> +#define REG_69 0x69
>> +/* Block size for SDMA or PIO */
>> +#define AU6601_REG_BLOCK_SIZE  0x6c
>> +/* Some power related reg, used together with REG_7A */
>> +#define REG_70 0x70
>> +/* PLL ctrl */
>> +#define AU6601_REG_PLL_CTRL    0x72
>> +/* ??? */
>> +#define REG_74 0x74
>> +/* ??? */
>> +#define REG_75 0x75
>> +/* card slot state? */
>> +#define REG_76 0x76
>> +/* ??? */
>> +#define REG_77 0x77
>> +/* looks like soft reset? */
>> +#define AU6601_REG_SW_RESET    0x79
>> + #define AU6601_RESET_UNK      BIT(7)  /* unknown bit */
>> + #define AU6601_RESET_DATA     BIT(3)
>> + #define AU6601_RESET_CMD      BIT(0)
>> +/* see REG_70 */
>> +#define REG_7A 0x7a
>> +/* ??? Padding? Timeing? */
>> +#define REG_7B 0x7b
>> +/* ??? Padding? Timeing? */
>> +#define REG_7C 0x7c
>> +/* ??? Padding? Timeing? */
>> +#define REG_7D 0x7d
>> +/* read EEPROM? */
>> +#define REG_7F 0x7f
>> +
>> +#define AU6601_REG_CMD_CTRL    0x81
>> +#define AU6601_REG_BUS_CTRL    0x82
>> + #define AU6601_BUS_WIDTH_4BIT BIT(5)
>> +#define REG_83 0x83
>> +
>> +#define AU6601_REG_BUS_STATUS  0x84
>> + #define AU6601_BUS_STAT_CMD   BIT(15)
>> +/* BIT(4) - BIT(7) are permanently 1.
>> + * May be reseved or not attached DAT4-DAT7 */
>> + #define AU6601_BUS_STAT_DAT3          BIT(3)
>> + #define AU6601_BUS_STAT_DAT2          BIT(2)
>> + #define AU6601_BUS_STAT_DAT1          BIT(1)
>> + #define AU6601_BUS_STAT_DAT0          BIT(0)
>> + #define AU6601_BUS_STAT_DAT_MASK      0xf
>> +#define REG_85 0x85
>> +/* ??? */
>> +#define REG_86 0x86
>> +#define AU6601_REG_INT_STATUS  0x90 /* IRQ intmask */
>> +#define AU6601_REG_INT_ENABLE  0x94
>> +/* ??? */
>> +#define REG_A1 0xa1
>> +/* ??? */
>> +#define REG_A2 0xa2
>> +/* ??? */
>> +#define REG_A3 0xa3
>> +/* ??? */
>> +#define REG_B0 0xb0
>> +/* ??? */
>> +#define REG_B4 0xb4
>> +
>> + /* AU6601_REG_INT_STATUS is identical or almost identical with sdhci=
=2Eh */
>> + /* OK - are tested and confirmed bits */
>> + #define  AU6601_INT_RESPONSE          0x00000001      /* ok */
>> + #define  AU6601_INT_DATA_END          0x00000002      /* fifo, ok */=

>> + #define  AU6601_INT_BLK_GAP           0x00000004
>> + #define  AU6601_INT_DMA_END           0x00000008
>> + #define  AU6601_INT_SPACE_AVAIL       0x00000010      /* fifo, ok */=

>> + #define  AU6601_INT_DATA_AVAIL                0x00000020      /* fif=
o, ok */
>> + #define  AU6601_INT_CARD_REMOVE       0x00000040
>> + #define  AU6601_INT_CARD_INSERT       0x00000080      /* 0x40 and 0x=
80 flip */
>> + #define  AU6601_INT_CARD_INT          0x00000100
>> + #define  AU6601_INT_ERROR             0x00008000      /* ok */
>> + #define  AU6601_INT_TIMEOUT           0x00010000      /* seems to be=
 ok */
>> + #define  AU6601_INT_CRC               0x00020000      /* seems to be=
 ok */
>> + #define  AU6601_INT_END_BIT           0x00040000
>> + #define  AU6601_INT_INDEX             0x00080000
>> + #define  AU6601_INT_DATA_TIMEOUT      0x00100000
>> + #define  AU6601_INT_DATA_CRC          0x00200000
>> + #define  AU6601_INT_DATA_END_BIT      0x00400000
>> + #define  AU6601_INT_BUS_POWER         0x00800000
>> + #define  AU6601_INT_ACMD12ERR         0x01000000
>> + #define  AU6601_INT_ADMA_ERROR                0x02000000
>> +
>> + #define  AU6601_INT_NORMAL_MASK       0x00007FFF
>> + #define  AU6601_INT_ERROR_MASK                0xFFFF8000
>> +
>> +/* magic 0xF0001 */
>> + #define  AU6601_INT_CMD_MASK  (AU6601_INT_RESPONSE | AU6601_INT_TIME=
OUT | \
>> +               AU6601_INT_CRC | AU6601_INT_END_BIT | AU6601_INT_INDEX=
)
>> +/* magic 0x70003A */
>> + #define  AU6601_INT_DATA_MASK (AU6601_INT_DATA_END | AU6601_INT_DMA_=
END | \
>> +               AU6601_INT_DATA_AVAIL | AU6601_INT_SPACE_AVAIL | \
>> +               AU6601_INT_DATA_TIMEOUT | AU6601_INT_DATA_CRC | \
>> +               AU6601_INT_DATA_END_BIT)
>> + #define AU6601_INT_ALL_MASK   ((uint32_t)-1)
>> +
>> +bool disable_dma =3D 0;
>=20
> Could this not be apart of the struct au6601_host? Or you might even
> be able to use "dma_on", which is already there?

I'll check it.

>> +
>> +struct au6601_host {
>> +       struct pci_dev *pdev;
>> +       struct  device *dev;
>> +       void __iomem *iobase;
>> +       void __iomem *virt_base;
>> +       dma_addr_t phys_base;
>> +
>> +       struct mmc_host *mmc;
>> +       struct mmc_request *mrq;
>> +       struct mmc_command *cmd;
>> +       struct mmc_data *data;
>> +       unsigned int data_early:1;      /* Data finished before cmd */=

>> +       unsigned int dma_on:1;
>> +       unsigned int trigger_dma_dac:1; /* Trigger Data after Command.=

>> +                                        * In some cases data ragister=

>> +                                        * should be triggered after
>> +                                        * command was done */
>> +
>> +       spinlock_t lock;
>> +
>> +       struct tasklet_struct card_tasklet;
>> +       struct tasklet_struct finish_tasklet;
>=20
> Please try using threaded irqs in favor of tasklets.

Right now i have some problems with this part.
I will need to rewrite DMA too.

>> +
>> +       struct timer_list timer;
>> +
>> +       struct sg_mapping_iter sg_miter;        /* SG state for PIO */=

>> +       unsigned int blocks;            /* remaining PIO blocks */
>> +       unsigned int requested_blocks;          /* count of requested =
*/
>> +       int sg_count;      /* Mapped sg entries */
>> +};
>> +
>> +static void au6601_send_cmd(struct au6601_host *host,
>> +                           struct mmc_command *cmd);
>> +
>> +static void au6601_prepare_data(struct au6601_host *host,
>> +                               struct mmc_command *cmd);
>> +static void au6601_finish_data(struct au6601_host *host);
>> +
>> +static const struct pci_device_id pci_ids[] =3D {

=3D=3D=3D=3D=3D=3D=3D=3D snip =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>> +/* val =3D 0x1 abort command; 0x8 abort data? */
>> +static void au6601_reset(struct au6601_host *host, u8 val)
>> +{
>> +       int i;
>> +       iowrite8(val | AU6601_RESET_UNK, host->iobase + AU6601_REG_SW_=
RESET);
>> +       for (i =3D 0; i < 100; i++) {
>> +               if (!(ioread8(host->iobase + AU6601_REG_SW_RESET) & va=
l))
>> +                       return;
>> +               udelay(50);
>> +       }
>> +       dev_err(host->dev, "%s: timeout\n", __func__);
>> +}
>> +
>> +/*
>> + * - 0x8       only Vcc is on
>> + * - 0x1       Vcc and other pins are on
>> + * - 0x1 | 0x8 like 0x1, but DAT2 is off
>> + */
>> +static void au6601_set_power(struct au6601_host *host,
>> +                            unsigned int value, unsigned int set)
>> +{
>> +       u8 tmp1, tmp2;
>> +
>> +       tmp1 =3D ioread8(host->iobase + REG_70);
>> +       tmp2 =3D ioread8(host->iobase + REG_7A);
>> +       if (set) {
>> +               iowrite8(tmp1 | value, host->iobase + REG_70);
>> +               msleep(20);
>> +               iowrite8(tmp2 | value, host->iobase + REG_7A);
>> +       } else {
>> +               iowrite8(tmp2 & ~value, host->iobase + REG_7A);
>> +               iowrite8(tmp1 & ~value, host->iobase + REG_70);
>> +       }
>> +}
>> +
>> +static void au6601_trigger_data_transfer(struct au6601_host *host,
>> +               unsigned int dma)
>> +{
>> +       struct mmc_data *data =3D host->data;
>> +       u8 ctrl =3D 0;
>> +
>> +       BUG_ON(data =3D=3D NULL);
>=20
> Do you really need BUG_ON?
>=20
> Also, please go through the complete patch to look for these
> BUG/BUG_ON, I think you shouldn't use them in most of the cases.
>=20
>> +       WARN_ON_ONCE(host->dma_on =3D=3D 1);
>=20
> Why?

Good question, mostly because i was not knowing what i am doing and made
some buggy assumptions. Will fix it.

>=20
>> +
>> +       if (data->flags & MMC_DATA_WRITE)
>> +               ctrl |=3D 0x80;
>> +
>> +       if (dma) {
>> +               iowrite32(host->phys_base, host->iobase + AU6601_REG_S=
DMA_ADDR);
>> +               ctrl |=3D 0x40;
>> +               host->dma_on =3D 1;
>> +
>> +               if (data->flags & MMC_DATA_WRITE)
>> +                       goto done;
>> +               /* prepare first DMA buffer for write operation */
>> +               if (host->blocks > AU6601_MAX_DMA_BLOCKS)
>> +                       host->requested_blocks =3D AU6601_MAX_DMA_BLOC=
KS;
>> +               else
>> +                       host->requested_blocks =3D host->blocks;
>> +
>> +       }
>> +
>> +done:
>> +       iowrite32(data->blksz * host->requested_blocks,
>> +               host->iobase + AU6601_REG_BLOCK_SIZE);
>> +       iowrite8(ctrl | 0x1, host->iobase + REG_83);
>> +}
>> +
>> +/********************************************************************=
*********\
>> + *                                                                   =
       *
>> + * Core functions                                                    =
       *
>> + *                                                                   =
       *
>> +\********************************************************************=
*********/

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>> +static void au6601_tasklet_finish(unsigned long param)
>> +{
>> +       struct au6601_host *host;
>> +       unsigned long flags;
>> +       struct mmc_request *mrq;
>> +
>> +       host =3D (struct au6601_host *)param;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       /*
>> +        * If this tasklet gets rescheduled while running, it will
>> +        * be run again afterwards but without any active request.
>> +        */
>> +       if (!host->mrq) {
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +               return;
>> +       }
>> +
>> +       del_timer(&host->timer);
>> +
>> +       mrq =3D host->mrq;
>> +
>> +       /*
>> +        * The controller needs a reset of internal state machines
>> +        * upon error conditions.
>> +        */
>> +       if ((mrq->cmd && mrq->cmd->error) ||
>> +                (mrq->data && (mrq->data->error ||
>> +                 (mrq->data->stop && mrq->data->stop->error)))) {
>> +
>> +               au6601_reset(host, AU6601_RESET_CMD);
>> +               au6601_reset(host, AU6601_RESET_DATA);
>> +       }
>> +
>> +       host->mrq =3D NULL;
>> +       host->cmd =3D NULL;
>> +       host->data =3D NULL;
>> +       host->dma_on =3D 0;
>> +       host->trigger_dma_dac =3D 0;
>> +
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       mmc_request_done(host->mmc, mrq);
>> +}
>> +
>> +static void au6601_timeout_timer(unsigned long data)
>=20
> I am just a bit curious, does this controller support hardware busy
> detection on DAT1 line while waiting for command completion?

Do you mean AU6601_REG_BUS_STATUS?
See at the beginning of patch.

>> +{
>> +       struct au6601_host *host;
>> +       unsigned long flags;
>> +
>> +       host =3D (struct au6601_host *)data;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       if (host->mrq) {
>> +               dev_err(host->dev,
>> +                       "Timeout waiting for hardware interrupt.\n");
>> +
>> +               if (host->data) {
>> +                       host->data->error =3D -ETIMEDOUT;
>> +                       au6601_finish_data(host);
>> +               } else {

>> +
>> +static int au6601_resume(struct pci_dev *pdev)
>> +{
>> +       struct au6601_host *host;
>> +       int ret;
>> +
>> +       host =3D pci_get_drvdata(pdev);
>> +
>> +       pci_set_power_state(pdev, PCI_D0);
>> +       pci_restore_state(pdev);
>> +       ret =3D pci_enable_device(pdev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       au6601_hw_init(host);
>> +       return 0;
>> +}
>> +
>> +
>> +#else /* CONFIG_PM */
>> +
>> +#define au6601_suspend NULL
>> +#define au6601_resume NULL
>> +
>> +#endif /* CONFIG_PM */
>=20
> Instead of the above tricks, can't you use the dev_pm_ops instead of
> the PM callbacks in the driver? And the use the "SIMPLE_DEV_PM_OPS"
> macro?

ok, on it.

>> +
>> +static struct pci_driver au6601_driver =3D {
>> +       .name =3D  DRVNAME,
>> +       .id_table =3D     pci_ids,
>> +       .probe =3D        au6601_pci_probe,
>> +       .remove =3D       au6601_pci_remove,
>> +       .suspend =3D au6601_suspend,
>> +       .resume =3D au6601_resume,
>> +};
>> +
>> +module_pci_driver(au6601_driver);

--=20
Regards,
Oleksij


--WSoVdwAoTbWoxHhaGCqJdMpaX0fMTHGKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlOz1WgACgkQHwImuRkmbWnx8gD+O6BM3xQOCR5/oNZP/wxtNQxP
qClZmk1fHZHELrlCrJEA/1yEir3nP7lYYkM73e8Ze87nksS+D21lA5sugNKqDRK8
=ZbIo
-----END PGP SIGNATURE-----

--WSoVdwAoTbWoxHhaGCqJdMpaX0fMTHGKa--
