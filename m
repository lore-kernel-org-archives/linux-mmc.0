From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Mon, 12 Mar 2012 22:45:45 +0100
Message-ID: <20120312214545.GC28087@pengutronix.de>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60138 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab2CLVps (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 17:45:48 -0400
Content-Disposition: inline
In-Reply-To: <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: linux-mmc@vger.kernel.org, shawn.guo@linaro.org, Hong-Xing.Zhu@freescale.com


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2012 at 03:50:03PM +0100, joancarles wrote:

> >>What could have changed between 2.6.39.3 and 3.3-rc5 to trigger this
> >>behaviour? A quick look at
> >>
> >>git diff v2.6.39 drivers/mmc/host/sdhci-esdhc-imx.c
> >
> >I'd recommend:
> >
> >git log v2.6.39.. drivers/mmc/host/sdhci-esdhc-imx.c
>=20
> I have been staring at those commits, however with very little
> domain knowledge it's a shot in the dark.

Have you tried copying sdhci-esdhc-imx.c from 2.6.39 to the current kernel
(might need some build fixes)? If that doesn't work, there might be somethi=
ng
wrong in the sdhci-driver itself, and not the esdhc-extension.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9ebokACgkQD27XaX1/VRssJQCgmMZHf4c+FyqhDE0wPUinD+rM
+DAAnia1XY0uXnqCVkbeeFvjo8b2Ku1o
=QvSi
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
