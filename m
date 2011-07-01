From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 11:17:53 +0200
Message-ID: <20110701091753.GE1922@pengutronix.de>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38573 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab1GAJRz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 05:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20110630145507.GG1997@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2011 at 04:55:07PM +0200, Wolfram Sang wrote:
> On Thu, Jun 30, 2011 at 12:13:34PM +0200, Koen Beel wrote:
> > Fix clock rate setting on mxs-mmc driver.
> > Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
> > have been 255 instead of 0.
> > Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
> > (TIMING_CLOCK_RATE + 1) where not correctly defined.
> >=20
> > Can easily be reproduced on mx23evk: default clock for high speed sdio
> > cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this resulted in
> > an actual clock rate of about 56 kHz.
> >=20
> > Signed-off-by: Koen Beel <koen.beel.barco <at> gmail.com>
>=20
> Looks promising, but your tabs are garbled (0xa0 0x20 here?)

Can you repost a patch which applies? I'd like to test it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAk4NkMEACgkQD27XaX1/VRvw0QCeP4F3oeKe1Ge3SLohJICLxZre
LKYAmJ2sEztaKIVw4NsZMYNqCUbbwFQ=
=C7kg
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
