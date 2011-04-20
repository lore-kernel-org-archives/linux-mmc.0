From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Re-Re-Resubmission
Date: Wed, 20 Apr 2011 04:07:08 +0200
Message-ID: <20110420020708.GA2231@pengutronix.de>
References: <1303231971.1622.33.camel@apple-mac>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52444 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab1DTCHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 22:07:35 -0400
Content-Disposition: inline
In-Reply-To: <1303231971.1622.33.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, arnd@arndb.de


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

> Add a driver for Elan Digital System's VUB300 chip
> which is a USB connected SDIO/SDmem/MMC host controller.
> A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> computer to use SDIO/SD/MMC cards without the need for
> a directly connected, for example via PCI, SDIO host
> controller.
>=20
> Signed-off-by: Anthony F Olech <tony.olech@elandigitalsystems.com>
> ---
> This is the forth submission attempt.

Looks to me that the concerns have not been addressed since last submission.
I had a few a while ago, but Arnd added to it and summed it up nicely:

	http://ns3.spinics.net/lists/linux-mmc/msg06693.html

> There are no errors reported by scripts/checkpatch.pl

Just to make sure:  This only means that there are no obvious (=3D detectab=
le by
a script) flaws. That makes it ready for submission, not necessarily for
inclusion. So, just resending will not be enough.

> This driver has been tested on
> a) 32bit x86
> b) 64bit x86
> c) dual processor
> d) PowerPC

The test coverage is great, yet the driver needs to comply to the kernel co=
ding
rules. I'd suggest to look at Arnd's review and fix the issues.

Regards,

  Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2uP8wACgkQD27XaX1/VRuDvQCdEED7H/BPbMuPFwnjgKBkUo/3
8GgAoLlxQbdr443Tq/Mcgull+QFfCEXb
=ypzH
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
