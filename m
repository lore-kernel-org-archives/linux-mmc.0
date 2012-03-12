From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Mon, 12 Mar 2012 14:24:23 +0100
Message-ID: <20120312132423.GC2459@pengutronix.de>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49663 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab2CLNYZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 09:24:25 -0400
Content-Disposition: inline
In-Reply-To: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: linux-mmc@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> What could have changed between 2.6.39.3 and 3.3-rc5 to trigger this
> behaviour? A quick look at
>=20
> git diff v2.6.39 drivers/mmc/host/sdhci-esdhc-imx.c

I'd recommend:

git log v2.6.39.. drivers/mmc/host/sdhci-esdhc-imx.c

and look at those commits. You should also include the people who did
those commits in CC when writing mails, otherwise they probably won't
notice. Richard Zhu and Shawn Guo are from Freescale, and have more
knowledge about the ESDHC cores.

Wild guessing, 97e4ba6a5ea903a221d87bcabdaf01efb0a609a5 looks like the
most likely candidate, but I may be totally wrong.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9d+QcACgkQD27XaX1/VRtkXQCdGce6Y+pI+0MzG0+XzBFpRixu
y3cAnRloPrjFW233UAkgIHz+PL8GZDaD
=lbln
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
