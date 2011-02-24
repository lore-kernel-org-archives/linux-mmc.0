From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 2/3] mmc: cb710: Return err value in
 cb710_wait_while_busy()
Date: Thu, 24 Feb 2011 09:40:25 +0100
Message-ID: <20110224084025.GA4901@pengutronix.de>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org>
 <1298500153-28081-2-git-send-email-cjb@laptop.org>
 <20110223230309.GB15104@pengutronix.de>
 <20110223231743.GA30908@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59433 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1BXIk1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 03:40:27 -0500
Content-Disposition: inline
In-Reply-To: <20110223231743.GA30908@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2011 at 11:17:43PM +0000, Chris Ball wrote:
> Fixes:
>=20
> drivers/mmc/host/cb710-mmc.c: In function =E2=80=98cb710_wait_while_busy=
=E2=80=99:
> drivers/mmc/host/cb710-mmc.c:182:6: warning: variable =E2=80=98err=E2=80=
=99 set but not
> used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1mGXkACgkQD27XaX1/VRuO5wCdGOfwBobz9YsLSHjGXN77/yZR
ahUAoMReWJcW4AvW/2pQsgxl4REwaSWz
=fuas
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
