From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Sat, 21 Jan 2017 10:37:14 +0100
Message-ID: <20170121093714.GB1440@katana>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
 <20170121030604.7672-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170121030604.7672-2-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 10:06:02PM -0500, Chris Brandt wrote:
> Some controllers have 2 clock sources instead of 1. The 2nd clock
> is for the internal card detect logic and must be enabled/disabled
> along with the main core clock for proper operation.
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgyvKAAoJEBQN5MwUoCm2bQQP/3RJ25QxzpNnb8NhjfkZgy8y
hp/y2QbVaWZyFj0DDR9xO3hegNCVVWuiPlUBOFp5Jy+z8jCSC5tVzZfayHQNCdxZ
/3nDCO1xkS9KG3Hdov3swkQvfxGL/KwWmZ37jj7yxLv5sGtQgHTWP5HzEAoDDHsO
Vt6wSIw5/7xcE0ELA2jMDmD8qFO9W4O01zl16ij8rmrO08X3dZVdlhjWnyoOlMsx
Mp3s18Mb4KLyWf++Zh+gck99Q34x5ZOBKNejkXLLim70xRW/io4x0BHeIVkmfh+s
FYWOXUD9M7wZ4113uMZVe/UFZluGWQ5K59UBpBXvjCB6UPWGGToJw85QSEIPwS/r
K8jzxVB6rIP4iVH7sHrjKbbmJb3+CCHqGBqFxkSmKEwHCY2emP/iiw8GPsi4TU6v
QtDnbeN/C5vIR7FtUS0+X3kyLYEnRG/uC34Td6G3Cfii/h4EBQ6HiUObX/crt3yb
4Y4V4y4vdNe0Uz236TlSOdowCxnOIMMTn2v+e+mjlP9zHpmCCsTPcBDu44iEFhGt
xxM4OZeeMRjyM3gagYaMm5z3O3zDDypZiqe9PFk6j1gd/HSclTnoLblIabr2zmlm
MEJaPfCmujCivWT9n32SmThsnEg1MwulBqWiK1ya0gPuIpTfg/sVY6pvz25C9aex
JRIEc48y4lw5Yjux7IS8
=Rwmc
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
