From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Tue, 14 Jun 2011 14:02:58 +0200
Message-ID: <20110614120258.GE5043@pengutronix.de>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
 <20110614092410.GB5043@pengutronix.de>
 <20110614115557.GF30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60708 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab1FNMDE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 08:03:04 -0400
Content-Disposition: inline
In-Reply-To: <20110614115557.GF30295@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > The issue was initially found by Eric Benard as below.
> > >=20
> > > http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> > >=20
> > > Not sure about other SDHCI based controller, but on Freescale eSDHC,
> > > the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> > > gets cleared, if a card is inserted. The driver need to mask the irq
> > > to prevent interrupt storm which will freeze the system.  And the
> > > SDHCI_INT_CARD_REMOVE gets the same situation.
> > >=20
> > > The patch fixes the problem based on the initial idea from
> > > Eric Benard.
> > >=20
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Eric Benard <eric@eukrea.com>
> >=20
> > Hmm, that should get enough testing on non-imx (and even non-ARM)
> > devices. And a comment describing the situation.
> >=20
> Agreed.  Will add something in commit message to mention the
> situation.  That's why I hope we can get the patch on mmc-next at

I actually meant a comment in the code, so it will be obvious for later
hackers why the "extra" steps are in there...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk33TfIACgkQD27XaX1/VRuYBwCgglior8Uas68IWJY0e3Eg2TbV
+FIAn3wnWp+29j3cizezxcUUeOwEAYeS
=ajWy
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
