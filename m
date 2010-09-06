From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] thoughts about recent Samsung related patches
Date: Mon, 6 Sep 2010 14:05:25 +0200
Message-ID: <20100906120525.GD2617@pengutronix.de>
References: <20100906110059.GC2617@pengutronix.de>
 <AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52772 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFMF2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 08:05:28 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mmc@vger.kernel.org, pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, m.szyprowski@samsung.com, akpm@linux-foundation.org, =?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > 2) 8-Bit data transfer support
> >
> > The comitted version ae6d6c92212e94b12ab9365c23fb73acc2c3c2e7 (sdhci:
> > 8-bit data transfer width support) looks different from another RFC
> > posted in February:
> > http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01250.html
> >
> > As those two already differ, I think it might be wiser to move
> > 8-bit-mode-handling to the platform-specific code? Even the documented
> > features of a SDHC differ across implementations, I fear side-effects
> > when using this kind of undocumented feature (official spec says
> > "reserved" when describing this bit).
>=20
> Okay it looks different from Samsung Spec.
> WIDE8[5]: Extended Data Transfer Width (It is for MMC 8-bit card).
> 1: 8-bit operatoin
> 0: Bit width is designated by the bit 1(Data Transfer Width)
> So no need to set the BIT 1 and BIT5 simultaneously.
> I also wonder other Specs how described it.

esdhc occupied BIT 2 (originally HI_SPD) for this :(
%10 means 8 bit transfer. %11 is reserved.

> Good, I think it's possible. I'll try and send a patch.

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyE2QUACgkQD27XaX1/VRvlRwCgoCsq7WKSImrErcQ/wJIne3Ym
+6sAniNgnjqNEwOfCbMMXf0wtbKrV60E
=lKPB
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
