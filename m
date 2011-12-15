From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
Date: Thu, 15 Dec 2011 04:09:50 +0100
Message-ID: <20111215030950.GB12130@pengutronix.de>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <20111214070411.GA2593@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111215024427.GA12130@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D9B@039-SN1MPN1-006.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33123 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599Ab1LODJw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 22:09:52 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11646D9B@039-SN1MPN1-006.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gao Guanhua-B22826 <B22826@freescale.com>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For P2020E Rev1.0, the DMA can't work, we need the PIO mode.
> For P2020E, P1010E, MPC8536, we can't use the timeout value calculated by=
 driver, we need the max value.
> For P1010E, the eSDHC controller can't use the max possible frequency(e.g=
=2E SDHC 50MHz), so we need one workaround to make the SD work

This is SoC specific, not board specific, so you could check for
"fsl,p2020-esdhc" for example. 1010 and 2020-rev1 would need proper compati=
bles
as well.

> For eSDHC, after suspending, the power of esdhc controller will shutdown,=
 we need to save the value of some registers before suspending, wich will u=
sed to restore the context after resuming.
> For eSDHC, the bit DCR[DMA__AHB2MAG_IRQ_BYPASS] can't be set automaticall=
y, so we need to set it manually

If this is true for all revisions (be careful about the imx users), you don=
't
need properties, but could simply set it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7pZP4ACgkQD27XaX1/VRviogCeLfzfPVLIFOPXF4f52LQiTX/F
6UUAmwe8tHzo2PJa2d/5v05YgVSxI5wI
=tE37
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
