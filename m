From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH RFC 14/15] ARM: dts: sun9i: a80-optimus: Enable hardware
 reset and HS-DDR for eMMC
Date: Sun, 24 Jan 2016 17:59:19 +0100
Message-ID: <20160124165919.GE7908@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-15-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40641 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752859AbcAXQ7U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2016 11:59:20 -0500
Content-Disposition: inline
In-Reply-To: <1453354002-28366-15-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 01:26:41PM +0800, Chen-Yu Tsai wrote:
> mmc2 has a special pin for eMMC hardware reset, which is controllable
> from the controller. Add the "mmc-cap-hw-reset" property to denote that
> this controller supports this function, and the pins are actually used.
>=20
> Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
> support.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpQLmAAoJEBx+YmzsjxAgQYUP/j+oaYlsvEJCKR62W667tJpV
9MhJfllIQII9vUK/mcoofAVu8b9ktmJNggLSIBqf7GvDpBgtl5NuF5ie/hfU9WXO
uN2EiBhxUP2Jn4jac23SjBp2Hrna6QN/HiMpve0CHgvNJsBSixwrPUKhIa2BmzhF
Bf1NIQBr005R9Qlv/1u/KkDzTgaLN58hnhstRMRnQn8je16+muwrHPoZCodw5x2f
fHDJiXiM2ZT1cIfCVnWGh1tHvK/t1dHCuyh5OkUYtVFgPFSTE9c1Dj66PMEEo2CI
tH0jcX7QMUJaWtIzp9ZnugiQAW9k7Lb0s2JblzWkQhtYFtCGVS9/Gv7pHQm1HoXd
sef2AI9J4DDku47wwBzuP9qnNM2GcJKYIfSMac7lbbUnyEgxI+6WjKWCx3FExI1f
smXFr7Lx3KpVC3f3AcfhxHWVprQ5CfcCEQlqORaAZYt7tHMTtsRrIooAk6H3enmM
/ZPrfWtNqiGitwJFQf5ljSS4eqdD4lEPuW9DSL+6YPJlF1sUwIYLzY++06LsmHrh
xjWibU/Ts5SB4ld7SY5erQcn633LhKO+3mWGs2/CnCJMZdyUBxQo9pwaQ7zRqRKJ
CRYr8bvI5xaMJb7Sn/SIo+QMFBMFmqF2b629X2GFVNXmxfJjlkqgOlROueT3+hiV
QaAyWxsDM30X6ndI02cP
=SqrK
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
