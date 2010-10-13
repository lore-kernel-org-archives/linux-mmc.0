From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 10:29:30 +0200
Message-ID: <20101013082930.GA11286@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
 <87aamjxe00.fsf@lechat.rtp-net.org>
 <4CB56A88.2040101@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0JMI3g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 04:29:36 -0400
Content-Disposition: inline
In-Reply-To: <4CB56A88.2040101@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2010 at 10:15:04AM +0200, Eric B=E9nard wrote:

> >I've tried it on a efika mx (to2 version) and I've a problem with the
> >write-protect. It's on a GPIO and I don't see any way to configure the
> >esdhc-imx driver to use it. Any idea on how it should be done ?
> >
> it's actually not yet supported by the driver. There is a wp_gpio in
> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
> but it's not yet used by the driver.

It's all prepared. I finally will have a look into it today.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky1beoACgkQD27XaX1/VRuOBgCfV/xC/XPqez+35/xAHNfo0V3X
Sq4AnjOgzvCtGzAURHZ7R157Ktcmaz5H
=eO4/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
