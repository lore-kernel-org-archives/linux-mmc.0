From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver (V3)
Date: Tue, 28 Sep 2010 13:08:59 +0200
Message-ID: <20100928110859.GD4441@pengutronix.de>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab0I1LJA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:09:00 -0400
Content-Disposition: inline
In-Reply-To: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 10:41:27AM +0200, Giuseppe CAVALLARO wrote:
> This patch adds the suspend and resume functions
> in the sdhci-pltfm device driver.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/mmc/host/sdhci-pltfm.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e045e3c..4f126de 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -165,6 +165,25 @@ static const struct platform_device_id sdhci_pltfm_i=
ds[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> =20
> +#ifdef CONFIG_PM
> +static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t=
 state)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	return sdhci_suspend_host(host, state);
> +}
> +
> +static int sdhci_pltfm_resume(struct platform_device *dev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +
> +	return sdhci_resume_host(host);
> +}
> +#else
> +#define sdhci_pltfm_suspend	NULL
> +#define sdhci_pltfm_resume	NULL
> +#endif	/* CONFIG_PM */
> +
>  static struct platform_driver sdhci_pltfm_driver =3D {
>  	.driver =3D {
>  		.name	=3D "sdhci",
> @@ -173,6 +192,8 @@ static struct platform_driver sdhci_pltfm_driver =3D {
>  	.probe		=3D sdhci_pltfm_probe,
>  	.remove		=3D __devexit_p(sdhci_pltfm_remove),
>  	.id_table	=3D sdhci_pltfm_ids,
> +	.suspend	=3D sdhci_pltfm_suspend,
> +	.resume		=3D sdhci_pltfm_resume,
>  };
> =20
>  /***********************************************************************=
******\
> --=20
> 1.5.5.6
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyhzMsACgkQD27XaX1/VRsl8ACgjyuh8+0LtQzIATIMId31hmfO
OSUAn34xbcr4Of2upMSw/uAFUYjrLtZG
=iQzv
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
