From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Tue, 24 May 2011 21:40:54 +0200
Message-ID: <20110524194054.GC25727@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38960 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1EXTk7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 15:40:59 -0400
Content-Disposition: inline
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> This patch is to consolidate SDHCI driver for Freescale eSDHC
> controller found on both MPCxxx and i.MX platforms.  It merges
> sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> .probe/.remove hook works with eSDHC for two platforms.
>=20
> As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> header esdhc.h containing the definition of esdhc_platform_data is
> put into the public folder.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I agree with Anton about not merging the two...

> +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> +#define cpu_is_mx25()	(0)
> +#define cpu_is_mx35()	(0)
> +#define cpu_is_mx51()	(0)
> +#define cpu_is_imx()	(0)
> +#else
> +#define cpu_is_imx()	(1)
> +#endif

=2E.. e.g. that looks a bit frightening.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3cCcYACgkQD27XaX1/VRtUwQCgoIV85fwgIwLJrNnpZcKcpuon
2t8AnAurv1dsjn89lmIF70htQOUZ02xt
=L9v8
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
