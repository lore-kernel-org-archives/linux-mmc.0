From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 05:04:53 +0200
Message-ID: <20110411030453.GA20437@pengutronix.de>
References: <4DA2633C.5000103@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab1DKDE6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Apr 2011 23:04:58 -0400
Content-Disposition: inline
In-Reply-To: <4DA2633C.5000103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2011 at 11:11:08AM +0900, Jaehoon Chung wrote:
> Sometimes we can't add the device,but we didn't check any error status.
> Need to check error status for mmc_add_host.
> And Missing regulator disable/put. Fixed them.

Is there any special reason you don't want to answer the open question from=
 the
last two reviews?

> [PATCH v4] : merged for v3 [PATCH 1/2] and [PATCH 2/2] reviewed on Wolfra=
m Sang

This should go below the dashed line (---)

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2ib9UACgkQD27XaX1/VRsPoACfaMtMUKoZwhdASL2j8kx8hp0g
1Y0AnRS8Zxkr77YoRypYWAerlFGkZQpS
=Afuj
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
