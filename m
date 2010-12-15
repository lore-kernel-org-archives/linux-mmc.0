From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 09:35:46 +0100
Message-ID: <20101215083546.GA16459@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53133 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0LOIf4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 03:35:56 -0500
Content-Disposition: inline
In-Reply-To: <1292388576-25600-5-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

On Tue, Dec 14, 2010 at 10:49:36PM -0600, Olof Johansson wrote:
> SDHCI driver for Tegra. Pretty straight forward, a few pieces of
> functionality left to fill in but nothing that stops it from going
> upstream. Board enablement submitted separately.
>=20
> This driver is based on an original one from:
>=20
> Signed-off-by: Yvonne Yip <y@palm.com>
>=20
> Misc fixes and suspend/resume by:
>=20
> Signed-off-by: Gary King <gking@nvidia.com>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>=20
> GPIO write protect plumbing:
>=20
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
>=20
> Quirk rework and cleanups before submission:
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>

Can't you just use sdhci-pltfm?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0IfeIACgkQD27XaX1/VRthRQCePqUQ4aMWph3Sm+vV6EP1QxZm
FLkAnjPcdL2ElRr85zP2X10CTRls6Sp9
=1k63
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
