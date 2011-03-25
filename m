From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Fri, 25 Mar 2011 09:53:29 +0100
Message-ID: <20110325085329.GA3302@pengutronix.de>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42186 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab1CYJAT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 05:00:19 -0400
Content-Disposition: inline
In-Reply-To: <1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2011 at 11:39:05AM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---

Please provide something like "changes since last time" _below_ this
dashed line "---" next time. Or use --cover-letter to introduce the
changes.

Other than that

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>=20

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2MWAkACgkQD27XaX1/VRusYwCdEmyohqDWwCNDB2KTa0sRbDkO
ttYAoJWTZdpS62m8dqYsxwiLlcDDsO33
=e70V
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
