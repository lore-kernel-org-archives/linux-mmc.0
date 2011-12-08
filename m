From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MXS MMC v2 3/4] Check the return codes of clk_enable() and
 mxs_reset_block()
Date: Thu, 8 Dec 2011 09:53:40 +0100
Message-ID: <20111208085340.GD23908@pengutronix.de>
References: <cover.1323328267.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323328267.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45484 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1LHIxs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 03:53:48 -0500
Content-Disposition: inline
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323328267.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2011 at 09:17:46AM +0100, Lothar Wa=DFmann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code of
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Despite minor nit that using __func__ is probably overkill:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7gexQACgkQD27XaX1/VRukoACgswAHyy/lpd8ipZOXS0TTz4bb
ijAAnRACLX5rWtR7jA3Bd2zwAS798nc9
=sUOB
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
