From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: sdhci-esdhc-imx -- MMC 10x slower than it should be
Date: Wed, 15 Jun 2011 12:53:18 +0200
Message-ID: <20110615105318.GB3097@pengutronix.de>
References: <20110615094001.GA21137@pma.sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1FOKxV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 06:53:21 -0400
Content-Disposition: inline
In-Reply-To: <20110615094001.GA21137@pma.sysgo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pma@sysgo.com>
Cc: linux-mmc@vger.kernel.org, pba@sysgo.com, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> not what it should be; it is about 10x lower in fact.

Which SoC? 25/35/51/53?

> ...any idea what this comment means? I'd like to eventualy support
> 8BITBUS...

8-Bit bus is not specified in the standard, so it cannot be detected.
Check other drivers where they use MMC_CAP_8_BIT_DATA.

> Part of the problem is that esdhc_writeb_le() does translation of bits
> into breescale format; but readb() does not do translation back, and
> core code uses read-modify-write on the register, for example when
> turning on the LED. What to do there? Translate back? Add shadow
> variable? Get rid of read-modify-write?

Probably the least ugly solution :/

> Any ideas why it is slow?

Your board polls for card-detect, Shawn recently sent a series which
lets you fix that for mx5.

ADMA is marked broken in mainline, cause it didn't work with a number of
cards. Richard sent a patch recently.

Both series could need some more testing :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk34jx4ACgkQD27XaX1/VRtEiwCdFQIZzkvxS8aaJpewxrDYYego
69AAoKKnO8SfRnKhAFqfDUohrscY0tbb
=hEJu
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
