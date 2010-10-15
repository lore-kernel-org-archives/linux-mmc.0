From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Fri, 15 Oct 2010 12:25:34 +0200
Message-ID: <20101015102534.GA4276@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
 <87aamjxe00.fsf@lechat.rtp-net.org>
 <4CB56A88.2040101@eukrea.com>
 <20101013082930.GA11286@pengutronix.de>
 <8762x6xx00.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38660 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0JOKZh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 06:25:37 -0400
Content-Disposition: inline
In-Reply-To: <8762x6xx00.fsf@lechat.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2010 at 11:28:15AM +0200, Arnaud Patard wrote:

> >> it's actually not yet supported by the driver. There is a wp_gpio in
> >> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
> >> but it's not yet used by the driver.
> >
> > It's all prepared. I finally will have a look into it today.
>=20
> oh, great. I was thinking about doing it but I'll wait for your patches
> then. I'm sure I need support for WP on GPIO but I may also need support
> for CD on GPIO so I'll be happy to test any patch you have.

Just to keep you updated: Got a bit distracted again but I hope to
finish it on Saturday. Looks like a patch for the gpiolib is also
needed...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky4LB4ACgkQD27XaX1/VRudgQCfc5KFyQ/2f5DIULONBn0hD77a
m1IAoK1gt885O1VqIyOuIPJDq7ElM12G
=94sW
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
