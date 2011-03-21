From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V7 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Mon, 21 Mar 2011 14:08:44 +0100
Message-ID: <20110321130844.GG9686@pengutronix.de>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40906 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab1CUNIv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 09:08:51 -0400
Content-Disposition: inline
In-Reply-To: <1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org, Richard Zhao <richard.zhao@freescale.com>


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2011 at 01:22:16PM +0800, Richard Zhu wrote:
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

I am still wondering if one of the fixes could be handled at core level,
but I don't have hardware to test. But I may be wrong, so this is good
enough for now to go in IMO.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2HTdwACgkQD27XaX1/VRslhwCdHmoww6QSK0f8c3DjjpempF9r
lpsAn2s+1yVJRdyIwZf6bJt8moKeta3j
=PKif
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
