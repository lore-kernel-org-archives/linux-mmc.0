From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
Date: Mon, 28 May 2018 08:50:43 +0200
Message-ID: <20180528065043.yewyrrat2eqlm2sa@flea>
References: <20180525210752.1794502-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jops65ydd4glphpe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525210752.1794502-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--jops65ydd4glphpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 11:07:42PM +0200, Arnd Bergmann wrote:
> The newly added runtime-pm functions cause a harmless warning
> when CONFIG_PM is disabled:
>=20
> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' =
defined but not used [-Werror=3Dunused-function]
>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' d=
efined but not used [-Werror=3Dunused-function]
>  static int sunxi_mmc_runtime_resume(struct device *dev)
>=20
> This marks them as __maybe_unused to shut up the warning.
>=20
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jops65ydd4glphpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsLprIACgkQ0rTAlCFN
r3Sk4g/4ztmk2MGwc/nBZIQCIaoS0xaVrifTM4UPyYUg0uG7leJ9mB9O1bgazsxd
ROUGsyRZ1i1Syrl5QkIpWTQNZ+y6vced1s2/cGFaRuIohuiU/ouyfYV9U/qdXWJk
lrMb1yGajD9klfmh1xhChOWZlqhd/7Z3IYt49Fc/B2A6QqcVB6aiUKYR2kd5ZUjc
Sw+nZrUBUzZScfiTxOUr95M0MuO+EqJA1ayA080BvrboZD8k0svq+wLXx5W42QYA
c0ayrBZRp+LwwtjuwkLkaCHVFEqh9Qda1ACXG2GohFFFo5xb6bps9yEOwaDo+EjU
NkzjgHA0i0Gj8+gUVv9qWKmHM8D5yKOynSfP/LzVjC5ToXSCX3AcTc3ZPFVa8gpm
PC6w/1Rm1hwrVHbYzzEM/a2bNGDAFhH7HAFgSrLfpsWPwnk8i6sj2ZfcZhIoNWrK
8ElCCGosmGK//2cAGJvnqX6Dl9onu0aho+RBDEdEXThwYPaQAOOPlwTV0WZmxp9e
u8/hCjV0kJtIYAtlId6GYrhpLymwtnjCzJRwInLDT+7HE1XS/XIWbwj0Hr9aJ6NF
hbNcEkQTH8+GRkEMLMYc/HnK4gMaD6Mt6bp+e7q/M4AwBKOttOp400noHbLUVsFy
AR0Yprwkq4zcb/WpqiMep6wUU5AkeosK5XcgTUxc5r9V6Htn2w==
=bNNd
-----END PGP SIGNATURE-----

--jops65ydd4glphpe--
