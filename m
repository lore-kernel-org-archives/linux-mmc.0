From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Wed, 6 Jul 2011 11:58:55 +0200
Message-ID: <20110706095855.GE2117@pengutronix.de>
References: <20110701144409.GA3825@pengutronix.de>
 <20110701154628.GD8631@S2100-06.ap.freescale.net>
 <20110702131225.GA5478@pengutronix.de>
 <20110703092850.GA9938@S2100-06.ap.freescale.net>
 <20110703103124.GA1333@pengutronix.de>
 <20110703115418.GB9938@S2100-06.ap.freescale.net>
 <20110704103402.GA3990@pengutronix.de>
 <CAHMSPgMxCqFzigAzMc7nbTB_0NyLcK3FrVDW8arKa0ip15TH3Q@mail.gmail.com>
 <20110706093848.GC2117@pengutronix.de>
 <CAHMSPgPZ6xJ3FQrR5wkJZiu5KCqg7k9bcxRq-ad9_TDJsyzx5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52488 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1GFJ67 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 05:58:59 -0400
Content-Disposition: inline
In-Reply-To: <CAHMSPgPZ6xJ3FQrR5wkJZiu5KCqg7k9bcxRq-ad9_TDJsyzx5g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think I misunderstood this suggestion previously. Using DIV_ROUND_UP
> would do the rounding in the correct direction.
> This should result in: "the actual clock is as high as possible
> without being higher then the requested clock."

Yes, that should be done in V2. And if you could also put the '- 1' to
the line calculating div2, that would be an extra plus. I think it is a
lot more readable to have the whole formula in one place, and not split
up.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4UMd8ACgkQD27XaX1/VRuVawCgp3xBgYEexOQC1+dkplJNxyh5
1m0An2ftoTnZBGZvd9VGAXbPSnms15ud
=lzt5
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
