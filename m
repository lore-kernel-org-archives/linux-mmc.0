From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
Date: Wed, 9 Dec 2009 10:50:16 +0900
Message-ID: <1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
	 <20091203220637.GR4808@trinity.fluff.org>
	 <1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
	 <20091207144145.GT4808@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63132 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbZLIBuN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2009 20:50:13 -0500
Received: by pwj9 with SMTP id 9so2008476pwj.21
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2009 17:50:19 -0800 (PST)
In-Reply-To: <20091207144145.GT4808@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jassi Brar <jassi.brar@samsung.com>

On Mon, Dec 7, 2009 at 11:41 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Dec 04, 2009 at 08:06:12PM +0900, jassi brar wrote:
>> On Fri, Dec 4, 2009 at 7:06 AM, Ben Dooks <ben-linux@fluff.org> wrot=
e:
>> > On Thu, Nov 26, 2009 at 03:48:17PM +0900, Jassi Brar wrote:
>> >> We need a way to pass controller specific information to the
>> >> SPI device driver. For that purpose a new header is made.
>> >>
>> >> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> >> ---
>> >> =C2=A0arch/arm/plat-s3c64xx/include/plat/spi.h | =C2=A0 68 ++++++=
++++++++++++++++++++++++
>> >> =C2=A01 files changed, 68 insertions(+), 0 deletions(-)
>> >> =C2=A0create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi.h
>> >>
>> >> diff --git a/arch/arm/plat-s3c64xx/include/plat/spi.h b/arch/arm/=
plat-s3c64xx/include/plat/spi.h
>> >> new file mode 100644
>> >> index 0000000..d65ddfd
>> >> --- /dev/null
>> >> +++ b/arch/arm/plat-s3c64xx/include/plat/spi.h
>> >
>> > let's not have all these called spi.h, it will make life more diff=
icult
>> > when trying to find which spi.h we are searching for in our platfo=
rm
>> > support.
>> We can call it s3c64xx-spi.h but won't that be kinda redundant as it=
's
>> in plat-s3c64xx ?
>
> If it ever gets moved, then there's your first problem case.
>
> The second, is that you look at the top of the driver and see <plat/s=
pi.h>
> and then go 'find . -type f -name spi.h' and see how many results you=
 get
> for that. Giving it a more descriptive name makes it easier to find t=
he
> right header without having to work out what is being included.
Ok.
Also I think, for reuse with newer SoCs, we need to divide this into tw=
o parts

  First - SPI controller specific part, which is common to all newer So=
Cs.
           Maybe this could go into plat-samsung/include with the
           name s3c64xx-spi.h?

  Second - SPI source clocks specific, which SoCs differ by name and nu=
mber.
          Maybe this could go into plat-<soc>/include with the name
          <soc>-spi.h

   Please share your opinion.

>> >> @@ -0,0 +1,68 @@
>> >> +/* linux/arch/arm/plat-s3c64xx/include/plat/spi.h
>> >> + *
>> >> + * Copyright (C) 2009 Samsung Electronics Ltd.
>> >> + * =C2=A0 Jaswinder Singh <jassi.brar@samsung.com>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or=
 modify
>> >> + * it under the terms of the GNU General Public License version =
2 as
>> >> + * published by the Free Software Foundation.
>> >> + */
>> >> +
>> >> +#ifndef __S3C64XX_PLAT_SPI_H
>> >> +#define __S3C64XX_PLAT_SPI_H __FILE__
>> >> +
>> >> +#define S3C64XX_SPI_SRCCLK_PCLK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>> >> +#define S3C64XX_SPI_SRCCLK_SPIBUS =C2=A0 =C2=A01
>> >> +#define S3C64XX_SPI_SRCCLK_48M =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 2
>> >> +
>> >> +#define BUSNUM(b) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(b)
>> >> +
>> >> +/**
>> >> + * struct s3c64xx_spi_csinfo - ChipSelect description
>> >> + * @fb_delay: Slave specific feedback delay.
>> >> + * @set_level: CS line control.
>> >> + */
>> >> +struct s3c64xx_spi_csinfo {
>> >> + =C2=A0 =C2=A0 u8 fb_delay;
>> >> + =C2=A0 =C2=A0 void (*set_level)(int lvl);
>> >> +};
>> >
>> > I think set_level should be called 'set_cs' to make it clearer wha=
t is
>> > being done here.
>> Well, in the driver we instantiate the structure pointer as 'cs', so=
 all
>> the calls look like "cs->set_level" so I think that should be ok,
>> as it's quite obvious its all about cs(ChipSelect).
>>
>> >> +/**
>> >> + * struct s3c64xx_spi_cntrlr_info - SPI Controller defining stru=
cture
>> >> + * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] f=
ield.
>> >> + * @src_clk_name: Platform name of the corresponding clock.
>> >> + * @src_clk: Pointer to the source clock.
>> >> + * @num_cs: Number of CS this controller emulates.
>> >> + * @cs: Array describing each CS.
>> >> + * @cfg_gpio: Configure pins for this SPI controller.
>> >> + * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
>> >> + * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
>> >> + * @high_speed: If the controller supports HIGH_SPEED_EN bit
>> >> + */
>> >> +struct s3c64xx_spi_cntrlr_info {
>> >
>> > how about not bothering with the _cntrlr_ here and just call it
>> > s3c64xx_spi_info instead?
>> Sure.
>>
>> >> + =C2=A0 =C2=A0 int src_clk_nr;
>> >> + =C2=A0 =C2=A0 char *src_clk_name;
>> >> + =C2=A0 =C2=A0 struct clk *src_clk;
>> >
>> > do not pass 'struct clk *' in via platform data.
>> Since this is not initialized in platform code: just a pointer
>> made available to the driver. So, yes, this can be made a
>> member of s3c64xx_spi_driver_data rather.
>>
>> >> + =C2=A0 =C2=A0 int num_cs;
>> >> + =C2=A0 =C2=A0 struct s3c64xx_spi_csinfo *cs;
>> >> +
>> >> + =C2=A0 =C2=A0 int (*cfg_gpio)(struct platform_device *pdev);
>> >> +
>> >> + =C2=A0 =C2=A0 /* Following two fields are for future compatibil=
ity */
>> >> + =C2=A0 =C2=A0 int fifo_lvl_mask;
>> >> + =C2=A0 =C2=A0 int rx_lvl_offset;
>> >> + =C2=A0 =C2=A0 int high_speed;
>> >> +};
>> >
>> > I was wondering if a single 'set_cs' callback here would be in ord=
er,
>> > given each spi device can already hold a chip-select number for us=
e
>> > with such callbacks, so:
>> >
>> > void (*set_cs)(struct s3c64xx_spi_cntrlr_info *us, struct spi_devi=
ce *sel, int to);
>> In that case the machine code wud have to map the chipselect number =
to
>> appropriate function/switch-case. Switch-case maybe ok, but calling =
some
>> function to toggle CS might result in bigger lags between CS and app=
earance
>> of clock on the bus.
>
> The point is that we should already have a pointer to the spi device
> being initialised, and this can have a machine-set field in it specif=
ying
> the chipselect. If it is all gpio, then this simply could be the
> number of the gpio involved.
Just for clarification:- the current implementation does make use of
spi_device->controller_data which, as u suggest, is set by machine code
to the pointer to a structure(since there is another CS
specific parameter- fb_delay) s3c64xx_spi_csinfo
We must have a callback function member, rather than void*, because
not every CS maybe simple GPIO manipulation. The driver simply call the
pointer to a function implemented in machine code.
I am unable to decide how to implement what u suggest.
If u think u understand the situation well and still stand by ur idea, =
please
let me know, I will modify the driver as you will explain.

> I don't see that this is going to save a lot of code time, wheras it =
is
> adding to the complexity of the platform data.
 Yes, that shudn't be a concern.

>> >> +/**
>> >> + * s3c64xx_spi_set_info - SPI Controller configure callback by t=
he board
>> >> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initialization code.
>> >> + * @cntrlr: SPI controller number the configuration is for.
>> >> + * @src_clk_nr: Clock the SPI controller is to use to generate S=
PI clocks.
>> >> + * @cs: Pointer to the array of CS descriptions.
>> >> + * @num_cs: Number of elements in the 'cs' array.
>> >> + */
>> >> +extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int=
 num_cs);
>> >> +
>> >> +#endif /* __S3C64XX_PLAT_SPI_H */
>> >> --
>> >> 1.6.2.5
