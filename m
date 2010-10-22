From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Fri, 22 Oct 2010 08:15:37 +0200
Message-ID: <20101022061537.GA5572@pengutronix.de>
References: <4CC0A281.1010202@eukrea.com> <1287696028-27854-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56377 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0JVGPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 02:15:40 -0400
Content-Disposition: inline
In-Reply-To: <1287696028-27854-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2010 at 11:20:27PM +0200, Eric B=E9nard wrote:
> this patch fix timeout problems on i.MX's sdhci as suggested by
> Richard Zhu.
>=20
> Tested on :
> - i.MX257 : not needed
> - i.MX357 : needed
> - i.MX515 : needed
>=20
> more details can be found here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029748=
=2Ehtml
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index afbac9a..11e1ae1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -130,6 +130,12 @@ static int esdhc_pltfm_init(struct sdhci_host *host,=
 struct sdhci_pltfm_data *pd
>  		gpio_request(boarddata->wp_gpio, "SD_WP");
>  		gpio_direction_input(boarddata->wp_gpio);
>  	}
> +
> +	if (cpu_is_mx35() || cpu_is_mx51()) {
> +		dev_info(mmc_dev(host->mmc), "using broken timeout quirk\n");

Please drop this line. The boot log is full enough IMO :)

Other than that:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> +		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 1.7.0.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzBLAkACgkQD27XaX1/VRv/+ACglBMbAb8bJVxtoFrut1KOpkH5
px0An1BqOD+eGELHdCrefB1Dpp6le4Yw
=dEAC
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
