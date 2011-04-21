From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/5] mmc: sdhci: make sdhci-pltfm device drivers self
 registered
Date: Thu, 21 Apr 2011 11:57:01 +0200
Message-ID: <20110421095701.GA2135@pengutronix.de>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
 <1301042931-4869-2-git-send-email-shawn.guo@linaro.org>
 <20110419102042.GB4164@pengutronix.de>
 <20110421080322.GD4024@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46045 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1DUJ5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 05:57:08 -0400
Content-Disposition: inline
In-Reply-To: <20110421080322.GD4024@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org, sameo@linux.intel.com, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +MODULE_LICENSE("GPL v2");
> >=20
> > Just to be sure: Did you double-check if the original licenses were v2
> > or v2+?
> >=20
> It seems to me that sdhci-cns3xxx.c, sdhci-dove.c, sdhci-esdhc-imx.c
> and sdhci-tegra.c all use v2.
>=20
> Actually I do not even know how v2+ is stated.  Do you have an example
> for me to refer?

Check davinci_mmc.c (or grep for 'any later version').

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2v/20ACgkQD27XaX1/VRvl8QCeNcN5AQaQfG6cbrzexrnIylTt
alMAoKQZvE4si/UuLC7eVC+Cc1y89ZPI
=0mbV
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
