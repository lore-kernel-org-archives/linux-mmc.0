From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only
	for i.MX25 and i.MX35
Date: Fri, 22 Oct 2010 08:18:03 +0200
Message-ID: <20101022061803.GB5572@pengutronix.de>
References: <4CC0A281.1010202@eukrea.com> <1287696028-27854-2-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab0JVGSE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 02:18:04 -0400
Content-Disposition: inline
In-Reply-To: <1287696028-27854-2-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2010 at 11:20:28PM +0200, Eric B=E9nard wrote:
> only these CPU's errata list this bug.

So, it was not directly tested?

>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 11e1ae1..4d67f58 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -136,6 +136,12 @@ static int esdhc_pltfm_init(struct sdhci_host *host,=
 struct sdhci_pltfm_data *pd
>  		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  	}
> =20
> +	/* fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
> +	if (cpu_is_mx25() || cpu_is_mx35()) {
> +		dev_info(mmc_dev(host->mmc), "using ENGcm07207 workaround\n");

Same here, no printout please (or do you see a reason for it?)

> +		host->quirks |=3D SDHCI_QUIRK_NO_MULTIBLOCK;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -162,10 +168,8 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
>  };
> =20
>  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
> -	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
> -			| SDHCI_QUIRK_BROKEN_ADMA,
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
>  	/* ADMA has issues. Might be fixable */
> -	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
>  	.ops =3D &sdhci_esdhc_ops,
>  	.init =3D esdhc_pltfm_init,
>  	.exit =3D esdhc_pltfm_exit,

Other than that, looks good. Thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzBLJsACgkQD27XaX1/VRuVigCfQTJBm/S3BHyJbSEqVhh+p13T
AJYAnigWFiFde3kb9O9em8v7tZbcra8p
=CmLG
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
