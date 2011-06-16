From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does
 not get cleared
Date: Thu, 16 Jun 2011 14:01:08 +0200
Message-ID: <20110616120108.GB23579@pengutronix.de>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
 <1308136522-3403-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab1FPMBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2011 08:01:13 -0400
Content-Disposition: inline
In-Reply-To: <1308136522-3403-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Pavel Machek <pma@sysgo.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2011 at 07:15:20PM +0800, Shawn Guo wrote:
> The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
> when the card detect gpio tells there is no card.  But it does not
> clear the bit actually.  The patch gives a fix on that.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Should go to stable...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk358IQACgkQD27XaX1/VRshfACcDmZee15J6sBeVjVrEvmB1u5t
td4AoIuPCGfU4hZwqrkTj92TTsZNcJzu
=sYl/
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
