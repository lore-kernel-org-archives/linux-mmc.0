From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/5] mmc: sdhci: merge two sdhci-pltfm.h into one
Date: Tue, 19 Apr 2011 12:21:26 +0200
Message-ID: <20110419102126.GF4164@pengutronix.de>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
 <1301042931-4869-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51416 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab1DSKVS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 06:21:18 -0400
Content-Disposition: inline
In-Reply-To: <1301042931-4869-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2011 at 04:48:51PM +0800, Shawn Guo wrote:
> The structure sdhci_pltfm_data is not necessarily to be in a public
> header like include/linux/mmc/sdhci-pltfm.h, so the patch moves it
> into drivers/mmc/host/sdhci-pltfm.h and eliminates the former one.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2tYiYACgkQD27XaX1/VRtyJgCgtEKqdat1hW9wRBOf65j3diql
WIcAoJN0XjGYUkhpB64fHj8n1m32JXTH
=p0MJ
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
