From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Thu, 30 Sep 2010 10:16:05 +0200
Message-ID: <20100930081605.GA2655@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
 <1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
 <4CA3AE89.2030107@pelagicore.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53169 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0I3IQN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 04:16:13 -0400
Content-Disposition: inline
In-Reply-To: <4CA3AE89.2030107@pelagicore.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors@pelagicore.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, Sep 29, 2010 at 11:24:25PM +0200, Richard R=F6jfors wrote:
> On 09/29/2010 10:07 PM, Wolfram Sang wrote:
> >We need to carry some information per host, e.g. the clock. Add a
> >structure for it and initialize it in the generic part. Also do not use
> >the parent of the platform_device (if it is available), this breaks the
> >clock-matching on ARM.
>=20
> The reason it's there is for instance a case when the shdci device is exp=
osed
> from a MFD device which sits on top of PCI. Then the parent (PCI device)
> is the device that is DMA capable. This patch will break such usage.

I feared that there is a reason. The problem I see is now, that the parent =
gets
always set (from drivers/base/platform.c):

37c12e74 (Russell King            2005-11-05 21:19:33 +0000  235) int platf=
orm_device_add(struct platform_device *pdev)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  236) {
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  237)       int=
 i, ret =3D 0;
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  238)=20
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  239)       if =
(!pdev)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  240)          =
     return -EINVAL;
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  241)=20
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  242)       if =
(!pdev->dev.parent)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  243)          =
     pdev->dev.parent =3D &platform_bus;
=2E..

So, sdhci-plftm cannot access the platform_data connected to the original
platform_device via host->mmc->parent.

> What is the purpose of this patch? You allocate space for an extra struct,
> which you have a pointer pointing to, but you never use the pointer?

We want to extend sdhci-pltfm to support the various sdhci-cores on (for now
mainly) ARM platforms. A number of those cores need board specific informat=
ion
to be used in a custom init()-call, which shall be passed via platform_data.
The pointer will be used in the platform specific extensions.

> >
> >Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
> >Cc: Richard R=F6jfors<richard.rojfors.ext@mocean-labs.com>
> >---
> >
> >Changes since last version:
> >
> >* added types.h
>=20
> I saw no types.h?

In the second chunk, the include file.

Thanks,

   Wolfram

>=20
> >* removed usage of pdev->dev.parent to ensure clk-matching
> >   Please speak up if this has a use case I failed to see!
> >
> >  drivers/mmc/host/sdhci-pltfm.c |    8 ++++----
> >  drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-plt=
fm.c
> >index e045e3c..095ca9d 100644
> >--- a/drivers/mmc/host/sdhci-pltfm.c
> >+++ b/drivers/mmc/host/sdhci-pltfm.c
> >@@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platform=
_device *pdev)
> >  	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
> >  	const struct platform_device_id *platid =3D platform_get_device_id(pd=
ev);
> >  	struct sdhci_host *host;
> >+	struct sdhci_pltfm_host *pltfm_host;
> >  	struct resource *iomem;
> >  	int ret;
> >
> >@@ -71,16 +72,15 @@ static int __devinit sdhci_pltfm_probe(struct platfo=
rm_device *pdev)
> >  		dev_err(&pdev->dev, "Invalid iomem size. You may "
> >  			"experience problems.\n");
> >
> >-	if (pdev->dev.parent)
> >-		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
> >-	else
> >-		host =3D sdhci_alloc_host(&pdev->dev, 0);
> >+	host =3D sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
> >
> >  	if (IS_ERR(host)) {
> >  		ret =3D PTR_ERR(host);
> >  		goto err;
> >  	}
> >
> >+	pltfm_host =3D sdhci_priv(host);
> >+
> >  	host->hw_name =3D "platform";
> >  	if (pdata&&  pdata->ops)
> >  		host->ops =3D pdata->ops;
> >diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-plt=
fm.h
> >index 900f329..93a0319 100644
> >--- a/drivers/mmc/host/sdhci-pltfm.h
> >+++ b/drivers/mmc/host/sdhci-pltfm.h
> >@@ -11,8 +11,15 @@
> >  #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
> >  #define _DRIVERS_MMC_SDHCI_PLTFM_H
> >
> >+#include<linux/clk.h>
> >+#include<linux/types.h>
> >  #include<linux/sdhci-pltfm.h>
> >
> >+struct sdhci_pltfm_host {
> >+	struct clk *clk;
> >+	u32 scratchpad; /* to handle quirks across io-accessor calls */
> >+};
> >+
> >  extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> >
> >  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkykR0UACgkQD27XaX1/VRsOQACgv/O4JyHNE3dJS9++6HJvLKfX
2G8AnRZ+Xo9/gre/TV5NQhMk3DuyHRrp
=6Zfu
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
