From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers to even numbers
Date: Tue, 11 Jun 2013 14:06:14 +0200
Message-ID: <201306111406.14850.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de> <201306111329.32749.heiko@sntech.de> <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38930 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125Ab3FKMGZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jun 2013 08:06:25 -0400
In-Reply-To: <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Am Dienstag, 11. Juni 2013, 13:51:56 schrieb Andy Shevchenko:
> On Tue, Jun 11, 2013 at 2:29 PM, Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
> > SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
> > that use the regular mechanisms for storage but allow only even
> > dividers and 1 to be used.
> >=20
> > Therefore add a flag that lets _is_valid_div limit the valid divide=
rs
> > to these values. _get_maxdiv is also adapted to return even values
> > for the CLK_DIVIDER_ONE_BASED case.
>=20
> Just one nitpick below (I'm okay with current implementation, but you
> might find my proposal useful).
>=20
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> >=20
> > @@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider
> > *divider, unsigned int div)
> >=20
> >                 return is_power_of_2(div);
> >        =20
> >         if (divider->table)
> >        =20
> >                 return _is_valid_table_div(divider->table, div);
> >=20
> > +       if (divider->flags & CLK_DIVIDER_EVEN && div !=3D 1 && (div=
 % 2) !=3D
> > 0) +               return false;
> >=20
> >         return true;
> > =20
> >  }
>=20
> What if rewrite like
>=20
>  if (divider->flags & CLK_DIVIDER_EVEN =3D=3D 0)
>  return true;
>=20
> return div < 2 || div % 2 =3D=3D 0;

hmm, the current structure is of the form of testing for each feature a=
nd=20
doing a applicable action if the flag is set. So it also is extensible =
for=20
future flags and checking for the absence of an attribute while the res=
t of=20
the conditionals check for the presence also might make the code harder=
 to=20
read.

So for me the current variant somehow looks more intuitive.

But I'll just let the majority decide ;-)


Heiko
