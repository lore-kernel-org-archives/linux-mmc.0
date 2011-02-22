From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/5] arm: mach-mx3: use IMX_GPIO_NR instead of
 hard-coded values
Date: Tue, 22 Feb 2011 20:56:53 +0100
Message-ID: <20110222195653.GB9046@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
 <1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
 <19811.47706.277301.848103@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33147 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab1BVT4y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 14:56:54 -0500
Content-Disposition: inline
In-Reply-To: <19811.47706.277301.848103@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >  #define GPIO_LCDPWR	(4)
> > =20
> While you are at it you could also remove the nonsensical () around
> the bare number.

That would need a seperate patch in my book. I won't bother.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1kFQUACgkQD27XaX1/VRv3RACgsNujUDtwJoj7dASOn2k7/dbe
bT4AniLH0LuGb+zkdlIIgRY+Oq2r412D
=vLCS
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
