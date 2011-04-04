From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 4 Apr 2011 15:32:46 +0200
Message-ID: <20110404133246.GD20421@pengutronix.de>
References: <4D996006.9030402@samsung.com>
 <20110404132807.GC20421@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59686 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DDNcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:32:47 -0400
Content-Disposition: inline
In-Reply-To: <20110404132807.GC20421@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> registering it failed? Looking at the remove function as comparison, ther=
e are
> still some buffers, timers, etc, forgotten :( Could you fix that, too, pl=
ease?

To avoid misunderstandings, that sad smiley didn't mean you but the state of
the current error-path in general.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2ZyH4ACgkQD27XaX1/VRutzQCfTyePxARQwhfKKOdE8ALkHwAC
qKcAn3w7vojiBzbE9OuBp5fl/zPPFEz2
=DGTW
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
