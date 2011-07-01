From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 16:44:09 +0200
Message-ID: <20110701144409.GA3825@pengutronix.de>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de>
 <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
 <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41757 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab1GAOoM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 10:44:12 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
> I send the patch as attachment for now.

Fine with me in this case...

> But I'll have to look into another way of doing this. Corporate mail
> system is adding stupid disclaimers, gmail web ui is not working ok
> and corporate firewalls avoid using a different smtp server...

Good luck with that!

About the patch itself: I didn't verify the formulas, but it does solve one
special problem here. Thanks a lot! So:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

@chris: If Shawn also likes the patch, I think this is a stable candidate.

Very minor nits:

> From ab610437fade5b30fdeacd9e959ddf95bc42587a Mon Sep 17 00:00:00 2001
> From: Koen Beel <koen.beel@barco.com>
> Date: Thu, 30 Jun 2011 12:00:19 +0200
> Subject: [PATCH] mxs-mmc: fix clock rate setting
>=20
> Fix clock rate setting on mxs-mmc driver.
> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would have b=
een 255 instead of 0.
> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2 (TIMING_CLOCK_RAT=
E + 1) where not correctly defined.
>=20
> Can easily be reproduced on mx23evk: default clock for high speed sdio ca=
rds is 50 MHz.
> With a SSP_CLK of 28.8 MHz (default), this resulted in an actual clock ra=
te of about 56 kHz.

Commit msg should linebreak at 72.


> Signed-off-by: Koen beel <koen.beel@barco.com>

Capital 'B'?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4N3TkACgkQD27XaX1/VRsyXQCgme798yR/w/0WtmFVLj5zDo3o
fUgAnj57h34eMNAf6e0mAf1dzxsjASAz
=o3QD
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
