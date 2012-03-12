From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: iMX53 and MMC_CAP_SDIO_IRQ
Date: Mon, 12 Mar 2012 11:10:37 +0100
Message-ID: <20120312101037.GA2459@pengutronix.de>
References: <4F5DB793.3080904@linuxtv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50283 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2CLKKn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 06:10:43 -0400
Content-Disposition: inline
In-Reply-To: <4F5DB793.3080904@linuxtv.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Hunold <hunold@linuxtv.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> The main problem is that the ancient Freescale 2.6.35 kernel is using
> the "mx_sdhci" driver, while in 3.3.0-rc6+ the generic "sdhci" driver is
> used, so it's not possible to simply compare the changes between the two
> versions. :-(

Not via diff, but the structure of both drivers should still be somewhat
similar.

> Probably this is a question for the Freescale people: why was the
> "mx_sdhci" necessary at all

It probably was never necessary, it was just easier to hack on a forked
driver, because you can't break other sdhci-users, I guess. Since large
portions of the code are duplicated but issues have been fixed in a
very, ahem, custom manner, this was never suitable for mainline. Back
then, most vendors thought this is good enough. Luckily, times have
changed a bit.

> and why is it not necessary any more?

Because I wanted SD support in mainline, so I had to take a different
path.

> Any help, hints and historical informations are highly appreciated,
> before I start to look deeper into this problem.

They don't have a common ancestor. Just dig into both, you will
recognize patterns, I guess.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9dy50ACgkQD27XaX1/VRsoWgCgyaFweCI0pHpl5Y2CJjPQ4Hda
pY8AoLtGtX33sJFZOt2e+wLZb6WltW8v
=PNbt
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
