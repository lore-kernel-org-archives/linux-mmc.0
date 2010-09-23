From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: print out controller name for register debug
Date: Thu, 23 Sep 2010 19:11:49 +0200
Message-ID: <20100923171149.GC1343@pengutronix.de>
References: <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <4C984B01.2000005@nokia.com> <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com> <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com> <20100922230805.GA6659@void.printf.net> <20100923083946.GA2994@pengutronix.de> <20100923161215.GA27023@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59671 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab0IWRLw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 13:11:52 -0400
Content-Disposition: inline
In-Reply-To: <20100923161215.GA27023@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> That's a much bigger change, though -- you'd be making sdhci_dumpregs()
> a no-op unless CONFIG_MMC_DEBUG is defined, right?  That's a change in
> semantics, since it's intentionally called from many non-debug error
> paths right now.

Hmm, true. dev_info would keep the semantics then, but change the loglevel.
Well, not worth the fuss right now...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkybilUACgkQD27XaX1/VRtYLwCgvrWsXTxphim3Hayatv4ohFuk
eoQAoLNy4iluCR/y6h9ikwVMVKnvobqP
=wfSQ
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
