From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc: simplify cd_gpio, wp_gpio
Date: Sun, 3 Jul 2011 10:22:28 +0200
Message-ID: <20110703082228.GA22711@pengutronix.de>
References: <1309562019-32707-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50877 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1GCIWh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2011 04:22:37 -0400
Content-Disposition: inline
In-Reply-To: <1309562019-32707-1-git-send-email-troy.kisky@boundarydevices.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Hong-Xing.Zhu@freescale.com, cjb@laptop.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2011 at 04:13:38PM -0700, Troy Kisky wrote:
> Currently, platform data is referenced by non init functions.
> Copy these fields into locally defined struct pltfm_imx_data.
>=20
> The code also currently frees imx_data on troubles with
> cd_gpio, but returns 0 anyway. Now the code ignores cd_gpio
> and wp_gpio if the values cause an error.
>=20
> Also, allow mx51/mx53 to use platform data.
>=20
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Have you seen this series from Shawn?

[PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support=
 for mx5

I haven't checked if you are doing the same or similar, just that you are
changing the same code. Please CC Shawn Guo and Richard Zhu if there is ano=
ther
patch series needed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4QJsQACgkQD27XaX1/VRuxzQCdHguuMuKCnyzqzAR2/I7hz4hj
RBkAnjfuqaPI4f+cgjwQTPeODvO78Erj
=lOvZ
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
