From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch 1/3] sdhci-pltfm: add call back alloc_host
Date: Tue, 28 Sep 2010 16:18:29 +0200
Message-ID: <20100928141829.GG4441@pengutronix.de>
References: <AANLkTin_BEE+LgZuJHeewvFDUQCipG98ZbkhMJGbnprC@mail.gmail.com>
 <AANLkTikmEGpRdbdfCxgY2Qy9c--TeTh+ywVc-Qkevssf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36065 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab0I1OSd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:18:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikmEGpRdbdfCxgY2Qy9c--TeTh+ywVc-Qkevssf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 10:08:27AM -0400, zhangfei gao wrote:
> On Sun, Sep 26, 2010 at 10:55 PM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> > From 7a870a620fa868ed4ce0cffcbd6b0683a00ae2e5 Mon Sep 17 00:00:00 2001
> > From: Zhangfei Gao <zhangfei.gao@marvell.com>
> > Date: Mon, 27 Sep 2010 10:30:01 -0400
> > Subject: [PATCH 1/3] sdhci-pltfm: add call back alloc_host
> >
> > =A0 =A0 =A0 =A0alloc_host could alloc specific structure of device to m=
eet different
> > requirement
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> > ---
> > =A0drivers/mmc/host/sdhci-pltfm.c | =A0 =A04 ++--
> > =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A01 +
> > =A02 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
> > index 9669f21..82d3d05 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -76,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
> > platform_device *pdev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Invalid iomem size.=
 You may "
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"experience problems.\n"=
);
> >
> > - =A0 =A0 =A0 if (pdev->dev.parent)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.paren=
t, 0);
> > + =A0 =A0 =A0 if (pdata && pdata->alloc_host)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D pdata->alloc_host(&pdev->dev);
> > =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host =3D sdhci_alloc_host(&pdev->dev, 0);
> >
> > diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
> > index e14fce3..80c415e 100644
> > --- a/include/linux/sdhci-pltfm.h
> > +++ b/include/linux/sdhci-pltfm.h
> > @@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
> > =A0 =A0 =A0 =A0unsigned int quirks;
> > =A0 =A0 =A0 =A0int (*init)(struct sdhci_host *host, struct sdhci_pltfm_=
data *pdata,
> > void* priv_pdata);
> > =A0 =A0 =A0 =A0void (*exit)(struct sdhci_host *host);
> > + =A0 =A0 =A0 struct sdhci_host *(*alloc_host)(struct device *dev);
> > =A0};
> >
> > =A0#endif /* _SDHCI_PLTFM_H */
> > --
> > 1.7.0.4
> >
>=20
> Any feed back, much thanks.

I had this in mind when creating the patch which added the
host-structure. But I came to the same conclusion as Anton that it seems
overengineered at this point. How much private data would you need?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyh+TUACgkQD27XaX1/VRu2cwCgsmxHj+fXTvX0VcFCWMnlyBqM
kpcAn3kkpc7qYG6/sYC4TDp/Q8+J+92S
=WFS7
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
