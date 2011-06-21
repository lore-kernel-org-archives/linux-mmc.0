From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not
 get cleared
Date: Tue, 21 Jun 2011 13:52:36 +0200
Message-ID: <20110621115236.GA14004@pengutronix.de>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
 <1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1FULwk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 07:52:40 -0400
Content-Disposition: inline
In-Reply-To: <1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2011 at 06:38:43PM +0800, Shawn Guo wrote:
> The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
> when the card detect gpio tells there is no card.  But it does not
> clear the bit actually.  The patch gives a fix on that.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

For the third time ;)

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Should go to stable.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4AhgQACgkQD27XaX1/VRvDogCeOvBpMxfNkON23eSd2kJmdqC6
IZQAnRXLA3renXLmEVi/bJWCkO0ybjH2
=jiy7
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
