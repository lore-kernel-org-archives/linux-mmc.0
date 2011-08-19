From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
 enum
Date: Fri, 19 Aug 2011 16:17:29 +0900
Message-ID: <20110819071720.GD16419@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-5-git-send-email-horms@verge.net.au>
 <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
 <20110819052004.GB17548@verge.net.au>
 <20110819063857.GC16419@verge.net.au>
 <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38052 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1HSHRg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 03:17:36 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 03:51:49PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 3:39 PM, Simon Horman <horms@verge.net.au> wr=
ote:
> > On Fri, Aug 19, 2011 at 02:20:11PM +0900, Simon Horman wrote:
> >> On Fri, Aug 19, 2011 at 01:16:09PM +0900, Magnus Damm wrote:
> >> > On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.=
au> wrote:
> >> > > This is intended to make it easier to correctly order IRQs.
> >> > >
> >> > > As suggested by Guennadi Liakhovetski.
> >> >
> >> > > --- a/arch/arm/mach-shmobile/board-ag5evm.c
> >> > > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> >> > > @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[]=
 =3D {
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.end =C2=
=A0 =C2=A0=3D 0xee1000ff,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=C2=A0=3D IORESOURCE_MEM,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >> > > - =C2=A0 =C2=A0 =C2=A0 [1] =3D {
> >> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] =3D=
 {
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =
=C2=A0=3D gic_spi(83),
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=C2=A0=3D IORESOURCE_IRQ,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >> > > - =C2=A0 =C2=A0 =C2=A0 [2] =3D {
> >> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =
=C2=A0=3D gic_spi(84),
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=C2=A0=3D IORESOURCE_IRQ,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >> > > - =C2=A0 =C2=A0 =C2=A0 [3] =3D {
> >> > > + =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_SDIO] =3D {
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =
=C2=A0=3D gic_spi(85),
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=C2=A0=3D IORESOURCE_IRQ,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >> >
> >> > Hm...
> >> >
> >> > So I know you guys have been discussing this back and forth, so =
I'm
> >> > not sure if jumping in to this thread makes things any better. B=
ut
> >> > anyhow, here are my opinions. Feel free to ignore them. =3D)
> >> >
> >> > First of all, having some kind of association with each IRQ is a=
 good
> >> > thing. I am however not convinced that using the index number of=
 the
> >> > platform device resource irq is the best option. Consider the ca=
se
> >> > when someone modifies the SDHI resource in the code above to onl=
y
> >> > include this interrupt:
> >> >
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D =
{
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=
=A0=3D gic_spi(84),
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=
=A0=3D IORESOURCE_IRQ,
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> >> >
> >> > >From my point of view, the common sense for this would be that =
only
> >> > the SDCARD interrupt would be enabled and the rest would be disa=
bled
> >> > since they are unspecified. However, with the current code the
> >> > behavior would be something else, and since the index number of =
SDCARD
> >> > is not matching it will be detected as CARD_DETECT.
> >> >
> >> > So isn't it really ugly to depend on the number of IRQs when the=
y are
> >> > supposed to be used as an index? I've been toying around with th=
is
> >> > driver for a few years now, and when I have a hard time creating
> >> > correct platform data then it's _probably_ a sign that there mus=
t be
> >> > better ways to implement this.
> >> >
> >> > I would propose just adding interrupts in struct resource [] as =
usual,
> >> > and then have thee separate flags in the platform data for each
> >> > interrupt type. If the number of IRQ bits set in the platform da=
ta
> >> > flags doesn't match the number of interrupt resources then retur=
n
> >> > error. If they match then simply go through each flag set in the
> >> > platform data flags and assign next available interrupt resource=
=2E And
> >> > if no flags are set then go for the combined interrupt handler f=
or all
> >> > available interrupt resources.
> >> >
> >> > That's what I would do at least. Any other ideas? Perhaps just k=
eep an
> >> > array of interrupt numbers in the platform data as the sh-sci dr=
iver
> >> > does and use the fixed indexes there if non-zero?
> >>
> >> Hi Magnus,
> >>
> >> unfortunately during the course of the review of this series a num=
ber
> >> of changes have crept in which I regard as being tangential to the
> >> goal of the series - which is to introduce broken-out handlers (I =
have
> >> already introduce support for broken-out IRQ sources).
> >>
> >> One area where such changes have occurred is in the subtle alterin=
g of the
> >> list of IRQ sources that it is valid to supply (again, support for
> >> broken-out IRQ sources is not introduced by this series).
> >>
> >> With regards to your comment and example above. I believe that you=
r
> >> understanding of my code is incorrect. The configuration you sugge=
st will
> >> be rejected because CARD_DETECT is not supplied, not because of an=
 index
> >> miss-match. It could be made acceptable within the current framewo=
rk by
> >> simply loosening up the logic a little (specifically to allow CARD=
_DETECT
> >> to be omitted even if only one other IRQ source is supplied). =C2=A0=
Incidently,
> >> I think that would make sense but Guennadi specifically asked for =
that
> >> combination to be regarded as invalid.
> >
> > [snip]
> >
> > After some discussion off-line I now realise that there is a proble=
m
> > with my implementation. Specifically that it assumes that
> > platform_get_irq() takes into account the index of resource entries=
 -
> > it does not.
>=20
> Right, this is a thing that only bites you once. =3D)
>=20
> > As we are already on the slippery slope of allowing combinations
> > other than 1 (legacy) or 3 (specific) IRQ sources I plan to impleme=
nt
> > a variant of your flag idea. The variation being to use names inste=
ad
> > because a) that allows the use of platform_get_irq_byname() and b)
> > the flags bits seem to be full and not driver-specific.
>=20
> Great, platform_get_irq_byname() seems like a perfect match.
>=20
> May I suggest "hotplug", "data" and "sdio" as names? I don't care ver=
y
> much about names except keeping them short and precise to prevent
> errors that can only be caught during runtime.

Earlier on in the life of this series Guennadi suggested
the names "card_detect", "sdcard" and "sdio". While I am
not particularly attached to those names the do seem
reasonable and are already used consistently by this series.
So I would prefer to use those names.

> > And as are already on the slippery slope of allowing combinations
> > if IRQ sources beyond 1 and 3 I intend to implement logic to allow
> > any number of unique specific IRQ sources to be handled. In practic=
e
> > hardware for some of these combinations is unlikely to exist. But t=
hat
> > doesn't seem to be a particularly good reason to add extra logic
> > to disallow them in the driver - its up to platform data to specify
> > something valid.
>=20
> Yes, I totally agree. Thanks a lot for your help!
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
