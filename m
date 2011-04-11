From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 07:59:59 +0200
Message-ID: <20110411055959.GE20437@pengutronix.de>
References: <4DA2633C.5000103@samsung.com>
 <20110411030453.GA20437@pengutronix.de>
 <4DA28098.9020202@samsung.com>
 <20110411044022.GD20437@pengutronix.de>
 <4DA289D2.7010501@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1DKGAB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 02:00:01 -0400
Content-Disposition: inline
In-Reply-To: <4DA289D2.7010501@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You means that didn't run start_host() before add_host failed.
> I think that need not to run stop_host. right?

Right, and other stuff like registering the pm_notifier.

> To use mmc_free_host, better than mmc_remove_host.

That would be true for most drivers. However, sdhci has encapsulated this in
its own sdhci_free_host. So, you don't need to call this as well.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2imN8ACgkQD27XaX1/VRun2QCgtJAwb4P4hEqutJ47BerUzDjO
rAoAn13WtaVjduXSIPtWhJkmhWFDkSbc
=Thc/
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
