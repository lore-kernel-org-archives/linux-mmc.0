From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci-tegra: free irq on error and remove
Date: Mon, 21 Feb 2011 08:21:20 +0100
Message-ID: <20110221072120.GA13424@pengutronix.de>
References: <1297357650-14245-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44283 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab1BUHVW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 02:21:22 -0500
Content-Disposition: inline
In-Reply-To: <1297357650-14245-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2011 at 06:07:30PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>=20
> Found the leak while working on the esdhc-imx driver. Not even compile te=
sted,
> please check.

Olof, do you have a minute for this one?

>=20
>  drivers/mmc/host/sdhci-tegra.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 4823ee9..f7e1f96 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -169,7 +169,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *=
host,
>  		if (rc) {
>  			dev_err(mmc_dev(host->mmc),
>  				"failed to allocate wp gpio\n");
> -			goto out_cd;
> +			goto out_irq;
>  		}
>  		tegra_gpio_enable(plat->wp_gpio);
>  		gpio_direction_input(plat->wp_gpio);
> @@ -195,6 +195,9 @@ out_wp:
>  		gpio_free(plat->wp_gpio);
>  	}
> =20
> +out_irq:
> +	if (gpio_is_valid(plat->cd_gpio))
> +		free_irq(gpio_to_irq(plat->cd_gpio), host);
>  out_cd:
>  	if (gpio_is_valid(plat->cd_gpio)) {
>  		tegra_gpio_disable(plat->cd_gpio);
> @@ -225,6 +228,7 @@ static void tegra_sdhci_pltfm_exit(struct sdhci_host =
*host)
>  	}
> =20
>  	if (gpio_is_valid(plat->cd_gpio)) {
> +		free_irq(gpio_to_irq(plat->cd_gpio), host);
>  		tegra_gpio_disable(plat->cd_gpio);
>  		gpio_free(plat->cd_gpio);
>  	}
> --=20
> 1.7.2.3
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1iEnAACgkQD27XaX1/VRtPYwCbBShgv6P3LZLl+O8fbEjgYdS6
E08AmgM+fkHXNflkpI6C68yzKCFcxMBn
=q84P
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
