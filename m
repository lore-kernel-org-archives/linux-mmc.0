From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 22 Feb 2011 16:51:30 +0100
Message-ID: <20110222155130.GJ2755@pengutronix.de>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110222113222.GE2755@pengutronix.de>
 <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34516 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab1BVPvk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 10:51:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Thanks for respinning \o/ This approach looks better to me, but CCing
> > Olof to comment on abstraction issues if he has them. Will do a deeper
> > review later this week.
>=20
>=20
> I like it! Definitely the right approach. Pushing quirks down into the
> I/O accessors is definitely the only scalable way to handle all the
> various buggy controllers out there.
>=20
> Acked-by: Olof Johansson <olof@lixom.net>

Glad to hear that. I do have a few issues though, will report them later
as mentioned before, it needs a bit of time.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1j24IACgkQD27XaX1/VRs3GACffvhmM3gmJo5lCye6mOVjsRbT
YpUAnioScX7w3+cIGm1otSLOiNKSGNsO
=IRGm
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
