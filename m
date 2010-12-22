From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/3 v2] Add SDHCI driver for Tegra
Date: Wed, 22 Dec 2010 17:05:17 +0100
Message-ID: <20101222160517.GB30951@pengutronix.de>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38486 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab0LVQFW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 11:05:22 -0500
Content-Disposition: inline
In-Reply-To: <1293004871-1918-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

> This is the second version of the SDHCI driver for tegra. I moved it
> over to a sdhci-pltfm variant, which turned out to be feasible -- at

Great.

> The one remaining quirk is of the kind that can be moved entirely into
> the driver, and I will look at doing so when I get around to cleaning
> up other quirks together with it. Until then, at least we have one more
> bit left to allocate. :-)

[BAZAAR MODE]

So, when are going to remove them? And how many? And what happens if
not? ;)

[/BAZAAR MODE]

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0SIb0ACgkQD27XaX1/VRvUkQCeK3zKaXO2ESVhVaQwLlsyqdMC
zBUAn2OKOiVUoKDF4dBsbkrtra6Wp0u5
=3jUN
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
