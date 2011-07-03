From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Sun, 3 Jul 2011 12:31:24 +0200
Message-ID: <20110703103124.GA1333@pengutronix.de>
References: <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de>
 <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
 <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
 <20110701144409.GA3825@pengutronix.de>
 <20110701154628.GD8631@S2100-06.ap.freescale.net>
 <20110702131225.GA5478@pengutronix.de>
 <20110703092850.GA9938@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51165 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab1GCKbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2011 06:31:31 -0400
Content-Disposition: inline
In-Reply-To: <20110703092850.GA9938@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Koen Beel <koen.beel.barco@gmail.com>, linux-mmc@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 03, 2011 at 05:28:52PM +0800, Shawn Guo wrote:
> On Sat, Jul 02, 2011 at 03:12:25PM +0200, Wolfram Sang wrote:
> > On Fri, Jul 01, 2011 at 11:46:29PM +0800, Shawn Guo wrote:
> > > On Fri, Jul 01, 2011 at 04:44:09PM +0200, Wolfram Sang wrote:
> > > > Hi,
> > > >=20
> > > > On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
> > > > > I send the patch as attachment for now.
> > > >=20
> > > > Fine with me in this case...
> > > >=20
> > > > > But I'll have to look into another way of doing this. Corporate m=
ail
> > > > > system is adding stupid disclaimers, gmail web ui is not working =
ok
> > > > > and corporate firewalls avoid using a different smtp server...
> > > >=20
> > > > Good luck with that!
> > > >=20
> > > > About the patch itself: I didn't verify the formulas, but it does s=
olve one
> > > > special problem here. Thanks a lot! So:
> > > >=20
> > > > Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> > > >=20
> > > > @chris: If Shawn also likes the patch, I think this is a stable can=
didate.
> > > >=20
> > > Thanks for the fixing, Koen.
> > >=20
> > > Acked-by: Shawn Guo <shawn.guo@freescale.com>
> >=20
> > Well, maybe not. My colleague complained and I think he is right that w=
e are
> > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit range. Th=
is must
> > be wrong for one value per se.
> >=20
> If you look at the context of the patch, you will find it's 'div2 - 1'
> than 'div2' gets written into register.

Exactly. The '- 1' is why Koen changed the upper limit from < 256 to <=3D 2=
56.
The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D 1', which =
is a 2:1
mapping. Not good, or?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4QRPwACgkQD27XaX1/VRuzrQCdHsTF/x42HZOUDMD8/4iG5lS6
F4UAoJpAn5O6Me6zn8u2WM1rg6QHPdAr
=2GKQ
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
