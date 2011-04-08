From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: add regulator disable/put when
 control error
Date: Fri, 8 Apr 2011 20:38:25 +0200
Message-ID: <20110408183825.GB23883@pengutronix.de>
References: <4D9ACC8C.2000202@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50714 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314Ab1DHSi1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 14:38:27 -0400
Content-Disposition: inline
In-Reply-To: <4D9ACC8C.2000202@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2011 at 05:02:20PM +0900, Jaehoon Chung wrote:
> Missing regulator disable/put. Fixed them.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks OK but could be merged into the previous patch.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2fViEACgkQD27XaX1/VRt1+wCaAxSjsZ+GqVdhnca16rMsO7LK
jfcAnjvIvSBSFknx7nMomkT6I4Y1YTgV
=KfuE
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
