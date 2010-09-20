From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Mon, 20 Sep 2010 15:10:56 +0200
Message-ID: <20100920131055.GE4058@pengutronix.de>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
 <20100920095042.GC4058@pengutronix.de>
 <AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40835 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab0ITNK6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 09:10:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 08:09:26AM -0400, zhangfei gao wrote:
> On Mon, Sep 20, 2010 at 5:50 AM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:
> >
> >> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa=
=2Ec
> >> new file mode 100644
> >> index 0000000..3e091c1
> >> --- /dev/null
> >> +++ b/drivers/mmc/host/sdhci-pxa.c
> >> @@ -0,0 +1,253 @@
> >> +/* linux/drivers/mmc/host/sdhci-pxa.c
> >> + *
> >> + * Copyright 2010 Marvell
> >> + * =A0 =A0 =A0Zhangfei Gao <zhangfei.gao@marvell.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +/* Supports:
> >> + * SDHCI support for MMP2/PXA910/PXA168
> >> + *
> >> + * Based on sdhci-platfm.c
> >> + */
> >
> > Why is it only "based on" and not directly using it?
>=20
> Thanks for your suggestion.
> This is the first stage, already implement sd card function, we will
> have some patches later to enhance the driver.
> We have to access many private registers to enable specific control.
> Besides some sdio device need some specific control, like marvell 8787
> host sleep, it is much reasonable to implement inside the driver.

Hmm, which hooks are missing for you to implement this as an extension
of the pltfm-driver? Maybe it makes sense to simply add this hook?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyXXV8ACgkQD27XaX1/VRtAxQCfafH+k4+HhWiDxM+cRqDn8KYC
Mq0AnRrh3v5192K7LdpIlLIxVBQI4ljW
=RPet
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
