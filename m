From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
Date: Wed, 14 Dec 2011 08:04:11 +0100
Message-ID: <20111214070411.GA2593@pengutronix.de>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab1LNHEN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 02:04:13 -0500
Content-Disposition: inline
In-Reply-To: <1323829182-1551-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2011 at 10:19:37AM +0800, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not work=
 on
> DMA mode because of the hardware bug, so we set a broken dma flag and use
> PIO mode.
>=20
> Signed-off-by: Gao Guanhua <B22826@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>

NACK for the series

1) If you introduce a new property you always have to document the binding
which is missing. But you don't need to write it because...

2) ... the aproach seems wrong to me. The quirks should be set depending
on the compatible entry, e.g. if compatible =3D=3D "this_controller" then
quirks |=3D whatever_needed. Or?

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7oSmsACgkQD27XaX1/VRu3owCcCccZOGPiv0rUNCdNRxSdDJ15
3YIAoIjjnuWJ91SRbEMks6uvbXzRBRWV
=Q9OQ
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
