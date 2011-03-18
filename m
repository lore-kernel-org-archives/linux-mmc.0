From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Fri, 18 Mar 2011 14:52:48 +0100
Message-ID: <20110318135248.GF2155@pengutronix.de>
References: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300442217-1060-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57829 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab1CRNxA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 09:53:00 -0400
Content-Disposition: inline
In-Reply-To: <1300442217-1060-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2011 at 05:56:56PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

You addressed 2 out of 3 comments nicely. But you still cast the void*
back and forth which is unnecessary. After that, I think we are finally
done.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2DY7AACgkQD27XaX1/VRsTwgCfcpLeaBo+cY7HLH5J8v24se3b
dAQAn34HFpC3pnSzFNLmvkgymkzaHwki
=EcFt
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
