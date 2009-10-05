From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mxcmmc: fix error path in mxcmci_probe
Date: Mon, 5 Oct 2009 21:46:47 +0200
Message-ID: <20091005194647.GA5785@pengutronix.de>
References: <1253778254-6881-1-git-send-email-u.kleine-koenig@pengutronix.de> <20090924095142.GL27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58217 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbZJETr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2009 15:47:57 -0400
Content-Disposition: inline
In-Reply-To: <20090924095142.GL27039@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>, Martin Fuzzey <mfuzzey@gmail.com>, Pierre Ossman <drzeus@drzeus.cx>, Andrew Morton <akpm@linux-foundation.org>

Hello,

On Thu, Sep 24, 2009 at 11:51:42AM +0200, Sascha Hauer wrote:
> On Thu, Sep 24, 2009 at 09:44:14AM +0200, Uwe Kleine-K=F6nig wrote:
> > After a failing allocation of mmc or a failed ioremap in mxcmci_pro=
be host was
> > used uninitialized.
>=20
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pierre Ossman <pierre@ossman.eu>
> > Cc: Martin Fuzzey <mfuzzey@gmail.com>
> > Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>

Anyone to pick up this patch?

> > ---
> >  drivers/mmc/host/mxcmmc.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> > index bc14bb1..bec4605 100644
> > --- a/drivers/mmc/host/mxcmmc.c
> > +++ b/drivers/mmc/host/mxcmmc.c
> > @@ -679,17 +679,17 @@ static int mxcmci_probe(struct platform_devic=
e *pdev)
> >  {
> >  	struct mmc_host *mmc;
> >  	struct mxcmci_host *host =3D NULL;
> > -	struct resource *r;
> > +	struct resource *iores, *r;
> >  	int ret =3D 0, irq;
> > =20
> >  	printk(KERN_INFO "i.MX SDHC driver\n");
> > =20
> > -	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	irq =3D platform_get_irq(pdev, 0);
> > -	if (!r || irq < 0)
> > +	if (!iores || irq < 0)
> >  		return -EINVAL;
> > =20
> > -	r =3D request_mem_region(r->start, resource_size(r), pdev->name);
> > +	r =3D request_mem_region(iores->start, resource_size(iores), pdev=
->name);
> >  	if (!r)
> >  		return -EBUSY;
> > =20
> > @@ -809,7 +809,7 @@ out_iounmap:
> >  out_free:
> >  	mmc_free_host(mmc);
> >  out_release_mem:
> > -	release_mem_region(host->res->start, resource_size(host->res));
> > +	release_mem_region(iores->start, resource_size(iores));
> >  	return ret;
> >  }
> > =20
> > --=20
> > 1.6.4.3

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
