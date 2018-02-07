From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 10/16] mmc: tmio: remove TMIO_MMC_WRPROTECT_DISABLE
Date: Wed, 7 Feb 2018 20:31:55 +0100
Message-ID: <20180207193155.42phpprycb3nx3nv@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-11-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ifrazsdmgitbusor"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-11-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--ifrazsdmgitbusor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:10AM +0900, Masahiro Yamada wrote:
> The use of this flag has been replaced with MMC_CAP2_NO_WRITE_PROTECT.
> No platform defines this flag any more.  Remove.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ifrazsdmgitbusor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VCsACgkQFA3kzBSg
KbYp6hAAlxqCwtGDsyOvTHHCdI7ovmAjVOm/kBzKXAF8jHUAAe+Z7W9VSssrbIYx
wssHlpeW1lUHIvhiFINTyZGLKpD4qFOULxUBuQF5yJr369M/KUT8aGaUuaLHUCOs
wmV47rdtusho6Bt+skW9InE3q+0dACD58YHYe6ZRuTeZ65T48DyC+Lm6JPlfqC13
/VwWykk5xBcaLnjCiEkFvYXsQwXJSX/EDdt6ZIst0JehBhuX4X58gkBDBgNeWY/d
BbvH5mRDFWxzQgdj0BojKhDorMXFpraQdreJuX7V6xvtuML3ogfQsUV9ALNaDe2i
40uElQKlE9aDGGnp6FtxppbDmVE74pvuQI4OTUKf4GF+i778IngAZQl6QsQ3f3FW
DZd2DodhnzrAHLHEWjn6sTeJLXuKWIHeC9G6WAJrJULGvo+RSyjGhsO59oSTiC2h
lvtuuy0//noRrlh8Jp8/f9Bz4bC5OF1hmKm1TnWRk/ZRMFT1f0p+t2lo6jz6GFkP
LhLzc3d7syx8mdydAJV1IkEiTycYGi7HY6KHb8vAu9LTJcvWVamuOHhLp4w5LAdJ
D06hfC1PkXy4YT4yc13+WpXqCV6zEq8nH/nLwNjxnPn7974uIHU3+6h9AQHZN0sB
npiVbIz/iMQU+Fd6Qt12mg6A/YMK0qEKAhvnBm61UHPJGUUwdzw=
=7HNv
-----END PGP SIGNATURE-----

--ifrazsdmgitbusor--
