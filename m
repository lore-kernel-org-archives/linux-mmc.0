From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 12:57:16 +0100
Message-ID: <20110222115716.GG2755@pengutronix.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110221174016.GN2616@pengutronix.de>
 <20110222085256.GA19871@S2100-06.ap.freescale.net>
 <20110222103349.GA2755@pengutronix.de>
 <20110222115045.GB19871@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39384 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab1BVL5T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 06:57:19 -0500
Content-Disposition: inline
In-Reply-To: <20110222115045.GB19871@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, arnd@arndb.de


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> My busybox version of dd does not report the speed.  But I tried to
> dd 8MB data and saw it's done in 1~2 seconds.
>=20
> Also here is mmc host driver test performance related result on my
> board if you are interested.

OK, looks good. Let's merge the driver then and I will check my board.

Thanks!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1jpJwACgkQD27XaX1/VRvbSwCfdU83hQxbb/hPuzx0eNPEKHCl
xicAn1TlixXCfpAvmdBQHFlnwmU5eyIN
=Kson
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
