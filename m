From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: SDHC ADMA Problem
Date: Mon, 23 Aug 2010 10:19:19 +0200
Message-ID: <20100823081919.GA6034@pengutronix.de>
References: <loom.20100823T075246-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47218 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0HWITV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Aug 2010 04:19:21 -0400
Content-Disposition: inline
In-Reply-To: <loom.20100823T075246-842@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ricoh <yadav.rajesh@nts.ricoh.co.jp>
Cc: linux-mmc@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2010 at 06:05:24AM +0000, Ricoh wrote:
> For the ADMA enabled SD Host Controller, SDHCI driver is not working fine.
> sdhci device gets an error "mmc0: unexpected interrupt" when an sdhc card=
 is=20
> inserted.
>=20
> This unexpected interrupt is the result of ADMA error.=20
> Refer the following dmesg informaion for more details.=20
>=20
> mmc0: Unexpected interrupt 0x02000000.
> sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DUMP =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> sdhci: Sys addr: 0x00000000 | Version:  0x00000401
> sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000001
> sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
> sdhci: Present:  0x01f70202 | Host ctl: 0x00000011
> sdhci: Power:    0x0000000f | Blk gap:  0x00000000
> sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
> sdhci: Timeout:  0x0000000a | Int stat: 0x02008008
> sdhci: Int enab: 0x02ff00cb | Sig enab: 0x02ff00cb
> sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
> sdhci: Caps:     0x21e832b2 | Max curr: 0x00000040
> sdhci: ADMA Err: 0x00000001 | ADMA Ptr: 0x020003b4
> sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Is there any updated information regarding to this issue??

We would need to know which kernel version you are using (it should be
as new as possible) and which SDHC controller.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxyLwcACgkQD27XaX1/VRsrMwCgjDH9dQFl/ELceQ9wUXOPLVug
u0MAnRZ5r7f3euaNUn0O4NO1SggGZKWY
=71sx
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
