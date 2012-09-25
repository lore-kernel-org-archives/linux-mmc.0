From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci / i.MX esdhc buswidth patches
Date: Tue, 25 Sep 2012 08:44:43 +0200
Message-ID: <20120925064443.GA8655@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab2IYGor (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 02:44:47 -0400
Content-Disposition: inline
In-Reply-To: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2012 at 09:22:22AM +0200, Sascha Hauer wrote:
> The first patch is a generic sdhci driver cleanup change, the others
> are i.MX specific, adding 8bit bus support and fix version register
> readout.
>=20
> Sascha
>=20
> ----------------------------------------------------------------
> Sascha Hauer (3):
>       mmc: sdhci: rename platform_8bit_width to platform_bus_width
>       mmc: esdhc i.MX: Fix version register read
>       mmc: esdhc i.MX: Support 8bit mode

Whole series:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBhUtsACgkQD27XaX1/VRuUYACfSRKotH5PVpI1WVsX+m3Pbd9K
I9AAn0FfuqlItK42B7SEyozpFBUN3qM0
=lcfC
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
