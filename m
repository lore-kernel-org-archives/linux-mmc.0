From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card
 busy.
Date: Thu, 2 Dec 2010 10:09:33 +0100
Message-ID: <20101202090932.GA3345@pengutronix.de>
References: <20101130095618.GA6408@pengutronix.de>
 <4CF4CE48.7040102@samsung.com>
 <20101130105435.GB6408@pengutronix.de>
 <4CF4E1DF.5000000@samsung.com>
 <43E4817426ED174AA81263BCECB4351D13200C545E@sc-vexch3.marvell.com>
 <4CF5E0DA.3060300@samsung.com>
 <A1CDFC9E-BD6B-43DF-BFAA-CAA5E41D7E9F@marvell.com>
 <4CF63FA9.1010304@samsung.com>
 <D5B06981-6CBA-46D1-B209-1FF10244ED27@marvell.com>
 <4CF74D5E.1080707@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55388 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab0LBJJm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 04:09:42 -0500
Content-Disposition: inline
In-Reply-To: <4CF74D5E.1080707@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > The timeout value in the host controller should not change once it is s=
et.  It s not supposed to=20
> > change value on reset (for example).
> >=20
> > Curious -- if you read the value when you are in the busy state before =
you set it -- what value is there.
>=20
> I checked the timeout value to 0xa (i didn't use broken timeout value. if=
 i used that quirk, set to 0xe)
> When suspend/resume..timeout value set to 0x0...so i set them...

What I don't see at the moment is why this issue happens after resume but
not after initial boot. Do you have an idea?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz3YkwACgkQD27XaX1/VRvvCQCcDQIVST4jKdo5yGFr/jXbYEHi
LH8AnjkQGM2+yZDLjGk4CoEYFjMRsbvI
=PW+N
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
