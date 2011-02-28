From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 3/4] mmc: sdhci-esdhc: remove
 SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
Date: Mon, 28 Feb 2011 15:20:38 +0100
Message-ID: <20110228142037.GE15532@pengutronix.de>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab1B1OUm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 09:20:42 -0500
Content-Disposition: inline
In-Reply-To: <1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com, Freescale@lists.linaro.org, eric.miao@linaro.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2011 at 07:32:04PM +0800, Richard Zhu wrote:
> sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET. Make it OF-sp=
ecific.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

Seems to work on mx35 at least:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1rrzUACgkQD27XaX1/VRtLUwCfQm9+Itn/6GTkBTfGA8P91AMO
Sf8AoMbvlQzNj75npWrHlzYeAg92PMvq
=zzcA
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
