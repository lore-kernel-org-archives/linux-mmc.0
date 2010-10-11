From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 11 Oct 2010 18:44:59 +0200
Message-ID: <20101011164459.GB476@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <20101011163255.GA21335@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34873 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab0JKQpA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 12:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20101011163255.GA21335@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Wolfram Sang (6):
> >   mmc: sdhci-pltfm: Add structure for host-specific data
> >   mmc: sdhci-pltfm: move .h-file into apropriate subdir
> >   mmc: sdhci: introduce private get_ro
> >   mmc: sdhci_pltfm: pass more data on custom init-call
> >   mmc: sdhci-of-esdhc: factor out common stuff
> >   mmc: sdhci-pltfm: add pltfm-driver for imx35/51
>=20
> Mind fixing up the >80 char lines in the last two patches?  It's just:

Sigh, I don't think it will help the readability of the code, but if it can=
't
be helped...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyzPwsACgkQD27XaX1/VRumWwCffTMS8NsgaUCUtIydoEbGGUSy
oGQAnROkx1rg8UiKveX1BPokPkxQz6S1
=vBTw
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
