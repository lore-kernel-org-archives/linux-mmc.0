From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers to even numbers
Date: Tue, 11 Jun 2013 21:23:50 +0200
Message-ID: <201306112123.51843.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de> <201306111329.32749.heiko@sntech.de> <20130611185750.8816.82691@quantum>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:45768 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab3FKTYF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jun 2013 15:24:05 -0400
In-Reply-To: <20130611185750.8816.82691@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

Am Dienstag, 11. Juni 2013, 20:57:50 schrieb Mike Turquette:
> Quoting Heiko St=C3=BCbner (2013-06-11 04:29:32)
>=20
> > SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
> > that use the regular mechanisms for storage but allow only even
> > dividers and 1 to be used.
> >=20
> > Therefore add a flag that lets _is_valid_div limit the valid divide=
rs
> > to these values. _get_maxdiv is also adapted to return even values
> > for the CLK_DIVIDER_ONE_BASED case.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >=20
> >  drivers/clk/clk-divider.c    |   14 ++++++++++++--
> >  include/linux/clk-provider.h |    2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index ce5cfe9..bdee7cf 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -45,8 +45,16 @@ static unsigned int _get_table_maxdiv(const stru=
ct
> > clk_div_table *table)
> >=20
> >  static unsigned int _get_maxdiv(struct clk_divider *divider)
> >  {
> >=20
> > -       if (divider->flags & CLK_DIVIDER_ONE_BASED)
> > -               return div_mask(divider);
> > +       if (divider->flags & CLK_DIVIDER_ONE_BASED) {
> > +               unsigned int div =3D div_mask(divider);
> > +
> > +               /* decrease to even number */
> > +               if (divider->flags & CLK_DIVIDER_EVEN)
> > +                       div--;
> > +
> > +               return div;
> > +       }
> > +
> >=20
> >         if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> >        =20
> >                 return 1 << div_mask(divider);
> >        =20
> >         if (divider->table)
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
> > 0)
>=20
> Is it correct to check for 'div !=3D 1' here?  Wouldn't that check on=
ly be
> valid in the presence of CLK_DIVIDER_ONE_BASED?
>=20
> Maybe something like this would be more correct:
>=20
> 	if (divider->flags & CLK_DIVIDER_EVEN && (div % 2) !=3D 0) {
> 		if (divider->flags & CLK_DIVIDER_ONE_BASED && div =3D=3D 1)
> 			return true;
> 		return false;
> 	}

hmm, not necessarily. As I understand the doc DIVIDER_ONE_BASED describ=
es how=20
the divider is stored in the register, i.e. if the register value is di=
v-1 or=20
div.

When div is 1, it of course means don't divide [rate/1], and CLK_DIVIDE=
R_EVEN=20
needs to just make sure that bigger dividers that really divide the rat=
e are=20
even values (so limiting the possible dividers to 1 2 4 ...), independe=
nt on=20
how the divider value is stored in the register.


