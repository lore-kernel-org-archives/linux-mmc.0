From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them
 self registered
Date: Thu, 19 May 2011 19:05:48 +0200
Message-ID: <20110519170548.GA1075@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <20110519094046.GA2219@pengutronix.de>
 <20110519160901.GC26816@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab1ESRF5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 13:05:57 -0400
Content-Disposition: inline
In-Reply-To: <20110519160901.GC26816@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Should I go for v3 right now to address the patch applying problems
> and that ESDHC_IMX build issue, or hold for a while to see if you
> have more comments on v2?

Please wait a little bit more.

> And what is your position on patch #5 which merges esdhc imx and mpc
> support into one?  As Anton has voted a NO there, I would probably
> drop the patch if there is another person has strong opinion to get
> imx and mpc stay separated.

This was the other main issue I spotted so far. I wanted to have another lo=
ok
tomorrow, yet the tendency is that I agree with Anton.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3VTewACgkQD27XaX1/VRvEVQCgoMGHWdXFq4VEDCKT4inZMq7b
/UEAnjZoFTYmmWA06EPFIGVIRqEvbO7A
=MmT8
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
