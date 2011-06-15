From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support for mx5
Date: Wed, 15 Jun 2011 12:44:04 +0200
Message-ID: <20110615104404.GA3097@pengutronix.de>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
 <1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
 <20110614095129.GD5043@pengutronix.de>
 <20110614130610.GH30295@S2100-06.ap.freescale.net>
 <20110615103344.GA3579@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40273 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1FOKoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 06:44:10 -0400
Content-Disposition: inline
In-Reply-To: <20110615103344.GA3579@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Sorry.  I had some reason for moving esdhc_pltfm_get_ro around.  We
> can not keep the existing approach (what I said above).  For mx51
> babbage example, esdhc1 uses internal WP while esdhc2 uses gpio WP.
> If we have esdhc_pltfm_get_ro handle gpio only and assign it to
> sdhci_esdhc_ops.get_ro in .probe only when wp_type is ESDHC_WP_GPIO,
> that works for esdhc2 but breaks esdhc1 WP function.  So no, I will
> not change my code except adding NONE case handling there.

Ok, fine with me. Thanks for checking!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk34jPQACgkQD27XaX1/VRtLWgCglYPLQu+SRnOBCAC7J/Z8tYOn
1CwAn2yS9Aeieyj4lq7VUcRRszJjC9Bz
=bSFX
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
