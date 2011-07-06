From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Wed, 6 Jul 2011 11:38:48 +0200
Message-ID: <20110706093848.GC2117@pengutronix.de>
References: <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
 <20110701144409.GA3825@pengutronix.de>
 <20110701154628.GD8631@S2100-06.ap.freescale.net>
 <20110702131225.GA5478@pengutronix.de>
 <20110703092850.GA9938@S2100-06.ap.freescale.net>
 <20110703103124.GA1333@pengutronix.de>
 <20110703115418.GB9938@S2100-06.ap.freescale.net>
 <20110704103402.GA3990@pengutronix.de>
 <CAHMSPgMxCqFzigAzMc7nbTB_0NyLcK3FrVDW8arKa0ip15TH3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35923 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1GFJiv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 05:38:51 -0400
Content-Disposition: inline
In-Reply-To: <CAHMSPgMxCqFzigAzMc7nbTB_0NyLcK3FrVDW8arKa0ip15TH3Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2011 at 12:59:29PM +0200, Koen Beel wrote:
> On Mon, Jul 4, 2011 at 12:34 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >
> >> > > > Well, maybe not. My colleague complained and I think he is right=
 that we are
> >> > > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit ra=
nge. This must
> >> > > > be wrong for one value per se.
> >> > > >
> >> > > If you look at the context of the patch, you will find it's 'div2 =
- 1'
> >> > > than 'div2' gets written into register.
> >> >
> >> > Exactly. The '- 1' is why Koen changed the upper limit from < 256 to=
 <=3D 256.
> >> > The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D 1',=
 which is a 2:1
> >> > mapping. Not good, or?
> >> >
> >> So you are saying the patch is a right fix but not the most optimal
> >> one? =A0In that case, it does not concern me. =A0I acked it as an valid
> >> fix.
> >
> > The patches fixes a few things, but for div2, it is curing the symptoms,
> > not the cause, I think. If you look at the formula in the datasheet:
> >
> > rate =3D ssp / (clock_divide * (1 + clock_rate));
> >
> > In the code, the calculation of div2 is equal to '1 + clock_rate' (the 1
> > gets subtracted when the value is written to the register which is a bit
> > unfortunate; doing it earlier would reduce confusion IMO). So that can
> > never be 0, it is a divisor. We should really use DIV_ROUND_UP here.
> > Even when not dealing with 0, this seems needed. Assume:
> >
> > ssp =3D 57600000, wanted_rate =3D 25000000, div1 =3D 2
> >
> > will give
> >
> > div2 =3D int(1.152) =3D 1 (meaning 0 + 1, because div2 - 1 will be writ=
ten)
> >
> > The rate will thus be:
> >
> > actual_rate =3D 57600000 / 2 * (0 + 1)
> > =A0 =A0 =A0 =A0 =A0 =A0=3D 28800000
> >
> > -> too fast!
> >
> > Or did I get something wrong?
> >
> > Regards,
> >
> > =A0 Wolfram
>=20
> Well, right now the clock freq. is set to the minimum clock value
> reaching the requested rate.=20

Sorry, it gets a bit confusing: what do you mean with "right now"?

> In current implementation, the rate will
> be higher in lot's of cases (all cases where the requested clock freq.
> cannot exactly be made).

Yes.

> But the thing is, the driver now enters dev_err, and returns without
> changing anything when the clock cannot be made as low as requested.
> In that case you will almost certainly end up with a clock being even
> higher then the lowest possible. So that not good I think.
> I might be better to set the clock as low as possible not matter what
> you to after that.

Yes, might be a bit academic (who would want 4kHz ;)), but still
correct. Shawn, do you agree?

> About the rounding. I don't think rounding is good. I think it would

We do rounding already (int conversion). Just in the wrong direction.

> be better to choose between having at least the requested rate (as it
> is now; will result is somewhat higher clock then requested in many
> cases)

You want a rate faster than what the card could do?

>, or having at maximum the requested clock rate. Both have there
> problems.

If I understood you correctly, this is my DIV_ROUND_UP suggestion. Which
problems does it have?

Regards,

   Wolfram

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4ULSgACgkQD27XaX1/VRsorQCfVRVm9Vpv4YSsfiMqIFctTKG9
7qkAnicSrjSzwObzBjyISDnXz6+Sze2s
=5LIq
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
