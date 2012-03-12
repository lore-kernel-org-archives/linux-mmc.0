From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: iMX53 and MMC_CAP_SDIO_IRQ
Date: Mon, 12 Mar 2012 12:06:24 +0100
Message-ID: <20120312110624.GB2459@pengutronix.de>
References: <4F5DB793.3080904@linuxtv.org>
 <20120312101037.GA2459@pengutronix.de>
 <4F5DD28F.50600@linuxtv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47193 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2CLLGZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 07:06:25 -0400
Content-Disposition: inline
In-Reply-To: <4F5DD28F.50600@linuxtv.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Hunold <hunold@linuxtv.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Ok, to sum this up:
>=20
> SDIO IRQs are working in mx_sdhci in the Freescale tree because it was
> properly implemented and tested, obviously.

Not sure about "properly", but, yes ;)

> SDIO IRQs are working for sdhci in mainline probably for other
> non-freescale platforms.

Probably, but I can't say 'yes' for sure. You'd need to find out.

> You fixed the generic sdhci driver in mainline to work with iMX53 to get
> rid of the need for mx_sdhci, but probably never got the chance to test
> if SDIO IRQs are really working.

I worked mainly with MX25/35 back then, and a little bit with MX51. IIRC
I only had an SDIO card for which no Linux drivers were available, so I
only could test that the card was detected :(

> That means, the subtle difference between mx_sdhci and sdhci to get SDIO
> IRQS to work on sdhci with iMX53 has yet to be found.

Yup. Try 'git log --follow sdhci-esdhc-imx.c' to find people who worked
with MX53 or SDIO using that driver.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9d2LAACgkQD27XaX1/VRtjqwCfX3V/IjUWTwHMa8ua8Mwop7Vw
RDIAoKIuKqD8NN09nVEMYm0J4xt4IzCZ
=kvFn
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
