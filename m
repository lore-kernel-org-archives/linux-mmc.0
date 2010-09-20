From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Mon, 20 Sep 2010 10:38:42 +0200
Message-ID: <20100920083842.GA4058@pengutronix.de>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39728 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab0ITIiw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 04:38:52 -0400
Content-Disposition: inline
In-Reply-To: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, matt@console-pimps.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 10:20:17AM +0200, Giuseppe CAVALLARO wrote:
> This patch adds the Arasan MMC/SD/SDIO driver
> for the STM ST40 platforms. It is based on the
> SDHCI driver.
> It has been tested on the STx7106/STx7108/STx5289
> platforms.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Looks to me that you could just use the sdhci-pltfm driver?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyXHZIACgkQD27XaX1/VRseMwCeMi79gx43pq6LAZFoYRwQTQzI
LHsAoMJ6GXTIGnZ/7nleUYhU9NpRN4gV
=NHqw
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
