From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 11:46:08 +0100
Message-ID: <20110221104608.GF2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
 <20110221100439.GE2616@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37075 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1BUKqO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 05:46:14 -0500
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: Zhao Richard-B20223 <B20223@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > +   if (cpu_is_mx53())
> > > +           host->quirks |=3D SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> >
> > Have you tried it doing it via IO-accessors?
> Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMD=
s execution procedure.
> It would be very abrupt and ugly, if the IO-accessors are added into thes=
e original procedures.

Please don't get it personal, but IMHO it is pretty ugly the way it is
now. This quirk is very imx-specific and calling something like
SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
does this bit do, the description doesn't say so?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAk1iQnAACgkQD27XaX1/VRvsswCgyO06NrNvG6hpfMbbBpFBUGjm
Z5IAlRIIqduZIvQ4xN7syjqk5A9gCmQ=
=cndg
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
