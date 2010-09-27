From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 2/3] mmc: split the sdhci.h to help
 platforms that uses shdci-pltfm d.d.
Date: Mon, 27 Sep 2010 16:30:52 +0200
Message-ID: <20100927143052.GK2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <20100927104320.GD2664@pengutronix.de>
 <4CA094CE.2010904@st.com>
 <20100927141304.GH2664@pengutronix.de>
 <4CA0A843.8090309@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lZZ4ablUVnt2XgAh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33675 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999Ab0I0Oax (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 10:30:53 -0400
Content-Disposition: inline
In-Reply-To: <4CA0A843.8090309@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


--lZZ4ablUVnt2XgAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hmm, it's not necessary to move them, indeed.
> They can stay in the original header if you prefer.
> No issues on my side at all.
> Let me know so I'll rework the patch and send it again.

You should know that yourself by now ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--lZZ4ablUVnt2XgAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygqpwACgkQD27XaX1/VRuKWQCfS/aKAAjdCG2Hh8ZnUjusoPMJ
KjQAniB1w9V90pzVT5veRsOIUmRg1PFx
=FRU1
-----END PGP SIGNATURE-----

--lZZ4ablUVnt2XgAh--
