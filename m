From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 4 Apr 2011 15:28:07 +0200
Message-ID: <20110404132807.GC20421@pengutronix.de>
References: <4D996006.9030402@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49987 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab1DDN2M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:28:12 -0400
Content-Disposition: inline
In-Reply-To: <4D996006.9030402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2011 at 03:07:02PM +0900, Jaehoon Chung wrote:
> Sometimes we can't add the device,but we didn't check any error status.
> Need to check error status for mmc_add_host.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---

Please add here what changed since the last revision.

You are still leaking the led_classdev. Why do you free the mmc_host when
registering it failed? Looking at the remove function as comparison, there =
are
still some buffers, timers, etc, forgotten :( Could you fix that, too, plea=
se?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2Zx2cACgkQD27XaX1/VRsNhQCeKV4KSssXueg2Pg/OmFt9GjeY
+CQAn34gye63SfDlf8H+IhjRdKaue+BS
=RwIG
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
