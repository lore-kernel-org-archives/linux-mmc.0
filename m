From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
 enum
Date: Fri, 19 Aug 2011 15:39:04 +0900
Message-ID: <20110819063857.GC16419@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-5-git-send-email-horms@verge.net.au>
 <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
 <20110819052004.GB17548@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40868 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1HSGjK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 02:39:10 -0400
Content-Disposition: inline
In-Reply-To: <20110819052004.GB17548@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 02:20:11PM +0900, Simon Horman wrote:
> On Fri, Aug 19, 2011 at 01:16:09PM +0900, Magnus Damm wrote:
> > On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au>=
 wrote:
> > > This is intended to make it easier to correctly order IRQs.
> > >
> > > As suggested by Guennadi Liakhovetski.
> >=20
> > > --- a/arch/arm/mach-shmobile/board-ag5evm.c
> > > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> > > @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] =3D=
 {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.end =C2=A0=
 =C2=A0=3D 0xee1000ff,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=
=A0=3D IORESOURCE_MEM,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > > - =C2=A0 =C2=A0 =C2=A0 [1] =3D {
> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] =3D {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =C2=
=A0=3D gic_spi(83),
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=
=A0=3D IORESOURCE_IRQ,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > > - =C2=A0 =C2=A0 =C2=A0 [2] =3D {
> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =C2=
=A0=3D gic_spi(84),
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=
=A0=3D IORESOURCE_IRQ,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > > - =C2=A0 =C2=A0 =C2=A0 [3] =3D {
> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_SDIO] =3D {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =C2=
=A0=3D gic_spi(85),
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=
=A0=3D IORESOURCE_IRQ,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >=20
> > Hm...
> >=20
> > So I know you guys have been discussing this back and forth, so I'm
> > not sure if jumping in to this thread makes things any better. But
> > anyhow, here are my opinions. Feel free to ignore them. =3D)
> >=20
> > First of all, having some kind of association with each IRQ is a go=
od
> > thing. I am however not convinced that using the index number of th=
e
> > platform device resource irq is the best option. Consider the case
> > when someone modifies the SDHI resource in the code above to only
> > include this interrupt:
> >=20
> >         [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
> >                 .start  =3D gic_spi(84),
> >                 .flags  =3D IORESOURCE_IRQ,
> >         },
> >=20
> > >From my point of view, the common sense for this would be that onl=
y
> > the SDCARD interrupt would be enabled and the rest would be disable=
d
> > since they are unspecified. However, with the current code the
> > behavior would be something else, and since the index number of SDC=
ARD
> > is not matching it will be detected as CARD_DETECT.
> >=20
> > So isn't it really ugly to depend on the number of IRQs when they a=
re
> > supposed to be used as an index? I've been toying around with this
> > driver for a few years now, and when I have a hard time creating
> > correct platform data then it's _probably_ a sign that there must b=
e
> > better ways to implement this.
> >=20
> > I would propose just adding interrupts in struct resource [] as usu=
al,
> > and then have thee separate flags in the platform data for each
> > interrupt type. If the number of IRQ bits set in the platform data
> > flags doesn't match the number of interrupt resources then return
> > error. If they match then simply go through each flag set in the
> > platform data flags and assign next available interrupt resource. A=
nd
> > if no flags are set then go for the combined interrupt handler for =
all
> > available interrupt resources.
> >=20
> > That's what I would do at least. Any other ideas? Perhaps just keep=
 an
> > array of interrupt numbers in the platform data as the sh-sci drive=
r
> > does and use the fixed indexes there if non-zero?
>=20
> Hi Magnus,
>=20
> unfortunately during the course of the review of this series a number
> of changes have crept in which I regard as being tangential to the
> goal of the series - which is to introduce broken-out handlers (I hav=
e
> already introduce support for broken-out IRQ sources).
>=20
> One area where such changes have occurred is in the subtle altering o=
f the
> list of IRQ sources that it is valid to supply (again, support for
> broken-out IRQ sources is not introduced by this series).
>=20
> With regards to your comment and example above. I believe that your
> understanding of my code is incorrect. The configuration you suggest =
will
> be rejected because CARD_DETECT is not supplied, not because of an in=
dex
> miss-match. It could be made acceptable within the current framework =
by
> simply loosening up the logic a little (specifically to allow CARD_DE=
TECT
> to be omitted even if only one other IRQ source is supplied).  Incide=
ntly,
> I think that would make sense but Guennadi specifically asked for tha=
t
> combination to be regarded as invalid.

[snip]

After some discussion off-line I now realise that there is a problem
with my implementation. Specifically that it assumes that
platform_get_irq() takes into account the index of resource entries -
it does not.

As we are already on the slippery slope of allowing combinations
other than 1 (legacy) or 3 (specific) IRQ sources I plan to implement
a variant of your flag idea. The variation being to use names instead
because a) that allows the use of platform_get_irq_byname() and b)
the flags bits seem to be full and not driver-specific.

And as are already on the slippery slope of allowing combinations
if IRQ sources beyond 1 and 3 I intend to implement logic to allow
any number of unique specific IRQ sources to be handled. In practice
hardware for some of these combinations is unlikely to exist. But that
doesn't seem to be a particularly good reason to add extra logic
to disallow them in the driver - its up to platform data to specify
something valid.

