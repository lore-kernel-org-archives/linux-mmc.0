From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: add quirk for controllers that don't support
	write only detect
Date: Fri, 24 Sep 2010 06:49:28 +0200
Message-ID: <20100924044928.GA21645@pengutronix.de>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com> <4B9DEAE2.3030707@nokia.com> <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com> <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <763CD352-8557-46F1-89D6-5596C40C435E@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38640 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0IXEta (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 00:49:30 -0400
Content-Disposition: inline
In-Reply-To: <763CD352-8557-46F1-89D6-5596C40C435E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 04:18:02PM -0700, Philip Rakity wrote:
>    Since your patches are not available yet -- I think it makes more sens=
e if
>    this patch is considered for inclusion and you can add then include its
>    functionality in your code.

Hmm, I don't think so. As I mentioned elsewhere, Richard Zhu has posted such
patches you could base your work on. And if his approach works for you and =
you
like it, you could ack them, or say Tested-by or so...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkycLdgACgkQD27XaX1/VRsZbQCgr25IppZ0VIMih0vHUmnzoxAr
28MAoLZaqG8T7xLqZtFSlp7RATyIySPH
=gsc2
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
