From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Tue, 19 Oct 2010 04:03:48 +0200
Message-ID: <20101019020348.GB3485@pengutronix.de>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101018145833.GB22538@pengutronix.de> <AANLkTikNVu6UaCbm-335KNd4x2TX_SUz1FQHn6ODUX43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45151 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab0JSCDv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 22:03:51 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikNVu6UaCbm-335KNd4x2TX_SUz1FQHn6ODUX43@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Currently platform driver can not support well of the requirement for
> several device sharing one driver,  each one has different quirk,
> different max_speed, and each device need some specific vectors.
> We prefer using independent driver first.

What about a custom init-call reading out the platform_data?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky8/IQACgkQD27XaX1/VRuYkQCfaPUOLkDwZ+mCW9ztlGJnAy85
S4oAn1MEL5UhA7bTi8+H5fcMSEEPmZwC
=6MTu
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
