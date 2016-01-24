From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH RFC 15/15] ARM: dts: sun9i: cubieboard4: Enable hardware
 reset and HS-DDR for eMMC
Date: Sun, 24 Jan 2016 17:59:37 +0100
Message-ID: <20160124165937.GF7908@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-16-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40666 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754648AbcAXQ7i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2016 11:59:38 -0500
Content-Disposition: inline
In-Reply-To: <1453354002-28366-16-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 01:26:42PM +0800, Chen-Yu Tsai wrote:
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

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpQL5AAoJEBx+YmzsjxAg3KIP/Ahlqse4VRf/uSmcb+9bVvnK
q33rKzlw+PB73jt1LwpsXr41zF7sjfXD0xrjQICcXUeppdlk6LPOHsWxwx1KQNcC
FTdCqNYBXj6ZOXKTYw58tJ/bLZCkXZKojsO4w5OY6pGpfA2Qn19TQfdjqE13hfCH
HcksC9jEl8lA2P/F6zp5pZDnv72bHrfkw3cWUoy8SXV7DvuvdRYmMX9QYFulbGWw
j/A+vSX2Bl3fLlSpTLJ/tF5vDUszqD4aPfnkPNKx0sR+3ptdVx4sRvLgk6bFzYtL
xeBcM2zt3tc7VVsrwTGlO8bZf3ZcnJ9IToRNSXCmNCz2/RBLv83672ce5QfCDpvv
qra/UEgleIpIFG9JVnhIaWeyV5qpXyEyyufV7qs2YviZCk1s+uWzohMy79BjrQi6
yXcD8/Z6OHnL8In4UyQgJxqPY/vDOw1VtjFXtsnfKAaLZjfiXkcYBeRd8X3+Xi2L
s+dmw6bYwguQELJTCe1Sy0Npv4YzhZqxW22DzPty3hY0cwfKTFfpEk7+PDmZep/J
JXEsZ0G7AMb7kNCM2s9ONwH32c+2wgIM/wnMvuuBd+U2ZQHYdcyfbkG+GMY9V4kA
HAcickGxvXzyB8D8VzLsuXfXTDCUR1GCaPGjJ48ILG3XmYFQ5TqbZ3S1xFJXmH6J
hFtsrkNRxEo0dM9e54we
=gdvL
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
