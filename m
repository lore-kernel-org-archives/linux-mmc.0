From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 5/5] SPI S3C64XX: SPI Controller driver for S3C64XX
Date: Thu, 26 Nov 2009 17:27:31 +0900
Message-ID: <1b68c6790911260027oe29cccasa06c12e4832bcb8@mail.gmail.com>
References: <1259218110-9905-1-git-send-email-jassi.brar@samsung.com>
	 <fa686aa40911252340j102f250dw586091c4de73a106@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:35971 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759673AbZKZI1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2009 03:27:25 -0500
Received: by pxi10 with SMTP id 10so400867pxi.33
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2009 00:27:31 -0800 (PST)
In-Reply-To: <fa686aa40911252340j102f250dw586091c4de73a106@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jassi Brar <jassi.brar@samsung.com>, dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On Thu, Nov 26, 2009 at 4:40 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Wed, Nov 25, 2009 at 11:48 PM, Jassi Brar <jassi.brar@samsung.com>=
 wrote:
>> Added S3C64XX SPI controller driver.
>>
>> Each SPI controller has exactly one CS line and as such doesn't
>> provide for multi-cs. We implement a workaround to support
>> multi-cs by _not_ configuring the mux'ed CS pin for each SPI
>> controller. The CS mechanism is assumed to be fully machine
>> specific - the driver doesn't even assume some GPIO pin is used
>> to control the CS.
>>
>> The driver selects between DMA and POLLING mode depending upon
>> the xfer size - DMA mode for xfers bigger than FIFO size, POLLING
>> mode otherwise.
>>
>> The driver has been designed to be capable of running SoCs since
>> s3c64xx and till date, for that reason some of the register fields
>> have been passed via, SoC specific, platform data.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> =C2=A0drivers/spi/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +
>> =C2=A0drivers/spi/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/spi/spi_s3c64xx.c | 1033 +++++++++++++++++++++++++++++=
++++++++++++++++
>> =C2=A0drivers/spi/spi_s3c64xx.h | =C2=A0189 +++++++++
>
> This is in the drivers/spi tree, but depends on the arch/arm stuff
> from the first 4 patches. =C2=A0Will need to decide which tree to mer=
ge
> this driver though.
>
> I won't review patches 1-4, but I've got a few comments for this
> patch. =C2=A0Mostly minor stuff. =C2=A0I don't seen anything on quick=
 review
> that jumps out at me as bad.
>
>> +
>> +#include "spi_s3c64xx.h"
>
> First, why the separate header file? =C2=A0It doesn't look like there=
 are
> any external users of the header file data. =C2=A0Please merge it int=
o the
> top of the .c file.
there is no user other than spi_s3c64xx.c
okay, I will merge the header in code.

>> +
>> +static struct s3c2410_dma_client s3c64xx_spi_dma_client =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .name =3D "s3c64xx-spi-dma",
>> +};
>> +
>> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>> +
>> +static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct s3c64xx_spi_cntrlr_info *sci =3D sdd->=
cntrlr_info;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long loops;
>> + =C2=A0 =C2=A0 =C2=A0 u32 val;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 val =3D readl(sdd->regs + S3C64XX_SPI_CH_CFG)=
;
>> + =C2=A0 =C2=A0 =C2=A0 val |=3D S3C64XX_SPI_CH_SW_RST;
>> + =C2=A0 =C2=A0 =C2=A0 val &=3D ~S3C64XX_SPI_CH_HS_EN;
>> + =C2=A0 =C2=A0 =C2=A0 writel(val, sdd->regs + S3C64XX_SPI_CH_CFG);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* Flush TxFIFO*/
>> + =C2=A0 =C2=A0 =C2=A0 loops =3D msecs_to_loops(1);
>> + =C2=A0 =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D readl(sdd=
->regs + S3C64XX_SPI_STATUS);
>> + =C2=A0 =C2=A0 =C2=A0 } while (TX_FIFO_LVL(val, sci) && loops--);
>
> nasty spin. =C2=A0Can you sleep here instead? =C2=A0How much time do =
you project
> is needed to flush the fifo. =C2=A0It is a worthwhile question to ask=
 on
> the other spin loops through this file.
Since this is called from between two xfers of a message,
sleeping isn't an option. Besides, the loops shudn't take more than a f=
ew
counts if everything is working fine.
=46IFO needs to be flushed before setting the PACKET_CNT register.
The real flushing is done by the S3C64XX_SPI_CH_SW_RST bit, these
loops are just to 'confirm' flushing. So, ideally, it shudn't loop even=
 second
counter. Practically, a few microseconds shud be enough waiting for cor=
rect
status. Btw, if it waits 1ms full, its pretty much the controller
malfunctioned and subsequent xfers will fail too(so we don't catch the
error here).
This function is called after every xfer so we can not sleep, even one =
slice,
 when the FIFO is flushed but the status register doesn't yet reflect t=
hat.

The same holds for the other loop.

>> +static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct s3c64xx_spi_csinfo *cs;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (sdd->tgl_spi !=3D NULL) { /* If last devi=
ce toggled after mssg */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sdd->tgl_spi =
!=3D spi) { /* if last mssg on diff device */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Deselect the last toggled device */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cs =3D sdd->tgl_spi->controller_data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (sdd->tgl_spi->mode & SPI_CS_HIGH)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdd->tgl_spi =3D =
NULL;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 cs =3D spi->controller_data;
>> + =C2=A0 =C2=A0 =C2=A0 if (spi->mode & SPI_CS_HIGH)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(1);
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(0);
>
> cs->set_level(spi->mode & SPI_CS_HIGH ? 1 : 0) perhaps?
yes, that wud be better.

>> +
>> + =C2=A0 =C2=A0 =C2=A0 S3C64XX_SPI_ACT(sdd);
>> +}
> [...]
>> +static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct s3c64xx_spi_csinfo *cs;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 S3C64XX_SPI_DEACT(sdd);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (sdd->tgl_spi =3D=3D spi)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdd->tgl_spi =3D =
NULL;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 cs =3D spi->controller_data;
>> + =C2=A0 =C2=A0 =C2=A0 if (spi->mode & SPI_CS_HIGH)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(0);
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs->set_level(1);
>
> ditto here.
yes sure.
Thanks.
