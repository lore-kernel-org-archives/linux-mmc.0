From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2]sdhci-pltfm add sdhci-pxa
Date: Sun, 26 Sep 2010 18:13:23 +0200
Message-ID: <20100926161323.GB23180@pengutronix.de>
References: <AANLkTin357VumrfSTaYPJD0fodOvz+YdXSqFYuCu_XxJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44806 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab0IZQNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 12:13:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin357VumrfSTaYPJD0fodOvz+YdXSqFYuCu_XxJ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2010 at 06:53:59AM -0400, zhangfei gao wrote:
> From 29b0255431e3d635ae32214b223daef823433885 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 26 Sep 2010 18:32:27 -0400
> Subject: [PATCH 1/2] sdhci-pltfm: add sdhci-pxa
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>

Should be merged into the other patch IMHO.

> ---
>  drivers/mmc/host/sdhci-pltfm.c |    3 +++
>  drivers/mmc/host/sdhci-pltfm.h |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e06f047..7511fb7 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -173,6 +173,9 @@ static const struct platform_device_id sdhci_pltfm_id=
s[] =3D {
>  #ifdef CONFIG_MMC_SDHCI_CNS3XXX
>  	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
>  #endif
> +#ifdef CONFIG_MMC_SDHCI_PXA
> +	{ "sdhci-pxa", (kernel_ulong_t)&sdhci_pxa_pdata },
> +#endif
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltf=
m.h
> index 900f329..0747f42 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -14,5 +14,6 @@
>  #include <linux/sdhci-pltfm.h>
>=20
>  extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> +extern struct sdhci_pltfm_data sdhci_pxa_pdata;
>=20
>  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --=20
> 1.7.0.4

> From 29b0255431e3d635ae32214b223daef823433885 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 26 Sep 2010 18:32:27 -0400
> Subject: [PATCH 1/2] sdhci-pltfm: add sdhci-pxa
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    3 +++
>  drivers/mmc/host/sdhci-pltfm.h |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e06f047..7511fb7 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -173,6 +173,9 @@ static const struct platform_device_id sdhci_pltfm_id=
s[] =3D {
>  #ifdef CONFIG_MMC_SDHCI_CNS3XXX
>  	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
>  #endif
> +#ifdef CONFIG_MMC_SDHCI_PXA
> +	{ "sdhci-pxa", (kernel_ulong_t)&sdhci_pxa_pdata },
> +#endif
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltf=
m.h
> index 900f329..0747f42 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -14,5 +14,6 @@
>  #include <linux/sdhci-pltfm.h>
> =20
>  extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> +extern struct sdhci_pltfm_data sdhci_pxa_pdata;
> =20
>  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --=20
> 1.7.0.4
>=20


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyfcSMACgkQD27XaX1/VRuZCwCdHeukvqDveByl3u8UMnw3YCd8
isYAoIIqi60FYyyt+1oopLvMyKt/TwoE
=5lt3
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
