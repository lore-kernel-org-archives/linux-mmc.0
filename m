From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Mon, 21 Mar 2011 14:06:30 +0100
Message-ID: <20110321130630.GF9686@pengutronix.de>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44642 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab1CUNGo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 09:06:44 -0400
Content-Disposition: inline
In-Reply-To: <1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2011 at 01:22:15PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2HTVYACgkQD27XaX1/VRsI3ACfVdwGsKRxIl0NMqoFjCsmhDOP
ecUAn3JDMCu2s/mhoLVZv8IXUUD4UfwC
=g5qU
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
