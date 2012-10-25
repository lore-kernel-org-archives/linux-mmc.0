From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] mmc: omap_hsmmc: introduce
 omap_hsmmc_prepare/complete
Date: Thu, 25 Oct 2012 21:04:18 +0300
Message-ID: <20121025180418.GB18046@arwen.pp.htv.fi>
References: <1350910768-8522-1-git-send-email-balbi@ti.com>
 <20121022132708.GA14033@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758569Ab2JYSKF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Oct 2012 14:10:05 -0400
Content-Disposition: inline
In-Reply-To: <20121022132708.GA14033@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "\\\"Venkatraman S.\\\"" <svenkatr@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 22, 2012 at 04:27:08PM +0300, Felipe Balbi wrote:
> On Mon, Oct 22, 2012 at 03:59:28PM +0300, Felipe Balbi wrote:
> > prepare() is supposed to prevent new children from
> > being registered. On the MMC subsystem, children
> > (new cards) registration starts with the card
> > detect IRQ.
> >=20
> > Move card detect IRQ disabling to prepare() so that
> > no new cards will be registered while we're trying
> > to suspend.
> >=20
> > Likewise, move card detect IRQ enabling to complete()
> > so we only try to register new children after our MMC
> > IP is back up.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Venkat, do you think the patch below makes sense ?
>=20
> btw, just checked suspend to ram with beagle and panda. We still have
> our filesystem after waking up.
>=20
> ps: you will [1] to test it:
>=20
> [1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D135090724817604&w=3D2

ping

>=20
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
> > index 54bfd0c..4c8b41e 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2022,6 +2022,26 @@ static int __devexit omap_hsmmc_remove(struct pl=
atform_device *pdev)
> >  }
> > =20
> >  #ifdef CONFIG_PM
> > +static int omap_hsmmc_prepare(struct device *dev)
> > +{
> > +	struct omap_hsmmc_host *host =3D dev_get_drvdata(dev);
> > +
> > +	if (host->pdata->suspend)
> > +		return host->pdata->suspend(dev, host->slot_id);
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_hsmmc_complete(struct device *dev)
> > +{
> > +	struct omap_hsmmc_host *host =3D dev_get_drvdata(dev);
> > +
> > +	if (host->pdata->resume)
> > +		return host->pdata->resume(dev, host->slot_id);
> > +
> > +	return 0;
> > +}
> > +
> >  static int omap_hsmmc_suspend(struct device *dev)
> >  {
> >  	int ret =3D 0;
> > @@ -2035,23 +2055,10 @@ static int omap_hsmmc_suspend(struct device *de=
v)
> > =20
> >  	pm_runtime_get_sync(host->dev);
> >  	host->suspended =3D 1;
> > -	if (host->pdata->suspend) {
> > -		ret =3D host->pdata->suspend(dev, host->slot_id);
> > -		if (ret) {
> > -			dev_dbg(dev, "Unable to handle MMC board"
> > -					" level suspend\n");
> > -			host->suspended =3D 0;
> > -			return ret;
> > -		}
> > -	}
> >  	ret =3D mmc_suspend_host(host->mmc);
> > =20
> >  	if (ret) {
> >  		host->suspended =3D 0;
> > -		if (host->pdata->resume) {
> > -			if (host->pdata->resume(dev, host->slot_id))
> > -				dev_dbg(dev, "Unmask interrupt failed\n");
> > -		}
> >  		goto err;
> >  	}
> > =20
> > @@ -2088,12 +2095,6 @@ static int omap_hsmmc_resume(struct device *dev)
> >  	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
> >  		omap_hsmmc_conf_bus_power(host);
> > =20
> > -	if (host->pdata->resume) {
> > -		ret =3D host->pdata->resume(dev, host->slot_id);
> > -		if (ret)
> > -			dev_dbg(dev, "Unmask interrupt failed\n");
> > -	}
> > -
> >  	omap_hsmmc_protect_card(host);
> > =20
> >  	/* Notify the core to resume the host */
> > @@ -2109,8 +2110,10 @@ static int omap_hsmmc_resume(struct device *dev)
> >  }
> > =20
> >  #else
> > +#define omap_hsmmc_prepare	NULL
> > +#define omap_hsmmc_complete	NULL
> >  #define omap_hsmmc_suspend	NULL
> > -#define omap_hsmmc_resume		NULL
> > +#define omap_hsmmc_resume	NULL
> >  #endif
> > =20
> >  static int omap_hsmmc_runtime_suspend(struct device *dev)
> > @@ -2138,6 +2141,8 @@ static int omap_hsmmc_runtime_resume(struct devic=
e *dev)
> >  static struct dev_pm_ops omap_hsmmc_dev_pm_ops =3D {
> >  	.suspend	=3D omap_hsmmc_suspend,
> >  	.resume		=3D omap_hsmmc_resume,
> > +	.prepare	=3D omap_hsmmc_prepare,
> > +	.complete	=3D omap_hsmmc_complete,
> >  	.runtime_suspend =3D omap_hsmmc_runtime_suspend,
> >  	.runtime_resume =3D omap_hsmmc_runtime_resume,
> >  };
> > --=20
> > 1.8.0.rc0
> >=20


--=20
balbi

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiX8iAAoJEIaOsuA1yqREWTQQAJMUwHcjzdkHVhu9CmYbU1Op
VBtr1VZkiHODROWUGOHTAposk8Hetjf+0FkttS/FT51R605yYBuKJimgkJQ/yfux
1WMOweWxPWDSXygQ3WmZf3OTrK7SQCO6rnUULamN9V0BeOLlIyuTdRxwfxKP/6Cv
L5R1e7T8Bb43sKDucuqTqE0IibFMwv/B7PteSPbO48O+GcOAggYhNm3Va2s74hnR
wtQ94BSs9qtl2DnY4qqh3O3pcLRmAD+oK+RG07MZd/LJG3nOxHiIvJlVTv6aRxmn
lAmnIRv6v8d8A9/2LuFlfj5Ncb7Yz9ZqzZydPNzUBEQmJfTqyPLBSOuVuIH1Su8N
dTIogu//fnRdmF4QbVaVHlHXOhE/If0r/tQsuN/0AadAY2vrc52nwrkkoutcXrbM
DAX2+2cSzB6L+j4125Dh1muVtmmKSaECDTBOJJnQVB0MI/YMeKTtlYoUwYcgnD+g
6tBJ3jp2aTK4KIMXHl5Lop2VOXxzO5vfju9Tgk63l89MElfEfEd6r08MFuEtfkvi
pGSo3IQqXmchHx+fUsaVXdzpea8lfzfcfPUdkWIuKbKvGMDdCpviIC1b+LcaLuIO
9WiIbA3/Omy94+7MYqoZ3cCMt7hRrWLE6gjShAWn/tSwy2G+XigGTTnuEwHJXNwh
thRqz69EUmACkoZSwpim
=Rgho
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
