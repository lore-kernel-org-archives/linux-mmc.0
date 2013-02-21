From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2] mmc: tegra: use mmc_of_parse to get the support of
 standard MMC DT bindings
Date: Thu, 21 Feb 2013 09:03:06 +0100
Message-ID: <20130221080306.GA7718@avionic-0098.mockup.avionic-design.de>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
 <1361343902-15223-3-git-send-email-josephl@nvidia.com>
 <512502D7.4090605@wwwdotorg.org>
 <1361413425.5678.8.camel@jlo-ubuntu-64.nvidia.com>
 <5125A075.5000000@wwwdotorg.org>
 <1361427997.5678.59.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3BUIDU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 03:03:20 -0500
Content-Disposition: inline
In-Reply-To: <1361427997.5678.59.camel@jlo-ubuntu-64.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joseph Lo <josephl@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <cjb@laptop.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2013 at 02:26:37PM +0800, Joseph Lo wrote:
> On Thu, 2013-02-21 at 12:20 +0800, Stephen Warren wrote:
> > On 02/20/2013 07:23 PM, Joseph Lo wrote:
> > > On Thu, 2013-02-21 at 01:07 +0800, Stephen Warren wrote:
> > >> On 02/20/2013 12:05 AM, Joseph Lo wrote:
> > >>> Updating the sdhci-tegra driver to use mmc_of_parse to support stan=
dard
> > >>> MMC DT bindings. Then we can remove the redundant code that already=
 support
> >=20
> > >>> @@ -220,15 +203,12 @@ static void sdhci_tegra_parse_dt(struct devic=
e *dev,
> > >>>  					struct sdhci_tegra *tegra_host)
> > >>>  {
> > >> ...
> > >>> +	struct sdhci_host *host;
> > >> ...
> > >>> +	host =3D platform_get_drvdata(to_platform_device(dev));
> > >>> +	mmc_of_parse(host->mmc);
> > >>>  }
> > >>
> > >> It might be simpler to change the function prototype to simply pass =
in
> > >> the host object too.
> > >=20
> > > It's a interface problem that I can't fix now. If sdhci core is going=
 to
> > > integrate mmc_of_parse into sdhci_get_of_property and mmc_gpio_get_ro
> > > into somethere sdhci_do_get_ro, then we can refine later.
> >=20
> > I meant to change the prototype of sdhci_tegra_parse_dt(). It would be
> > simple to change that function in this patch.
>=20
> Hmm. It might not too much different. Which version you prefer?
>=20
> 1. Original version
>=20
> 2.
>  static void sdhci_tegra_parse_dt(struct device *dev,
> -                                       struct sdhci_tegra *tegra_host)
> +                                       struct sdhci_host *host)
>  {
>         struct device_node *np =3D dev->of_node;
> -       struct sdhci_host *host;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host =3D pltfm_host->priv;
> =20
>         tegra_host->power_gpio =3D of_get_named_gpio(np, "power-gpios",0);
> -
> -       host =3D platform_get_drvdata(to_platform_device(dev));
>         mmc_of_parse(host->mmc);
>  }
> =20
> @@ -240,7 +239,7 @@ static int sdhci_tegra_probe(struct platform_device
> *pdev)
>         tegra_host->soc_data =3D soc_data;
>         pltfm_host->priv =3D tegra_host;
> =20
> -       sdhci_tegra_parse_dt(&pdev->dev, tegra_host);
> +       sdhci_tegra_parse_dt(&pdev->dev, host);
> =20

I personally prefer this second version. It keeps with the tradition to
pass a struct device into the *_parse_dt() and also provides easy access
to the sdhci_host.

And on a side-note:

	host =3D platform_get_drvdata(to_platform_device(dev));

can be more simply written as:

	host =3D dev_get_drvdata(dev);

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRJdS6AAoJEN0jrNd/PrOhxhgQAL17M8WNZ1fmbTb9alTuVPFG
/2Kb4eJNA2diTz5v1eHWZABoLY0lUbgE/vE7cv3gXZPUrK3NFkfcpr5sIpSaTf6a
2l7VPaVk4IfFaVvdKgByV8tFLJz3f0bU3AnVMYOlp8kTjCZeQMvwa8u2/9ZSIOZh
8PSNpQwbPr556jxIy4UjXfRyxC4PpplOtyV/rDTIm5miIpeahkimdTQgLGM90YEw
Dt4crnM0QzWyjSr4/zo8YbNKC/ZyqWA8mM9z1JsgFm8LVVQ2BAwB657m4AcUOokz
jTFVWsUyimLIethQrPCY1SALI/txyUhaeWvyraNmQfQn/AkBzpMD3NocAJmeUT4j
NhsS373A6Cbmipsa7SgSEmTMWZdDw4ck7KN2cUtqyFlmkT2FaZBxSVY5P+UPabbP
k/Qox+WP/2GAffKGANpVlkRtB0Uv/zC7BmZ+LiOYDZRojuyiklxJwEjOvCJEqFM/
hQhFeZD/05kS3ssdPcOuTn6ihZL8LKYQCzMGJbdvcfnY4GzvkIta3ZHQzdSS9irY
/+3OmTWppdMY5zXSRfiEtokjpU3HRYmtMVD4EmAjVhnsL31WXyKDMOgqE22lc6z/
N5vS65/wiqUgKH59RWvh1M191UyIqnwwAJkVqdX5CEEJmOFtQWssO38Ldf5LRHIv
N6Zp83lhsFHwg0XwwUUb
=uok5
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
