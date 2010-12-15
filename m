From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 12:44:55 +0100
Message-ID: <20101215114455.GG3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-3-git-send-email-olof@lixom.net>
 <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com>
 <20101215105443.GA32297@lixom.net>
 <20101215110312.GE3515@pengutronix.de>
 <20101215112454.GA2086@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42232 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab0LOLo7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 06:44:59 -0500
Content-Disposition: inline
In-Reply-To: <20101215112454.GA2086@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > That won't scale for long, I fear (and will make sdhci.c an unreadable
> > mess). We need less quirks and more flexible means to handle flawed
> > controllers, I'd think.
>=20
> It won't scale for long, but it'll give a buffer while a cleaned up
> quirk structure can be hashed out and implemented.

I am a bit pessimistic here; at the end of u64, the first suggestion
will probably be using two u64 ;)

> There are already a handful of quirks in there that can be trivially
> moved into their respective drivers by overriding the register read/write
> functions (like I already have for a couple on sdhci-tegra). Some of

I know. Despite being easy, it hardly resulted in patches so far.

> the others are not obvious to me how they can be easily abstracted out
> without adding even more callbacks up and down the stack for adding hooks.

Yes, it needs some architectural work. If we'd go for u64 now, we will
just earn more quirks and it will get harder and harder to abstract.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0IqjcACgkQD27XaX1/VRvQQgCcDrrEyEngzbioNQrBBQsCX3Q7
CAEAnAiPUr8IkoJfdD7QegSUU+LSzoVz
=eKVY
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
