From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V8 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Fri, 25 Mar 2011 10:00:18 +0100
Message-ID: <20110325090018.GB3302@pengutronix.de>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1301024346-2232-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42200 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1CYJA0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 05:00:26 -0400
Content-Disposition: inline
In-Reply-To: <1301024346-2232-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org, Richard Zhao <richard.zhao@freescale.com>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2011 at 11:39:06AM +0800, Richard Zhu wrote:
> Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK
> read in SDIO on imx53.
>=20
> The CMDTYPE of the CMD register (offset 0xE) should be set to
> "11" when the STOP CMD12 is issued on imx53 to abort one
> open ended multi-blk IO. Otherwise one the TC INT wouldn't
> be generated.
>=20
> In exact block transfer, the controller doesn't complete the
> operations automatically as required at the end of the
> transfer and remains on hold if the abort command is not sent on
> imx53.
> As a result, the TC flag is not asserted and SW  received timeout
> exeception. set bit1 of Vendor Spec registor to fix it.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2MWaIACgkQD27XaX1/VRt0iQCgj2KhBAgIAE82ocXUASpeixBQ
BbMAniSWZneuby7lb8yhP4GCGOVQgRPV
=lDTE
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
