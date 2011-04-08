From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci: fixed regulator control when suspend/resume
Date: Fri, 8 Apr 2011 20:47:10 +0200
Message-ID: <20110408184710.GC23883@pengutronix.de>
References: <4D9D3C58.5030901@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52709 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab1DHSrM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 14:47:12 -0400
Content-Disposition: inline
In-Reply-To: <4D9D3C58.5030901@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2011 at 01:23:52PM +0900, Jaehoon Chung wrote:
> Suspend/resume is working always enable regulator after resuming.=20
> (if there is host->vmmc)

The regulator is enabled during add_host. How could it not be enabled in
suspend?

>  	struct regulator *vmmc;	/* Power regulator */
> +	bool restore_vmmc;	/* Restore vmmc */

If you can explain the above, this should be turned into a SDHCI_-flag IMHO.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2fWC4ACgkQD27XaX1/VRuTAwCghHV5u2l8tAqnLPAwBf3fz+iV
MVoAnRB+hXXCZU3xZQghwVVBcm7iu5+H
=cDOF
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
