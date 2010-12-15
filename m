From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 12:03:12 +0100
Message-ID: <20101215110312.GE3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-3-git-send-email-olof@lixom.net>
 <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com>
 <20101215105443.GA32297@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51695 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0LOLDQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 06:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20101215105443.GA32297@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Really appreciate if not using the valuable quirk resource, which is u3=
2.
>=20
> No big deal. Next person that needs a quirk bit gets to bump the data
> type to u64.

That won't scale for long, I fear (and will make sdhci.c an unreadable
mess). We need less quirks and more flexible means to handle flawed
controllers, I'd think.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0IoHAACgkQD27XaX1/VRtfDwCgn1TF+f5/kN3n6NQpGL0Euvug
UnUAn3m4Rci6jztNa+d/yW9/IO2qdfHV
=mKQb
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
