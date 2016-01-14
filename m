From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 13:07:06 +0100
Message-ID: <20160114120706.GA12774@earth>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452762920-2588-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pali.rohar@gmail.com, pavel@ucw.cz, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 14, 2016 at 02:45:20PM +0530, Kishon Vijay Abraham I wrote:
> Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
> have PBIAS regulator) in order for MMC1 to work.
>=20
> Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
> using a olddefconfig or a custom .config.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7fb0753..7086bd6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host=
 *host)
>  	host->pbias =3D devm_regulator_get_optional(host->dev, "pbias");
>  	if (IS_ERR(host->pbias)) {
>  		ret =3D PTR_ERR(host->pbias);
> -		if ((ret !=3D -ENODEV) && host->dev->of_node)
> +		if ((ret !=3D -ENODEV) && host->dev->of_node) {
> +			dev_err(host->dev,
> +			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
>  			return ret;
> +		}
>  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
>  			PTR_ERR(host->pbias));
>  		host->pbias =3D NULL;


Is there a good reason against adding "depends on REGULATOR_PBIAS"
to MMC_OMAP_HS? I guess it's required for most systems and the regulator
driver is just 250 loc. I am aware, that this will disable the
hsmmc driver for 'make oldconfig', but I guess that will be noticed
in a similar way your warning is noticed.

The advantage of having the depends line is, that people configuring
their kernel have a chance to notice the regulator requirement
during configuration.

Anyways, this message improves the situation, so:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWl49nAAoJENju1/PIO/qak80P/1NVhcVdD38xMzcDzNog1jTS
BMLy4D1EMOc27c63cE+46hc1S/9B3jJs8sjvOc4C4WIM1OBTWFvgVWB9FKQGeHbR
5RJIZCXQu14SKD0zm1E98txXpRciGaRTx+F/2IXSGJZoJWJWmKjs4F7FRhLFsuXT
ZFxJGLy2n1ZVs0w7EuQyHKayImvnDtngJrt32JcBqSrJb8O4GLCdpmHi9xrZbDW+
fqC6TqSps/uka/tTeBD+8PwS4lIbulNHP1XM6LG+8mx0tIBv7imzDlBgZpaB7BTJ
2f5Xifu+AIjoXv66QzA36bkQydsJU3txQZplxBu3YkJWqL+IMBPXFKjnd4ZPTqV7
Ng+AhHO+Zsu00c/JSfWrn+qqGcLyWotT2TXeJLItod7Og0y/d87PjjXqaeBoXjNl
0wrC6iWSEKj34lPRVZ/iOk/FI3mfxREWUFzuevOWcW+HYtDpjFcebrrJtL5J6VVi
ZWM1Gx2fS/cYKD9+MUVe3L4Fn4EP52N3p0HmD1CcTDsZVFu2oYWnWY/TjZ+0wBRz
TpTOXmiMRIdWanOGwCXyFntaiZOHGCzY1q+b8jElGOO3yDs4nw0+3TKrwY34BWTB
vjDxNzEOory0fvYgyUVLoH/QApr9Cc667uBp6s/7tSmFc0HH4TRAfCHmnSqRcW4C
lWuWHWZs84BLYk1yedDo
=e01X
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
