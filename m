From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
Date: Fri, 4 Dec 2009 20:06:12 +0900
Message-ID: <1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
	 <20091203220637.GR4808@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:42832 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbZLDLGG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2009 06:06:06 -0500
Received: by pzk14 with SMTP id 14so2454505pzk.23
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2009 03:06:12 -0800 (PST)
In-Reply-To: <20091203220637.GR4808@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Jassi Brar <jassi.brar@samsung.com>, dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 4, 2009 at 7:06 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Nov 26, 2009 at 03:48:17PM +0900, Jassi Brar wrote:
>> We need a way to pass controller specific information to the
>> SPI device driver. For that purpose a new header is made.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> =C2=A0arch/arm/plat-s3c64xx/include/plat/spi.h | =C2=A0 68 +++++++++=
+++++++++++++++++++++
>> =C2=A01 files changed, 68 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi.h
>>
>> diff --git a/arch/arm/plat-s3c64xx/include/plat/spi.h b/arch/arm/pla=
t-s3c64xx/include/plat/spi.h
>> new file mode 100644
>> index 0000000..d65ddfd
>> --- /dev/null
>> +++ b/arch/arm/plat-s3c64xx/include/plat/spi.h
>
> let's not have all these called spi.h, it will make life more difficu=
lt
> when trying to find which spi.h we are searching for in our platform
> support.
We can call it s3c64xx-spi.h but won't that be kinda redundant as it's
in plat-s3c64xx ?

>> @@ -0,0 +1,68 @@
>> +/* linux/arch/arm/plat-s3c64xx/include/plat/spi.h
>> + *
>> + * Copyright (C) 2009 Samsung Electronics Ltd.
>> + * =C2=A0 Jaswinder Singh <jassi.brar@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __S3C64XX_PLAT_SPI_H
>> +#define __S3C64XX_PLAT_SPI_H __FILE__
>> +
>> +#define S3C64XX_SPI_SRCCLK_PCLK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00
>> +#define S3C64XX_SPI_SRCCLK_SPIBUS =C2=A0 =C2=A01
>> +#define S3C64XX_SPI_SRCCLK_48M =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 2
>> +
>> +#define BUSNUM(b) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(b)
>> +
>> +/**
>> + * struct s3c64xx_spi_csinfo - ChipSelect description
>> + * @fb_delay: Slave specific feedback delay.
>> + * @set_level: CS line control.
>> + */
>> +struct s3c64xx_spi_csinfo {
>> + =C2=A0 =C2=A0 u8 fb_delay;
>> + =C2=A0 =C2=A0 void (*set_level)(int lvl);
>> +};
>
> I think set_level should be called 'set_cs' to make it clearer what i=
s
> being done here.
Well, in the driver we instantiate the structure pointer as 'cs', so al=
l
the calls look like "cs->set_level" so I think that should be ok,
as it's quite obvious its all about cs(ChipSelect).

>> +/**
>> + * struct s3c64xx_spi_cntrlr_info - SPI Controller defining structu=
re
>> + * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] fiel=
d.
>> + * @src_clk_name: Platform name of the corresponding clock.
>> + * @src_clk: Pointer to the source clock.
>> + * @num_cs: Number of CS this controller emulates.
>> + * @cs: Array describing each CS.
>> + * @cfg_gpio: Configure pins for this SPI controller.
>> + * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
>> + * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
>> + * @high_speed: If the controller supports HIGH_SPEED_EN bit
>> + */
>> +struct s3c64xx_spi_cntrlr_info {
>
> how about not bothering with the _cntrlr_ here and just call it
> s3c64xx_spi_info instead?
Sure.

>> + =C2=A0 =C2=A0 int src_clk_nr;
>> + =C2=A0 =C2=A0 char *src_clk_name;
>> + =C2=A0 =C2=A0 struct clk *src_clk;
>
> do not pass 'struct clk *' in via platform data.
Since this is not initialized in platform code: just a pointer
made available to the driver. So, yes, this can be made a
member of s3c64xx_spi_driver_data rather.

>> + =C2=A0 =C2=A0 int num_cs;
>> + =C2=A0 =C2=A0 struct s3c64xx_spi_csinfo *cs;
>> +
>> + =C2=A0 =C2=A0 int (*cfg_gpio)(struct platform_device *pdev);
>> +
>> + =C2=A0 =C2=A0 /* Following two fields are for future compatibility=
 */
>> + =C2=A0 =C2=A0 int fifo_lvl_mask;
>> + =C2=A0 =C2=A0 int rx_lvl_offset;
>> + =C2=A0 =C2=A0 int high_speed;
>> +};
>
> I was wondering if a single 'set_cs' callback here would be in order,
> given each spi device can already hold a chip-select number for use
> with such callbacks, so:
>
> void (*set_cs)(struct s3c64xx_spi_cntrlr_info *us, struct spi_device =
*sel, int to);
In that case the machine code wud have to map the chipselect number to
appropriate function/switch-case. Switch-case maybe ok, but calling som=
e
function to toggle CS might result in bigger lags between CS and appear=
ance
of clock on the bus.

>> +/**
>> + * s3c64xx_spi_set_info - SPI Controller configure callback by the =
board
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 initialization code.
>> + * @cntrlr: SPI controller number the configuration is for.
>> + * @src_clk_nr: Clock the SPI controller is to use to generate SPI =
clocks.
>> + * @cs: Pointer to the array of CS descriptions.
>> + * @num_cs: Number of elements in the 'cs' array.
>> + */
>> +extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int nu=
m_cs);
>> +
>> +#endif /* __S3C64XX_PLAT_SPI_H */
>> --
>> 1.6.2.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> --
> Ben
>
> Q: =C2=A0 =C2=A0 =C2=A0What's a light-year?
> A: =C2=A0 =C2=A0 =C2=A0One-third less calories than a regular year.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
