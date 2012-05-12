From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: Workaround for SD dat1 glitch
 causes system panic
Date: Sat, 12 May 2012 12:20:41 +0200
Message-ID: <20120512102041.GA20673@pengutronix.de>
References: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
 <1336642399-4543-5-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34004 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab2ELKUn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 May 2012 06:20:43 -0400
Content-Disposition: inline
In-Reply-To: <1336642399-4543-5-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-mmc@vger.kernel.org, RichardZhu <richard.zhu@linaro.org>, Tony Lin <tony.lin@freescale.com>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2012 at 11:33:19AM +0200, Dirk Behme wrote:
> From: RichardZhu <richard.zhu@linaro.org>
>=20
> Some SD cards insertions will cause a glitch on SD dat1
> which is also a card interrupt signal. Thus the wrongly
> generated card interrupt will make system panic because
> there's no registered sdio interrupt handler.
> This patch fixes this issue.
>=20
> Note: This is a workaround for i.MX6 version 1.0 silicon. It's
>       fixed in hardware in version 1.1 silicon.
>=20
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> Signed-off-by: RichardZhu <richard.zhu@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index a13e75b..50a72a4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -486,6 +486,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct pla=
tform_device *pdev)
>  	struct clk *clk;
>  	int err;
>  	struct pltfm_imx_data *imx_data;
> +	u32 reg;
> =20
>  	host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
>  	if (IS_ERR(host))
> @@ -513,7 +514,22 @@ static int __devinit sdhci_esdhc_imx_probe(struct pl=
atform_device *pdev)
>  	clk_prepare_enable(clk);
>  	pltfm_host->clk =3D clk;
> =20
> -	host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	/* disable card interrupt enable bit, and clear status bit
> +	 * the default value of this enable bit is 1, but it should
> +	 * be 0 regarding to standard host controller spec 2.1.3.
> +	 * if this bit is 1, it may cause some problems.

Very minor: "the following problem"?

> +	 * there's dat1 glitch when some cards inserting into the slot,
> +	 * thus wrongly generate a card interrupt that will cause
> +	 * system panic because it lacks of sdio handler
> +	 * following code will solve the problem.
> +	 */
> +	reg =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> +	reg &=3D ~SDHCI_INT_CARD_INT;
> +	sdhci_writel(host, reg, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, SDHCI_INT_CARD_INT, SDHCI_INT_STATUS);
> +
> +	if (!is_imx25_esdhc(imx_data))
> +		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

NACK on the last two lines. Wrong rebase conflict resolution?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+uOXkACgkQD27XaX1/VRvdVwCfRF5XLE+Zp9cfNkQ7anzgPZrW
WF8AoLdsV7PPGFV95Ix+fRdsXFil2p6B
=bixg
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
