From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] SPI S3C64XX: SPI Controller driver for S3C64XX
Date: Thu, 26 Nov 2009 00:40:58 -0700
Message-ID: <fa686aa40911252340j102f250dw586091c4de73a106@mail.gmail.com>
References: <1259218110-9905-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36452 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746AbZKZHlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2009 02:41:13 -0500
Received: by gxk26 with SMTP id 26so440211gxk.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2009 23:41:18 -0800 (PST)
In-Reply-To: <1259218110-9905-1-git-send-email-jassi.brar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dbrownell@users.sourceforge.net, ben-linux@fluff.org

On Wed, Nov 25, 2009 at 11:48 PM, Jassi Brar <jassi.brar@samsung.com> w=
rote:
> Added S3C64XX SPI controller driver.
>
> Each SPI controller has exactly one CS line and as such doesn't
> provide for multi-cs. We implement a workaround to support
> multi-cs by _not_ configuring the mux'ed CS pin for each SPI
> controller. The CS mechanism is assumed to be fully machine
> specific - the driver doesn't even assume some GPIO pin is used
> to control the CS.
>
> The driver selects between DMA and POLLING mode depending upon
> the xfer size - DMA mode for xfers bigger than FIFO size, POLLING
> mode otherwise.
>
> The driver has been designed to be capable of running SoCs since
> s3c64xx and till date, for that reason some of the register fields
> have been passed via, SoC specific, platform data.
>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 =A07 +
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/spi_s3c64xx.c | 1033 +++++++++++++++++++++++++++++++++=
++++++++++++
> =A0drivers/spi/spi_s3c64xx.h | =A0189 +++++++++

This is in the drivers/spi tree, but depends on the arch/arm stuff
from the first 4 patches.  Will need to decide which tree to merge
this driver though.

I won't review patches 1-4, but I've got a few comments for this
patch.  Mostly minor stuff.  I don't seen anything on quick review
that jumps out at me as bad.

> +
> +#include "spi_s3c64xx.h"

=46irst, why the separate header file?  It doesn't look like there are
any external users of the header file data.  Please merge it into the
top of the .c file.

> +
> +static struct s3c2410_dma_client s3c64xx_spi_dma_client =3D {
> + =A0 =A0 =A0 .name =3D "s3c64xx-spi-dma",
> +};
> +
> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> +
> +static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
> +{
> + =A0 =A0 =A0 struct s3c64xx_spi_cntrlr_info *sci =3D sdd->cntrlr_inf=
o;
> + =A0 =A0 =A0 unsigned long loops;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 val =3D readl(sdd->regs + S3C64XX_SPI_CH_CFG);
> + =A0 =A0 =A0 val |=3D S3C64XX_SPI_CH_SW_RST;
> + =A0 =A0 =A0 val &=3D ~S3C64XX_SPI_CH_HS_EN;
> + =A0 =A0 =A0 writel(val, sdd->regs + S3C64XX_SPI_CH_CFG);
> +
> + =A0 =A0 =A0 /* Flush TxFIFO*/
> + =A0 =A0 =A0 loops =3D msecs_to_loops(1);
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readl(sdd->regs + S3C64XX_SPI_S=
TATUS);
> + =A0 =A0 =A0 } while (TX_FIFO_LVL(val, sci) && loops--);

nasty spin.  Can you sleep here instead?  How much time do you project
is needed to flush the fifo.  It is a worthwhile question to ask on
the other spin loops through this file.

> +static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct s3c64xx_spi_csinfo *cs;
> +
> + =A0 =A0 =A0 if (sdd->tgl_spi !=3D NULL) { /* If last device toggled=
 after mssg */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdd->tgl_spi !=3D spi) { /* if last=
 mssg on diff device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Deselect the last to=
ggled device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D sdd->tgl_spi->co=
ntroller_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdd->tgl_spi->mode =
& SPI_CS_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set=
_level(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set=
_level(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdd->tgl_spi =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cs =3D spi->controller_data;
> + =A0 =A0 =A0 if (spi->mode & SPI_CS_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(1);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(0);

cs->set_level(spi->mode & SPI_CS_HIGH ? 1 : 0) perhaps?

> +
> + =A0 =A0 =A0 S3C64XX_SPI_ACT(sdd);
> +}
[...]
> +static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct s3c64xx_spi_csinfo *cs;
> +
> + =A0 =A0 =A0 S3C64XX_SPI_DEACT(sdd);
> +
> + =A0 =A0 =A0 if (sdd->tgl_spi =3D=3D spi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdd->tgl_spi =3D NULL;
> +
> + =A0 =A0 =A0 cs =3D spi->controller_data;
> + =A0 =A0 =A0 if (spi->mode & SPI_CS_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(1);

ditto here.

g.
