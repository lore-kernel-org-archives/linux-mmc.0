From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
	sdhci-pltfm driver (V3)
Date: Mon, 4 Oct 2010 10:57:31 +0200
Message-ID: <20101004085731.GA10746@pengutronix.de>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com> <20100930232526.GA29636@void.printf.net> <4CA967F8.9030005@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58511 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab0JDI5g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 04:57:36 -0400
Content-Disposition: inline
In-Reply-To: <4CA967F8.9030005@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In the near future I'll have to start using SDIO and eMMC devices.
> I wonder if I'll be able to continue to use the platform driver or if
> I'll need to actually have own driver (to solve specific limits/features
> .... due to our Hw) or if we'll extend the sdhci-pltfm d.d.
>=20
> What do you think?

First rule should be trying to extend pltfm. If all of the drafts we come up
with don't seem reasonable, the "own driver" solution is the fallback.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyplvsACgkQD27XaX1/VRvWzwCfQwxwrsxtk6D50uwr+1OSQIbQ
05cAoLnEe3JJpUMlBZBjN7/8Gl78T8AI
=nW+2
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
