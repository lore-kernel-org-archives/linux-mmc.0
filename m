From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/4 v2] mmc: mn57xx: only access registers above 0xff,
 if available
Date: Mon, 14 Mar 2011 08:37:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103140826480.6125@axis700.grange>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
 <Pine.LNX.4.64.1103110900080.23675@axis700.grange>
 <AANLkTi=CwkzwvDy+CTzJBni-OtZUMEtmceNr+-xpuVOK@mail.gmail.com>
 <Pine.LNX.4.64.1103122349080.28741@axis700.grange>
 <AANLkTi=cGjomEu4uPbOFcwQfMYu6q4kjMwmdetRXeefC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=cGjomEu4uPbOFcwQfMYu6q4kjMwmdetRXeefC@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Sun, 13 Mar 2011, Magnus Damm wrote:

> On Sun, Mar 13, 2011 at 7:57 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Sun, 13 Mar 2011, Magnus Damm wrote:
> >
> >> On Fri, Mar 11, 2011 at 5:09 PM, Guennadi Liakhovetski
> >> <g.liakhovetski@gmx.de> wrote:
> >> > Not all mn57xx / tmio implementations have registers above oxff.
> >> > Accessing them on thise platforms is dangerous. In some cases it=
 leads
> >> > to address wrapping to addresses below 0x100, which corrupts ran=
dom
> >> > unrelated registers.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> > ---
> >> >
> >> > v2:
> >>
> >> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> >> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> >>
> >> Nice, it looks like this patch should apply on your earlier broken=
 out
> >> patch set...
> >>
> >> > + =A0 =A0 =A0 if (resource_size(res) > 0x100) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_CLK_AND_=
WAIT_CTL, 0x0000);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> >> > + =A0 =A0 =A0 }
> >>
> >> ... but now since you've separated the tmio specific code from the
> >> SDHI implementation, why don't you just make all the offsets above
> >> 0x100 stay in the tmio code, and let the SDHI only access below 0x=
ff?
> >
> > The current split is:
> >
> > tmio_mmc_pio.c: _all_ driver functionality in PIO mode, including M=
MC API
> > tmio_mmc_dma.c: DMA
> >
> > tmio_mmc.c: _only_ MFD glue - no IO at all
> >
> > sh_mobile_sdhi.c: _only_ platform glue for SDHI - no IO at all
> >
> > This split seems logical to me - every file performs one function. =
But I
> > do agree, that special-casing addresses > 0xff in the generic core =
is not
> > very nice... We could otherwise modify the actual read / write acce=
ssors
> > to check, whether _each_ register address is within the resource, b=
ut that
> > would be too much of a performance hit. But pulling those couple of=
 > 0xff
> > accesses out of the driver proper and into the MFD glue didn't look=
 like a
> > very logical thing to me. I thought this version provided both - no
> > performance hit and preserved clean function separation - at the co=
st of
> > "slight ugliness." Opinions?
>=20
> I don't really see why you want to have "no IO at all" in the
> tmio/sdhi specific files.
>=20
> Actually, I think it makes sense to abstract based on the hardware
> register layout difference.
>=20
>  Since some parts of the code only applies to tmio (offset >=3D 0x100=
)
> and some only to SDHI (TMIO_MMC_SDIO_IRQ), why don't you do the
> following:
>=20
> In tmio_mmc_pio.c:
>=20
> tmio_mmc_core_clk_start()
> tmio_mmc_core_clk_stop()
> tmio_mmc_core_reset()

=2E..and then you'd have to add pointers to these functions to the tmio=
=20
struct to be able to call them from the core (*_pio) and check it for N=
ULL=20
and-and-and... And this instead of just one test for resource size >=20
0x100. Do you really think it's worth it? Basically, when your code has=
 to=20
act differently in different situations you can either check some=20
parameters, set by the environment, or, in more complicated cases, call=
=20
some environment callback. I think this case is still simple enough - y=
ou=20
even don't have to add any new parameters - they are already there - th=
e=20
resource size. You just have to check it.

We might well need some callbacks in the future, when we implement=20
multiple interrupts or some even more significant differences, but this=
=20
looks like a really simple thing to me, and your approach makes it a bi=
t=20
overly complicated, don't you think?

Thanks
Guennadi

>=20
> Above functions only implement offset < 0x100 and no TMIO_MMC_ stuff
> in there if possible
>=20
> In tmio_mmc.c
>=20
> tmio_mmc_clk_start()
> tmio_mmc_clk_stop()
> tmio_mmc_reset()
>=20
> Above 3 functions call tmio_mmc_core_xxx() and also implement >=3D 0x=
100
> offset access.
>=20
> In sh_mobile_sdhi.c
>=20
> sh_mobile_sdhi_clk_start()
> sh_mobile_sdhi_clk_stop()
> sh_mobile_sdhi_reset()
>=20
> Above 3 functions call tmio_mmc_core_xxx() and perhaps also implement=
 SDIO IRQ.
>=20
> Ideally we want to share the SDIO IRQ code with the TMIO MFD
> implementation, but we're not really receiving any test feedback from
> anyone, so from my POV to avoid breakage we may as well keep things i=
n
> the SDHI portion and move over to the common place if needed in the
> future.
>=20
> / magnus
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
