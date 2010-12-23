From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Thu, 23 Dec 2010 12:23:46 +0100
Message-ID: <20101223112346.GA5044@pengutronix.de>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
 <1293096828-19985-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55312 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab0LWLXw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 06:23:52 -0500
Content-Disposition: inline
In-Reply-To: <1293096828-19985-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Changes since v2:
> 	* Whitespace fixes
> 	* Changed order of test in get_ro

What benefit has the reordering? (And just to make sure: You still
return -1 meaning "read-only". I assume this is intentional)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0TMUIACgkQD27XaX1/VRtc4wCgtGpnbMEJM7p+JYAUSAALZzIs
+FQAn30rrSHN2791C/DtLIOnLaHgYfyD
=4ySS
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
