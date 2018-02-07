From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 12/16] mmc: tmio: support IP-builtin card detection
 logic
Date: Wed, 7 Feb 2018 20:34:59 +0100
Message-ID: <20180207193459.tsmci752idkayjxd@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-13-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4m25o3xbgccrgxf4"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-13-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--4m25o3xbgccrgxf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:12AM +0900, Masahiro Yamada wrote:
> A card detect GPIO is set up only for platforms with "cd-gpios"
> DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
> core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
> if ctx->cd_gpio is unset.
>=20
> The bit 5 of the status register provides the current signal level
> of the CD line.  Allow to use it if the GPIO is unused.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> @@ -1095,7 +1103,7 @@ static const struct mmc_host_ops tmio_mmc_ops =3D {

I just wonder why the diff-tool puts 'const' in the definition. There is
no const in my version here. And there shouldn't be because we modify
the struct in this patch.


--4m25o3xbgccrgxf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VOMACgkQFA3kzBSg
KbZGqQ/8DthXTG6l97SKntYj+pv4dvj8FsQzt8GO2RAxBDJlUkNUEWpy0H/udeHl
hDOuk9DMB2yRyRlP+AsZztgSSIC7hpILa3WdpeAo+WSUDhXbiv942861NOPNR2J4
ctsRJBT2eoeF/G+LsUd1G3Hxgb933TV0rZMJM1rRsBB/Py8pSRVJayPxWPLc1gNZ
elAEIEYUnDFbr9XEooz6MzRi8hR3ZLnlDpngQfQZPeuojANbp7oHHXWKOJgQxAIq
PafXaan5v1iHmCnNIDUZYEqlhAM0B2I/ZNWsHya6Mss4oUMVqg+Jyw9N0j/hfZuI
lGw4BAFm2dKplVkJNwD4OLoL28H1K+tgAorCnIpxbCxyMBgS3Y5d8fUimNz22hpj
l7yM5jfJyGsYocBRCfMVikNM4FC6qCEQBU5mjTIOCr5XvwX2hoZ7nw97eBhdNfEN
4D+Ge/1SFKz72eKp+pcEbBCHQE3i87ptE5/OpixNL2abk2N3oQLM6gwqUoApz4zx
QYci702qoREBOsohMAfqFJ9ObLGeL2h7cBNxt7NvQJMk4KPB9Amly/nRGGlckLP8
yX0g7ZNhq3YcGJcGypTIwYFx55q5faYi/0CV7Ss2anE7w5/S+/AzMjiJHe+WPcyi
YXEJ8LZwfYFNTt8OJFLuNYtey45WUGRu1jvx/NqvsYi+CHWUwFA=
=M3qF
-----END PGP SIGNATURE-----

--4m25o3xbgccrgxf4--
