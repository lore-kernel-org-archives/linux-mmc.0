From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: print out controller name for register debug
Date: Thu, 23 Sep 2010 10:39:46 +0200
Message-ID: <20100923083946.GA2994@pengutronix.de>
References: <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
 <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
 <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
 <4C984B01.2000005@nokia.com>
 <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
 <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com>
 <20100922230805.GA6659@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44961 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab0IWIkB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 04:40:01 -0400
Content-Disposition: inline
In-Reply-To: <20100922230805.GA6659@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 12:08:06AM +0100, Chris Ball wrote:
> Hi Philip,
>=20
> On Wed, Sep 22, 2010 at 03:25:13PM -0700, Philip Rakity wrote:
> > Subject: [PATCH] sdhci: print out controller name for register debug
> >=20
> > In a multi-controller environment it is helpful to know which controller
> > has problems.
> >=20
> > Signed-off-by: Philip Rakity <prakity@marvell.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index e2b1f32..6b8ca32 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,7 +47,8 @@ static void sdhci_finish_command(struct sdhci_host *);
> > =20
> >  static void sdhci_dumpregs(struct sdhci_host *host)
> >  {
> > -	printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > +	printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D RE=
GISTER DUMP (%s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> > +		mmc_hostname(host->mmc));
> > =20
> >  	printk(KERN_DEBUG DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\=
n",
> >  		sdhci_readl(host, SDHCI_DMA_ADDRESS),
>=20
> Thanks, pushed to mmc-next; I'm surprised no-one noticed this before. :)

Uh, that was fast. I would have preferred to switch the whole printout
to dev_dbg?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkybElIACgkQD27XaX1/VRsiKQCfU+0ItizXYTq/QNABnjXwoD9/
cDkAoMNK/NPw7i94HOrqcjpRw83fWTkg
=UMmM
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
