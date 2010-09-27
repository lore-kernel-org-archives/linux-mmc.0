From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Mon, 27 Sep 2010 12:37:22 +0200
Message-ID: <20100927103722.GC2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51144 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0I0KhY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 06:37:24 -0400
Content-Disposition: inline
In-Reply-To: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 11:14:24AM +0200, Giuseppe CAVALLARO wrote:
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

I'd prefer it the way sdhci-mv.c is doing it (just one #if-block and
returning the code from the sdhci_*-functions). Then it should be fine.

> ---
>  drivers/mmc/host/sdhci-pltfm.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e045e3c..89ea64b 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -165,6 +165,24 @@ static const struct platform_device_id sdhci_pltfm_i=
ds[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> =20
> +#ifdef CONFIG_PM
> +static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t=
 pm)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	sdhci_suspend_host(host, pm);
> +	return 0;
> +}
> +
> +static int sdhci_pltfm_resume(struct platform_device *dev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	sdhci_resume_host(host);
> +	return 0;
> +}
> +#endif
> +
>  static struct platform_driver sdhci_pltfm_driver =3D {
>  	.driver =3D {
>  		.name	=3D "sdhci",
> @@ -173,6 +191,10 @@ static struct platform_driver sdhci_pltfm_driver =3D=
 {
>  	.probe		=3D sdhci_pltfm_probe,
>  	.remove		=3D __devexit_p(sdhci_pltfm_remove),
>  	.id_table	=3D sdhci_pltfm_ids,
> +#ifdef CONFIG_PM
> +	.suspend =3D sdhci_pltfm_suspend,
> +	.resume =3D sdhci_pltfm_resume,
> +#endif
>  };
> =20
>  /***********************************************************************=
******\
> --=20
> 1.5.5.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygc+IACgkQD27XaX1/VRu6zACgqOEeXJBch5nPiZda9o1D5XpM
MMUAn2w6mRPykr4uFD+NSqhuPGTSKcIk
=FGbl
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
