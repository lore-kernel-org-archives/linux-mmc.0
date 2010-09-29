From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Wed, 29 Sep 2010 21:26:20 +0200
Message-ID: <20100929192620.GD7542@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
 <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
 <20100928205701.GK27885@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58671 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0I2T0X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 15:26:23 -0400
Content-Disposition: inline
In-Reply-To: <20100928205701.GK27885@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Saeed Bishara <saeed@marvell.com>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> My preference would be to rework the sdhci-pltfm.c to be the 'core'
> implementation called by each driver. I'll have a look at posting
> some patches to see what can be done to sort this out.

Cool!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyjktwACgkQD27XaX1/VRtS7gCeOCArI+h5fm/BEfmY0SlUC0VG
o1AAni2GfN0cK287gr39lhgKy7CCJlUh
=s4Vb
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
