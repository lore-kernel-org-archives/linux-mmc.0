From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Thu, 3 Mar 2011 11:49:02 +0100
Message-ID: <20110303104902.GE3649@pengutronix.de>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110228144741.GF15532@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
 <20110301113115.GB2212@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C82A4@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44670 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1CCKtM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 05:49:12 -0500
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C82A4@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "eric.miao@linaro.org" <eric.miao@linaro.org>


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > > +/* Abort type definition in the command register  */
> > > > > +#define  SDHCI_CMD_ABORTCMD        0xC0
> > > >
> > > > Won't that belong into sd.h (unless I misunderstood your last mail)?
> > > This is the bit definitions of the ABORTCMD CMD-TYPE on the bit6~7 of
> > CMD register.
> > > Here is the definition of the CMD register derived from SDHC spec. FY=
I.
> > > D15   D14 D13  D08     D07 D06       D05                  D04
> > D03                       D02         D01 D00
> > > Rsvd  Command  Index   Command Type  Data Present Select  Command Ind=
ex
> > Check Enable   Command CRC Check Enable  Rsvd        Response Type Sele=
ct
> >
> > Ack, I found that, too. Exactly because it is in the standard, I thought
> > this should rather go into sd.h than sdhci-esdhc-imx.c. Would be a
> > seperate patch, though.
> >
> Do you means the sdhci.h file?
> I find that the sd.h file doesn't contain the bit definitions stuff of SD=
 HOST CONTROLLER registers.
> The sdhci.h file has them, such as:
> #define SDHCI_COMMAND           0x0E
> #define  SDHCI_CMD_RESP_MASK    0x03
> #define  SDHCI_CMD_CRC          0x08
> #define  SDHCI_CMD_INDEX        0x10
> #define  SDHCI_CMD_DATA         0x20

My idea was that it belongs more to the command definitions, thus sd.h.
But as long as there is nothing to be solved at core-level sdhci.h might
do for now as well.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1vch4ACgkQD27XaX1/VRvsSACfWYHiUlrUgz4s+vNTUefpVbxL
1rwAoIPvDwtnwckzXXGDDjkTOQ9UbXxd
=1suG
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
