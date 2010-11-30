From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card
 busy.
Date: Tue, 30 Nov 2010 11:54:35 +0100
Message-ID: <20101130105435.GB6408@pengutronix.de>
References: <4CF4961C.5020606@samsung.com>
 <20101130095618.GA6408@pengutronix.de>
 <4CF4CE48.7040102@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52253 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0K3Kyi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 05:54:38 -0500
Content-Disposition: inline
In-Reply-To: <4CF4CE48.7040102@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, matt@console-pimps.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Maybe, happen for all sdhci-controllers...

My point is: If it is needed for all SDHCI-controllers, we don't need a
quirk and can apply your code unconditionally.

> Card is configurable with eMMC spec..But sdhci-controller didn't
> support that card. So SDHCI controller need to use quriks..

Can we find out if this is a general issue?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz01+sACgkQD27XaX1/VRt5WgCgrZXLhFBNPVFq8Xm902sD86la
Z98AnigU+FFpTQe6G8KH/lcscBfuWhWz
=z44l
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
