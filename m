From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Tue, 26 Apr 2011 08:58:51 +0200
Message-ID: <20110426065851.GA14534@pengutronix.de>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
 <m3d3k9u0yy.fsf@pullcord.laptop.org>
 <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37794 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab1DZG64 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 02:58:56 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > * Where is the patch that implements the get_shared_pins() hook in
> > =A0your driver?
> We send the common level patch ahead to get the upstream agreement so
> that we can maintain our bottom level sdhci codes better. We will send
> the special driver patch after some time.

Hmm, why should be there a functionality if there is no user for it? A
reference user helps people understand how it is intended to be used.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk22bSoACgkQD27XaX1/VRuqyQCfTPvx1T2Jrpe8peSk2H7ONkM9
4twAnjilc+eyZBU+i/+QTF8q+YhL8E1D
=qFS0
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
