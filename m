From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Mon, 27 Sep 2010 16:15:49 +0200
Message-ID: <20100927141549.GI2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <20100927103722.GC2664@pengutronix.de>
 <4CA094D7.7070101@st.com>
 <4CA09AF2.2030809@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38840 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab0I0OPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 10:15:49 -0400
Content-Disposition: inline
In-Reply-To: <4CA09AF2.2030809@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 03:24:02PM +0200, Peppe CAVALLARO wrote:
> On 09/27/2010 02:57 PM, Peppe CAVALLARO wrote:
> > On 09/27/2010 12:37 PM, Wolfram Sang wrote:
> >  > On Thu, Sep 23, 2010 at 11:14:24AM +0200, Giuseppe CAVALLARO wrote:
> >  >> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> >  >
> >  > I'd prefer it the way sdhci-mv.c is doing it (just one #if-block and
> >  > returning the code from the sdhci_*-functions). Then it should be fi=
ne.
> >=20
> > Okay! I can rework it without any problems.
>=20
> Hi Wolfram
> attached the new patch:
> Let me know if it's ok.

Better, but you still do not return the retval from the sdhci-functions.
And please annotate the #endif with the define it depends on as a
comment. And wait for more comments and respin the series as a whole,
not every patch independently. That soon gets a mess.

> From 847f635d0824c88f6575d86f5e9f50283883cd60 Mon Sep 17 00:00:00 2001
> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Date: Thu, 23 Sep 2010 10:13:00 +0200
> Subject: [PATCH (mmc-next)] mmc: add suspend/resume in the sdhci-pltfm dr=
iver (V2)
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e045e3c..c43f954 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -165,6 +165,27 @@ static const struct platform_device_id sdhci_pltfm_i=
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
> +#else
> +#define sdhci_pltfm_suspend	NULL
> +#define sdhci_pltfm_resume	NULL
> +#endif
> +
>  static struct platform_driver sdhci_pltfm_driver =3D {
>  	.driver =3D {
>  		.name	=3D "sdhci",
> @@ -173,6 +194,8 @@ static struct platform_driver sdhci_pltfm_driver =3D {
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

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygpxUACgkQD27XaX1/VRvCGgCdHp3TPwB9LxzjKvGT4D4twvgs
/ukAn3oVhIFKpWcZ9klFHYq3/6sssiJL
=0SoW
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
