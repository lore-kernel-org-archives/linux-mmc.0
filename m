From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 1/7] mmc: omap_hsmmc: use devm_regulator API
Date: Thu, 9 Jan 2014 09:18:44 -0600
Message-ID: <20140109151844.GB2417@saruman.home>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-2-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41265 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaAIPTy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jan 2014 10:19:54 -0500
Content-Disposition: inline
In-Reply-To: <1389279062-32291-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com, mark.rutland@arm.com

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 09, 2014 at 08:20:56PM +0530, Balaji T K wrote:
> Use devm_regulator API, while at it use
> devm_regulator_get_optional for optional vmmc_aux supply
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..1eb4350 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host =
*host)
>  	struct regulator *reg;
>  	int ocr_value =3D 0;
> =20
> -	reg =3D regulator_get(host->dev, "vmmc");
> +	reg =3D devm_regulator_get(host->dev, "vmmc");
>  	if (IS_ERR(reg)) {
>  		dev_err(host->dev, "vmmc regulator missing\n");
>  		return PTR_ERR(reg);
> @@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host =
*host)
>  		}
> =20
>  		/* Allow an aux regulator */
> -		reg =3D regulator_get(host->dev, "vmmc_aux");
> +		reg =3D devm_regulator_get_optional(host->dev, "vmmc_aux");
>  		host->vcc_aux =3D IS_ERR(reg) ? NULL : reg;
> =20
>  		/* For eMMC do not power off when not in sleep state */
> @@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host =
*host)
> =20
>  static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)

since this function does nothing now, you could pretty much remove it
and move set_power assignment to ->remove() directly. No strong feelings
though.

--=20
balbi

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzr3UAAoJEIaOsuA1yqREx9MQAIQnh+MUCUUoX01fRIVr+MlT
DNW9f0eIJpMWK3MhASSgGXQlwUxEzU3i9MkaIMU8Z0XZnE+Q45s5g0DDrKUoQbl+
OYd3SoeJ7SfrspqOtJ5y+steNzO8rsVBL3dnBaFuV+jYbR6bKcir+7OiB8gIJAc4
OqqoaDj6XL5XKnY7TOgnzHETW+TrHLcun3EMSZu0TaV2coOvE9yOD4Z/2lnxcftO
zJ9uRV6wn8ymSuJ246v3pHnO0Wg/ucFBn5ZpM6zMNxi5zTzFFvxRBWupoTNZMsv+
H3s6PSiacPukCL3aLsUl83F1gbPljhNesIy4WVmYWgY6AE4jfoPLH4SV6bMwwrlY
yQ0axGpt8KiHK6JGxT4amz2G79a0H3zz/DZatXzb/VwwCVMl/bFu/6ZaioEFEwMP
pHONj7iIuIuUGUVkthdri0zjPF8HNqGgGWaclh+FmtIXaQ1OCLWaT26sQiIajiXy
uHWR5hYQEqPwe6fVdsDAfYaieDc5Mr7OWqj50dFfNqDYuo0eZ4XV9ZPGUj+sb26P
ku2exs6YdVi0KW0+BH7SlSSB6pnojb3z9OZFjJNRvOkFbq1Nz9IWEWNesnKeEpQY
eotO6VbmKe4rJB9aJjyGnW8Lg5Yn6nV3zAXRSE1zZP1rsUiuLtfqEzDTXvwigFBT
RvtfXM3T7KektEV71EtZ
=Yl1l
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
