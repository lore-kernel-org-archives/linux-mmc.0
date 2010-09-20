From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: add quirk for controllers that don't support
	write only detect
Date: Mon, 20 Sep 2010 08:14:59 +0200
Message-ID: <20100920061459.GA9353@pengutronix.de>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com> <4B9DEAE2.3030707@nokia.com> <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com> <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55606 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0ITGPC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 02:15:02 -0400
Content-Disposition: inline
In-Reply-To: <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2010 at 02:46:40PM -0700, Philip Rakity wrote:
>=20
>=20
> Some board designs for embedded systems  do not always bring up the SD Ho=
st Write Protect Signal. =20
> This patch defines a new quirk that when enabled enables write access.

I am preparing a patch series which will also make get_ro an overloadable
function. Then, board specific things could be handled there.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyW++MACgkQD27XaX1/VRsOtgCfSSf4WvjQhib2+OIqyZK7PHYp
2LgAoIGg6WvESsjDRgZw9DZa/6lb33Kf
=+YFZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
