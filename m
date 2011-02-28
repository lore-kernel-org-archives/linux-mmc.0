From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 1/4] ARM: imx53_loco: add esdhc device support
Date: Mon, 28 Feb 2011 15:19:02 +0100
Message-ID: <20110228141902.GD15532@pengutronix.de>
References: <1298892315-23386-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <AANLkTin1U=B3xnp0UGK_2iHK2k=o4Tda=6NzyoLFgUAv@mail.gmail.com>
 <AANLkTimTsv1jsvX8Eq9EttU32O0sJ-8yj-SGadx9gwLD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34748 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab1B1OTM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 09:19:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimTsv1jsvX8Eq9EttU32O0sJ-8yj-SGadx9gwLD@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, richard.zhao@freescale.com, eric@eukrea.com, avorontsov@ru.mvista.com


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> >> ---
> >> =A0arch/arm/mach-mx5/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> =A0arch/arm/mach-mx5/board-mx53_loco.c | =A0 =A02 ++
> >> =A02 files changed, 3 insertions(+), 0 deletions(-)
> >
> > I think this patch should be the last one of the series.
> Yes, but I don't think it matter much.

It will if you bisect and end up here without the clock patch, no?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1rrtYACgkQD27XaX1/VRvX0QCghKH5atK2tVLZJlxcQK6G+Nhu
YJYAn30KCx0LAFx/4Da6tAtwtkYUGezJ
=Upqg
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
