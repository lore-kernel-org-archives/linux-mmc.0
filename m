From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: sdhci_dumpregs: allow private information to be
	dumped on error
Date: Tue, 19 Oct 2010 21:47:24 +0200
Message-ID: <20101019194724.GC31336@pengutronix.de>
References: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37324 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab0JSTr0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2010 15:47:26 -0400
Content-Disposition: inline
In-Reply-To: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Tue, Oct 19, 2010 at 11:27:22AM -0700, Philip Rakity wrote:
> Our controller has private registers that are useful to see on error.
> define a new host->ops to allow these registers to be printed
>=20
> Signed-off-by: Philip Rakity <prakity@marvell.com>

I wonder if we really need such a thing in the mainline kernel? It is proba=
bly
used for debugging the driver?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky99cwACgkQD27XaX1/VRsJcwCfZvMtHDYeuAByLSBVaOaRgmL4
KUoAoLdQuoiAlB8dmwh72spEHGEqALNl
=J6vx
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
