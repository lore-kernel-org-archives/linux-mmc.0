From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Thu, 19 May 2011 11:48:42 +0200
Message-ID: <20110519094841.GB2219@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54548 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870Ab1ESJsq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 05:48:46 -0400
Content-Disposition: inline
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +config MMC_SDHCI_ESDHC
> +	bool
> +	depends on MMC_SDHCI
> +	select MMC_SDHCI_PLTFM
> +	help
> +	  This selects SDHCI driver for Freescale eSDHC controller.

bool is not a good choice here, because if ESDHC_IMX is selected as a
module (-m), it will get converted here to built-in (-y). Same goes for
MMC_SDHCI_PLTFM. If I change both into tristate and then compile, I get
a build error:

ERROR: "sdhci_pltfm_suspend" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_get_of_property" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_init" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_free" [drivers/mmc/host/sdhci-esdhc.ko] undefined!

So, the module-support seems to be missing for the library.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3U53kACgkQD27XaX1/VRtYigCfaUQ0Zm6JgulAx7GPts/7nUwP
pi8AoKgWBD6yoBCrQblL/2kel4qUhfy/
=1g4j
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
