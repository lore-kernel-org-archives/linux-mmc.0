From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support for mx5
Date: Thu, 16 Jun 2011 14:10:22 +0200
Message-ID: <20110616121022.GC23579@pengutronix.de>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
 <1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1FPMK0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2011 08:10:26 -0400
Content-Disposition: inline
In-Reply-To: <1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Pavel Machek <pma@sysgo.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2011 at 07:15:22PM +0800, Shawn Guo wrote:
> The patch extends card_detect and write_protect support to get mx5
> family and more scenarios supported.  The changes include:
>=20
>  * Turn platform_data from optional to mandatory
>  * Add cd_types and wp_types into platform_data to cover more use
>    cases
>  * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
>  * Adjust some machine codes to adopt the platform_data changes
>=20
> With this patch, card_detect and write_protect gets supported on
> mx5 based platforms.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Looks like right direction to me, so far; some testers would be good,
though.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk358q4ACgkQD27XaX1/VRtn7wCff4u1yQ4jQq3ItmMayGEGaZIy
Us8AoKrikc4H+UR+IpnklaHHoaSxvs+G
=s9/v
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
