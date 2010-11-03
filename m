From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: commit 'mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
	capabilities' breaks ricoh mmc device
Date: Wed, 3 Nov 2010 06:57:35 +0100
Message-ID: <20101103055735.GA21719@pengutronix.de>
References: <1288410826.3119.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37592 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0KCF5i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 01:57:38 -0400
Content-Disposition: inline
In-Reply-To: <1288410826.3119.5.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2010 at 05:53:46AM +0200, Maxim Levitsky wrote:
> Hi,=20
>=20
> I just bisected and reverted this commit.

Commit-ID would have been useful, too: b08caed8659ab27199db51c63a35c5ee067f=
c7ef
Also, adding the author to cc, done now.

> With it I am unable to read MMC cards via Ricoh MMC function,
> support for which I added recently.
>=20
> 07:00.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev
> 12)
>=20
> The logs show lot of errors like this:
>=20
> [  219.590748] mmc1: new MMC card at address 0001
> [  219.639449] mmcblk0: mmc1:0001 MMC    483 MiB=20
> [  219.647008] mmcblk0: retrying using single block read
> [  219.649262] mmcblk0: error -84 transferring data, sector 0, nr 8, card=
 status 0x900
> [  219.649271] end_request: I/O error, dev mmcblk0, sector 0
> [  219.651964] mmcblk0: error -84 transferring data, sector 1, nr 7, card=
 status 0x900
> [  219.651969] end_request: I/O error, dev mmcblk0, sector 1
> [  219.654202] mmcblk0: error -84 transferring data, sector 2, nr 6, card=
 status 0x900
> [  219.654206] end_request: I/O error, dev mmcblk0, sector 2
> [  219.657049] mmcblk0: error -84 transferring data, sector 3, nr 5, card=
 status 0x900
> [  219.657054] end_request: I/O error, dev mmcblk0, sector 3
> [  219.661094] mmcblk0: error -84 transferring data, sector 4, nr 4, card=
 status 0x900
> [  219.661100] end_request: I/O error, dev mmcblk0, sector 4
> [  219.663347] mmcblk0: error -84 transferring data, sector 5, nr 3, card=
 status 0x900
> [  219.663352] end_request: I/O error, dev mmcblk0, sector 5
> [  219.665593] mmcblk0: error -84 transferring data, sector 6, nr 2, card=
 status 0x900
> [  219.665598] end_request: I/O error, dev mmcblk0, sector 6
> [  219.667905] mmcblk0: error -84 transferring data, sector 7, nr 1, card=
 status 0x900
> [  219.667910] end_request: I/O error, dev mmcblk0, sector 7
> [  219.667915] Buffer I/O error on device mmcblk0, logical block 0
> [  219.672258] mmcblk0: retrying using single block read
> ....
>=20
>=20
> Now that reader in not standard (it doesn't claim SDHCI, but work very si=
miliar),=20
> so it might be device specific bug or not.
>=20
> One thing for sure, it doesn't physicaly support 8-bit (although the MMC =
Plus card I tested
> probably does via extra connectors).

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzQ+c8ACgkQD27XaX1/VRuu1wCeNoiPR3A+KvMj7yv+tUG9MMN2
RxgAn2PawZYyJBWkyASD8aitHW2PV0Z4
=FcE6
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
