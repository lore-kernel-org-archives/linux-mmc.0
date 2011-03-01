From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 1 Mar 2011 12:31:15 +0100
Message-ID: <20110301113115.GB2212@pengutronix.de>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110228144741.GF15532@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40109 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab1CALb0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 06:31:26 -0500
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "eric.miao@linaro.org" <eric.miao@linaro.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

> Thanks a lot for your review-comments firstly. :)

You are welcome :)

> > > +/* Abort type definition in the command register  */
> > > +#define  SDHCI_CMD_ABORTCMD        0xC0
> >
> > Won't that belong into sd.h (unless I misunderstood your last mail)?
> This is the bit definitions of the ABORTCMD CMD-TYPE on the bit6~7 of CMD=
 register.
> Here is the definition of the CMD register derived from SDHC spec. FYI.
> D15   D14 D13  D08     D07 D06       D05                  D04            =
              D03                       D02         D01 D00
> Rsvd  Command  Index   Command Type  Data Present Select  Command Index C=
heck Enable   Command CRC Check Enable  Rsvd        Response Type Select

Ack, I found that, too. Exactly because it is in the standard, I thought
this should rather go into sd.h than sdhci-esdhc-imx.c. Would be a
seperate patch, though.

> >
> > > +/* VENDOR SPEC register */
> > > +#define SDHCI_VENDOR_SPEC  0xC0
> > > +
> > > +/*
> > > + * The CMDTYPE of the CMD register(offset 0xE) should be set to
> >
> > Check spaces.
> I used the <kernel_dir>/./scripts/checkpatch.pl script to check the patch=
es, and didn't find that there are issues about the spaces.
> Can you tell me what's kinds of spaces issue should be fixed?

Space before opening brace -> "register (offset ..."

> No, we can't keep it enabled all the time.
> This bit should be set to '1'/clear to '0' at the begin/end of the transf=
er.
> Unfortunately, We can't use it to fix CMD12 issue either, this bit is onl=
y used to fix SDIO Multi-BLK NO INT case.

Ok, thanks for checking.

> IC guy insist that the CMD12 case is not a bug refer to the SD HOST contr=
oller spec, the bit7-6 should be
> Set to 11b when the abort CMD is issued.

That's a flaw in the core then? Need to investigate that.

> > Hmm, to me, just using cpu_is_mx53() is more readable than introducing
> > another layer of flags/quirks.
> Hi Wolfram:
> I discussed it with Richard Zhao before sending out these V3 patches.
> As we know that there is not only mx53 has this issue, maybe some followi=
ng SOCs have this issue too.
> So we make a decision that we introduce another flags/quirks to declare i=
t for all those SOCs that required this
> mechanism in the end.

Seems I am outnumbered on this matter, so OK. I just got a bit afraid
of that approach seeing it didn't scale very well with sdhci.c.

> > > +
> > > +static struct sdhci_ops sdhci_esdhc_ops;
> > > +
> >
> > Move them to the front. But I did this already, so no worries :) I will
> > ping Chris to merge my series, so we will have something better to
> > develop on.
> >
> Thanks.:)

He pulled the changes now, so please rebase your patches against
mmc-next. There is already a write_le-function now, but this should be
not too hard, hopefully.

Keep in mind that you don't need to cast void*.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1s2QMACgkQD27XaX1/VRtF4wCgnaCy9H39KxCIrZ2RHt/jciV0
CLoAoMsXagHAWB9MM24GGPT/0PnIH1Qc
=B08g
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
