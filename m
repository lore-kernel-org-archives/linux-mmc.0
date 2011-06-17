From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
Date: Fri, 17 Jun 2011 09:48:36 +0200
Message-ID: <20110617074836.GA1874@pengutronix.de>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
 <20110616115133.GC31375@pma.sysgo.com>
 <BANLkTi=JHnv+_HwkqR+LEq4no70abVKksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45349 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382Ab1FQHsq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 03:48:46 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=JHnv+_HwkqR+LEq4no70abVKksw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: Pavel Machek <pma@sysgo.com>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, linux-mmc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, pba@sysgo.com


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>    It's strange that the sd card can't work on MX25 board without ADMA_BR=
OKEN
>    quirks.

BTW how many cards/boards have you tested?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk37BtQACgkQD27XaX1/VRsp9wCgssaAgmhadaIll3nE5XmPFYiE
cHQAoKZlUa7h/kHcoNddGxqAov0c/2xO
=rYoG
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
