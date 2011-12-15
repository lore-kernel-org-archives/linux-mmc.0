From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
Date: Thu, 15 Dec 2011 03:44:27 +0100
Message-ID: <20111215024427.GA12130@pengutronix.de>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <20111214070411.GA2593@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35854 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1LOCo3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 21:44:29 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gao Guanhua-B22826 <B22826@freescale.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > 2) ... the aproach seems wrong to me. The quirks should be set dependin=
g on
> > the compatible entry, e.g. if compatible =3D=3D "this_controller" then =
quirks
> > |=3D whatever_needed. Or?
> >=20
> The quirk will not be set only depending on the compatible entry, the
> property entry can be, too.

Where is that needed? I don't see how they are board-specific.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7pXwsACgkQD27XaX1/VRt94wCfdKY+oy00LUgK4mRRJA2+Aj56
awsAoIacSoX7cEImkeWhwdjshYRYc22q
=TT1n
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
