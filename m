From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 20/22] mmc: tmio: move clk_enable/disable out of
 tmio_mmc_host_probe()
Date: Tue, 16 Jan 2018 23:42:48 +0100
Message-ID: <20180116224248.6ywmgcxpe5luykws@tetsubishi>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-21-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d5o6ckdt6porjxbf"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-21-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--d5o6ckdt6porjxbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:55AM +0900, Masahiro Yamada wrote:
> The clock is enabled in the tmio_mmc_host_probe().  It also prevents
> drivers from performing platform-specific settings before mmc_add_host()
> because the register access generally requires a clock.
>=20
> Enable/disable the clock in drivers' probe/remove.  Also, I passed
> tmio_mmc_data to tmio_mmc_host_alloc() because renesas_sdhi_clk_enable()
> needs it to get the private data from tmio_mmc_host.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--d5o6ckdt6porjxbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpef98ACgkQFA3kzBSg
KbZlQA//UOGijpKwM3o7ffnF2WlXgvOvMXvJpASzzsZS/T1D2heveBDhff45/0Od
NILrTozdr69E15F94nFoF8N4UPVnAX2jGqvMpCcay2S/Jb0SZhwT/GUT3f0I1Z7f
PgxO8wJwQwwRzMk9AYMRzWGb0GCS2aU4o/ucxLatYxIN+4byAn4MwDyTdfdoCdgJ
TX+Mr6X4k+CpIMxQeXp8PzXJC2/MLXEBLRsN5DYYQ+fLIEQ8HXCuxy+mz7xGjiOt
E9+4x/Bzapkb3K2WHFdgwS6pzuQBpYDl+hZO3imkpTIzMsDZa9b4IUaNHBJZ4qSa
LnfaIujvSY+3YWaPSq942io3+qO0+ddiUzv8GKlgvMRVcDm1cyl3neF03ekR+H8J
6LY54lwDmCqT/2TVIvh8MdZUUV+ZobiVSSDisA4z2yGj+ME+Q0mY73Sah0sQrSbf
tShC8Kg/E50YOE0+Daqm1TDlpfskroct0nrEI/EhwouCDpNnUDc5OlkuaJV22LfX
zFaWWLu2lSweU7MqWlHFBoUOsPgom1U/5Owpd4yIz0pBeOO5ih4zObx3oABJk1MN
wWxsp8pNnLZmktA2wyw0YwUUg33o1c+QVckUYvsKzTNl+PwOGE9qWBhYDSRzy/H9
19yPsaUJUny9Xo/D0yhg/rP6afdJHqEzKf4zr70OVMXuUhRX8uM=
=oJJq
-----END PGP SIGNATURE-----

--d5o6ckdt6porjxbf--
