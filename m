From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] mmc: sunxi: fix mojibake in module metadata
Date: Tue, 28 Nov 2017 08:36:30 +0100
Message-ID: <20171128073630.7gxuyv775ateta62@flea.home>
References: <20171128034455.10344-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uovrehrebwdavoot"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52671 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdK1Hgc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Nov 2017 02:36:32 -0500
Content-Disposition: inline
In-Reply-To: <20171128034455.10344-1-kilobyte@angband.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, linux-mmc@vger.kernel.org


--uovrehrebwdavoot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 04:44:55AM +0100, Adam Borowski wrote:
> It had an U+FFFD: not a corrupted character but a literal well-formed
> replacement marker.
>=20
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Ah, I always forgot to fix it :)

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uovrehrebwdavoot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlodEfoACgkQ0rTAlCFN
r3TLpBAAlqCNj5XT9tzTthByvfJL4y3LTGIU9PCTEVFIbdKaTRsFMaktCl8yL2+d
l/g+5NayHLxqffb/4yShUp/czZLv+IjmmJ7fd9xT93mGvIoy2IwbNr1mu9LHPpqD
y4aOuOUOpTj1O6Y8IzvPMywHC3wz7RM+L37lRinwBi9c1/YDCgEIVWk2BKxbZIi6
G2pJBkON1lbO25aMVtCLf+fng4ysKOWL6PRj4E9HDyuUlKEJLjhEDJNfRGDRR2Ey
8EX/xQHzfJSvudIGksEkINp6y9bn2NW/+7HXyou2S9ebGVXoM1o2NpwM1qWY0xiw
+oApPb7Q7dOOibAnF+uVbI1D4ci6wiOWeQG+jK7ZK2y8rc2ERn8WANPTrUw+aoaa
UWKwOL2hZ6FVNwhQvAyTGkVXNFx3XktFk78cvqeP+BsslayARhq/mMUi3j49aabq
ojLbubP0DTMKhcThEXV/MXejTzaFahYRO4MDWhsYlwAGoH/04ZU/EpZRXGqVEWa4
cvNahFFApsLMQwScsnFnazXi7UpYVRWQayFuiBf4Q2ah57uxRuVz10pta+kUr7XZ
mxbVdoBPNWuOOyZ/s/NYKLWcmlXpHK20H/w44szl6baF/0m0iVEigO6Exbbacxq6
4Si9HTY8A2kH7AxtOTtwORAzUy6+XW48n2b3qJZkCgWxnzLxbzU=
=mvbj
-----END PGP SIGNATURE-----

--uovrehrebwdavoot--
