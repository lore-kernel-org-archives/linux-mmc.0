From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 11:01:49 +0200
Message-ID: <20120327090148.GB6790@pengutronix.de>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48897 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2C0JBw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 05:01:52 -0400
Content-Disposition: inline
In-Reply-To: <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >does that attached patch fix your problem ?
>=20
> YES, indeed it does to a certain degree. The timeout errors do not
> occur anymore and I can successfully perform many fs->ops, such as

Interesting question is now why it worked on your older kernel? The code
around BROKEN_TIMEOUT is there for much longer, I'd think.

> The speed of the card is excruciatingly slow, however. We roughly
> get between 34KB/s and 64KB/s from a dd if=3D/dev/zero write to any of
> the following partitions:

Check the code below what is patched. That's currently the best solution
for the errata. There might be better ones, though, but you'd need to
find out.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9xgfwACgkQD27XaX1/VRtCrACfUvuIwwawMtzZkzyGgsTOLiA0
UC0AoMrf51+NI4Q5NJ/5Z/FlOqmNziP5
=IC3u
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
