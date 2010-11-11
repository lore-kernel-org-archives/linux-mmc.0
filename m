From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v1 1/3]Add erase timeout calculation routine for sdhci
 host
Date: Thu, 11 Nov 2010 11:15:36 +0100
Message-ID: <20101111101536.GB3131@pengutronix.de>
References: <20101111090519.GB18170@intel.com>
 <20101111093341.GA3131@pengutronix.de>
 <5D8008F58939784290FAB48F549751982EF72ADA59@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab0KKKPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 05:15:38 -0500
Content-Disposition: inline
In-Reply-To: <5D8008F58939784290FAB48F549751982EF72ADA59@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2010 at 06:01:23PM +0800, Dong, Chuanxiao wrote:
> Hi wolfram
> >=20
> > Just a formal thing I noticed on a glimpse...
> >=20
> You mean can directly set the TIMEOUT CONTROL register to be the maximum =
value?

Well, just use a #define instead of 0xe. I did not mean more :)

> And any comment about patch2 and patch3?

Sadly not. No resources left currently :(

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzbwkgACgkQD27XaX1/VRuWxACfZ5Q8HAf3Bln2YS2KzSmgN84l
0eEAn1WmQraCP/IezH0c+k0KCjcvnJSA
=MYo/
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
