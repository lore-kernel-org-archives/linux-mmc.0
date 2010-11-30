From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card
 busy.
Date: Tue, 30 Nov 2010 10:56:18 +0100
Message-ID: <20101130095618.GA6408@pengutronix.de>
References: <4CF4961C.5020606@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42439 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0K3J4X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 04:56:23 -0500
Content-Disposition: inline
In-Reply-To: <4CF4961C.5020606@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, matt@console-pimps.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 30, 2010 at 03:13:48PM +0900, Jaehoon Chung wrote:
> This patch is added quirks for data timeout value.
>=20
> Some card have problem when suspend/resume.
> CMD6(switch command) to switch the bus to high speed mode=20
> and to set the bus width.
>=20
> After resuming, the card was initialized...in that time, some
> card need set a correct timeout value.
> so we add SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL.

If this is a flaw of the _card_, why do we need a controller quirk here?
Shouldn't this happen for all sdhci-controllers?

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz0ykIACgkQD27XaX1/VRvdQACeJ+RzUHDI8LyJ+H1Fz2Sx/gBh
th0AoMrAWQCgxcCxedj076hHOk8N/t4b
=s/5L
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
