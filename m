From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3
 sd controller
Date: Mon, 8 Nov 2010 10:17:54 +0100
Message-ID: <20101108091754.GA8638@pengutronix.de>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
 <20101107220411.GB5376@pengutronix.de>
 <BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47173 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab0KHJR4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 04:17:56 -0500
Content-Disposition: inline
In-Reply-To: <BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > This isn't a quirk, this is platform_data, no?
>=20
> Never sure of the difference between a quirk and platform data.=20
> example:  Broken card detect is a quirk but maybe some slots on the board=
 work and some do not

A quirk is something which needs to be handled in a special case because
some controllers do not adhere to the SDHC standard. An 8 bit bus seems
to be in the 3.0 standard, so it is not a quirk :) Does the standard say
anything about how the actual bus width should be handled?

That said, you are right that quirks have been abused to cover board
issues. Another reason to clean them up ;)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzXwEIACgkQD27XaX1/VRuQ8QCeN1ueDODn5jbt9MS49MCJcQXS
BccAn0VnBmmBbLRFvBf/wo4zStAXUGV0
=VwO1
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
