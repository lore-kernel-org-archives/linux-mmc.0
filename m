From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3 v2] sh, mmc: Use defines when setting CE_CLK_CTRL
Date: Sun, 28 Nov 2010 06:17:36 +0900
Message-ID: <20101127211736.GC2090@verge.net.au>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au>
 <1290812579-20410-3-git-send-email-horms@verge.net.au>
 <20101127000109.GA29427@verge.net.au>
 <20101127001155.GA30946@verge.net.au>
 <AANLkTi=zKbNhVz=Bh7ytRezobsnxeWE49mJcAS=rJ4Oq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=zKbNhVz=Bh7ytRezobsnxeWE49mJcAS=rJ4Oq@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Nov 27, 2010 at 12:54:41PM +0100, Micha=C5=82 Miros=C5=82aw wro=
te:
> 2010/11/27 Simon Horman <horms@verge.net.au>:
> > The 16-19th bits of CE_CLK_CTRL set the
> > MMC clock frequency.
> >
> > Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> > =C2=A0include/linux/mmc/sh_mmcif.h | =C2=A0 17 +++++++++--------
> > =C2=A01 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mm=
cif.h
> > index 519a2cd..44fc534 100644
> > --- a/include/linux/mmc/sh_mmcif.h
> > +++ b/include/linux/mmc/sh_mmcif.h
> > @@ -77,6 +77,9 @@ struct sh_mmcif_plat_data {
> > =C2=A0#define CLK_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(1 << 24) /* 1: output mmc clock */
> > =C2=A0#define CLK_CLEAR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
> > =C2=A0#define CLK_SUP_PCLK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((1 <=
< 19) | (1 << 18) | (1 << 17) | (1 << 16))
> > +#define CLKDIV_4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(1<<16) /* mmc clock frequency.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* n: bus clock/(2^(n+1)) */
> > +#define CLKDIV_256 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (7<<1=
6) /* mmc clock frequency. (see above) */
> > =C2=A0#define SRSPTO_256 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
((1 << 13) | (0 << 12)) /* resp timeout */
> > =C2=A0#define SRBSYTO_29 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
((1 << 11) | (1 << 10) | =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 9) | (1 << 8)) /* resp=
 busy timeout */
> [...]
>=20
> Maybe zero is a valid value here meaning CLKDIV =3D 2.

Hi Micha=C5=82,

Yes, it is. I intended to provide defines only for values that are used=
=2E
But I can provide all the valid values (there are only 9) it that
makes thing clearer. Or perhaps change the comment to:

					    /* CLKDIV_n
					     * mmc clock frequency.
					     * n: bus clock/(2^(m+1))
					     *    where 0 <=3D m <=3D 8 */

