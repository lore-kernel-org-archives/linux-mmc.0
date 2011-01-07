From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: mshci: Add support Mobile Storage Host Controller
 Interface
Date: Fri, 7 Jan 2011 12:51:23 +0100
Message-ID: <20110107115123.GD32436@pengutronix.de>
References: <1294399237-5716-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1AGLvc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 06:51:32 -0500
Content-Disposition: inline
In-Reply-To: <1294399237-5716-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Hyunsung Jang <hs79.jang@samsung.com>, Hyuk Lee <hyuk1.lee@samsung.com>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The 'mshci.c' is based on 'linux/drivers/mmc/host/sdhci.c' and
> the role is exactly same with that.

Can you sum up the differences why you cannot sdhci.c directly, please?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0m/jsACgkQD27XaX1/VRtGlgCfUx7nWjsXAx0uGdb9NVqZzGY5
vnwAnR+gmnyd/t517KkxWJMBVu9h7lhA
=TFDi
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
