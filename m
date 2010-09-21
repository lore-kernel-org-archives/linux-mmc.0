From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
Date: Tue, 21 Sep 2010 18:58:29 +0200
Message-ID: <20100921165829.GA883@pengutronix.de>
References: <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com> <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <4C984B01.2000005@nokia.com> <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56942 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab0IUQ6b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 12:58:31 -0400
Content-Disposition: inline
In-Reply-To: <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2010 at 08:06:20AM -0700, Philip Rakity wrote:
>=20
> Our hardware needs to be programmed to handle this case.  The host-ops op=
tion is only needed from h/w that does not handle this.
>=20
> If you can suggest a way to do this in the mmc layer I would welcome impl=
ementing it. =20
>=20
> I looked and the solution requires a call into the driver from the mmc la=
yer after the all setting POWER_ON call.  This was more intrusive than doin=
g it in the driver but if you think this makes sense I can do a patch for t=
hat. =20

Do you have a draft patch for this intrusive way (can be quick'n'dirty)? It=
 is
usually easier to think about such issues if there is some code...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyY5DUACgkQD27XaX1/VRtprwCguXN7pfCLmxBIzbcjjohEsL+7
jnwAoMGgrYd2plbJWeiNmGiAy1ucgKhY
=2l4M
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
