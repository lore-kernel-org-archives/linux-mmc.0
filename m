From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Sat, 30 Aug 2014 01:16:14 +0200
Message-ID: <3040533.uqhIdSSGxW@dizzy-6.o2s.ch>
References: <1408541960-14788-1-git-send-email-wens@csie.org> <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch> <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2336499.IqaWaCkYNV"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kolab.o2s.ch ([77.109.136.180]:60258 "EHLO kolab.o2s.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbaH2XRF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Aug 2014 19:17:05 -0400
In-Reply-To: <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans de Goede <hdegoede@redhat.com>


--nextPart2336499.IqaWaCkYNV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi
> > I totally agree with you that information about such capabilities s=
hould
> > be
> > exposed but maybe it would be wiser to use DT instead of hardcoding=
 it?
>=20
> Nope, this is pure software support. No HW config.
Okey!
> What we should do future wise, is to remove the MMC_CAP_ERASE
> entirely. Due to current existing bugs, mainly in mmc core layer
> regarding erase, we can't do it yet.
I see.
> > I mean a WiFi device won't support erase functionality...
>=20
> That's already covered by the mmc core layer. No worries.
Splendid!
Ok then. Let's have it in our driver so far until we can get rid of thi=
s flag
for good.

cheers
=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart2336499.IqaWaCkYNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlQBCcIACgkQAeZw77btGjqu7QCgrDg/Qs3jY7jMVvar/ST0EGWA
uJUAn3uGK7jsC8FXch79BbkSTDxWlsCH
=DTLE
-----END PGP SIGNATURE-----

--nextPart2336499.IqaWaCkYNV--

