From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Tue, 14 Sep 2010 22:00:49 +0200
Message-ID: <20100914200049.GA6238@pengutronix.de>
References: <20100913172738.20345.61119.stgit@localhost.localdomain> <20100913173940.20345.66285.stgit@localhost.localdomain> <20100914142129.GF2629@pengutronix.de> <20100914144057.0d13f843@linux.intel.com> <20100914144512.GH2629@pengutronix.de> <20100914165743.GA19431@void.printf.net> <20100914174125.387f4b29@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39160 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0INUAw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2010 16:00:52 -0400
Content-Disposition: inline
In-Reply-To: <20100914174125.387f4b29@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The big question seems to be whether the approach the patchset takes
> > -- moving from quirks to hooks, extending sdhci.c without creating a=20
> > full driver, and the initial choice of overridable hooks -- makes
> > sense.  I'd be happy to hear everyone's thoughts on that.
>=20
> I'd rather see that discussion happen and then redo the MID patches to
> match whatever turns out to suit a more generalised set of driver
> tidyups this way than push it in ASAP.

+1 The cleanup may force the drivers to adapt, but not the other way around=
 ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyP1HEACgkQD27XaX1/VRvPIQCeMrZQaT54H8VS/jhKRaIWSFIQ
ohwAoMgkhSbopiv2qTHbTeSfrSEXrZJx
=mEaA
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
