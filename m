From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/3] mmc: sunxi-mmc: change idma descriptor to __le32
Date: Fri, 22 Jul 2016 10:59:29 +0200
Message-ID: <20160722085929.GA7687@lukather>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-2-michael.weiser@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40059 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751455AbcGVI7m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2016 04:59:42 -0400
Content-Disposition: inline
In-Reply-To: <20160721182329.13478-2-michael.weiser@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Weiser <michael.weiser@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 08:23:27PM +0200, Michael Weiser wrote:
> The sunxi-mmc driver does not take into account the processor may be big
> endian when writing the DMA descriptors. This causes cards not to be
> detected when running a big-endian kernel. Change the descriptors for
> IDMA to use __le32 and ensure they are suitably swapped before writing.
> Tested successfully on the Cubieboard2.
>=20
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkeBxAAoJEBx+YmzsjxAgaO4P/3W8A4C5mkiA4t7e3UZPJWkt
uPGoR630FJNxLvjPlpxySWhpYyrSl7EIdHtMZReCQHs0brlBJiJCz/KXKnRYfu6G
IXxpmCwy7S54ObhUgyCY4AkKFCJpEQFHj2YoeAXNsuX381f74RmOumPiS985cW3Z
fiMcsMkZ3nxtwG+iOD+HZ8p6xWwZ3ctwCOoZlUvHmbaOjyMdIATi/3D3RT6tI/Uj
afc6mFGuarl6bVOg5Ly8K6CxZqWYGJoth98j6+mkuxvsBtLxK6cRsMWMZL1JwL8I
VTKgjD/U5P1dVy+1Xr2CEueu5IUCtquSoAuJ0bRBQtm7FITta8Utl0X+ReMSgzOO
E5sAamHsw51Qe9petGblNCp6zRHcXYxMtDl7saTargRa7o4F7E2xtjDeTaqMmP0p
vtNb40BxjHu1Pbrm0USxB+p4cgdA+uUvvlqaDTI8aTzzty068SM0SVXCz6oOAXin
5051vDtsvEkE1ElcGv6XHTbTv5bOk3Q+qNMa/4QkWIMSHcw8gKdJFmtuNEksktrg
+IlucS/YQiSKckPsQyXpD6lSJbaY+w0PcVbqCyEWe8knuNO37or0SrioXicT2Tc+
pLwnr7UJVvHk5VwsXBgzyJag7Ds4wWpgdYJvAU6mUTs5qW4xg38/xOKvKwO5aeQs
ygp8+k/GoRKY9GZgxhCC
=r8sE
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
