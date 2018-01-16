From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 21/22] mmc: tmio: move {tmio_}mmc_of_parse() to
 tmio_mmc_host_alloc()
Date: Tue, 16 Jan 2018 23:42:55 +0100
Message-ID: <20180116224255.sf6bm53qk54cr4gq@tetsubishi>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-22-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ke3noqytirshwmf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-22-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--6ke3noqytirshwmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:56AM +0900, Masahiro Yamada wrote:
> mmc_of_parse() parses various DT properties and sets capability flags
> accordingly.  However, drivers have no chance to run platform init
> code depending on such flags because mmc_of_parse() is called from
> tmio_mmc_host_probe().
>=20
> Move mmc_of_parse() to tmio_mmc_host_alloc() so that drivers can
> handle capabilities before mmc_add_host().  Move tmio_mmc_of_parse()
> likewise.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6ke3noqytirshwmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpef+4ACgkQFA3kzBSg
KbbzrQ/8D2TegEVVDZUhqrLZ/FKoBy2RhzgaWqhLwa1rGe4Bm2YS2gcRJdbBCMmA
MJ9SrJeWkBYzbBGeNyFju/XTKswCFpz7ngpyAteHiz6iwLdjH8IPIPj6bjWd68n6
YzFdWte9r4u7vxVE7aOYshjCH631i0h98Xz+Ihl5uFy9GubdHpb3yZfcF7rjMDeu
G03BTNBsuo8CKttawttaPMd/RmeYSdo3COtzE/sJekFoc+DfcTacSRONKV9Ch1Ws
dEvGsI33wRy6TZqCWiU+c5YvLMIXUuBU1TRpl66UARqmnVr6n46GNC0vFtQr+VQL
Hv3qGfnFt26HpP5Tz0pp9X0jDI8b0AZwwweSHv2fzPlBM3S4bKkXxZBre6PXvaUM
jOKV3aeXsPxmS6+AyoFLfkgGeGrhnl05sZmCirYjRXkjCi/xlGWuFEiGVgih0b8W
pSZAcwzk7brkfD2Bv5BBDhjOX5EYaSrvtvHPPIEI7tV8Lm0E6EXi/117mdrWzitR
vpjS57qpEPiFk23oiUHuVGUAAS71FDOPxw7Lw2QdJrYV7AyFddD5YJJFEzlxsfhg
h2jJoyek3a5elng/gi6Yyft73vcOfSR0D03NEv/pHMlz5hnJv1nLgQSYO4pM//Dc
meaKCq479+PBom2aVJOb3zJwLVAHjBSKZlg/MlOY+nEC2rDhTF0=
=BzsU
-----END PGP SIGNATURE-----

--6ke3noqytirshwmf--
