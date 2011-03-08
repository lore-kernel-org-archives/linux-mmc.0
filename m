From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Tue, 8 Mar 2011 23:12:13 +0100
Message-ID: <20110308221213.GB5170@pengutronix.de>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
 <m31v2hqsm5.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46963 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1CHWMQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 17:12:16 -0500
Content-Disposition: inline
In-Reply-To: <m31v2hqsm5.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Mikko Vinni <mmvinni@yahoo.com>, linux-mmc@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thanks, I agree, pushed to -next for testing.  I'd still appreciate
> a Reviewed-by: from someone on linux-mmc@, and would like to hear
> if anyone thinks this needs to be a quirk rather than a generic fix.

Not surprisingly, I prefer the generic fix over a quirk ;) It seems to not =
cost
much detecting the flaw at runtime. I try to have a closer review tomorrow.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk12qb0ACgkQD27XaX1/VRsmRQCgmwaubLcTBaY1cv+E+V/2aIvT
YbUAoKE51NzABq8jpT1jrAYa0i1paMUF
=64qt
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
