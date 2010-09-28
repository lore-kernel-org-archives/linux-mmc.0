From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Tue, 28 Sep 2010 16:51:02 +0200
Message-ID: <20100928145102.GJ4441@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
 <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37384 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab0I1OvE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:51:04 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Saeed Bishara <saeed@marvell.com>


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static int esdhc_pltfm_init(struct sdhci_host *host,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pltfm_data *pdata, void *pri=
v_pdata)
> > +{
> > + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > + =A0 =A0 =A0 struct clk *clk;
> > +
> > + =A0 =A0 =A0 clk =3D clk_get(NULL, "sdhc");
>=20
> Here only could support one device, how about several device, for
> example sdhc.0, sdhc.1 sdhc.2, if using this method, they will get the
> first clock.
> Then sdhc.1 sdhc.2 can not work.
>=20

Ouch, totally overlooked this one. Thanks for spotting it!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyiANYACgkQD27XaX1/VRvebQCgoiGGjVWbVN+oSIZJsI4yL/LY
kqkAnj4F8Ct+Fl70XU44lK0Xb2naE+Xi
=l78v
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
