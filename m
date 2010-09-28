From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch 1/3] sdhci-pltfm: add call back get_quirk
Date: Tue, 28 Sep 2010 21:39:56 +0200
Message-ID: <20100928193956.GA11280@pengutronix.de>
References: <AANLkTimjF_rL7CcPQDo=LUa6GfofmqM0uGRJ1ZjVMDZn@mail.gmail.com> <AANLkTinY_zdF457ePv0tTMRsxz_49BN4Y7h=+u0c+Eud@mail.gmail.com> <20100928142023.GH4441@pengutronix.de> <AANLkTik_UXUxESmzWCEBxCdME0E-GOpVYxTa=31Lc1-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758410Ab0I1Tj7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 15:39:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik_UXUxESmzWCEBxCdME0E-GOpVYxTa=31Lc1-V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I might be blind, but I can't see why you can't handle that in init()?
>=20
> The issue is not init, but the common quirk in pdata.
> If using only one quirks in pdata combined with one driver, then
> different device would impact each other.
> for example device.0 set QUIRK_BROKEN_A to pdata->quirks, the device.1
> would use this quirk as default one, device.1 set QUIRK_BROKEN_B to
> pdata->quirks, then what device.2 default quirk would become
> QUIRK_DEFAULT | QUIRK_BROKEN_A | QUIRK_BROKEN_B.
>=20
> So differnet device should have quirk by iteslf, and pltfm.c would get
> such quirk after init.

Aren't devices .0, .1 and .2 own platform_devices and as such have
independent platform_data?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyiRIwACgkQD27XaX1/VRuG/QCgqaP16S0vKezI4zgmuRAdxrd8
IWkAoLAW0WgpbjiLlOH95a+M7B2fISNA
=X72n
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
