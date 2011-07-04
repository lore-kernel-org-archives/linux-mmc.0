From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Mon, 4 Jul 2011 12:34:02 +0200
Message-ID: <20110704103402.GA3990@pengutronix.de>
References: <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
 <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
 <20110701144409.GA3825@pengutronix.de>
 <20110701154628.GD8631@S2100-06.ap.freescale.net>
 <20110702131225.GA5478@pengutronix.de>
 <20110703092850.GA9938@S2100-06.ap.freescale.net>
 <20110703103124.GA1333@pengutronix.de>
 <20110703115418.GB9938@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54665 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab1GDKeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 06:34:07 -0400
Content-Disposition: inline
In-Reply-To: <20110703115418.GB9938@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Koen Beel <koen.beel.barco@gmail.com>, linux-mmc@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > Well, maybe not. My colleague complained and I think he is right th=
at we are
> > > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit range=
=2E This must
> > > > be wrong for one value per se.
> > > >=20
> > > If you look at the context of the patch, you will find it's 'div2 - 1'
> > > than 'div2' gets written into register.
> >=20
> > Exactly. The '- 1' is why Koen changed the upper limit from < 256 to <=
=3D 256.
> > The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D 1', wh=
ich is a 2:1
> > mapping. Not good, or?
> >=20
> So you are saying the patch is a right fix but not the most optimal
> one?  In that case, it does not concern me.  I acked it as an valid
> fix.=20

The patches fixes a few things, but for div2, it is curing the symptoms,
not the cause, I think. If you look at the formula in the datasheet:

rate =3D ssp / (clock_divide * (1 + clock_rate));

In the code, the calculation of div2 is equal to '1 + clock_rate' (the 1
gets subtracted when the value is written to the register which is a bit
unfortunate; doing it earlier would reduce confusion IMO). So that can
never be 0, it is a divisor. We should really use DIV_ROUND_UP here.
Even when not dealing with 0, this seems needed. Assume:

ssp =3D 57600000, wanted_rate =3D 25000000, div1 =3D 2

will give

div2 =3D int(1.152) =3D 1 (meaning 0 + 1, because div2 - 1 will be written)

The rate will thus be:

actual_rate =3D 57600000 / 2 * (0 + 1)
            =3D 28800000

-> too fast!

Or did I get something wrong?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4RlxoACgkQD27XaX1/VRuf7ACgqQ4PvBf9d0am2ButvDT0ZHy1
CQwAn1iHNXcl6t46IW7L/l3UkW7J2nxb
=kbX8
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
