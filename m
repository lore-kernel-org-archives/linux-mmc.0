From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
Date: Mon, 15 Oct 2018 00:28:12 +0200
Message-ID: <20181014222812.GC3260@kunai>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
 <1539143492-32605-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539143492-32605-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 12:51:32PM +0900, Masahiro Yamada wrote:
> TMIO_MMC_HAVE_HIGH_REG is confusing due to its counter-intuitive name.
>=20
> All the TMIO MMC variants (TMIO MMC, Renesas SDHI, UniPhier SD) actually
> have high registers. It is just that each of them implements its own
> registers there. The original IP from Panasonic only defines registers
> 0x00-0xff in the bus_shift=3D1 review. The register area above them is
> platform-dependent.
>=20
> In fact, TMIO_MMC_HAVE_HIGH_REG is set only by tmio-mmc.c and used to
> test the accessibility of CTL_SDIO_REGS. Because it is specific to
> the TMIO MFD variant, the right thing to do is to move such registers
> to tmio_mmc.c and delete the TMIO_MMC_HAVE_HIGH_REG flag.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDwvsACgkQFA3kzBSg
Kbay1A/+On/wewSBWptZO6Mw0kGifN4qaygGNAXiH0OW51Ep9ac+jqqAkwCmvBT2
66YruBNec5gVTbJ3M/OKzDIaw+gFjCd4U9X3Ygg6i+GxX0YR45DXLmyiYM+QMtWf
Zj4BCSWi11nj2ROwGaLKhcQKpCOkRvh93XeaVdkIDUPNWIlb5lkE3qEw1pOEXddl
MkfJL80GPMCoFU1kRSZ1AFhhxKxcKO8OJggk9iBp2B62ICDlm6wL1HbtaXv64nHm
DIVJu/KXijJ7ggo0tEywxonqdWVa00v7LyLWSg4EZL/wL1r/fG/e3/idlNKGF0ui
XyVu7b4uCr6jQSQO37qK9MZyVnvQ/4JYxHVuPOE4344lGgx+29CMI4fDGUnE6qM3
pPALSfuxUcC67WVLLeNANPnc7czf6nZOoWbDhlg1/WaDw8d1cR5hwoF2lvSmc3Ah
z2GMzr/MCcxNVb0XCi5Vkeg5jirx0TeVI/ZKVuMQ8uzRnXF9WBrFvPM5JY4Egnpz
nOWkXpbX0k4Bxppxodv6zS+uhR+aGBpOy1/6zg2hZYRbbhG6c19O8IH50xfTEblI
DIy2xnr0HhvtMoCuGPgvqyQAoZlHxvI51uJcA2dXri70wXdmPYbk8JsBCCM+eSYG
P1XDhhCHQ/mc7slHlZ/rzr4vyf3zQFxopk7gJlybeCKy1g5Ebc0=
=biCc
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
