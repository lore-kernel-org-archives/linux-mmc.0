From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/5] mmc: sdhci-esdhc: broken card detection is not a
 default quirk
Date: Thu, 10 Feb 2011 20:18:21 +0100
Message-ID: <20110210191821.GD2206@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
 <1297365291-1038-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56978 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab1BJTSZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 14:18:25 -0500
Content-Disposition: inline
In-Reply-To: <1297365291-1038-3-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Adding Anton to Cc...

On Thu, Feb 10, 2011 at 08:14:48PM +0100, Wolfram Sang wrote:
> It can be worked around using a GPIO which will be done for i.MX later.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
>  drivers/mmc/host/sdhci-esdhc.h     |    1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  |    3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 83d178b..e0fa1f3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -170,7 +170,8 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
>  }
> =20
>  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
> -	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
> +			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>  	/* ADMA has issues. Might be fixable */
>  	.ops =3D &sdhci_esdhc_ops,
>  	.init =3D esdhc_pltfm_init,
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdh=
c.h
> index afaf1bc..c55aae8 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -19,7 +19,6 @@
>   */
> =20
>  #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
> -				SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
>  				SDHCI_QUIRK_NO_BUSY_IRQ | \
>  				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
>  				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
> index fcd0e1f..08161f6 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -73,7 +73,8 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci=
_host *host)
>  }
> =20
>  struct sdhci_of_data sdhci_esdhc =3D {
> -	.quirks =3D ESDHC_DEFAULT_QUIRKS,
> +	/* card detection could be handled via GPIO */
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>  	.ops =3D {
>  		.read_l =3D sdhci_be32bs_readl,
>  		.read_w =3D esdhc_readw,
> --=20
> 1.7.2.3
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1UOf0ACgkQD27XaX1/VRuJWgCgiu9b8pJfSrZoOpD6D3O55a+z
hqEAn2R2Ks3eageJhMb5RWgqrHi9p0eV
=Dmnu
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
