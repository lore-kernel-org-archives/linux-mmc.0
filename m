From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: sunxi mmc on A10 / A13 does not have a sample clock, cannot do
 ddr ?
Date: Tue, 5 Jul 2016 10:29:22 +0200
Message-ID: <20160705082922.GJ7643@lukather>
References: <de974dc5-2192-a87f-d727-a8e9e9f4b079@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37688 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753425AbcGEI3X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2016 04:29:23 -0400
Content-Disposition: inline
In-Reply-To: <de974dc5-2192-a87f-d727-a8e9e9f4b079@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 03, 2016 at 05:20:43PM +0200, Hans de Goede wrote:
> Hi Chen-Yu,
>=20
> While working on some dts cleanups I tested
> the latest sunxi-next kernel code on my A13
> Utoo P66 tablet and the emmc no longer works.
>=20
> The kernel tries to enable DDR52 mode on it,
> since it apparently can do that and after that
> the kernel can no longer talk to it.
>=20
> Removing MMC_CAP_1_8V_DDR from sunxi-mmc.c
> fixes this.
>=20
> Part of the problem likely is that it seems
> that the mmc clock on sun4i / sun5i do
> not have sample / output phase clks.
>=20
> It does not matter what one writes to
> 0x1c20088 / 0x1c20090, bits 8-10 and
> 20-22 are always 0.
>=20
> I've observed this on both sun4i and sun5i,
> and the sun4i / sun5i datasheets
> also do not mention the phase bits
> for register 0x1c20088 / 0x1c20090.
>=20
> As such I'm thinking that the best way to fix
> this is:
>=20
> 1) In sunxi-mmc.c make the sample clocks
> optional; and if not present then do not
> set MMC_CAP_1_8V_DDR (and do not try to
> set sample clks)
>=20
> 2) Remove the sample clks from the base
> sun4i / sun5i dtsi files

That looks like the right approach to me.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe2/hAAoJEBx+YmzsjxAgKLMP/2684d1wqdVyPtQxGSJp9Xb6
y/DqU6oaak24saDD6C6cgaMtEHBBhKi511zYzTPVRl0LJMZcVbn7cvzTIUSHgoA4
nxmcX5BFfvQTkcvOJJe/fgYyfdoAcFnu63iUO7qsxRX+HB63IrESu/9ngHuR4tTW
k1R8znkTTLEyg31si1cYwlc4ustESW/P8k6McUwL6zVkqsPLxx1eB6XB0AXO3qGv
8zXgoH18e7w/7Tw4j5LULu7VrkmyO/qjxWUjdK+M0ciM8XBhlTFJULy9NeCda3xT
aGMC+0fG6mFRPh5Us6nXnRmIKurjMyOxBjD765Sq3HQeMp6DZH5y21KwVkloktij
hn0YeYxt+OlkaomSuqbAiOtILihVRq+IZSrEGHU/LZcV6rijDaRAYrUa5mx6nXs8
v7AFF4SKC+1wp0Rt+inQMcUCyCq+brTaNQtoUNs415yzq9zsKHrxdSzx6T2QprLO
WV4oXyB+6P6Nas41fb3TvrTZ6RclKoifWsPwudIHPzECWcCel7cr8xO1k1JxMONM
pbgqmvAs27OFeQgKIr3fd1/I9XwKMdvEUiIavLC+8FCNjf3rSlD/U9Ta/trbIwqP
JI1DnhLMzn3cmeTUrgaBG+XeR3XJhBN0w9cEBwX9bTt4C597MzrJV8Xvw8/Mtxyw
Ku5U1RgTyX0bbSM+Tkvm
=sG6k
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
