From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 12:15:57 +0100
Message-ID: <20110221111557.GG2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
 <20110221100439.GE2616@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
 <20110221104608.GF2616@pengutronix.de>
 <20110221110905.GL14495@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38322 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab1BULQF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 06:16:05 -0500
Content-Disposition: inline
In-Reply-To: <20110221110905.GL14495@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Zhu Richard-R65037 <R65037@freescale.com>, Zhao Richard-B20223 <B20223@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, "eric@eukrea.com" <eric@eukrea.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2011 at 11:09:05AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > > +   if (cpu_is_mx53())
> > > > > +           host->quirks |=3D SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK=
_IO;
> > > >
> > > > Have you tried it doing it via IO-accessors?
> > > Richard Zhu: This quirk is used to fix a mechanism problem in the MMC=
 CMDs execution procedure.
> > > It would be very abrupt and ugly, if the IO-accessors are added into =
these original procedures.
> >=20
> > Please don't get it personal, but IMHO it is pretty ugly the way it is
> > now. This quirk is very imx-specific and calling something like
> > SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
> > does this bit do, the description doesn't say so?
>=20
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
> there a shorter version which could be used?  SDHCI_QUIRK_SDIO_MULTIBLK_I=
NT
> maybe?

As I understand, the non-SDIO part is handled here:

+       /*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
+       if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
+               if (cmd->opcode =3D=3D 12)
+                       flags |=3D SDHCI_CMD_ABORTCMD;
+       }

But I'd really like to avoid the quirk bit. Maybe we'll get a better
idea once we understand what that magic bit actually does. For a start,
we might simply set SDHCI_QUIRK_NO_MULTIBLOCK for mx53 like we do for
other imx.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1iSW0ACgkQD27XaX1/VRsB1QCguCuCg3dCc8lCl+Cfatg053zw
2g4AoKGpP+QPSuoy+eDDehzugJ0pApfG
=LGiU
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
