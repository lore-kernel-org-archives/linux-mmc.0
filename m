From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch] sdhci-pltfm: add call back function
Date: Sun, 26 Sep 2010 18:09:33 +0200
Message-ID: <20100926160933.GA23180@pengutronix.de>
References: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35710 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0IZQJf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 12:09:35 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Richard Zhu <r65037@freescale.com>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2010 at 04:52:06AM -0400, zhangfei gao wrote:
> Add several call back to sdhci-pltfm.c, help give suggestion

Just formal things, without looking at the code yet.

Make seperate patches out of these, everyone with a proper description.

> 1. struct sdhci_host *(*alloc_host)(struct device *dev), since
> specific driver need some private variable to allocate and free,
> including clk.
> 2. unsigned int  (*get_quirk)(struct sdhci_host *host); add this
> because one driver may serve several device, each one may require
> different quirk, and specific driver is right one to know.
> 3. void (*set_max_speed)(struct sdhci_host *host); this should be done
> after add_host, which impact f_max.
> 4. int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data
> *pdata, void* priv_pdata); copy from Wolfram Sang's patch to transfer
> platform data, copy here for test.

No copying. If you think my patch is useful, add an Acked-by and say your
patches depend on mine.

>=20
> From 8c59d0b917f434d7c424ce1e0896af45c3e5fbba Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 26 Sep 2010 16:37:11 -0400
> Subject: [PATCH 2/2] sdhci-pltfm: add call back function
>=20
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |   24 ++++++++++++++++++------
>  include/linux/sdhci-pltfm.h    |    5 ++++-
>  2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e045e3c..e06f047 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
>  {
>  	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
>  	const struct platform_device_id *platid =3D platform_get_device_id(pdev=
);
> +	void *priv_pdata =3D NULL;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
>  	int ret;
>=20
> -	if (!pdata && platid && platid->driver_data)
> +	if (platid && platid->driver_data) {
>  		pdata =3D (void *)platid->driver_data;
> +		priv_pdata =3D pdev->dev.platform_data;
> +	} else {
> +		pdata =3D pdev->dev.platform_data;
> +	}
>=20
>  	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iomem) {
> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
>  		dev_err(&pdev->dev, "Invalid iomem size. You may "
>  			"experience problems.\n");
>=20
> -	if (pdev->dev.parent)
> -		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
> +	if (pdata && pdata->alloc_host)
> +		host =3D pdata->alloc_host(&pdev->dev);
>  	else
>  		host =3D sdhci_alloc_host(&pdev->dev, 0);
>=20
> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
>  		host->ops =3D pdata->ops;
>  	else
>  		host->ops =3D &sdhci_pltfm_ops;
> -	if (pdata)
> -		host->quirks =3D pdata->quirks;
> +
>  	host->irq =3D platform_get_irq(pdev, 0);
>=20
>  	if (!request_mem_region(iomem->start, resource_size(iomem),
> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
>  	}
>=20
>  	if (pdata && pdata->init) {
> -		ret =3D pdata->init(host);
> +		ret =3D pdata->init(host, pdata, priv_pdata);
>  		if (ret)
>  			goto err_plat_init;
>  	}
>=20
> +	if (pdata && pdata->get_quirk)
> +		host->quirks =3D pdata->get_quirk(host);
> +	else if (pdata)
> +		host->quirks =3D pdata->quirks;
> +
>  	ret =3D sdhci_add_host(host);
>  	if (ret)
>  		goto err_add_host;
>=20
> +	if (pdata && pdata->set_max_speed)
> +		pdata->set_max_speed(host);
> +
>  	platform_set_drvdata(pdev, host);
>=20
>  	return 0;
> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
> index 0239bd7..0d8e8f6 100644
> --- a/include/linux/sdhci-pltfm.h
> +++ b/include/linux/sdhci-pltfm.h
> @@ -28,8 +28,11 @@ struct sdhci_host;
>  struct sdhci_pltfm_data {
>  	struct sdhci_ops *ops;
>  	unsigned int quirks;
> -	int (*init)(struct sdhci_host *host);
> +	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
> void* priv_pdata);
>  	void (*exit)(struct sdhci_host *host);
> +	void (*set_max_speed)(struct sdhci_host *host);
> +	unsigned int  (*get_quirk)(struct sdhci_host *host);
> +	struct sdhci_host *(*alloc_host)(struct device *dev);
>  };
>=20
>  #endif /* _SDHCI_PLTFM_H */
> --=20
> 1.7.0.4

> From 8c59d0b917f434d7c424ce1e0896af45c3e5fbba Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 26 Sep 2010 16:37:11 -0400
> Subject: [PATCH 2/2] sdhci-pltfm: add call back function
>=20
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |   24 ++++++++++++++++++------
>  include/linux/sdhci-pltfm.h    |    5 ++++-
>  2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index e045e3c..e06f047 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct platfor=
m_device *pdev)
>  {
>  	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
>  	const struct platform_device_id *platid =3D platform_get_device_id(pdev=
);
> +	void *priv_pdata =3D NULL;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
>  	int ret;
> =20
> -	if (!pdata && platid && platid->driver_data)
> +	if (platid && platid->driver_data) {
>  		pdata =3D (void *)platid->driver_data;
> +		priv_pdata =3D pdev->dev.platform_data;
> +	} else {
> +		pdata =3D pdev->dev.platform_data;
> +	}
> =20
>  	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iomem) {
> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct platform_=
device *pdev)
>  		dev_err(&pdev->dev, "Invalid iomem size. You may "
>  			"experience problems.\n");
> =20
> -	if (pdev->dev.parent)
> -		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
> +	if (pdata && pdata->alloc_host)
> +		host =3D pdata->alloc_host(&pdev->dev);
>  	else
>  		host =3D sdhci_alloc_host(&pdev->dev, 0);
> =20
> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_=
device *pdev)
>  		host->ops =3D pdata->ops;
>  	else
>  		host->ops =3D &sdhci_pltfm_ops;
> -	if (pdata)
> -		host->quirks =3D pdata->quirks;
> +
>  	host->irq =3D platform_get_irq(pdev, 0);
> =20
>  	if (!request_mem_region(iomem->start, resource_size(iomem),
> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct platf=
orm_device *pdev)
>  	}
> =20
>  	if (pdata && pdata->init) {
> -		ret =3D pdata->init(host);
> +		ret =3D pdata->init(host, pdata, priv_pdata);
>  		if (ret)
>  			goto err_plat_init;
>  	}
> =20
> +	if (pdata && pdata->get_quirk)
> +		host->quirks =3D pdata->get_quirk(host);
> +	else if (pdata)
> +		host->quirks =3D pdata->quirks;
> +
>  	ret =3D sdhci_add_host(host);
>  	if (ret)
>  		goto err_add_host;
> =20
> +	if (pdata && pdata->set_max_speed)
> +		pdata->set_max_speed(host);
> +
>  	platform_set_drvdata(pdev, host);
> =20
>  	return 0;
> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
> index 0239bd7..0d8e8f6 100644
> --- a/include/linux/sdhci-pltfm.h
> +++ b/include/linux/sdhci-pltfm.h
> @@ -28,8 +28,11 @@ struct sdhci_host;
>  struct sdhci_pltfm_data {
>  	struct sdhci_ops *ops;
>  	unsigned int quirks;
> -	int (*init)(struct sdhci_host *host);
> +	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata, vo=
id* priv_pdata);
>  	void (*exit)(struct sdhci_host *host);
> +	void (*set_max_speed)(struct sdhci_host *host);
> +	unsigned int  (*get_quirk)(struct sdhci_host *host);
> +	struct sdhci_host *(*alloc_host)(struct device *dev);
>  };
> =20
>  #endif /* _SDHCI_PLTFM_H */
> --=20
> 1.7.0.4
>=20


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyfcD0ACgkQD27XaX1/VRt1rgCdHfpBgfsUinbhf4wXCvIMreul
tCwAoIvA7nFDgH4jBIZgLX6xRstcENaG
=3A6W
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
