From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: Rename SDHCI I/O accessor functions
Date: Tue, 27 Apr 2010 08:36:13 +0200
Message-ID: <20100427063613.GA22743@pengutronix.de>
References: <a2d0197b810b93814fe3ab8aa78fb0e721b9f08e.1272347885.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45619 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0D0GgS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2010 02:36:18 -0400
Content-Disposition: inline
In-Reply-To: <a2d0197b810b93814fe3ab8aa78fb0e721b9f08e.1272347885.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2010 at 07:01:27AM +0100, Matt Fleming wrote:
> Unfortunately some architectures #define their read{b,w,l} and
> write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functions
> of the same names subject to preprocessing. This leads to the following
> compiler error,
>=20
> In file included from drivers/mmc/host/sdhci.c:26:
> drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 arguments=
, but takes just 2
>=20
> Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS can
> be enabled for architectures that implement their read{b,w,l} and
> write{b,w,l} functions with macros.
>=20
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

I remember hitting this problem, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvWhd0ACgkQD27XaX1/VRs0CQCgkOEZuh8IAYbLr3PLXwoqnrKF
7Z8An0Pumh7KL1ABNMxznFGZkcIVVQvS
=WCra
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
