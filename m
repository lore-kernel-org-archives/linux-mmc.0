From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Mon, 20 Sep 2010 11:50:42 +0200
Message-ID: <20100920095042.GC4058@pengutronix.de>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35229 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0ITJup (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 05:50:45 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:

> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> new file mode 100644
> index 0000000..3e091c1
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -0,0 +1,253 @@
> +/* linux/drivers/mmc/host/sdhci-pxa.c
> + *
> + * Copyright 2010 Marvell
> + *      Zhangfei Gao <zhangfei.gao@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* Supports:
> + * SDHCI support for MMP2/PXA910/PXA168
> + *
> + * Based on sdhci-platfm.c
> + */

Why is it only "based on" and not directly using it?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyXLnIACgkQD27XaX1/VRs1tACguzCS47XrzzMD+mWwFOSkgr1q
AR8AnRbztMJI30NqFihZyE8bkVlFJe18
=BsNX
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
