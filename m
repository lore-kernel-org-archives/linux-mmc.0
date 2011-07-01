From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 14:27:09 +0200
Message-ID: <20110701122709.GJ1922@pengutronix.de>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de>
 <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45345 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab1GAM1L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 08:27:11 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Think the tabs problem was due to the gmail web ui.
> Hope it's better now.

No 0xa0 anymore, but still no tabs. Oh, and lines are wrapped.

Documentation/email-clients.txt says

=3D=3D=3D

Gmail (Web GUI)

Does not work for sending patches.

Gmail web client converts tabs to spaces automatically.

At the same time it wraps lines every 78 chars with CRLF style line
breaks although tab2space problem can be solved with external editor.

Another problem is that Gmail will base64-encode any message that has a
non-ASCII character. That includes things like European names.

=3D=3D=3D

I don't know if git-send-email can work directly with gmail, but it
seems you need some kind of alternative approach.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4NvR0ACgkQD27XaX1/VRtjmACfQzU2j5+awQ78Ey7Ir+39uhxn
j70AoJQG0D6tK3rYh4YeYsiyFAsLieC5
=DqDV
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
