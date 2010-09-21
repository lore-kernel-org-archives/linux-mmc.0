From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
Date: Tue, 21 Sep 2010 08:48:15 +0200
Message-ID: <20100921064815.GB3168@pengutronix.de>
References: <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
 <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
 <4BA72971.1070804@nokia.com>
 <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
 <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
 <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59508 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab0IUGsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 02:48:16 -0400
Content-Disposition: inline
In-Reply-To: <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Mark Brown <markb@marvell.com>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philip,

> I generated the patch for eMMC 74 clocks.  I do not know if you want
> to incorporate into your submission or let it stand on its own.

I won't pick it up as I am missing the technical details for this issue.
I only jumped in because adding quirk bits should be handled very
carefully at the moment IMHO.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyYVS8ACgkQD27XaX1/VRvWtACbBgjIjD5ppMARRJWQ9jwAMdC/
ydYAniivw0TYzLM6yisVd3TQEV0lnN/s
=kNTw
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
