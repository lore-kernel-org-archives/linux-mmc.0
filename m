From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 17:36:06 +0100
Message-ID: <20110222163606.GK2755@pengutronix.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110222085256.GA19871@S2100-06.ap.freescale.net>
 <20110222103349.GA2755@pengutronix.de>
 <201102221715.07480.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48849 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1BVQgK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 11:36:10 -0500
Content-Disposition: inline
In-Reply-To: <201102221715.07480.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org


--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2011 at 05:15:07PM +0100, Arnd Bergmann wrote:
> On Tuesday 22 February 2011, Wolfram Sang wrote:
> > # mount -t vfat /dev/mmcblk0p1 /mnt
> > # dd if=3D/mnt/test.dat of=3D/tmp/a bs=3D1024
> > # umount /mnt
> > # ./dd --version
> > dd (coreutils) 8.5
>=20
> In general, you should try to rule out file system, garbage collection,
> partitioning and cache effects.

Yes, right, I am aware of that (well, most of it ;)). I simplified my
testcase here, because I was sure by previous tests it was only
dependent on the frequency requested by the card. Remember, I wasn't
after maximum values but chasing a difference in read performance of two
magnitudes.


Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1j5fYACgkQD27XaX1/VRtM5ACdHHoFjJvjLuA3aOniQWWPde92
sroAn2ch634CVHFCu7ebuFS0fm6BrT74
=Xb4g
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--
