From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/4] mmc: sdhci-esdhc-imx: remove "WP" from flag
 ESDHC_FLAG_GPIO_FOR_CD_WP
Date: Tue, 14 Jun 2011 11:28:13 +0200
Message-ID: <20110614092812.GC5043@pengutronix.de>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54783 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab1FNJ2Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 05:28:16 -0400
Content-Disposition: inline
In-Reply-To: <1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2011 at 06:42:51PM +0800, Shawn Guo wrote:
> The use of flag ESDHC_FLAG_GPIO_FOR_CD_WP is all CD related.  It does
> not necessarily need to bother WP in the flag name.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'd just squash it into the next one?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk33KawACgkQD27XaX1/VRt5GACffqVdpNR6LCycASRRPfoR8Mia
GVgAnjpxVuM43SxSTnZxszt5JLAPhXMW
=/+KF
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
