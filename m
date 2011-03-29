From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: Add MPC512x SDHC driver.
Date: Tue, 29 Mar 2011 12:42:31 +0200
Message-ID: <20110329104231.GB18155@pengutronix.de>
References: <AANLkTi=cMzOj-NEc0uksDDBiBvyaKQWta9T9jtO12Gxr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56016 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1C2Kmj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 06:42:39 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=cMzOj-NEc0uksDDBiBvyaKQWta9T9jtO12Gxr@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "vooon341@gmail.com" <vooon341@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> MPC512x have similar sdhc module as in MX2/MX3,
> but use different access to the registers.

There are quite some drivers abstracting the register-access
(sdhci-esdhc for example which is also used on ppc and arm). If the
state-machine is the same, this really should be done. Otherwise
maintenance will be harder. I have mx2/3-hardware here and am willing to
test the changes. If the state-machine is significantly different, a
seperate driver makes sense, of course.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2Rt5cACgkQD27XaX1/VRupZQCfZBKjZDcAXYpWruv/YddLcrl6
5l4AnigRQQhsiy7kyVpMGYYDvtdlzziJ
=fihf
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
