From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/5] mm: sdhci-esdhc: remove
 SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
Date: Mon, 21 Feb 2011 11:02:26 +0100
Message-ID: <20110221100226.GD2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-4-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1BUKCe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 05:02:34 -0500
Content-Disposition: inline
In-Reply-To: <1298282095-2279-4-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, r65037@freescale.com, Richard Zhu <Hong-Xing.Zhu@freescale.com>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2011 at 05:54:54PM +0800, Richard Zhao wrote:
> sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET.
> Make it OF-specific.

Just to make sure, because all the other patches are for mx53: Do you
have tested it on mx25/35/51 also?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1iODIACgkQD27XaX1/VRuHDwCgjj2e741hiXkacWfHNqQaqeij
HhIAnjeCCBNHApewnDHRTelptp2zkjIT
=ULWf
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
