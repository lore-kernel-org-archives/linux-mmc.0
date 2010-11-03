From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: commit 'mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
	capabilities' breaks ricoh mmc device
Date: Wed, 3 Nov 2010 07:24:31 +0100
Message-ID: <20101103062431.GB21719@pengutronix.de>
References: <1288410826.3119.5.camel@maxim-laptop> <20101103055735.GA21719@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0KCGYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 02:24:34 -0400
Content-Disposition: inline
In-Reply-To: <20101103055735.GA21719@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 03, 2010 at 06:57:35AM +0100, Wolfram Sang wrote:
> On Sat, Oct 30, 2010 at 05:53:46AM +0200, Maxim Levitsky wrote:
> > Hi,=20
> >=20
> > I just bisected and reverted this commit.
>=20
> Commit-ID would have been useful, too: b08caed8659ab27199db51c63a35c5ee06=
7fc7ef
> Also, adding the author to cc, done now.

Sorry, just saw that the threading got somehow broken and the thread was
continued. Sorry for the noise!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzRAB8ACgkQD27XaX1/VRtSHACgvSytzl8BXzNFuM31HDWryl/4
HPoAnRGReSnUgTbjOzGYOepJbcPhprGa
=oMKq
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
