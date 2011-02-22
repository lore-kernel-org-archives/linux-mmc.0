From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/5] arm: mach-mx3: pcm043: add write-protect and
 card-detect for SD1
Date: Tue, 22 Feb 2011 20:55:04 +0100
Message-ID: <20110222195504.GA9046@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
 <1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
 <AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33105 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1BVTzG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 14:55:06 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +#define SD1_GPIO_WP    IMX_GPIO_NR(2, 23)
> +#define SD1_GPIO_CD     IMX_GPIO_NR(2, 24)

Probably you noticed by now, but the next patch does that for the whole
directory :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1kFJgACgkQD27XaX1/VRtwxwCgrzTz4AYNnVWzb5jnQODYJXHi
5vAAoL4ath8dYmAkUCwgIf1qaAPOz13N
=A1NK
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
