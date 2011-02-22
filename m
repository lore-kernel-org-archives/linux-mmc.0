From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 11:33:49 +0100
Message-ID: <20110222103349.GA2755@pengutronix.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110221174016.GN2616@pengutronix.de>
 <20110222085256.GA19871@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab1BVKdv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 05:33:51 -0500
Content-Disposition: inline
In-Reply-To: <20110222085256.GA19871@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, arnd@arndb.de


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What throughput rates do you get on a mx28-regulated slot serving a card
> > at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
>=20
> To make sure we are on the same test, can you share the test case
> you ran to get the result?  So that I can run it here for the result
> on my board.

# mount -t vfat /dev/mmcblk0p1 /mnt
# dd if=3D/mnt/test.dat of=3D/tmp/a bs=3D1024
# umount /mnt
# ./dd --version
dd (coreutils) 8.5
=2E..

'test.dat' was a 8MB file of random data on a 4GB SDHC card
(extrememory) on a slot powered by the mx28. Operating the card at
50Mhz, dd will report ~55 kb/s. If I add 'rate /=3D 2;' to the beginning
of set_clk_rate, so it will operate at 25Mhz, I have 8mb/s.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1jkQ0ACgkQD27XaX1/VRucGACgucR1CNKwBT/Lm/6MOB5u66t3
fiEAnjtJ1tw+hp6CkN1U+WkiQx0vpbPg
=gtrR
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
