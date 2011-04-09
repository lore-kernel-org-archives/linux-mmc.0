From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: add regulator disable/put when
 control error
Date: Sat, 9 Apr 2011 17:53:38 +0200
Message-ID: <20110409155338.GA23093@pengutronix.de>
References: <4D9ACC8C.2000202@samsung.com>
 <20110408183825.GB23883@pengutronix.de>
 <BANLkTimSWHM2m_LpLYgJ09svsgqndEFikQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47242 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab1DIPxl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Apr 2011 11:53:41 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimSWHM2m_LpLYgJ09svsgqndEFikQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Looks OK but could be merged into the previous patch.
>=20
> Thanks. :)
> yes, i can be merged into the previous patch.
> But i think good that  separeted. anyway..don't mind merged or not?

I prefer it merged, because it then fixes all forgotten cleanups in the
error-path in one go.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2ggQIACgkQD27XaX1/VRuFjQCdGOft0Cq7p5h+3fGXI0yEOOvE
LD0AoJv+sVmhTENMM+L05Wt7T1kHeWxz
=HP0z
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
