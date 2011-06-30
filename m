From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Thu, 30 Jun 2011 16:55:07 +0200
Message-ID: <20110630145507.GG1997@pengutronix.de>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44404 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab1F3OzJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 10:55:09 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2011 at 12:13:34PM +0200, Koen Beel wrote:
> Fix clock rate setting on mxs-mmc driver.
> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
> have been 255 instead of 0.
> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
> (TIMING_CLOCK_RATE + 1) where not correctly defined.
>=20
> Can easily be reproduced on mx23evk: default clock for high speed sdio
> cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this resulted in
> an actual clock rate of about 56 kHz.
>=20
> Signed-off-by: Koen Beel <koen.beel.barco <at> gmail.com>

Looks promising, but your tabs are garbled (0xa0 0x20 here?)

> ---
> =A0drivers/mmc/host/mxs-mmc.c | =A0 12 ++++++------
> =A01 files changed, 6 insertions(+), 6 deletions(-)
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 99d39a6..3575330 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -570,22 +570,22 @@ static void mxs_mmc_set_clk_rate(struct
> mxs_mmc_host *host, unsigned int rate)
> =A0 =A0 ssp_rate =3D clk_get_rate(host->clk);
> - =A0 for (div1 =3D 2; div1 < 254; div1 +=3D 2) {
> + =A0 for (div1 =3D 2; div1 <=3D 254; div1 +=3D 2) {
> =A0 =A0 =A0 =A0 div2 =3D ssp_rate / rate / div1;
> - =A0 =A0 =A0 if (div2 < 0x100)
> + =A0 =A0 =A0 if (div2 <=3D 256)
> =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 }
> - =A0 if (div1 >=3D 254) {
> + =A0 if (div1 > 254) {
> =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc),
> =A0 =A0 =A0 =A0 =A0 =A0 "%s: cannot set clock to %d\n", __func__, rate);
> =A0 =A0 =A0 =A0 return;
> =A0 =A0 }
> =A0 =A0 if (div2 =3D=3D 0)
> - =A0 =A0 =A0 bit_rate =3D ssp_rate / div1;
> - =A0 else
> - =A0 =A0 =A0 bit_rate =3D ssp_rate / div1 / div2;
> + =A0 =A0 =A0 div2 =3D 1;
> +
> + =A0 bit_rate =3D ssp_rate / div1 / div2;
> =A0 =A0 val =3D readl(host->base + HW_SSP_TIMING);
> =A0 =A0 val &=3D ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4MjksACgkQD27XaX1/VRuv0wCfXR+4OTmgVlSN23aFdcOiA3qa
yzEAn2az6/QF+7SiMzrcOvGhv/xZQsH8
=zTL2
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
