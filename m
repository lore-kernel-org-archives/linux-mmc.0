From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 11:45:45 +0200
Message-ID: <20120327094545.GE6790@pengutronix.de>
References: <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
 <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41939 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893Ab2C0Jpu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 05:45:50 -0400
Content-Disposition: inline
In-Reply-To: <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Might be unrelated, however I have been keeping my eyes on the fix
> of ENGcm07207 quirk introduced with 16a790bcc. According to the
> IMX25CE.pdf, to abort data transfers on the AHB, software can reset
> the eSDHC by writing 1 to SYSCTL[24] (RSTA), which currently is not
> done with SDHCI_QUIRK_NO_MULTIBLOCK. It sets the max_blk_count to 1
> instead of 65535. Not sure if this is also limiting the speed.

Oh, it is limiting speed, for sure.

SDHCI_QUIRK_NO_MULTIBLOCK is a _generic_ quirk which can be enabled by
various buggy sdhci implementations, not only esdhc (which is pretty
good at being buggy). It is not there to fix MX25 specific issues,
that would have to be done seperately in sdhci-esdhc-imx.c.

So, the above quirk is a big hammer solution. There might be more
precise ones, but those still would have to be developed. I don't know
of anyone planning to do this.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9xjEkACgkQD27XaX1/VRtMRACfXKL18OTUBtGUEbI+3/m1tIkZ
qRMAn0eKCg+V32tvuSXN7INY2KrgipwS
=i2v8
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
