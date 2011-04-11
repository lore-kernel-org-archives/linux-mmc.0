From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 06:40:22 +0200
Message-ID: <20110411044022.GD20437@pengutronix.de>
References: <4DA2633C.5000103@samsung.com>
 <20110411030453.GA20437@pengutronix.de>
 <4DA28098.9020202@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50013 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab1DKEkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 00:40:24 -0400
Content-Disposition: inline
In-Reply-To: <4DA28098.9020202@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I just think good that remove the host...(any crash didn't occur).
> there is not special reason.

Look at the mmc-core code, please (host.c). Compare what remove_host does a=
nd
what add_host does before it fails. What do you think?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2ihjYACgkQD27XaX1/VRticACgyecllHDOcM8tmWw8S531R9Uu
/JwAoIt+VcwxnVczlRgkdGolIYqGPPa7
=cV80
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
