From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/2] mmc: tmio: remove confusing
 TMIO_MMC_HAVE_HIGH_REG flag
Date: Mon, 15 Oct 2018 00:30:12 +0200
Message-ID: <20181014223011.GD3260@kunai>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 12:51:30PM +0900, Masahiro Yamada wrote:
> CTL_SDIO_REGS is a register specific to tmio_mmc.c
>=20
> Currently, we handle it in tmio_mmc_core.c, hence need
> TMIO_MMC_HAVE_HIGH_REG flag to prevent the other platforms
> from accessing to it.
>=20
> We can just move CTL_SDIO_REGS to tmio_mmc.c
> and delete the confusing TMIO_MMC_HAVE_HIGH_REG flag.

Looks good, thanks! Ulf, please give me Monday to test the changes on
some more devices...


--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDw3MACgkQFA3kzBSg
KbZLfQ/5Af4/pUZqW/1cDPQlI5MGOgP5r7qOdRItI0JWBkRYEJbxo/3RJDRCki78
CA9tiz0wUQoWYOrNrgQcPXb7wX68ph8yu7v9upuEZiY6/u8t1k/ez2aSIrZ4nY8g
s0ePf8txDjTYDYfsMaUsm1G8OvuH1TnCp/NOkBo+FxUtxwCq4vpBQzi0mfYyq0hs
B8gwzuR8Q8oqCpmttvlnfgW08Odo6UNGNgGLcKSL1I21GtGAawuFDChzkJALKdi2
WUnaMRaULXFMhvdv7UzxzAcd8ES6HaPKWUlXw6LEnvLWMtM7XYDLSC4ev8mERSAu
Yd4VxNw8D8QdSbiHsbR5TAFhYB5MTwwVIVrNrNurZyom0ftBE8+s0nZ8v4HFGixS
r6qYNCvQvRyArsLwmZ2eMthEw7DR6d73aDlKm/4gROwbuuKXlR3kwZU9jqCrS+/6
dIZUapbH0r8xfQaYqFZrGPhYfWKjr8i2sEzcLzU0IWMT+75E03w9UOkMLJgfHonX
3kA15Mkuqii+D3CmT7d/mvxRZSSwiYjQMzZEbGYlNzn2aoU7PLjGeEjkMY6bvNDI
KNRGu1eEltAdQHltfGeMLUJwN7NEPRWhFv2Alv9/nvQmzfY6bwucum6rbBP0AGOr
H2lvrrdf9AZQJvl4jZUXAThOwSCzVOJ6qjr9Ns0Wp7ujfuwl6x0=
=XJV3
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
