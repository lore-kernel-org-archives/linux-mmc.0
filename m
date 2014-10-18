From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2] mmc: add new au6601 driver
Date: Sat, 18 Oct 2014 08:26:41 +0200
Message-ID: <54420821.5000600@rempel-privat.de>
References: <CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>	<1411801899-5236-1-git-send-email-linux@rempel-privat.de> <CAOyx1LpwJmWyrg07mc-UsDMZ=Mggs91SWq7e9GWb83H5k86Dwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="grFRE21XtvtBp5wTDuVJr3vWf4Wg7giC9"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:50120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbaJRG0v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Oct 2014 02:26:51 -0400
In-Reply-To: <CAOyx1LpwJmWyrg07mc-UsDMZ=Mggs91SWq7e9GWb83H5k86Dwg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, ulf.hansson@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--grFRE21XtvtBp5wTDuVJr3vWf4Wg7giC9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 17.10.2014 um 14:37 schrieb Venkatraman S:
> On Sat, Sep 27, 2014 at 12:41 PM, Oleksij Rempel <linux@rempel-privat.d=
e> wrote:
>>
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
>>  drivers/mmc/host/au6601.c | 1215 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 1224 insertions(+)
>>  create mode 100644 drivers/mmc/host/au6601.c
>>
>> --- /dev/null
>> +++ b/drivers/mmc/host/au6601.c
>> @@ -0,0 +1,1215 @@
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
>> +#include <linux/pm.h>
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
>> +#define AU6601_DMA_LOCAL_SEGMENTS      3
>> +#define AU6601_MAX_BLOCK_COUNT         65536
>> +
>> +/* SDMA phy address. Higer then 0x0800.0000? */
>> +#define AU6601_REG_SDMA_ADDR   0x00
>> + #define AU6601_SDMA_MASK      0xfffff000
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
>> +       struct mutex cmd_mutex;
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
>> +static void au6601_request_complete(struct au6601_host *host);
>> +
>> +static const struct pci_device_id pci_ids[] =3D {
>> +       {
>> +               .vendor  =3D PCI_ID_ALCOR_MICRO,
>> +               .device  =3D PCI_ID_AU6601,
>> +               .subvendor      =3D PCI_ANY_ID,
>> +               .subdevice      =3D PCI_ANY_ID,
>> +       },
>> +       { /* end: all zeroes */ },
>> +};
>> +MODULE_DEVICE_TABLE(pci, pci_ids);
>> +
>> +static inline void au6601_rmw(void __iomem *reg, u32 clear, u32 set)
>> +{
>> +       u32 var;
>> +
>> +       var =3D ioread32(reg);
>> +       var &=3D ~clear;
>> +       var |=3D set;
>> +       iowrite32(var, reg);
>> +}
>> +
>> +static inline void au6601_mask_irqs(struct au6601_host *host)
>> +{
>> +       iowrite32(0, host->iobase + AU6601_REG_INT_ENABLE);
>> +}
>> +
>> +static inline void au6601_unmask_irqs(struct au6601_host *host)
>> +{
>> +       iowrite32(AU6601_INT_CMD_MASK | AU6601_INT_DATA_MASK |
>> +                 AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE |
>> +                 AU6601_INT_CARD_INT | AU6601_INT_BUS_POWER,
>> +                 host->iobase + AU6601_REG_INT_ENABLE);
>> +}
>> +
>> +static void au6601_clear_set_reg86(struct au6601_host *host, u32 clea=
r, u32 set)
>> +{
>> +       au6601_rmw(host->iobase + REG_86, clear, set);
>> +}
>> +
>> +/*
>> + * check if one of data line is pulled down
>> + */
>> +static inline int au6601_card_busy(struct au6601_host *host)
>> +{
>> +       u8 status;
>> +
>> +       status =3D (ioread8(host->iobase + AU6601_REG_BUS_STATUS) &
>> +               AU6601_BUS_STAT_DAT_MASK);
>> +       /* If all data lines are up, then card is not busy */
>> +       if (status =3D=3D (AU6601_BUS_STAT_DAT0 | AU6601_BUS_STAT_DAT1=
 |
>> +                      AU6601_BUS_STAT_DAT2 | AU6601_BUS_STAT_DAT3))
>=20
> If all lines have to be up, shouldn't it be "&" instead of "|" ?

No :)
01 & 10 =3D 00
01 | 1O =3D 11

in case of & status will be compared against 0.

>=20
>> +               return 0;
>> +
>> +       return 1;
>> +}


--=20
Regards,
Oleksij


--grFRE21XtvtBp5wTDuVJr3vWf4Wg7giC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlRCCCUACgkQHwImuRkmbWm8iwD+LE4r5uFXVwhoku8xx3J56OuM
5I9s5ny8gx9SufhAAKEA/R+9tcPHiGTIZp7wNrI4IP0z9rD8CBAZ6CnanhZjNutB
=a4Rl
-----END PGP SIGNATURE-----

--grFRE21XtvtBp5wTDuVJr3vWf4Wg7giC9--
