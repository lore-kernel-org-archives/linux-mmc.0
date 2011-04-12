From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] mmc: sdhci: work around broken dma boundary behavior
Date: Tue, 12 Apr 2011 06:56:34 +0200
Message-ID: <20110412045634.GA25956@pengutronix.de>
References: <20110314172129.GA20654@pengutronix.de>
 <1301388814-10931-1-git-send-email-mmvinni@yahoo.com>
 <m3tye4a48n.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42529 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1DLE4h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 00:56:37 -0400
Content-Disposition: inline
In-Reply-To: <m3tye4a48n.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Mikko Vinni <mmvinni@yahoo.com>, linux-mmc@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > In my opinion this is more risky than the original patch because this
> > will affect the behavior on all controllers that use sdhci, and not
> > just on those ones that don't update SDHCI_DMA_ADDRESS themselves.
> > Comments welcome!
>=20
> Any thoughts on which of the two approaches you prefer?

Thanks for the ping. I prefer the latter approach but it should be given en=
ough
time testing in -next.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2j24IACgkQD27XaX1/VRvj7wCeI4veo7R3U1pOXaL8ZPExYQCa
DbgAoJfpCXwp2hZdjfyYlNU8hMKfv/jA
=CDH8
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
