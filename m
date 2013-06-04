From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
Date: Tue, 4 Jun 2013 14:05:12 +0200
Message-ID: <201306041405.13320.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <201306030059.47611.heiko@sntech.de> <CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:58999 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab3FDMF3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jun 2013 08:05:29 -0400
In-Reply-To: <CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi,

I'll just skip over the "right, will fix that" issues and just address =
the=20
unclear ones.

Am Dienstag, 4. Juni 2013, 09:08:09 schrieb Linus Walleij:
> On Mon, Jun 3, 2013 at 12:59 AM, Heiko St=FCbner <heiko@sntech.de> wr=
ote:
> > This driver adds support the Cortex-A9 based SoCs from Rockchip,
> > so at least the RK2928, RK3066 (a and b) and RK3188.
> > Earlier Rockchip SoCs seem to use similar mechanics for gpio
> > handling so should be supportable with relative small changes.
> > Pull handling on the rk3188 is currently a stub, due to it being
> > a bit different to the earlier SoCs.
> >=20
> > Pinmuxing as well as gpio (and interrupt-) handling tested on
> > a rk3066a based machine.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Overall this is looking very good, mainly minor comments.

> > +Required properties for pin configuration node:
> > +  - rockchip,pins: 4 integers array, represents a group of pins mu=
x and
> > config +    setting. The format is rockchip,pins =3D <PIN_BANK
> > PIN_BANK_NUM MUX CONFIG>. +    The MUX 0 means gpio and MUX 1 to 3 =
mean
> > the specific device function +
> > +Bits used for CONFIG:
> > +PULL_AUTO      (1 << 0): indicate this pin needs a pull setting fo=
r SoCs
> > +                         that determine the pull up or down themse=
lfs
>=20
> Hm, never saw that before...

Citing the original gpio driver:

	/*
	 * Values written to this register independently
	 * control Pullup/Pulldown or not for the
	 * corresponding data bit in GPIO.
	 * 0: pull up/down enable, PAD type will decide
	 * to be up or down, not related with this value
	 * 1: pull up/down disable
	 */

So if it's a pull up or down is decided based on the mux of the pin. Ca=
lling=20
everything a "pull down" (or up) when it isn't seemed somehow wrong to =
me.

The rk3188 on the other hand supports both pull up and down separately.

Or should this be selected as PULL_UP | PULL_DOWN in the config?


> > +uart2: serial@20064000 {
> > +       compatible =3D "snps,dw-apb-uart";
> > +       reg =3D <0x20064000 0x400>;
> > +       interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>=20
> Using #defines, nice!

everything for bonus-points ;-)

And actually it's definitly easier on me as well, as I don't have to re=
member=20
what each integer value means.

> +++ b/drivers/pinctrl/Kconfig
> @@ -158,6 +158,12 @@ config PINCTRL_DB8540
>         bool "DB8540 pin controller driver"
>         depends on PINCTRL_NOMADIK && ARCH_U8500
>=20
> +config PINCTRL_ROCKCHIP
> +       bool
> +       select PINMUX
> +       select PINCONF
> +       select GENERIC_IRQ_CHIP
>=20
> Why is this super-simple pin config thing not using
> GENERIC_PINCONF?
>=20
> I *know* it is simpler to implement your own thing, but think of the
> poor maintainers that have to wade through 50 identical implementatio=
ns.
> Do this, it pays off.

generic pinconf sounds interesting ... will give it a try.

The only problem is the pull stuff mentioned above that is either pull =
up or=20
down without the driver having knowledge about it. And generic_pinconf =
only=20
knows about them separately right now.


> BTW: it leads to wanting to use generic pinconf DT bindings as experi=
enced
> by Laurent and others. We need to fix that too...
>=20
> (...)
>=20
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > +static void rockchip_pin_dbg_show(struct pinctrl_dev *pctldev,
> > +                                       struct seq_file *s, unsigne=
d
> > offset) +{
> > +       seq_printf(s, "%s", dev_name(pctldev->dev));
> > +}
>=20
> Nothing else you want to say about the pins here?
> (No big deal for sure, but....)

when using pinconfig_generic, its dump_pin function should be more talk=
ative=20
right?


> > +
> > +               data =3D readl_relaxed(reg);
> > +               data >>=3D bit;
> > +               data &=3D 1;
> > +
> > +               return !data;
>=20
> That's a bit hard to read, I'd just:
>=20
> #include <linux/bitops.h>
> return !(readl_relaxed(reg) & BIT(bit));
>=20
> And skip the "data" variable. The ! operator will
> clamp this to a bool (0/1).
>=20
> But we all have our habits.

yeah, but sometimes it's also good to try to break them ... your soluti=
on is=20
much nicer to read (and shorter).


> All I could think of right now...

Thanks for the review
Heiko
