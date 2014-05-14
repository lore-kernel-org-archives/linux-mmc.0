From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Wed, 14 May 2014 09:19:47 +0200
Message-ID: <53731913.4020605@rempel-privat.de>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8U3Qnl3TdWPsGvioLHjW9du3S4EvA4X73"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50487 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaENHUB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 May 2014 03:20:01 -0400
In-Reply-To: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8U3Qnl3TdWPsGvioLHjW9du3S4EvA4X73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello all,

are there any comments, suggestions, critics about this patch?

Am 08.05.2014 11:58, schrieb Oleksij Rempel:
> This driver is based on documentation which was based on my RE-work and=

> comparision with other MMC drivers.
> It works in legacy mode and can provide 20MB/s R/W spead for most moder=
n
> SD cards, even if at least 40MB/s should be possible on this hardware.
> It was not possible provide description for all register. But some of t=
hem
> are important to make this hardware work in some unknown way.
>=20
> Biggest part of RE-work was done by emulating AU6601 in QEMU.
>=20
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  drivers/mmc/host/Kconfig  |    8 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/au6601.c | 1276 +++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 1285 insertions(+)
>  create mode 100644 drivers/mmc/host/au6601.c
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8aaf8c1..99b309f 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -315,6 +315,14 @@ config MMC_WBSD
> =20
>  	  If unsure, say N.
> =20
> +config MMC_AU6601
> +	tristate "Alcor Micro AU6601"
> +	help
> +	  This selects the Alcor Micro Multimedia card interface.
> +
> +	  If unsure, say N.
> +
> +
>  config MMC_AU1X
>  	tristate "Alchemy AU1XX0 MMC Card Interface support"
>  	depends on MIPS_ALCHEMY
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 0c8aa5e..8f3c64c 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_MMC_SDHCI_SIRF)   	+=3D sdhci-sirf.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
>  obj-$(CONFIG_MMC_AU1X)		+=3D au1xmmc.o
> +obj-$(CONFIG_MMC_AU6601)	+=3D au6601.o
>  obj-$(CONFIG_MMC_OMAP)		+=3D omap.o
>  obj-$(CONFIG_MMC_OMAP_HS)	+=3D omap_hsmmc.o
>  obj-$(CONFIG_MMC_ATMELMCI)	+=3D atmel-mci.o
> diff --git a/drivers/mmc/host/au6601.c b/drivers/mmc/host/au6601.c
> new file mode 100644
> index 0000000..92d639f
> --- /dev/null
> +++ b/drivers/mmc/host/au6601.c
> @@ -0,0 +1,1276 @@
> +/*
> + * Copyright (C) 2014 Oleksij Rempel.
> + *
> + * Authors: Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * This software is licensed under the terms of the GNU General Public=

> + * License version 2, as published by the Free Software Foundation, an=
d
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +
> +#define DRVNAME			"au6601-pci"
> +#define PCI_ID_ALCOR_MICRO	0x1aea
> +#define PCI_ID_AU6601		0x6601
> +
> +#define MHZ_TO_HZ(freq)	((freq) * 1000 * 1000)
> +
> +#define AU6601_MIN_CLOCK		(150 * 1000)
> +#define AU6601_MAX_CLOCK		MHZ_TO_HZ(208)
> +#define AU6601_MAX_SEGMENTS		512
> +#define AU6601_MAX_BLOCK_LENGTH		512
> +#define AU6601_MAX_DMA_BLOCKS		8
> +#define AU6601_MAX_BLOCK_COUNT		65536
> +
> +/* SDMA phy address. Higer then 0x0800.0000? */
> +#define AU6601_REG_SDMA_ADDR	0x00
> +/* ADMA block count? AU6621 only. */
> +#define REG_05	0x05
> +/* PIO */
> +#define AU6601_REG_BUFFER	0x08
> +/* ADMA ctrl? AU6621 only. */
> +#define REG_0C	0x0c
> +/* ADMA phy address. AU6621 only. */
> +#define REG_10	0x10
> +/* CMD index */
> +#define AU6601_REG_CMD_OPCODE	0x23
> +/* CMD parametr */
> +#define AU6601_REG_CMD_ARG	0x24
> +/* CMD response 4x4 Bytes */
> +#define AU6601_REG_CMD_RSP0	0x30
> +#define AU6601_REG_CMD_RSP1	0x34
> +#define AU6601_REG_CMD_RSP2	0x38
> +#define AU6601_REG_CMD_RSP3	0x3C
> +/* LED ctrl? */
> +#define REG_51	0x51
> +/* ??? */
> +#define REG_52	0x52
> +/* LED related? Always toggled BIT0 */
> +#define REG_61	0x61
> +/* Same as REG_61? */
> +#define REG_63	0x63
> +/* ??? */
> +#define REG_69	0x69
> +/* Block size for SDMA or PIO */
> +#define AU6601_REG_BLOCK_SIZE	0x6c
> +/* Some power related reg, used together with REG_7A */
> +#define REG_70	0x70
> +/* PLL ctrl */
> +#define AU6601_REG_PLL_CTRL	0x72
> +/* ??? */
> +#define REG_74	0x74
> +/* ??? */
> +#define REG_75	0x75
> +/* card slot state? */
> +#define REG_76	0x76
> +/* ??? */
> +#define REG_77	0x77
> +/* looks like soft reset? */
> +#define AU6601_REG_SW_RESET	0x79
> + #define AU6601_RESET_UNK	BIT(7)	/* unknown bit */
> + #define AU6601_RESET_DATA	BIT(3)
> + #define AU6601_RESET_CMD	BIT(0)
> +/* see REG_70 */
> +#define REG_7A	0x7a
> +/* ??? Padding? Timeing? */
> +#define REG_7B	0x7b
> +/* ??? Padding? Timeing? */
> +#define REG_7C	0x7c
> +/* ??? Padding? Timeing? */
> +#define REG_7D	0x7d
> +/* read EEPROM? */
> +#define REG_7F	0x7f
> +
> +#define AU6601_REG_CMD_CTRL	0x81
> +#define AU6601_REG_BUS_CTRL	0x82
> + #define AU6601_BUS_WIDTH_4BIT	BIT(5)
> +#define REG_83	0x83
> +
> +#define AU6601_REG_BUS_STATUS	0x84
> + #define AU6601_BUS_STAT_CMD	BIT(15)
> +/* BIT(4) - BIT(7) are permanently 1.
> + * May be reseved or not attached DAT4-DAT7 */
> + #define AU6601_BUS_STAT_DAT3		BIT(3)
> + #define AU6601_BUS_STAT_DAT2		BIT(2)
> + #define AU6601_BUS_STAT_DAT1		BIT(1)
> + #define AU6601_BUS_STAT_DAT0		BIT(0)
> + #define AU6601_BUS_STAT_DAT_MASK	0xf
> +#define REG_85	0x85
> +/* ??? */
> +#define REG_86	0x86
> +#define AU6601_REG_INT_STATUS	0x90 /* IRQ intmask */
> +#define AU6601_REG_INT_ENABLE	0x94
> +/* ??? */
> +#define REG_A1	0xa1
> +/* ??? */
> +#define REG_A2	0xa2
> +/* ??? */
> +#define REG_A3	0xa3
> +/* ??? */
> +#define REG_B0	0xb0
> +/* ??? */
> +#define REG_B4	0xb4
> +
> + /* AU6601_REG_INT_STATUS is identical or almost identical with sdhci.=
h */
> + /* OK - are tested and confirmed bits */
> + #define  AU6601_INT_RESPONSE		0x00000001	/* ok */
> + #define  AU6601_INT_DATA_END		0x00000002	/* fifo, ok */
> + #define  AU6601_INT_BLK_GAP		0x00000004
> + #define  AU6601_INT_DMA_END		0x00000008
> + #define  AU6601_INT_SPACE_AVAIL	0x00000010	/* fifo, ok */
> + #define  AU6601_INT_DATA_AVAIL		0x00000020	/* fifo, ok */
> + #define  AU6601_INT_CARD_REMOVE	0x00000040
> + #define  AU6601_INT_CARD_INSERT	0x00000080	/* 0x40 and 0x80 flip */
> + #define  AU6601_INT_CARD_INT		0x00000100
> + #define  AU6601_INT_ERROR		0x00008000	/* ok */
> + #define  AU6601_INT_TIMEOUT		0x00010000	/* seems to be ok */
> + #define  AU6601_INT_CRC		0x00020000	/* seems to be ok */
> + #define  AU6601_INT_END_BIT		0x00040000
> + #define  AU6601_INT_INDEX		0x00080000
> + #define  AU6601_INT_DATA_TIMEOUT	0x00100000
> + #define  AU6601_INT_DATA_CRC		0x00200000
> + #define  AU6601_INT_DATA_END_BIT	0x00400000
> + #define  AU6601_INT_BUS_POWER		0x00800000
> + #define  AU6601_INT_ACMD12ERR		0x01000000
> + #define  AU6601_INT_ADMA_ERROR		0x02000000
> +
> + #define  AU6601_INT_NORMAL_MASK	0x00007FFF
> + #define  AU6601_INT_ERROR_MASK		0xFFFF8000
> +
> +/* magic 0xF0001 */
> + #define  AU6601_INT_CMD_MASK	(AU6601_INT_RESPONSE | AU6601_INT_TIMEOU=
T | \
> +		AU6601_INT_CRC | AU6601_INT_END_BIT | AU6601_INT_INDEX)
> +/* magic 0x70003A */
> + #define  AU6601_INT_DATA_MASK	(AU6601_INT_DATA_END | AU6601_INT_DMA_E=
ND | \
> +		AU6601_INT_DATA_AVAIL | AU6601_INT_SPACE_AVAIL | \
> +		AU6601_INT_DATA_TIMEOUT | AU6601_INT_DATA_CRC | \
> +		AU6601_INT_DATA_END_BIT)
> + #define AU6601_INT_ALL_MASK	((uint32_t)-1)
> +
> +bool disable_dma =3D 0;
> +
> +struct au6601_host {
> +	struct pci_dev *pdev;
> +	struct  device *dev;
> +	void __iomem *iobase;
> +	void __iomem *virt_base;
> +	dma_addr_t phys_base;
> +
> +	struct mmc_host *mmc;
> +	struct mmc_request *mrq;
> +	struct mmc_command *cmd;
> +	struct mmc_data *data;
> +	unsigned int data_early:1;      /* Data finished before cmd */
> +	unsigned int dma_on:1;
> +	unsigned int trigger_dma_dac:1;	/* Trigger Data after Command.
> +					 * In some cases data ragister
> +					 * should be triggered after
> +					 * command was done */
> +
> +	spinlock_t lock;
> +
> +	struct tasklet_struct card_tasklet;
> +	struct tasklet_struct finish_tasklet;
> +
> +	struct timer_list timer;
> +
> +	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
> +	unsigned int blocks;		/* remaining PIO blocks */
> +	unsigned int requested_blocks;		/* count of requested */
> +	int sg_count;	   /* Mapped sg entries */
> +};
> +
> +static void au6601_send_cmd(struct au6601_host *host,
> +			    struct mmc_command *cmd);
> +
> +static void au6601_prepare_data(struct au6601_host *host,
> +				struct mmc_command *cmd);
> +static void au6601_finish_data(struct au6601_host *host);
> +
> +static const struct pci_device_id pci_ids[] =3D {
> +	{
> +		.vendor	 =3D PCI_ID_ALCOR_MICRO,
> +		.device	 =3D PCI_ID_AU6601,
> +		.subvendor      =3D PCI_ANY_ID,
> +		.subdevice      =3D PCI_ANY_ID,
> +	},
> +	{ /* end: all zeroes */ },
> +};
> +MODULE_DEVICE_TABLE(pci, pci_ids);
> +
> +static inline void au6601_rmw(void __iomem *reg, u32 clear, u32 set)
> +{
> +	u32 var;
> +
> +	var =3D ioread32(reg);
> +	var &=3D ~clear;
> +	var |=3D set;
> +	iowrite32(var, reg);
> +}
> +
> +static void au6601_clear_set_irqs(struct au6601_host *host, u32 clear,=
 u32 set)
> +{
> +	au6601_rmw(host->iobase + AU6601_REG_INT_ENABLE, clear, set);
> +}
> +
> +static void au6601_clear_set_reg86(struct au6601_host *host, u32 clear=
, u32 set)
> +{
> +	au6601_rmw(host->iobase + REG_86, clear, set);
> +}
> +
> +/*
> + * check if one of data line is pulled down
> + */
> +static inline int au6601_card_busy(struct au6601_host *host)
> +{
> +	u8 status;
> +
> +	status =3D (ioread8(host->iobase + AU6601_REG_BUS_STATUS) &
> +		AU6601_BUS_STAT_DAT_MASK);
> +	/* If all data lines are up, then card is not busy */
> +	if (status =3D=3D (AU6601_BUS_STAT_DAT0 | AU6601_BUS_STAT_DAT1 |
> +		       AU6601_BUS_STAT_DAT2 | AU6601_BUS_STAT_DAT3))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/* val =3D 0x1 abort command; 0x8 abort data? */
> +static void au6601_reset(struct au6601_host *host, u8 val)
> +{
> +	int i;
> +	iowrite8(val | AU6601_RESET_UNK, host->iobase + AU6601_REG_SW_RESET);=

> +	for (i =3D 0; i < 100; i++) {
> +		if (!(ioread8(host->iobase + AU6601_REG_SW_RESET) & val))
> +			return;
> +		udelay(50);
> +	}
> +	dev_err(host->dev, "%s: timeout\n", __func__);
> +}
> +
> +/*
> + * - 0x8	only Vcc is on
> + * - 0x1	Vcc and other pins are on
> + * - 0x1 | 0x8	like 0x1, but DAT2 is off
> + */
> +static void au6601_set_power(struct au6601_host *host,
> +			     unsigned int value, unsigned int set)
> +{
> +	u8 tmp1, tmp2;
> +
> +	tmp1 =3D ioread8(host->iobase + REG_70);
> +	tmp2 =3D ioread8(host->iobase + REG_7A);
> +	if (set) {
> +		iowrite8(tmp1 | value, host->iobase + REG_70);
> +		msleep(20);
> +		iowrite8(tmp2 | value, host->iobase + REG_7A);
> +	} else {
> +		iowrite8(tmp2 & ~value, host->iobase + REG_7A);
> +		iowrite8(tmp1 & ~value, host->iobase + REG_70);
> +	}
> +}
> +
> +static void au6601_trigger_data_transfer(struct au6601_host *host,
> +		unsigned int dma)
> +{
> +	struct mmc_data *data =3D host->data;
> +	u8 ctrl =3D 0;
> +
> +	BUG_ON(data =3D=3D NULL);
> +	WARN_ON_ONCE(host->dma_on =3D=3D 1);
> +
> +	if (data->flags & MMC_DATA_WRITE)
> +		ctrl |=3D 0x80;
> +
> +	if (dma) {
> +		iowrite32(host->phys_base, host->iobase + AU6601_REG_SDMA_ADDR);
> +		ctrl |=3D 0x40;
> +		host->dma_on =3D 1;
> +
> +		if (data->flags & MMC_DATA_WRITE)
> +			goto done;
> +		/* prepare first DMA buffer for write operation */
> +		if (host->blocks > AU6601_MAX_DMA_BLOCKS)
> +			host->requested_blocks =3D AU6601_MAX_DMA_BLOCKS;
> +		else
> +			host->requested_blocks =3D host->blocks;
> +
> +	}
> +
> +done:
> +	iowrite32(data->blksz * host->requested_blocks,
> +		host->iobase + AU6601_REG_BLOCK_SIZE);
> +	iowrite8(ctrl | 0x1, host->iobase + REG_83);
> +}
> +
> +/*********************************************************************=
********\
> + *									     *
> + * Core functions							     *
> + *									     *
> +\*********************************************************************=
********/
> +
> +static void au6601_read_block(struct au6601_host *host)
> +{
> +	unsigned long flags;
> +	size_t blksize, len, chunk;
> +	u32 uninitialized_var(scratch);
> +	void __iomem *virt_base =3D host->virt_base;
> +	u8 *buf;
> +
> +	dev_dbg(host->dev, "PIO reading\n");
> +
> +	blksize =3D host->data->blksz * host->requested_blocks;
> +	chunk =3D 0;
> +
> +	local_irq_save(flags);
> +
> +	while (blksize) {
> +		if (!sg_miter_next(&host->sg_miter))
> +			BUG();
> +
> +		len =3D min(host->sg_miter.length, blksize);
> +
> +		blksize -=3D len;
> +		host->sg_miter.consumed =3D len;
> +
> +		buf =3D host->sg_miter.addr;
> +
> +		if (host->dma_on) {
> +			memcpy_fromio(buf, virt_base, len);
> +			virt_base +=3D len;
> +			len =3D 0;
> +		} else {
> +			while (len) {
> +				if (chunk =3D=3D 0) {
> +					scratch =3D ioread32(host->iobase +
> +							AU6601_REG_BUFFER);
> +					chunk =3D 4;
> +				}
> +
> +				*buf =3D scratch & 0xFF;
> +
> +				buf++;
> +				scratch >>=3D 8;
> +				chunk--;
> +				len--;
> +			}
> +		}
> +	}
> +
> +	sg_miter_stop(&host->sg_miter);
> +	local_irq_restore(flags);
> +}
> +
> +static void au6601_write_block(struct au6601_host *host)
> +{
> +	unsigned long flags;
> +	size_t blksize, len, chunk;
> +	void __iomem *virt_base =3D host->virt_base;
> +	u32 scratch;
> +	u8 *buf;
> +
> +	dev_dbg(host->dev, "PIO writing\n");
> +
> +	blksize =3D host->data->blksz * host->requested_blocks;
> +	chunk =3D 0;
> +	scratch =3D 0;
> +
> +	local_irq_save(flags);
> +
> +	while (blksize) {
> +		if (!sg_miter_next(&host->sg_miter))
> +			BUG();
> +
> +		len =3D min(host->sg_miter.length, blksize);
> +
> +		blksize -=3D len;
> +		host->sg_miter.consumed =3D len;
> +
> +		buf =3D host->sg_miter.addr;
> +
> +		if (host->dma_on) {
> +			memcpy_toio(virt_base, buf, len);
> +			virt_base +=3D len;
> +			len =3D 0;
> +		} else {
> +			while (len) {
> +				scratch |=3D (u32)*buf << (chunk * 8);
> +
> +				buf++;
> +				chunk++;
> +				len--;
> +
> +				if ((chunk =3D=3D 4) || ((len =3D=3D 0)
> +						&& (blksize =3D=3D 0))) {
> +					iowrite32(scratch, host->iobase +
> +						AU6601_REG_BUFFER);
> +					chunk =3D 0;
> +					scratch =3D 0;
> +				}
> +			}
> +		}
> +	}
> +
> +	sg_miter_stop(&host->sg_miter);
> +
> +	local_irq_restore(flags);
> +}
> +
> +static void au6601_transfer_data(struct au6601_host *host)
> +{
> +	BUG_ON(!host->data);
> +
> +	if (host->blocks =3D=3D 0)
> +		return;
> +
> +	if (host->data->flags & MMC_DATA_READ)
> +		au6601_read_block(host);
> +	else
> +		au6601_write_block(host);
> +
> +	host->blocks -=3D host->requested_blocks;
> +	if (host->dma_on) {
> +		host->dma_on =3D 0;
> +		if (host->blocks || (!host->blocks &&
> +				(host->data->flags & MMC_DATA_WRITE)))
> +			au6601_trigger_data_transfer(host, 1);
> +		else
> +			au6601_finish_data(host);
> +	}
> +
> +	dev_dbg(host->dev, "PIO transfer complete.\n");
> +}
> +
> +static void au6601_finish_command(struct au6601_host *host)
> +{
> +	struct mmc_command *cmd =3D host->cmd;
> +
> +	BUG_ON(host->cmd =3D=3D NULL);
> +
> +	if (host->cmd->flags & MMC_RSP_PRESENT) {
> +		cmd->resp[0] =3D ioread32be(host->iobase + AU6601_REG_CMD_RSP0);
> +		if (host->cmd->flags & MMC_RSP_136) {
> +			cmd->resp[1] =3D
> +				ioread32be(host->iobase + AU6601_REG_CMD_RSP1);
> +			cmd->resp[2] =3D
> +				ioread32be(host->iobase + AU6601_REG_CMD_RSP2);
> +			cmd->resp[3] =3D
> +				ioread32be(host->iobase + AU6601_REG_CMD_RSP3);
> +		}
> +
> +	}
> +
> +	host->cmd->error =3D 0;
> +
> +	/* Finished CMD23, now send actual command. */
> +	if (host->cmd =3D=3D host->mrq->sbc) {
> +		host->cmd =3D NULL;
> +		au6601_send_cmd(host, host->mrq->cmd);
> +	} else {
> +		/* Processed actual command. */
> +		if (!host->data)
> +			tasklet_schedule(&host->finish_tasklet);
> +		else if (host->data_early)
> +			au6601_finish_data(host);
> +		else if (host->trigger_dma_dac) {
> +			host->dma_on =3D 1;
> +			au6601_transfer_data(host);
> +		}
> +
> +		host->cmd =3D NULL;
> +	}
> +}
> +
> +static void au6601_finish_data(struct au6601_host *host)
> +{
> +	struct mmc_data *data;
> +
> +	BUG_ON(!host->data);
> +
> +	data =3D host->data;
> +	host->data =3D NULL;
> +	host->dma_on =3D 0;
> +	host->trigger_dma_dac =3D 0;
> +
> +	/*
> +	 * The specification states that the block count register must
> +	 * be updated, but it does not specify at what point in the
> +	 * data flow. That makes the register entirely useless to read
> +	 * back so we have to assume that nothing made it to the card
> +	 * in the event of an error.
> +	 */
> +	if (data->error)
> +		data->bytes_xfered =3D 0;
> +	else
> +		data->bytes_xfered =3D data->blksz * data->blocks;
> +
> +	/*
> +	 * Need to send CMD12 if -
> +	 * a) open-ended multiblock transfer (no CMD23)
> +	 * b) error in multiblock transfer
> +	 */
> +	if (data->stop &&
> +	    (data->error ||
> +	     !host->mrq->sbc)) {
> +
> +		/*
> +		 * The controller needs a reset of internal state machines
> +		 * upon error conditions.
> +		 */
> +		if (data->error) {
> +			au6601_reset(host, AU6601_RESET_CMD);
> +			au6601_reset(host, AU6601_RESET_DATA);
> +		}
> +		au6601_send_cmd(host, data->stop);
> +	} else
> +		tasklet_schedule(&host->finish_tasklet);
> +}
> +
> +static void au6601_prepare_sg_miter(struct au6601_host *host)
> +{
> +	unsigned int flags =3D SG_MITER_ATOMIC;
> +	struct mmc_data *data =3D host->data;
> +
> +	if (data->flags & MMC_DATA_READ)
> +		flags |=3D SG_MITER_TO_SG;
> +	else
> +		flags |=3D SG_MITER_FROM_SG;
> +	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
> +}
> +
> +static void au6601_prepare_data(struct au6601_host *host,
> +				struct mmc_command *cmd)
> +{
> +	unsigned int dma =3D 0;
> +	struct mmc_data *data =3D cmd->data;
> +
> +	WARN_ON(host->data);
> +
> +	if (!data)
> +		return;
> +
> +	/* Sanity checks */
> +	BUG_ON(data->blksz * data->blocks > 524288);
> +	BUG_ON(data->blksz > host->mmc->max_blk_size);
> +	BUG_ON(data->blocks > AU6601_MAX_BLOCK_COUNT);
> +
> +	host->data =3D data;
> +	host->data_early =3D 0;
> +	host->data->bytes_xfered =3D 0;
> +	host->requested_blocks =3D 1;
> +
> +	au6601_prepare_sg_miter(host);
> +	host->blocks =3D data->blocks;
> +
> +	if (!disable_dma &&
> +			host->blocks > 1 &&
> +			data->blksz =3D=3D host->mmc->max_blk_size) {
> +		dma =3D 1;
> +
> +		if (data->flags & MMC_DATA_WRITE) {
> +			/* prepare first write buffer */
> +			/* Don't trigger data transfer now.
> +			 * DMA may start it too eraly */
> +			host->trigger_dma_dac =3D 1;
> +			return;
> +		}
> +	}
> +
> +	au6601_trigger_data_transfer(host, dma);
> +}
> +
> +static void au6601_send_cmd(struct au6601_host *host,
> +			    struct mmc_command *cmd)
> +{
> +	u8 ctrl; /*some mysterious flags and control */
> +	unsigned long timeout;
> +
> +	timeout =3D jiffies;
> +	if (!cmd->data && cmd->busy_timeout > 9000)
> +		timeout +=3D DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> +	else
> +		timeout +=3D 10 * HZ;
> +	mod_timer(&host->timer, timeout);
> +
> +	host->cmd =3D cmd;
> +	au6601_prepare_data(host, cmd);
> +
> +	iowrite8(cmd->opcode | 0x40, host->iobase + AU6601_REG_CMD_OPCODE);
> +	iowrite32be(cmd->arg, host->iobase + AU6601_REG_CMD_ARG);
> +
> +	switch (mmc_resp_type(cmd)) {
> +	case MMC_RSP_NONE:
> +		ctrl =3D 0;
> +		break;
> +	case MMC_RSP_R1:
> +		ctrl =3D 0x40;
> +		break;
> +	case MMC_RSP_R1B:
> +		ctrl =3D 0x40 | 0x10;
> +		break;
> +	case MMC_RSP_R2:
> +		ctrl =3D 0xc0;
> +		break;
> +	case MMC_RSP_PRESENT | MMC_RSP_OPCODE:
> +	case MMC_RSP_R3:
> +		ctrl =3D 0x80;
> +		break;
> +	default:
> +		dev_err(host->dev, "%s: cmd->flag (0x%02x) is not valid\n",
> +			mmc_hostname(host->mmc), mmc_resp_type(cmd));
> +		break;
> +	}
> +
> +	iowrite8(ctrl | 0x20, host->iobase + AU6601_REG_CMD_CTRL);
> +}
> +
> +/*********************************************************************=
********\
> + *									     *
> + * Interrupt handling							     *
> + *									     *
> +\*********************************************************************=
********/
> +
> +static void au6601_cmd_irq(struct au6601_host *host, u32 intmask)
> +{
> +	BUG_ON(intmask =3D=3D 0);
> +
> +	if (!host->cmd) {
> +		dev_err(host->dev,
> +			"Got command interrupt 0x%08x even though no command operation was =
in progress.\n",
> +			intmask);
> +		return;
> +	}
> +
> +	if (intmask & AU6601_INT_TIMEOUT)
> +		host->cmd->error =3D -ETIMEDOUT;
> +	else if (intmask & (AU6601_INT_CRC | AU6601_INT_END_BIT |
> +			AU6601_INT_INDEX))
> +		host->cmd->error =3D -EILSEQ;
> +
> +	if (host->cmd->error) {
> +		tasklet_schedule(&host->finish_tasklet);
> +		return;
> +	}
> +
> +	/*
> +	 * The host can send and interrupt when the busy state has
> +	 * ended, allowing us to wait without wasting CPU cycles.
> +	 * Unfortunately this is overloaded on the "data complete"
> +	 * interrupt, so we need to take some care when handling
> +	 * it.
> +	 *
> +	 * Note: The 1.0 specification is a bit ambiguous about this
> +	 *       feature so there might be some problems with older
> +	 *       controllers.
> +	 */
> +	if (host->cmd->flags & MMC_RSP_BUSY) {
> +		if (host->cmd->data)
> +			dev_warn(host->dev,
> +				 "Cannot wait for busy signal when also doing a data transfer");
> +	}
> +
> +	if (intmask & AU6601_INT_RESPONSE)
> +		au6601_finish_command(host);
> +}
> +
> +static void au6601_data_irq(struct au6601_host *host, u32 intmask)
> +{
> +	BUG_ON(intmask =3D=3D 0);
> +
> +	if (!host->data) {
> +		/* FIXME: Ist is same for AU6601
> +		 * The "data complete" interrupt is also used to
> +		 * indicate that a busy state has ended. See comment
> +		 * above in au6601_cmd_irq().
> +		 */
> +		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
> +			if (intmask & AU6601_INT_DATA_END) {
> +				au6601_finish_command(host);
> +				return;
> +			}
> +		}
> +
> +		dev_err(host->dev,
> +			"Got data interrupt 0x%08x even though no data operation was in pro=
gress.\n",
> +			(unsigned)intmask);
> +
> +		if (intmask & AU6601_INT_ERROR_MASK) {
> +			host->cmd->error =3D -ETIMEDOUT;
> +			tasklet_schedule(&host->finish_tasklet);
> +		}
> +		return;
> +	}
> +
> +	if (intmask & AU6601_INT_DATA_TIMEOUT)
> +		host->data->error =3D -ETIMEDOUT;
> +	else if (intmask & AU6601_INT_DATA_END_BIT)
> +		host->data->error =3D -EILSEQ;
> +	else if (intmask & AU6601_INT_DATA_CRC)
> +		host->data->error =3D -EILSEQ;
> +
> +	if (host->data->error)
> +		au6601_finish_data(host);
> +	else {
> +		if (intmask & (AU6601_INT_DATA_AVAIL | AU6601_INT_SPACE_AVAIL))
> +			au6601_transfer_data(host);
> +
> +		if (intmask & AU6601_INT_DATA_END) {
> +			if (host->cmd) {
> +				/*
> +				 * Data managed to finish before the
> +				 * command completed. Make sure we do
> +				 * things in the proper order.
> +				 */
> +				host->data_early =3D 1;
> +			} else if (host->blocks && !host->dma_on) {
> +				/*
> +				 * Probably we do multi block operation.
> +				 * Prepare PIO for next block.
> +				 */
> +				au6601_trigger_data_transfer(host, 0);
> +			} else if (host->blocks && host->dma_on) {
> +				au6601_transfer_data(host);
> +			} else {
> +				if (host->dma_on)
> +					au6601_transfer_data(host);
> +				au6601_finish_data(host);
> +			}
> +		}
> +	}
> +}
> +
> +static irqreturn_t au6601_irq(int irq, void *d)
> +{
> +	struct au6601_host *host =3D d;
> +	irqreturn_t ret =3D IRQ_HANDLED;
> +	u32 intmask;
> +
> +	spin_lock(&host->lock);
> +
> +	intmask =3D ioread32(host->iobase + AU6601_REG_INT_STATUS);
> +	iowrite32(intmask, host->iobase + AU6601_REG_INT_STATUS);
> +
> +	/* some thing bad */
> +	if (unlikely(!intmask || intmask =3D=3D AU6601_INT_ALL_MASK)) {
> +		dev_warn(host->dev, "impossible IRQ %x\n", intmask);
> +		ret =3D IRQ_NONE;
> +		goto exit;
> +	}
> +
> +	if (intmask & AU6601_INT_CMD_MASK) {
> +		dev_dbg(host->dev, "CMD IRQ %x\n", intmask);
> +
> +		au6601_cmd_irq(host, intmask & AU6601_INT_CMD_MASK);
> +		intmask &=3D ~AU6601_INT_CMD_MASK;
> +	}
> +
> +	if (intmask & AU6601_INT_DATA_MASK) {
> +		dev_dbg(host->dev, "DATA IRQ %x\n", intmask);
> +		au6601_data_irq(host, intmask & AU6601_INT_DATA_MASK);
> +		intmask &=3D ~AU6601_INT_DATA_MASK;
> +	}
> +
> +	if (intmask & (AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE)) {
> +		/* this check can be remove */
> +		if (intmask & AU6601_INT_CARD_REMOVE)
> +			dev_dbg(host->dev, "card removed\n");
> +		else
> +			dev_dbg(host->dev, "card inserted\n");
> +
> +		intmask &=3D ~(AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE);
> +		tasklet_schedule(&host->card_tasklet);
> +	}
> +
> +	if (intmask & 0x100) {
> +		dev_warn(host->dev,
> +			 "0x100 (card INT?) got unknown IRQ with %x\n",
> +			 intmask);
> +		intmask &=3D ~0x100;
> +	}
> +
> +	if (intmask & 0xFFFF7FFF) {
> +		dev_warn(host->dev, "0xFFFF7FFF got unhandled IRQ with %x\n",
> +			 intmask);
> +	}
> +
> +exit:
> +	spin_unlock(&host->lock);
> +	return ret;
> +}
> +
> +static void au6601_sdc_request(struct mmc_host *mmc, struct mmc_reques=
t *mrq)
> +{
> +	struct au6601_host *host;
> +	unsigned long flags;
> +
> +	host =3D mmc_priv(mmc);
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	host->mrq =3D mrq;
> +
> +	/* check if card is present then send command and data */
> +	if (ioread8(host->iobase + REG_76) & 0x1)
> +		au6601_send_cmd(host, mrq->cmd);
> +	else {
> +		mrq->cmd->error =3D -ENOMEDIUM;
> +		tasklet_schedule(&host->finish_tasklet);
> +	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static void au6601_set_clock(struct au6601_host *host, unsigned int cl=
ock)
> +{
> +	unsigned int div =3D 0, mult =3D 0, ctrl =3D 0x1;
> +
> +	/* FIXME: mesuered and calculated values are different.
> +	 * the clock is unstable in some mult/div combinations.
> +	 */
> +	if (clock >=3D MHZ_TO_HZ(208)) {
> +		mult =3D 0xb0;	/* 30 * ? / 2 =3D ?MHz */
> +		div =3D 2;
> +	} else if (clock >=3D MHZ_TO_HZ(194)) {
> +		mult =3D 0x30;	/* 30 * 14 / 2 =3D 210MHz */
> +		div =3D 2;
> +	} else if (clock >=3D MHZ_TO_HZ(130)) {
> +		mult =3D 0x30;	/* 30 * 14 / 3 =3D 140MHz */
> +		div =3D 3;
> +	} else if (clock >=3D MHZ_TO_HZ(100)) {
> +		mult =3D 0x30;	/* 30 * 14 / 4 =3D 105MHz */
> +		div =3D 4;
> +	} else if (clock >=3D MHZ_TO_HZ(80)) {
> +		mult =3D 0x30;	/* 30 * 14 / 5 =3D 84MHz */
> +		div =3D 5;
> +	} else if (clock >=3D MHZ_TO_HZ(60)) {
> +		mult =3D 0x30;	/* 30 * 14 / 7 =3D 60MHz */
> +		div =3D 7;
> +	} else if (clock >=3D MHZ_TO_HZ(50)) {
> +		mult =3D 0x10;	/* 30 * 2 / 1 =3D 60MHz */
> +		div =3D 1;
> +	} else if (clock >=3D MHZ_TO_HZ(40)) {
> +		mult =3D 0x30;	/* 30 * 14 / 10 =3D 42MHz */
> +		div =3D 10;
> +	} else if (clock >=3D MHZ_TO_HZ(25)) {
> +		mult =3D 0x10;	/* 30 * 2 / 2 =3D 30MHz */
> +		div =3D 2;
> +	} else if (clock >=3D MHZ_TO_HZ(20)) {
> +		mult =3D 0x20;	/* 30 * 4 / 7 =3D 17MHz */
> +		div =3D 7;
> +	} else if (clock >=3D MHZ_TO_HZ(10)) {
> +		mult =3D 0x10;	/* 30 * 2 / 5 =3D 12MHz */
> +		div =3D 5;
> +	} else if (clock >=3D MHZ_TO_HZ(5)) {
> +		mult =3D 0x10;	/* 30 * 2 / 10 =3D 6MHz */
> +		div =3D 10;
> +	} else if (clock >=3D MHZ_TO_HZ(1)) {
> +		mult =3D 0x0;	/* 30 / 16 =3D 1,8 MHz */
> +		div =3D 16;
> +	} else if (clock =3D=3D 0) {
> +		ctrl =3D 0;
> +	} else {
> +		mult =3D 0x0;	/* reversed 150 * 200 =3D 30MHz */
> +		div =3D 200;	/* 150 KHZ mesured */
> +	}
> +	dev_dbg(host->dev, "set freq %d, %x, %x\n", clock, div, mult);
> +	iowrite16((div - 1) << 8 | mult | ctrl,
> +		  host->iobase + AU6601_REG_PLL_CTRL);
> +}
> +
> +static void au6601_sdc_set_ios(struct mmc_host *mmc, struct mmc_ios *i=
os)
> +{
> +	struct au6601_host *host;
> +	unsigned long flags;
> +
> +	host =3D mmc_priv(mmc);
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	iowrite8(0, host->iobase + REG_85);
> +	iowrite8(0x31, host->iobase + REG_7B);
> +	iowrite8(0x33, host->iobase + REG_7C);
> +	iowrite8(1, host->iobase + REG_75);
> +	iowrite8(0, host->iobase + REG_85);
> +
> +	if (ios->bus_width =3D=3D MMC_BUS_WIDTH_1) {
> +		iowrite8(0x0,
> +			 host->iobase + AU6601_REG_BUS_CTRL);
> +		au6601_clear_set_reg86(host, 0xc0, 0);
> +	} else if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4) {
> +		iowrite8(AU6601_BUS_WIDTH_4BIT,
> +			 host->iobase + AU6601_REG_BUS_CTRL);
> +		au6601_clear_set_reg86(host, 0, 0xc0);
> +	} else
> +		dev_err(host->dev, "Unknown BUS mode\n");
> +
> +	au6601_set_clock(host, ios->clock);
> +
> +	switch (ios->power_mode) {
> +	case MMC_POWER_OFF:
> +		au6601_set_power(host, 0x1 | 0x8, 0);
> +		break;
> +	case MMC_POWER_UP:
> +		au6601_set_power(host, 0x8, 1);
> +		break;
> +	case MMC_POWER_ON:
> +		au6601_set_power(host, 0x1, 1);
> +		au6601_set_power(host, 0x8, 0);
> +		break;
> +	default:
> +		dev_err(host->dev, "Unknown power parametr\n");
> +	}
> +
> +	iowrite8(0x80, host->iobase + REG_83);
> +	iowrite8(0x7d, host->iobase + REG_69);
> +	ioread8(host->iobase + REG_74);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static int au6601_ops_card_busy(struct mmc_host *mmc)
> +{
> +	struct au6601_host *host;
> +	host =3D mmc_priv(mmc);
> +
> +	return au6601_card_busy(host);
> +}
> +
> +static const struct mmc_host_ops au6601_sdc_ops =3D {
> +	.request =3D au6601_sdc_request,
> +	.set_ios =3D au6601_sdc_set_ios,
> +
> +	.card_busy =3D au6601_ops_card_busy,
> +};
> +
> +/*********************************************************************=
********\
> + *									     *
> + * Tasklets								     *
> + *									     *
> +\*********************************************************************=
********/
> +
> +static void au6601_tasklet_card(unsigned long param)
> +{
> +	struct au6601_host *host =3D (struct au6601_host *)param;
> +
> +	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> +}
> +
> +static void au6601_tasklet_finish(unsigned long param)
> +{
> +	struct au6601_host *host;
> +	unsigned long flags;
> +	struct mmc_request *mrq;
> +
> +	host =3D (struct au6601_host *)param;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	/*
> +	 * If this tasklet gets rescheduled while running, it will
> +	 * be run again afterwards but without any active request.
> +	 */
> +	if (!host->mrq) {
> +		spin_unlock_irqrestore(&host->lock, flags);
> +		return;
> +	}
> +
> +	del_timer(&host->timer);
> +
> +	mrq =3D host->mrq;
> +
> +	/*
> +	 * The controller needs a reset of internal state machines
> +	 * upon error conditions.
> +	 */
> +	if ((mrq->cmd && mrq->cmd->error) ||
> +		 (mrq->data && (mrq->data->error ||
> +		  (mrq->data->stop && mrq->data->stop->error)))) {
> +
> +		au6601_reset(host, AU6601_RESET_CMD);
> +		au6601_reset(host, AU6601_RESET_DATA);
> +	}
> +
> +	host->mrq =3D NULL;
> +	host->cmd =3D NULL;
> +	host->data =3D NULL;
> +	host->dma_on =3D 0;
> +	host->trigger_dma_dac =3D 0;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	mmc_request_done(host->mmc, mrq);
> +}
> +
> +static void au6601_timeout_timer(unsigned long data)
> +{
> +	struct au6601_host *host;
> +	unsigned long flags;
> +
> +	host =3D (struct au6601_host *)data;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (host->mrq) {
> +		dev_err(host->dev,
> +			"Timeout waiting for hardware interrupt.\n");
> +
> +		if (host->data) {
> +			host->data->error =3D -ETIMEDOUT;
> +			au6601_finish_data(host);
> +		} else {
> +			if (host->cmd)
> +				host->cmd->error =3D -ETIMEDOUT;
> +			else
> +				host->mrq->cmd->error =3D -ETIMEDOUT;
> +
> +			tasklet_schedule(&host->finish_tasklet);
> +		}
> +	}
> +
> +	mmiowb();
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +
> +
> +static void au6601_init_mmc(struct au6601_host *host)
> +{
> +	struct mmc_host *mmc =3D host->mmc;
> +
> +	mmc->f_min =3D AU6601_MIN_CLOCK;
> +	mmc->f_max =3D AU6601_MAX_CLOCK;
> +	mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> +	mmc->caps =3D MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED;
> +	mmc->ops =3D &au6601_sdc_ops;
> +
> +	/* Hardware cannot do scatter lists? */
> +	mmc->max_segs =3D AU6601_MAX_SEGMENTS;
> +
> +	mmc->max_blk_size =3D AU6601_MAX_BLOCK_LENGTH;
> +	mmc->max_blk_count =3D AU6601_MAX_BLOCK_COUNT;
> +
> +	mmc->max_seg_size =3D AU6601_MAX_BLOCK_LENGTH * AU6601_MAX_DMA_BLOCKS=
;
> +	mmc->max_req_size =3D mmc->max_seg_size * mmc->max_segs;
> +}
> +
> +static void au6601_hw_init(struct au6601_host *host)
> +{
> +
> +	iowrite8(0, host->iobase + REG_74);
> +
> +	iowrite8(0, host->iobase + REG_76);
> +	/* disable DlinkMode? disabled by default. */
> +	iowrite8(0x80, host->iobase + REG_76);
> +
> +	au6601_reset(host, AU6601_RESET_CMD);
> +
> +	iowrite8(0x0, host->iobase + REG_05);
> +	iowrite8(0x1, host->iobase + REG_75);
> +	au6601_clear_set_irqs(host, AU6601_INT_ALL_MASK,
> +		AU6601_INT_CMD_MASK | AU6601_INT_DATA_MASK |
> +		AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE |
> +		AU6601_INT_CARD_INT | AU6601_INT_BUS_POWER);
> +	iowrite32(0x0, host->iobase + AU6601_REG_BUS_CTRL);
> +
> +	au6601_reset(host, AU6601_RESET_DATA);
> +
> +	iowrite8(0x0, host->iobase + REG_05);
> +	iowrite8(0x0, host->iobase + REG_85);
> +	iowrite8(0x8, host->iobase + REG_75);
> +	iowrite32(0x3d00fa, host->iobase + REG_B4);
> +
> +	au6601_set_power(host, 0x1, 0);
> +	au6601_set_power(host, 0x8, 0);
> +
> +	host->dma_on =3D 0;
> +}
> +
> +static int __init au6601_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *ent)
> +{
> +	struct mmc_host *mmc;
> +	struct au6601_host *host;
> +	int ret, bar;
> +
> +	BUG_ON(pdev =3D=3D NULL);
> +	BUG_ON(ent =3D=3D NULL);
> +
> +	dev_info(&pdev->dev, "AU6601 controller found [%04x:%04x] (rev %x)\n"=
,
> +		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
> +
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> +		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
> +		return -ENODEV;
> +	}
> +
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* FIXME: create managed version of mmc_alloc_host and use it */
> +	mmc =3D mmc_alloc_host(sizeof(struct au6601_host *), &pdev->dev);
> +	if (!mmc) {
> +		dev_err(&pdev->dev, "Can't allocate MMC\n");
> +		return -ENOMEM;
> +	}
> +
> +	host =3D mmc_priv(mmc);
> +	host->mmc =3D mmc;
> +	host->pdev =3D pdev;
> +	host->dev =3D &pdev->dev;
> +
> +	ret =3D pci_request_region(pdev, bar, DRVNAME);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot request region\n");
> +		return -ENOMEM;
> +	}
> +
> +	host->iobase =3D pcim_iomap(pdev, bar, 0);
> +	if (!host->iobase)
> +		return -ENOMEM;
> +
> +	ret =3D devm_request_irq(&pdev->dev, pdev->irq, au6601_irq,
> +				IRQF_TRIGGER_FALLING, "au6601 host",
> +				host);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get irq for data line\n");
> +		return -ENOMEM;
> +	}
> +
> +	host->virt_base =3D dmam_alloc_coherent(&pdev->dev,
> +		AU6601_MAX_BLOCK_LENGTH * AU6601_MAX_DMA_BLOCKS,
> +		&host->phys_base, GFP_KERNEL);
> +	if (!host->virt_base) {
> +		dev_err(&pdev->dev, "Failed to alloc DMA\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set DMA mask\n");
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, host);
> +
> +	spin_lock_init(&host->lock);
> +	/*
> +	 * Init tasklets.
> +	 */
> +	tasklet_init(&host->card_tasklet,
> +		au6601_tasklet_card, (unsigned long)host);
> +	tasklet_init(&host->finish_tasklet,
> +		au6601_tasklet_finish, (unsigned long)host);
> +	setup_timer(&host->timer, au6601_timeout_timer, (unsigned long)host);=

> +
> +	au6601_init_mmc(host);
> +	au6601_hw_init(host);
> +
> +	mmc_add_host(mmc);
> +	return 0;
> +}
> +
> +static void au6601_hw_uninit(struct au6601_host *host)
> +{
> +	iowrite8(0x0, host->iobase + REG_76);
> +	au6601_clear_set_irqs(host, AU6601_INT_ALL_MASK, 0);
> +
> +	au6601_set_power(host, 0x1, 0);
> +
> +	iowrite8(0x0, host->iobase + REG_85);
> +	iowrite8(0x0, host->iobase + REG_B4);
> +
> +	au6601_set_power(host, 0x8, 0);
> +}
> +
> +static void __exit au6601_pci_remove(struct pci_dev *pdev)
> +{
> +	struct au6601_host *host;
> +
> +	host =3D pci_get_drvdata(pdev);
> +
> +	au6601_hw_uninit(host);
> +
> +	del_timer_sync(&host->timer);
> +	tasklet_kill(&host->card_tasklet);
> +	tasklet_kill(&host->finish_tasklet);
> +
> +	mmc_remove_host(host->mmc);
> +	mmc_free_host(host->mmc);
> +}
> +
> +#ifdef CONFIG_PM
> +
> +static int au6601_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct au6601_host *host;
> +	host =3D pci_get_drvdata(pdev);
> +
> +	au6601_hw_uninit(host);
> +
> +	pci_save_state(pdev);
> +	pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
> +	pci_disable_device(pdev);
> +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> +
> +	return 0;
> +}
> +
> +static int au6601_resume(struct pci_dev *pdev)
> +{
> +	struct au6601_host *host;
> +	int ret;
> +
> +	host =3D pci_get_drvdata(pdev);
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	ret =3D pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	au6601_hw_init(host);
> +	return 0;
> +}
> +
> +
> +#else /* CONFIG_PM */
> +
> +#define au6601_suspend NULL
> +#define au6601_resume NULL
> +
> +#endif /* CONFIG_PM */
> +
> +static struct pci_driver au6601_driver =3D {
> +	.name =3D	 DRVNAME,
> +	.id_table =3D     pci_ids,
> +	.probe =3D	au6601_pci_probe,
> +	.remove =3D       au6601_pci_remove,
> +	.suspend =3D au6601_suspend,
> +	.resume =3D au6601_resume,
> +};
> +
> +module_pci_driver(au6601_driver);
> +
> +module_param(disable_dma, bool, S_IRUGO);
> +MODULE_PARM_DESC(disable_dma, "Disable DMA");
> +
> +MODULE_AUTHOR("Oleksij Rempel <linux@rempel-privat.de>");
> +MODULE_DESCRIPTION("PCI driver for Alcor Micro AU6601 Secure Digital H=
ost Controller Interface");
> +MODULE_LICENSE("GPL");
>=20


--=20
Regards,
Oleksij


--8U3Qnl3TdWPsGvioLHjW9du3S4EvA4X73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlNzGRcACgkQHwImuRkmbWkiIwD/XT90MIbaaxW2q4NtZp8R7hIQ
SdMVBSNjY62pdH+pP9EA/iQXZUGrvBUDWxvQPF7a+l/d2VfkrghMq/JhZHPPKszz
=sjat
-----END PGP SIGNATURE-----

--8U3Qnl3TdWPsGvioLHjW9du3S4EvA4X73--
