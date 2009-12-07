From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
Date: Mon, 7 Dec 2009 14:41:45 +0000
Message-ID: <20091207144145.GT4808@trinity.fluff.org>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com> <20091203220637.GR4808@trinity.fluff.org> <1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:37741 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689AbZLGOln (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Dec 2009 09:41:43 -0500
Content-Disposition: inline
In-Reply-To: <1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jassi Brar <jassi.brar@samsung.com>

On Fri, Dec 04, 2009 at 08:06:12PM +0900, jassi brar wrote:
> On Fri, Dec 4, 2009 at 7:06 AM, Ben Dooks <ben-linux@fluff.org> wrote=
:
> > On Thu, Nov 26, 2009 at 03:48:17PM +0900, Jassi Brar wrote:
> >> We need a way to pass controller specific information to the
> >> SPI device driver. For that purpose a new header is made.
> >>
> >> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> >> ---
> >> =A0arch/arm/plat-s3c64xx/include/plat/spi.h | =A0 68 +++++++++++++=
+++++++++++++++++
> >> =A01 files changed, 68 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi.h
> >>
> >> diff --git a/arch/arm/plat-s3c64xx/include/plat/spi.h b/arch/arm/p=
lat-s3c64xx/include/plat/spi.h
> >> new file mode 100644
> >> index 0000000..d65ddfd
> >> --- /dev/null
> >> +++ b/arch/arm/plat-s3c64xx/include/plat/spi.h
> >
> > let's not have all these called spi.h, it will make life more diffi=
cult
> > when trying to find which spi.h we are searching for in our platfor=
m
> > support.
> We can call it s3c64xx-spi.h but won't that be kinda redundant as it'=
s
> in plat-s3c64xx ?

If it ever gets moved, then there's your first problem case.

The second, is that you look at the top of the driver and see <plat/spi=
=2Eh>
and then go 'find . -type f -name spi.h' and see how many results you g=
et
for that. Giving it a more descriptive name makes it easier to find the
right header without having to work out what is being included.
=20
> >> @@ -0,0 +1,68 @@
> >> +/* linux/arch/arm/plat-s3c64xx/include/plat/spi.h
> >> + *
> >> + * Copyright (C) 2009 Samsung Electronics Ltd.
> >> + * =A0 Jaswinder Singh <jassi.brar@samsung.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or =
modify
> >> + * it under the terms of the GNU General Public License version 2=
 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +#ifndef __S3C64XX_PLAT_SPI_H
> >> +#define __S3C64XX_PLAT_SPI_H __FILE__
> >> +
> >> +#define S3C64XX_SPI_SRCCLK_PCLK =A0 =A0 =A0 =A0 =A0 =A0 =A00
> >> +#define S3C64XX_SPI_SRCCLK_SPIBUS =A0 =A01
> >> +#define S3C64XX_SPI_SRCCLK_48M =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> >> +
> >> +#define BUSNUM(b) =A0 =A0 =A0 =A0 =A0 =A0(b)
> >> +
> >> +/**
> >> + * struct s3c64xx_spi_csinfo - ChipSelect description
> >> + * @fb_delay: Slave specific feedback delay.
> >> + * @set_level: CS line control.
> >> + */
> >> +struct s3c64xx_spi_csinfo {
> >> + =A0 =A0 u8 fb_delay;
> >> + =A0 =A0 void (*set_level)(int lvl);
> >> +};
> >
> > I think set_level should be called 'set_cs' to make it clearer what=
 is
> > being done here.
> Well, in the driver we instantiate the structure pointer as 'cs', so =
all
> the calls look like "cs->set_level" so I think that should be ok,
> as it's quite obvious its all about cs(ChipSelect).
>=20
> >> +/**
> >> + * struct s3c64xx_spi_cntrlr_info - SPI Controller defining struc=
ture
> >> + * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] fi=
eld.
> >> + * @src_clk_name: Platform name of the corresponding clock.
> >> + * @src_clk: Pointer to the source clock.
> >> + * @num_cs: Number of CS this controller emulates.
> >> + * @cs: Array describing each CS.
> >> + * @cfg_gpio: Configure pins for this SPI controller.
> >> + * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
> >> + * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
> >> + * @high_speed: If the controller supports HIGH_SPEED_EN bit
> >> + */
> >> +struct s3c64xx_spi_cntrlr_info {
> >
> > how about not bothering with the _cntrlr_ here and just call it
> > s3c64xx_spi_info instead?
> Sure.
>=20
> >> + =A0 =A0 int src_clk_nr;
> >> + =A0 =A0 char *src_clk_name;
> >> + =A0 =A0 struct clk *src_clk;
> >
> > do not pass 'struct clk *' in via platform data.
> Since this is not initialized in platform code: just a pointer
> made available to the driver. So, yes, this can be made a
> member of s3c64xx_spi_driver_data rather.
>=20
> >> + =A0 =A0 int num_cs;
> >> + =A0 =A0 struct s3c64xx_spi_csinfo *cs;
> >> +
> >> + =A0 =A0 int (*cfg_gpio)(struct platform_device *pdev);
> >> +
> >> + =A0 =A0 /* Following two fields are for future compatibility */
> >> + =A0 =A0 int fifo_lvl_mask;
> >> + =A0 =A0 int rx_lvl_offset;
> >> + =A0 =A0 int high_speed;
> >> +};
> >
> > I was wondering if a single 'set_cs' callback here would be in orde=
r,
> > given each spi device can already hold a chip-select number for use
> > with such callbacks, so:
> >
> > void (*set_cs)(struct s3c64xx_spi_cntrlr_info *us, struct spi_devic=
e *sel, int to);
> In that case the machine code wud have to map the chipselect number t=
o
> appropriate function/switch-case. Switch-case maybe ok, but calling s=
ome
> function to toggle CS might result in bigger lags between CS and appe=
arance
> of clock on the bus.

The point is that we should already have a pointer to the spi device
being initialised, and this can have a machine-set field in it specifyi=
ng
the chipselect. If it is all gpio, then this simply could be the
number of the gpio involved.=20

I don't see that this is going to save a lot of code time, wheras it is
adding to the complexity of the platform data.
=20
> >> +/**
> >> + * s3c64xx_spi_set_info - SPI Controller configure callback by th=
e board
> >> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 initializa=
tion code.
> >> + * @cntrlr: SPI controller number the configuration is for.
> >> + * @src_clk_nr: Clock the SPI controller is to use to generate SP=
I clocks.
> >> + * @cs: Pointer to the array of CS descriptions.
> >> + * @num_cs: Number of elements in the 'cs' array.
> >> + */
> >> +extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int =
num_cs);
> >> +
> >> +#endif /* __S3C64XX_PLAT_SPI_H */
> >> --
> >> 1.6.2.5
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> > --
> > --
> > Ben
> >
> > Q: =A0 =A0 =A0What's a light-year?
> > A: =A0 =A0 =A0One-third less calories than a regular year.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

