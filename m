From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC] thoughts about recent Samsung related patches
Date: Mon, 6 Sep 2010 13:00:59 +0200
Message-ID: <20100906110059.GC2617@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56534 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0IFLBE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 07:01:04 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, akpm@linux-foundation.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while working on the esdhc-controller for the imx-platform, I noticed
the recently comitted changes for Samsung controllers and have some
remarks (sorry for being late):

1) Checking conditions for of host->ops->get_min_clock

The original commit e9510176ff728135383f0cdfc9c90cfe57f9e162 (sdhci: be
more strict with get_min_clock() usage) states why the additional checks
were added. Under this light, it could be argued that commit
cfd1f82f20e0c557a061189f7d8c30d623fbe313 (sdhci: remove useless
set_clock() check) could be reverted and this commit
ce5f036bbbfc6c21d7b55b8fdaa2e2bd56392d94 (sdhci-s3c: add support for the
non standard minimal clock value) could also be reverted if the samsung
platform driver just uses SDHCI_QUIRK_NONSTANDARD_CLOCK without setting
ops->set_clock?

2) 8-Bit data transfer support

The comitted version ae6d6c92212e94b12ab9365c23fb73acc2c3c2e7 (sdhci:
8-bit data transfer width support) looks different from another RFC
posted in February:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01250.html=20

As those two already differ, I think it might be wiser to move
8-bit-mode-handling to the platform-specific code? Even the documented
features of a SDHC differ across implementations, I fear side-effects
when using this kind of undocumented feature (official spec says
"reserved" when describing this bit).

3) NO_HI_SPD

Commit 5193250168ccdf87364e35a11965336dc088578c (sdhci: add no hi-speed
bit quirk support) adds a quirk which can be avoided by using
io-accessors like in sdhci-of-esdhc.c. Maybe we can even get rid of
more, older quirks this way to save precious quirk flags. Have to check
that later.

I hope my comments are applicable; because there is no freely available
datasheet, I can't verify all of my assumptions. Looking forward to
comments.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyEyesACgkQD27XaX1/VRsm/QCePflpNSE0iQQWSUjf/PY723qK
ZbEAoLxAIS7jIJY/lUQpQvbkJMN6ve19
=98xD
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
