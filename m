From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 11:04:39 +0100
Message-ID: <20110221100439.GE2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41226 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1BUKEq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 05:04:46 -0500
Content-Disposition: inline
In-Reply-To: <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, r65037@freescale.com, Richard Zhu <Hong-Xing.Zhu@freescale.com>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> Fix no INT in MULTI-BLK IO.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 9b82910..2eeb03e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -113,7 +113,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host,=
 struct sdhci_pltfm_data *pd
>  	clk_enable(clk);
>  	pltfm_host->clk =3D clk;
> =20
> -	if (cpu_is_mx35() || cpu_is_mx51())
> +	if (cpu_is_mx53())
> +		host->quirks |=3D SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;

Have you tried it doing it via IO-accessors?

> +	if (cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53())

Maybe we should use !cpu_is_mx25 for simplicity?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1iOLcACgkQD27XaX1/VRs9yACfXC26XzuBMMrb8tFu4Qbg1Ga0
O9sAoMGquKB3XTnGXnvBEfkl41bdSROY
=lBCA
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
